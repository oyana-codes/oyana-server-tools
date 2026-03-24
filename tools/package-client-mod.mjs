import { existsSync, mkdirSync, rmSync, cpSync } from 'node:fs';
import { resolve } from 'node:path';
import { execSync } from 'node:child_process';

const root = resolve(process.cwd());
const clientSource = resolve(root, 'client-src/OyanaServerTools');
const tmp = resolve(root, '.tmp/client/OyanaServerTools');
const outDir = resolve(root, 'Resources/Client');
const outFile = resolve(outDir, 'OyanaServerTools.zip');

rmSync(resolve(root, '.tmp/client'), { recursive: true, force: true });
mkdirSync(tmp, { recursive: true });
mkdirSync(outDir, { recursive: true });
cpSync(clientSource, tmp, { recursive: true });

if (!existsSync(resolve(tmp, 'mod_info/info.json'))) {
  console.error('Client mod_info/info.json missing');
  process.exit(1);
}

rmSync(outFile, { force: true });
execSync(`cd "${resolve(root, '.tmp/client')}" && zip -qr "${outFile}" OyanaServerTools`);
console.log(`Created ${outFile}`);
