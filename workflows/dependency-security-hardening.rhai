// Generated draft — Grok Build workflow template.
// Install: copy to .grok/workflows/dependency-security-hardening.rhai (or ~/.grok/workflows/).
// Requires Grok host APIs: agent(), phase(), log(), complete() — not rhai-host.
// Skill chain: dependency-security → upgrade-packages → trust-policy-resolution

let meta = #{
    name: "dependency-security-hardening",
    description: "end-to-end workflow to move pnpm settings, audit/fix vulns, create reusable skills, harden workspace with max supply-chain rules, perform safe upgrades and commit",
    phases: [
        #{ title: "Explore", detail: "read package.json, pnpm-workspace.yaml, run pnpm audit" },
        #{ title: "Skill Authoring", detail: "create .agents/skills/ for security and upgrades" },
        #{ title: "Apply & Harden", detail: "update workspace, run sfw installs, bump packages" },
        #{ title: "Commit", detail: "branch + commit with skill and config changes" }
    ],
    when_to_use: "end-to-end workflow to move pnpm settings, audit/fix vulns, create reusable skills, harden workspace with max supply-chain rules, perform safe upgrades and commit",
};

phase("Explore");
let r0 = agent(
    "Follow skill 'dependency-security'. read package.json, pnpm-workspace.yaml, run pnpm audit. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "dependency-security",
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
    log("phase failed: dependency-security");
}


phase("Skill Authoring");
let r1 = agent(
    "Follow skill 'upgrade-packages'. create .agents/skills/ for security and upgrades. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "upgrade-packages",
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
    log("phase failed: upgrade-packages");
}


phase("Apply & Harden");
let r2 = agent(
    "Follow skill 'trust-policy-resolution'. update workspace, run sfw installs, bump packages. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "trust-policy-resolution",
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
    log("phase failed: trust-policy-resolution");
}


phase("Commit");
let r3 = agent(
    "Follow skill 'Commit'. branch + commit with skill and config changes. Use read-only tools first when mapping; "
        + "then apply edits. Report {done: bool, notes: string}.",
    #{
        label: "Commit",
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
    log("phase failed: Commit");
}

complete(#{
    summary: "Finished workflow dependency-security-hardening",
    skill_chain: ["dependency-security","upgrade-packages","trust-policy-resolution"],
});
