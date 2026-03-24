import { cpSync, existsSync, mkdirSync, rmSync } from 'node:fs';
import { resolve } from 'node:path';

const root = resolve(process.cwd());
const dist = resolve(root, 'ui/angular-app/dist/oyana-server-tools-ui/browser');
const target = resolve(root, 'client-src/OyanaServerTools/ui/modules/oyana-server-tools');

if (!existsSync(dist)) {
  console.error('Angular build output not found. Run the Angular build first.');
  process.exit(1);
}

rmSync(target, { recursive: true, force: true });
mkdirSync(target, { recursive: true });
cpSync(dist, target, { recursive: true });
console.log(`Copied UI build to ${target}`);
