// Generated draft — Grok Build workflow template.
// Install: copy to .grok/workflows/roadmap-sprint-execution.rhai (or ~/.grok/workflows/).
// Requires Grok host APIs: agent(), phase(), log(), complete() — not rhai-host.
// Skill chain: eat-the-frog-roadmap → pr-review-canvas → logical-commit-after-phase

let meta = #{
    name: "roadmap-sprint-execution",
    description: "Drive sprint from coming-next.md items through implementation, debugging, PR review integration and doc maintenance with logical commits",
    phases: [
        #{ title: "Explore", detail: "Read roadmap and layout" },
        #{ title: "Implement", detail: "SN-2 + fixes" },
        #{ title: "Review", detail: "Canvas-based PR review and triage" },
        #{ title: "Close", detail: "Commits, doc updates, PR body" }
    ],
    when_to_use: "Drive sprint from coming-next.md items through implementation, debugging, PR review integration and doc maintenance with logical commits",
};

phase("Explore");
let r0 = agent(
    "Follow skill 'eat-the-frog-roadmap'. Read roadmap and layout. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "eat-the-frog-roadmap",
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
    log("phase failed: eat-the-frog-roadmap");
}


phase("Implement");
let r1 = agent(
    "Follow skill 'pr-review-canvas'. SN-2 + fixes. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "pr-review-canvas",
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
    log("phase failed: pr-review-canvas");
}


phase("Review");
let r2 = agent(
    "Follow skill 'logical-commit-after-phase'. Canvas-based PR review and triage. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "logical-commit-after-phase",
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
    log("phase failed: logical-commit-after-phase");
}


phase("Close");
let r3 = agent(
    "Follow skill 'Close'. Commits, doc updates, PR body. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "Close",
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
    log("phase failed: Close");
}

complete(#{
    summary: "Finished workflow roadmap-sprint-execution",
    skill_chain: ["eat-the-frog-roadmap","pr-review-canvas","logical-commit-after-phase"],
});
