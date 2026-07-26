// Generated draft — Grok Build workflow template.
// Install: copy to .grok/workflows/docs-maintenance-and-pr.rhai (or ~/.grok/workflows/).
// Requires Grok host APIs: agent(), phase(), log(), complete() — not rhai-host.
// Skill chain: summarize-recent-changes → update-roadmap-docs → logical-commit-push → branch-from-sentinel-pr

let meta = #{
    name: "docs-maintenance-and-pr",
    description: "End-to-end flow for capturing shipped work, updating docs, shipping via commit/push, and opening PR from sentinel base",
    phases: [
        #{ title: "Inspect", detail: "git log + product surface read" },
        #{ title: "Update", detail: "roadmap + FUNREADME edits" },
        #{ title: "Ship", detail: "logical commit + push" },
        #{ title: "Review", detail: "branch diff + PR summary" },
        #{ title: "Polish+PR", detail: "README tweaks then sentinel branch + PR" }
    ],
    when_to_use: "End-to-end flow for capturing shipped work, updating docs, shipping via commit/push, and opening PR from sentinel base",
};

phase("Inspect");
let r0 = agent(
    "Follow skill 'summarize-recent-changes'. git log + product surface read. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "summarize-recent-changes",
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
    log("phase failed: summarize-recent-changes");
}


phase("Update");
let r1 = agent(
    "Follow skill 'update-roadmap-docs'. roadmap + FUNREADME edits. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "update-roadmap-docs",
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
    log("phase failed: update-roadmap-docs");
}


phase("Ship");
let r2 = agent(
    "Follow skill 'logical-commit-push'. logical commit + push. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "logical-commit-push",
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
    log("phase failed: logical-commit-push");
}


phase("Review");
let r3 = agent(
    "Follow skill 'branch-from-sentinel-pr'. branch diff + PR summary. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "branch-from-sentinel-pr",
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
    log("phase failed: branch-from-sentinel-pr");
}


phase("Polish+PR");
let r4 = agent(
    "Follow skill 'Polish+PR'. README tweaks then sentinel branch + PR. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "Polish+PR",
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
    log("phase failed: Polish+PR");
}

complete(#{
    summary: "Finished workflow docs-maintenance-and-pr",
    skill_chain: ["summarize-recent-changes","update-roadmap-docs","logical-commit-push","branch-from-sentinel-pr"],
});
