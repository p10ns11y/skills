// Generated draft — Grok Build workflow template.
// Install: copy to .grok/workflows/author-and-apply-skill.rhai (or ~/.grok/workflows/).
// Requires Grok host APIs: agent(), phase(), log(), complete() — not rhai-host.
// Skill chain: skill-authoring → looper → compose-skills

let meta = #{
    name: "author-and-apply-skill",
    description: "end-to-end creation of a composable agent skill then immediate use with another skill to accomplish a product task",
    phases: [
        #{ title: "Explore", detail: "read plan and existing skills" },
        #{ title: "Implement", detail: "write skill files, rule, indexes, validation" },
        #{ title: "Refine", detail: "rename and fix references" },
        #{ title: "Apply", detail: "compose with impeccable for UI polish" },
        #{ title: "Ship", detail: "commit and push" }
    ],
    when_to_use: "end-to-end creation of a composable agent skill then immediate use with another skill to accomplish a product task",
};

phase("Explore");
let r0 = agent(
    "Follow skill 'skill-authoring'. read plan and existing skills. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "skill-authoring",
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
    log("phase failed: skill-authoring");
}


phase("Implement");
let r1 = agent(
    "Follow skill 'looper'. write skill files, rule, indexes, validation. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "looper",
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
    log("phase failed: looper");
}


phase("Refine");
let r2 = agent(
    "Follow skill 'compose-skills'. rename and fix references. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "compose-skills",
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
    log("phase failed: compose-skills");
}


phase("Apply");
let r3 = agent(
    "Follow skill 'Apply'. compose with impeccable for UI polish. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "Apply",
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
    log("phase failed: Apply");
}


phase("Ship");
let r4 = agent(
    "Follow skill 'Ship'. commit and push. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "Ship",
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
    log("phase failed: Ship");
}

complete(#{
    summary: "Finished workflow author-and-apply-skill",
    skill_chain: ["skill-authoring","looper","compose-skills"],
});
