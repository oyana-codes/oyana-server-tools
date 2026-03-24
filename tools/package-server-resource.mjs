import { existsSync } from 'node:fs';
import { resolve } from 'node:path';

const root = resolve(process.cwd());
const source = resolve(root, 'Resources/Server/OyanaServerTools');
const entry = resolve(source, 'main.lua');

if (!existsSync(entry)) {
  console.error(`Server entry file missing: ${entry}`);
  process.exit(1);
}

console.log(`Server resource ready at ${source}`);
