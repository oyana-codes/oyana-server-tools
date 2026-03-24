import { execSync } from 'node:child_process';
import { cpSync, existsSync, mkdirSync, rmSync } from 'node:fs';
import { resolve } from 'node:path';

const root = resolve(process.cwd());
const stage = resolve(root, 'release/OyanaServerTools');
const stageResources = resolve(stage, 'Resources');
const serverSource = resolve(root, 'Resources/Server/OyanaServerTools');
const clientZip = resolve(root, 'Resources/Client/OyanaServerTools.zip');
const releaseZip = resolve(root, 'release/OyanaServerTools-release.zip');

execSync('node ./tools/package-server-resource.mjs', { stdio: 'inherit' });
execSync('node ./tools/package-client-mod.mjs', { stdio: 'inherit' });

rmSync(stage, { recursive: true, force: true });
mkdirSync(resolve(stageResources, 'Server'), { recursive: true });
mkdirSync(resolve(stageResources, 'Client'), { recursive: true });
cpSync(serverSource, resolve(stageResources, 'Server/OyanaServerTools'), { recursive: true });
cpSync(clientZip, resolve(stageResources, 'Client/OyanaServerTools.zip'));

rmSync(releaseZip, { force: true });
execSync(`cd "${resolve(root, 'release')}" && zip -qr "${releaseZip}" OyanaServerTools`);
console.log(`Created ${releaseZip}`);
