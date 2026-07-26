// Portable multi-agent delivery — skill-backed (not session archaeology).
// Install: copy to .grok/workflows/ or ~/.grok/workflows/
// Skills: agent-orchestrator → control-graph → git-worktrees → split-to-prs

let meta = #{
    name: "multi-agent-delivery",
    description: "Triage, control-graph phases, worktree delivery, verify, split to PRs",
    phases: [
        #{ title: "Triage", detail: "single-shot vs full orchestration" },
        #{ title: "Plan", detail: "Control Card + success criteria + verify commands" },
        #{ title: "Execute", detail: "bounded Inner DAG on worktrees" },
        #{ title: "Verify", detail: "independent checks vs plan" },
        #{ title: "Integrate", detail: "merge hygiene + optional PR split" },
    ],
    when_to_use: "multi-step multi-agent delivery with thrash risk",
};

let report_schema = #{
    "type": "object",
    "required": ["done", "phase", "notes", "verify_commands", "risks"],
    "properties": #{
        "done": #{ "type": "boolean" },
        "phase": #{ "type": "string" },
        "notes": #{ "type": "string" },
        "verify_commands": #{ "type": "array", "items": #{ "type": "string" } },
        "risks": #{ "type": "array", "items": #{ "type": "string" } },
    },
};

let goal = if args == () { () } else { args.goal };
if goal == () {
    pause("verification", "Pass args.goal — one-sentence delivery outcome.");
}

phase("Triage");
let triage_prompt = "";
triage_prompt += "Follow skill agent-orchestrator (read its SKILL.md if present in workspace skills). ";
triage_prompt += "Goal: " + goal + ". ";
triage_prompt += "Triage single-shot vs light vs full orchestration. ";
triage_prompt += "If single-shot is safe, state that and list the exact files+verify cmds; do not invent workers. ";
triage_prompt += "If full, list disjoint worker slices and why. ";
triage_prompt += "Use read-only tools (read_file, grep, git status/diff) before deciding. ";
triage_prompt += "Report {done, phase, notes, verify_commands, risks}.";
let r0 = agent(triage_prompt, #{
    label: "triage",
    capability_mode: "read-only",
    output_schema: report_schema,
});
if r0 == () || !r0.success {
    log("phase failed: Triage");
    complete(#{ summary: "Triage failed", ok: false });
}

phase("Plan");
let plan_prompt = "";
plan_prompt += "Follow skill control-graph (formal SoT; expand english-procedure ONLY if ambiguous). ";
plan_prompt += "Formerly named looper. Open a Control Card for goal: " + goal + ". ";
plan_prompt += "phase=ORIENT then PLAN. Write success criteria, verify commands, budgets ";
plan_prompt += "(max_loop_iters, max_repair_rounds, max_step_retries), and Inner DAG steps. ";
plan_prompt += "HITL_PLAN_GATE if high stakes. Do not implement yet. ";
plan_prompt += "Use read-only tools. Report {done, phase, notes, verify_commands, risks}.";
let r1 = agent(plan_prompt, #{
    label: "plan-control-graph",
    capability_mode: "read-only",
    output_schema: report_schema,
});
if r1 == () || !r1.success {
    log("phase failed: Plan");
    complete(#{ summary: "Plan failed", ok: false });
}

phase("Execute");
let exec_prompt = "";
exec_prompt += "Follow skills control-graph + git-worktrees (+ concurrent-cli-agents only if steps are independent). ";
exec_prompt += "Goal: " + goal + ". ";
exec_prompt += "EXECUTE only the planned Inner DAG. Prefer worktrees; commit on agent branches; never cp-merge. ";
exec_prompt += "Honor budgets; stop on no_progress. Structured handoffs only. ";
exec_prompt += "Report {done, phase, notes, verify_commands, risks}.";
let r2 = agent(exec_prompt, #{
    label: "execute",
    capability_mode: "read-write",
    output_schema: report_schema,
});
if r2 == () || !r2.success {
    log("phase failed: Execute");
}

phase("Verify");
let ver_prompt = "";
ver_prompt += "Follow control-graph VERIFY + REVIEW_GATE. You are REVIEW role — fresh context. ";
ver_prompt += "Goal: " + goal + ". ";
ver_prompt += "Run every verify command from the plan yourself. Pass/fail + gap list only. ";
ver_prompt += "Do not re-implement features. Report {done, phase, notes, verify_commands, risks}.";
let r3 = agent(ver_prompt, #{
    label: "verify-review",
    capability_mode: "execute",
    output_schema: report_schema,
});
if r3 == () || !r3.success {
    log("phase failed: Verify");
}

phase("Integrate");
let int_prompt = "";
int_prompt += "Follow git-worktrees merge hygiene and split-to-prs if the user needs reviewable chunks. ";
int_prompt += "Goal: " + goal + ". ";
int_prompt += "Integrate only after verify pass (or document blockers). No cp from worktrees. ";
int_prompt += "Report {done, phase, notes, verify_commands, risks}.";
let r4 = agent(int_prompt, #{
    label: "integrate",
    capability_mode: "read-write",
    output_schema: report_schema,
});
if r4 == () || !r4.success {
    log("phase failed: Integrate");
}

complete(#{
    summary: "Finished multi-agent-delivery",
    skill_chain: ["agent-orchestrator", "control-graph", "git-worktrees", "concurrent-cli-agents", "split-to-prs"],
    triage: r0,
    plan: r1,
    execute: r2,
    verify: r3,
    integrate: r4,
});
