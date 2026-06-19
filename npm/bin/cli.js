#!/usr/bin/env node
// EnGen OS npm launcher. The product itself is Python (console) + Docker (Cortex); npm is
// only delivery. On first use this bootstraps the product under ~/.engenos via the public
// curl installer (download + checksum-verify + product install), then delegates every
// command to the product's own `engenos` CLI (install/upgrade/start/stop/status/version).
'use strict'
const { execFileSync } = require('child_process')
const fs = require('fs')
const os = require('os')
const path = require('path')

const HOME = process.env.ENGENOS_HOME || path.join(os.homedir(), '.engenos')
const CLI = path.join(HOME, 'engenos', 'local-cortex', 'console', 'scripts', 'engenos')
const INSTALLER = 'https://raw.githubusercontent.com/EnGen-AI/homebrew-engenos/main/install.sh'

function ensureInstalled() {
  if (fs.existsSync(CLI)) return
  process.stderr.write('EnGen OS: not installed yet — bootstrapping…\n')
  execFileSync('bash', ['-c', `curl -fsSL ${INSTALLER} | bash`], { stdio: 'inherit' })
}

try {
  ensureInstalled()
  const args = process.argv.slice(2)
  execFileSync(CLI, args.length ? args : ['version'], { stdio: 'inherit' })
} catch (err) {
  process.stderr.write(`engenos: ${err.message}\n`)
  process.exit(typeof err.status === 'number' ? err.status : 1)
}
