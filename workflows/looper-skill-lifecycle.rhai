// Generated draft — Grok Build workflow template.
// Install: copy to .grok/workflows/looper-skill-lifecycle.rhai (or ~/.grok/workflows/).
// Requires Grok host APIs: agent(), phase(), log(), complete() — not rhai-host.
// Skill chain: looper → skill-rename-propagation → looper-composition

let meta = #{
    name: "looper-skill-lifecycle",
    description: "end-to-end creation, rename, validation, application to UI/React work, and cross-repo propagation of the looper control-plane skill",
    phases: [
        #{ title: "Implement", detail: "write SKILL.md, loop-card, validator, index" },
        #{ title: "Harden", detail: "rename, fix casing, add README + X-ref" },
        #{ title: "Apply", detail: "drive UI/UX polish and React domain fixes with looper" },
        #{ title: "Propagate", detail: "copy to skills lib + life-os, commit all" }
    ],
    when_to_use: "end-to-end creation, rename, validation, application to UI/React work, and cross-repo propagation of the looper control-plane skill",
};

phase("Implement");
let r0 = agent(
    "Follow skill 'looper'. write SKILL.md, loop-card, validator, index. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "looper",
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
    log("phase failed: looper");
}


phase("Harden");
let r1 = agent(
    "Follow skill 'skill-rename-propagation'. rename, fix casing, add README + X-ref. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "skill-rename-propagation",
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
    log("phase failed: skill-rename-propagation");
}


phase("Apply");
let r2 = agent(
    "Follow skill 'looper-composition'. drive UI/UX polish and React domain fixes with looper. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "looper-composition",
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
    log("phase failed: looper-composition");
}


phase("Propagate");
let r3 = agent(
    "Follow skill 'Propagate'. copy to skills lib + life-os, commit all. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "Propagate",
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
    log("phase failed: Propagate");
}

complete(#{
    summary: "Finished workflow looper-skill-lifecycle",
    skill_chain: ["looper","skill-rename-propagation","looper-composition"],
});
