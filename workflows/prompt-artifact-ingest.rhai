// Generated draft — Grok Build workflow template.
// Install: copy to .grok/workflows/prompt-artifact-ingest.rhai (or ~/.grok/workflows/).
// Requires Grok host APIs: agent(), phase(), log(), complete() — not rhai-host.
// Skill chain: harvest-conversations → suggest-artifacts → install-artifacts

let meta = #{
    name: "prompt-artifact-ingest",
    description: "Harvest raw sessions, filter by split/repo, derive skills/rules, generate installable bundles, and publish via .agents/ installer",
    phases: [
        #{ title: "Explore & Evaluate", detail: "Check TOON vs JSONL and repo data shapes" },
        #{ title: "Harvest", detail: "Extract 1273 turns across repos with path preservation" },
        #{ title: "Derive", detail: "Produce high-signal skills/rules and avoid pitfalls" },
        #{ title: "Package & Install", detail: "Create installer script and inverted gitignore" }
    ],
    when_to_use: "Harvest raw sessions, filter by split/repo, derive skills/rules, generate installable bundles, and publish via .agents/ installer",
};

phase("Explore & Evaluate");
let r0 = agent(
    "Follow skill 'harvest-conversations'. Check TOON vs JSONL and repo data shapes. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "harvest-conversations",
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
    log("phase failed: harvest-conversations");
}


phase("Harvest");
let r1 = agent(
    "Follow skill 'suggest-artifacts'. Extract 1273 turns across repos with path preservation. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "suggest-artifacts",
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
    log("phase failed: suggest-artifacts");
}


phase("Derive");
let r2 = agent(
    "Follow skill 'install-artifacts'. Produce high-signal skills/rules and avoid pitfalls. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "install-artifacts",
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
    log("phase failed: install-artifacts");
}


phase("Package & Install");
let r3 = agent(
    "Follow skill 'Package & Install'. Create installer script and inverted gitignore. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "Package & Install",
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
    log("phase failed: Package & Install");
}

complete(#{
    summary: "Finished workflow prompt-artifact-ingest",
    skill_chain: ["harvest-conversations","suggest-artifacts","install-artifacts"],
});
