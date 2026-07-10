import fs from "node:fs/promises";
import path from "node:path";
import process from "node:process";
import less from "less";

const projectRoot = process.cwd();
const templatesRoot = path.join(projectRoot, "www", "templates");
const linkedLessPattern = /^\.\.[/\\].*\.less$/;

const stats = {
  lessFiles: 0,
  linkedLessFiles: 0,
  realLessFiles: 0,
  cssCompiled: 0,
  failed: 0,
};

const failures = [];

async function pathExists(filePath) {
  try {
    await fs.access(filePath);
    return true;
  } catch {
    return false;
  }
}

async function collectLessFiles(dir) {
  const entries = await fs.readdir(dir, { withFileTypes: true });
  const files = [];

  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      files.push(...await collectLessFiles(fullPath));
    } else if (entry.isFile() && entry.name.endsWith(".less")) {
      files.push(fullPath);
    }
  }

  return files;
}

async function resolveLessSource(entryPath, chain = []) {
  const realEntryPath = path.resolve(entryPath);
  if (chain.includes(realEntryPath)) {
    throw new Error(`Circular linked Less reference: ${[...chain, realEntryPath].join(" -> ")}`);
  }

  const content = await fs.readFile(realEntryPath, "utf8");
  const trimmed = content.trim();

  if (!linkedLessPattern.test(trimmed)) {
    return {
      sourcePath: realEntryPath,
      content,
      linked: chain.length > 0,
    };
  }

  const targetPath = path.resolve(path.dirname(realEntryPath), trimmed);
  if (!await pathExists(targetPath)) {
    throw new Error(`Linked Less target does not exist: ${trimmed}`);
  }

  return resolveLessSource(targetPath, [...chain, realEntryPath]);
}

async function compileLess(entryPath) {
  const outputPath = entryPath.replace(/\.less$/i, ".css");
  const resolved = await resolveLessSource(entryPath);

  const result = await less.render(resolved.content, {
    filename: resolved.sourcePath,
    paths: [path.dirname(resolved.sourcePath)],
    math: "always",
  });

  await fs.writeFile(outputPath, result.css);
  stats.cssCompiled += 1;

  return {
    entryPath,
    sourcePath: resolved.sourcePath,
    outputPath,
    linked: path.resolve(entryPath) !== resolved.sourcePath,
  };
}

function relativeToProject(filePath) {
  return path.relative(projectRoot, filePath).replaceAll(path.sep, "/");
}

if (!await pathExists(templatesRoot)) {
  console.error(`Templates directory not found: ${templatesRoot}`);
  process.exit(1);
}

const lessFiles = await collectLessFiles(templatesRoot);
stats.lessFiles = lessFiles.length;

for (const filePath of lessFiles) {
  try {
    const content = await fs.readFile(filePath, "utf8");
    if (linkedLessPattern.test(content.trim())) {
      stats.linkedLessFiles += 1;
    } else {
      stats.realLessFiles += 1;
    }

    const compiled = await compileLess(filePath);
    const source = relativeToProject(compiled.sourcePath);
    const output = relativeToProject(compiled.outputPath);
    const entry = relativeToProject(compiled.entryPath);
    if (compiled.linked) {
      console.log(`${entry} -> ${source} -> ${output}`);
    } else {
      console.log(`${entry} -> ${output}`);
    }
  } catch (error) {
    stats.failed += 1;
    failures.push({
      source: relativeToProject(filePath),
      error: error.message,
    });
  }
}

console.log("");
console.log(`Less files: ${stats.lessFiles}`);
console.log(`Linked less files: ${stats.linkedLessFiles}`);
console.log(`Real less files: ${stats.realLessFiles}`);
console.log(`CSS compiled: ${stats.cssCompiled}`);
console.log(`Failed: ${stats.failed}`);

if (failures.length > 0) {
  console.error("");
  for (const failure of failures) {
    console.error(`source less: ${failure.source}`);
    console.error(`error: ${failure.error}`);
    console.error("");
  }
  process.exit(1);
}
