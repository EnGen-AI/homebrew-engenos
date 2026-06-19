# EnGen OS — install & upgrade

Public distribution for **EnGen OS** (the EnGenAI local-deployment app: native console +
Cortex memory + autonomy runtime). The source is private (`EnGen-AI/engenos`); this repo
hosts the **public installable artifact** + the brew/npm/curl front doors. Control is a
runtime **license key** (`ENGENOS_LICENSE_KEY`), not download-gating.

> Requires **Docker** (for the Cortex stack) and **Python 3.12+**. macOS + Linux.

## Install — pick one

**Homebrew** (macOS + Linuxbrew)
```sh
brew install engen-ai/engenos/engenos
engenos install      # bootstrap Cortex + app-DB + native console
engenos start
```

**npm**
```sh
npm i -g @engen-ai/engenos
engenos install
```

**curl**
```sh
curl -fsSL https://raw.githubusercontent.com/EnGen-AI/homebrew-engenos/main/install.sh | bash
```

All three land the **same** product and the same `engenos` CLI. The curl + brew paths
**checksum-verify** the release tarball before installing (a release becomes the live app).

## Upgrade — non-disruptive

`engenos upgrade` swaps the console (app + SPA) and restarts only that service in ~2s — the
Cortex containers and your data are never touched (a console-only release never restarts
Cortex; container images are pulled only when their pinned digest changes).

```sh
brew update && brew upgrade engenos     # Homebrew
npm update -g @engen-ai/engenos         # npm
engenos upgrade                         # direct (any install method)
```

Rollback is automatic if the new build fails its health check.

## CLI

```
engenos install            first-time bootstrap (deps → Cortex compose → console + first-run)
engenos upgrade [--sha256] swap in a new release (checksum-pinned), migrate, restart, rollback-on-fail
engenos start | stop | restart | status
engenos version
```

## License

Proprietary — © EnGenAI. Use requires a valid `ENGENOS_LICENSE_KEY`.
