// Generated draft — Grok Build workflow template.
// Install: copy to .grok/workflows/parallel-epic-to-pr-cycle.rhai (or ~/.grok/workflows/).
// Requires Grok host APIs: agent(), phase(), log(), complete() — not rhai-host.
// Skill chain: epic-parallel-assessment → single-branch-compatible-epics → pr-review-with-attached-skills

let meta = #{
    name: "parallel-epic-to-pr-cycle",
    description: "End-to-end flow from epic collision analysis through joint implementation, bug fix, PR, skill-driven review, and done-card archiving",
    phases: [
        #{ title: "Explore", detail: "collision mapping and stacking decision" },
        #{ title: "Implement", detail: "joint branch edits for SN-TS+SN-8" },
        #{ title: "Stabilize", detail: "fix path_shadow_report and strict-path issues" },
        #{ title: "Review", detail: "PR + attached-skill canvas review" },
        #{ title: "Archive", detail: "done cards + non-technical PR body update" }
    ],
    when_to_use: "End-to-end flow from epic collision analysis through joint implementation, bug fix, PR, skill-driven review, and done-card archiving",
};

phase("Explore");
let r0 = agent(
    "Follow skill 'epic-parallel-assessment'. collision mapping and stacking decision. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "epic-parallel-assessment",
        capability_mode: "read-only",
        output_schema: #{
            "type": "object",
            "required": ["done", "notes"],
            "properties": #{
                "done": #{ "type": "boolean" },
                "notes": #{ "type": "string" },
            },
        },
    },
);
if r0 == () || !r0.success {
    log("phase failed: epic-parallel-assessment");
}


phase("Implement");
let r1 = agent(
    "Follow skill 'single-branch-compatible-epics'. joint branch edits for SN-TS+SN-8. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "single-branch-compatible-epics",
        capability_mode: "read-write",
        output_schema: #{
            "type": "object",
            "required": ["done", "notes"],
            "properties": #{
                "done": #{ "type": "boolean" },
                "notes": #{ "type": "string" },
            },
        },
    },
);
if r1 == () || !r1.success {
    log("phase failed: single-branch-compatible-epics");
}


phase("Stabilize");
let r2 = agent(
    "Follow skill 'pr-review-with-attached-skills'. fix path_shadow_report and strict-path issues. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "pr-review-with-attached-skills",
        capability_mode: "read-write",
        output_schema: #{
            "type": "object",
            "required": ["done", "notes"],
            "properties": #{
                "done": #{ "type": "boolean" },
                "notes": #{ "type": "string" },
            },
        },
    },
);
if r2 == () || !r2.success {
    log("phase failed: pr-review-with-attached-skills");
}


phase("Review");
let r3 = agent(
    "Follow skill 'Review'. PR + attached-skill canvas review. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "Review",
        capability_mode: "read-write",
        output_schema: #{
            "type": "object",
            "required": ["done", "notes"],
            "properties": #{
                "done": #{ "type": "boolean" },
                "notes": #{ "type": "string" },
            },
        },
    },
);
if r3 == () || !r3.success {
    log("phase failed: Review");
}


phase("Archive");
let r4 = agent(
    "Follow skill 'Archive'. done cards + non-technical PR body update. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "Archive",
        capability_mode: "read-write",
        output_schema: #{
            "type": "object",
            "required": ["done", "notes"],
            "properties": #{
                "done": #{ "type": "boolean" },
                "notes": #{ "type": "string" },
            },
        },
    },
);
if r4 == () || !r4.success {
    log("phase failed: Archive");
}

complete(#{
    summary: "Finished workflow parallel-epic-to-pr-cycle",
    skill_chain: ["epic-parallel-assessment","single-branch-compatible-epics","pr-review-with-attached-skills"],
});
