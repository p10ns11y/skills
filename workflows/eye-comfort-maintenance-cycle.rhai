// Generated draft — Grok Build workflow template.
// Install: copy to .grok/workflows/eye-comfort-maintenance-cycle.rhai (or ~/.grok/workflows/).
// Requires Grok host APIs: agent(), phase(), log(), complete() — not rhai-host.
// Skill chain: theme-contrast-inspect → single-timer-mutex → waybar-tooltip-light-fix → logical-commit-pr

let meta = #{
    name: "eye-comfort-maintenance-cycle",
    description: "Inspect theme artifacts, apply targeted rendering/timer fixes, update backlog, then ship via logical commits",
    phases: [
        #{ title: "Inspect", detail: "Load configs, delta, timers and recent eye-comfort changes" },
        #{ title: "Fix", detail: "Patch fonts, tooltips, enforce timer mutex" },
        #{ title: "Plan", detail: "Write cultural theme backlog cards and apply review comments" },
        #{ title: "Ship", detail: "Logical commits and open PR" }
    ],
    when_to_use: "Inspect theme artifacts, apply targeted rendering/timer fixes, update backlog, then ship via logical commits",
};

phase("Inspect");
let r0 = agent(
    "Follow skill 'theme-contrast-inspect'. Load configs, delta, timers and recent eye-comfort changes. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "theme-contrast-inspect",
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
    log("phase failed: theme-contrast-inspect");
}


phase("Fix");
let r1 = agent(
    "Follow skill 'single-timer-mutex'. Patch fonts, tooltips, enforce timer mutex. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "single-timer-mutex",
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
    log("phase failed: single-timer-mutex");
}


phase("Plan");
let r2 = agent(
    "Follow skill 'waybar-tooltip-light-fix'. Write cultural theme backlog cards and apply review comments. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "waybar-tooltip-light-fix",
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
    log("phase failed: waybar-tooltip-light-fix");
}


phase("Ship");
let r3 = agent(
    "Follow skill 'logical-commit-pr'. Logical commits and open PR. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "logical-commit-pr",
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
    log("phase failed: logical-commit-pr");
}

complete(#{
    summary: "Finished workflow eye-comfort-maintenance-cycle",
    skill_chain: ["theme-contrast-inspect","single-timer-mutex","waybar-tooltip-light-fix","logical-commit-pr"],
});
