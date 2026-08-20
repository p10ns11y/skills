#!/usr/bin/env node
/**
 * Structural contract test for odysseus-navigator (skills library layout).
 * Exit 0 = pass; non-zero = fail with diagnostics.
 */
import { readFileSync, existsSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const skillDir = join(__dirname, "..");
const repoRoot = join(skillDir, "..");
const skillMd = join(skillDir, "SKILL.md");
const skillReadme = join(skillDir, "README.md");
const englishRef = join(skillDir, "references", "english-procedure.md");
const ruleMd = join(repoRoot, "rules", "odysseus-navigator.mdc");
const readmeMd = join(repoRoot, "README.md");
const cgSkill = join(repoRoot, "control-graph", "SKILL.md");
const evaRule = join(repoRoot, "rules", "eva-emptiness.mdc");

const failures = [];
const notes = [];

function must(cond, msg) {
  if (!cond) failures.push(msg);
  else notes.push(`ok: ${msg}`);
}

function read(p) {
  must(existsSync(p), `exists ${p}`);
  if (!existsSync(p)) return "";
  return readFileSync(p, "utf8");
}

const body = read(skillMd);
must(body.length > 0, "SKILL.md non-empty");

const fm = body.match(/^---\r?\n([\s\S]*?)\r?\n---/);
must(!!fm, "YAML frontmatter present");
const front = fm ? fm[1] : "";
const nameVal = (front.match(/^name:\s*[\"']?([^\"'\n]+)/m) || [])[1]?.trim();
must(!!nameVal && nameVal.length > 0, `frontmatter name non-empty (got ${JSON.stringify(nameVal)})`);
must(nameVal === "odysseus-navigator", `name is odysseus-navigator (got ${JSON.stringify(nameVal)})`);
must(front.includes("description:"), "frontmatter description key present");

const descLower = front.slice(front.indexOf("description:")).toLowerCase();
for (const term of ["odysseus", "ithaca", "control-graph", "eva"]) {
  must(descLower.includes(term), `description mentions "${term}"`);
}

const bodyLower = body.toLowerCase();
const requiredPhrases = [
  { id: "ithaca", any: ["ithaca"] },
  { id: "mistakes", all: ["cyclops", "sirens", "helios", "circe", "winds", "scylla", "prophecy"] },
  { id: "antidotes", all: ["opacity", "yagni", "resilience", "incremental", "observability"] },
  { id: "spirits", all: ["metis", "endurance", "curiosity", "leadership"] },
  { id: "navigator-emit", any: ["## odysseus", "navigator"] },
  { id: "cg-compose", any: ["control-graph"] },
  { id: "eva-compose", any: ["eva-emptiness"] },
  { id: "no-inline", any: ["never inline", "do not inline", "never restated"] },
  { id: "progressive", any: ["english-procedure", "only if"] },
  { id: "calm-waters", any: ["calm waters", "waters=calm"] },
];

for (const req of requiredPhrases) {
  if (req.all) {
    must(
      req.all.every((t) => bodyLower.includes(t)),
      `body includes ${req.all.join(", ")} (${req.id})`,
    );
  }
  if (req.any) {
    must(
      req.any.some((t) => bodyLower.includes(t)),
      `body includes one of [${req.any.join(" | ")}] (${req.id})`,
    );
  }
}

must(body.includes("higher-order-decision-architect"), "composes with HODA (no duplication)");
must(body.includes("control-feeder"), "composes with control-feeder");

const lineCount = body.split(/\r?\n/).length;
must(lineCount <= 500, `SKILL.md line count ≤500 (got ${lineCount})`);
if (lineCount > 220) notes.push(`note: SKILL.md is ${lineCount} lines (target ≲200)`);

must(existsSync(englishRef), "references/english-procedure.md exists");
const eng = read(englishRef);
must(
  eng.toLowerCase().includes("only if") || eng.toLowerCase().includes("progressive"),
  "english ref is progressive disclosure",
);
must(eng.toLowerCase().includes("boasting to the cyclops"), "english ref keeps copy-paste Cyclops line");
must(eng.toLowerCase().includes("you are odysseus navigator"), "english ref keeps system prompt identity");
must(eng.toLowerCase().includes("control-graph"), "english ref hooks control-graph");
must(eng.toLowerCase().includes("eva-emptiness") || eng.toLowerCase().includes("actorask"), "english ref hooks EVA");

const skillReadmeBody = read(skillReadme);
must(skillReadmeBody.includes("SKILL.md"), "skill README points at SKILL.md");
must(skillReadmeBody.toLowerCase().includes("judgment"), "skill README states judgment plane");

const rule = read(ruleMd);
must(rule.includes("---"), "odysseus-navigator.mdc has frontmatter");
must(/alwaysApply:\s*false/i.test(rule), "rule alwaysApply false");
must(rule.includes("odysseus-navigator"), "rule points at odysseus-navigator skill");
must(rule.toLowerCase().includes("control-graph"), "rule composes with control-graph");
must(rule.toLowerCase().includes("eva"), "rule composes with eva");

const readme = read(readmeMd);
must(readme.includes("odysseus-navigator"), "README.md indexes odysseus-navigator");

const cg = read(cgSkill);
must(cg.includes("odysseus-navigator"), "control-graph composition points at odysseus-navigator");

const eva = read(evaRule);
must(eva.toLowerCase().includes("odysseus"), "eva-emptiness.mdc composes with odysseus-navigator");

console.log("=== odysseus-navigator validate-skill (skills library) ===");
for (const n of notes) console.log(`  ${n}`);
if (failures.length) {
  console.error("\nFAILURES:");
  for (const f of failures) console.error(`  - ${f}`);
  console.error(`\n${failures.length} failure(s)`);
  process.exit(1);
}
console.log("\nALL CHECKS PASSED");
process.exit(0);
