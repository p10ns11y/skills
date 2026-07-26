// Generated draft — Grok Build workflow template.
// Install: copy to .grok/workflows/plan-to-sentinel-wave-prioritization.rhai (or ~/.grok/workflows/).
// Requires Grok host APIs: agent(), phase(), log(), complete() — not rhai-host.
// Skill chain: scan-and-extract-plans → neutral-wave-filenames → sentinel-coordination-pack

let meta = #{
    name: "plan-to-sentinel-wave-prioritization",
    description: "convert raw plan docs into neutral wave files with sentinel prompts, regression buckets, and progress lock for autonomous execution",
    phases: [
        #{ title: "Explore", detail: "Glob and read all .kilo/plans/*.md" },
        #{ title: "Prioritize", detail: "map P1-P4 status and correct sentinel assignments" },
        #{ title: "Artifact", detail: "create .composer/waves with neutral names and regression table" },
        #{ title: "Coordinate", detail: "add ordered prompts + progress.md lock" }
    ],
    when_to_use: "convert raw plan docs into neutral wave files with sentinel prompts, regression buckets, and progress lock for autonomous execution",
};

phase("Explore");
let r0 = agent(
    "Follow skill 'scan-and-extract-plans'. Glob and read all .kilo/plans/*.md. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "scan-and-extract-plans",
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
    log("phase failed: scan-and-extract-plans");
}


phase("Prioritize");
let r1 = agent(
    "Follow skill 'neutral-wave-filenames'. map P1-P4 status and correct sentinel assignments. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "neutral-wave-filenames",
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
    log("phase failed: neutral-wave-filenames");
}


phase("Artifact");
let r2 = agent(
    "Follow skill 'sentinel-coordination-pack'. create .composer/waves with neutral names and regression table. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "sentinel-coordination-pack",
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
    log("phase failed: sentinel-coordination-pack");
}


phase("Coordinate");
let r3 = agent(
    "Follow skill 'Coordinate'. add ordered prompts + progress.md lock. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "Coordinate",
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
    log("phase failed: Coordinate");
}

complete(#{
    summary: "Finished workflow plan-to-sentinel-wave-prioritization",
    skill_chain: ["scan-and-extract-plans","neutral-wave-filenames","sentinel-coordination-pack"],
});
