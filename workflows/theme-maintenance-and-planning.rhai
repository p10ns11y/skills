// Generated draft — Grok Build workflow template.
// Install: copy to .grok/workflows/theme-maintenance-and-planning.rhai (or ~/.grok/workflows/).
// Requires Grok host APIs: agent(), phase(), log(), complete() — not rhai-host.
// Skill chain: inspect-theme-config → fix-waybar-font-blur → defer-large-cultural-overlay → apply-plan-review

let meta = #{
    name: "theme-maintenance-and-planning",
    description: "Inspect current eye-comfort theme wiring, fix immediate rendering bugs, then defer large cultural theme work into a reviewed backlog",
    phases: [
        #{ title: "Explore", detail: "Load delta, git, waybar and eye-comfort files" },
        #{ title: "Fix", detail: "Patch font blur and contrast issues" },
        #{ title: "Plan", detail: "Create deferred Sweden/America cultural theme backlog using TN pattern" }
    ],
    when_to_use: "Inspect current eye-comfort theme wiring, fix immediate rendering bugs, then defer large cultural theme work into a reviewed backlog",
};

phase("Explore");
let r0 = agent(
    "Follow skill 'inspect-theme-config'. Load delta, git, waybar and eye-comfort files. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "inspect-theme-config",
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
    log("phase failed: inspect-theme-config");
}


phase("Fix");
let r1 = agent(
    "Follow skill 'fix-waybar-font-blur'. Patch font blur and contrast issues. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "fix-waybar-font-blur",
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
    log("phase failed: fix-waybar-font-blur");
}


phase("Plan");
let r2 = agent(
    "Follow skill 'defer-large-cultural-overlay'. Create deferred Sweden/America cultural theme backlog using TN pattern. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "defer-large-cultural-overlay",
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
    log("phase failed: defer-large-cultural-overlay");
}

complete(#{
    summary: "Finished workflow theme-maintenance-and-planning",
    skill_chain: ["inspect-theme-config","fix-waybar-font-blur","defer-large-cultural-overlay","apply-plan-review"],
});
