## Base information
This image is based on Ubuntu 25.04 and Wine 10.11 with all the latest features — staging, TKG, NTSync, and WoW64. Additionally, wine-mono and vcrun 2022 (Visual C++ 2022 Redistributable) are preinstalled.  
This Docker build is designed to be compatible with https://hub.docker.com/r/steamcmd/steamcmd

## ARM64
ARM64 compatibility is provided by Box64/Fex-emu/Hangover

## DockerHUB
https://hub.docker.com/r/tsxcloud/steamcmd-wine-ntsync

## Usage
Pull latest image
```yaml
docker pull tsxcloud/steamcmd-wine-ntsync:latest
```
Test interactively
```yaml
docker run --entrypoint bash -it tsxcloud/steamcmd-wine-ntsync:latest
```
* To run SteamCMD:

  ```bash
  steamcmd
  ```

* To run x86\_64 Linux programs:

  ```bash
  $runx64 ./your_x64_program
  ```

* To run x86\_64 Windows programs:

  ```bash
  wine your_x64_program.exe
  ```

An example of usage can be seen with the game LOTR Moria. https://github.com/tsx-cloud/moria-docker-arm

---

## Running a Game Server or App on ARM with Docker

If you want to run a **playful server or Windows program on ARM**, follow this step-by-step approach:

### 1. Start with the default image

```bash
tsxcloud/steamcmd-wine-ntsync:latest
```

### 2. If that doesn't work, try the FEX variant

```bash
tsxcloud/steamcmd-wine-ntsync:arm64-fex
```

### 3. Still no luck? Try with Hangover

```bash
tsxcloud/steamcmd-wine-ntsync:arm64-hangover
```

### 4. Nothing works? Back to step 1 — but with tweaks

Switch back to:

```bash
tsxcloud/steamcmd-wine-ntsync:latest
```

And experiment with Box64 environment variables. See [Box64 Usage Docs](https://github.com/ptitSeb/box64/blob/main/docs/USAGE.md) for full options.

#### Example in a bash script:

```bash
export BOX64_DYNAREC_STRONGMEM=1
```

---

### 🔧 How to set environment variables in `docker-compose.yml`

```yaml
services:
  game-server:
    image: tsxcloud/steamcmd-wine-ntsync:latest
    environment:
      - BOX64_DYNAREC_STRONGMEM=1
      - BOX64_LOG=1
```

---

This tiered approach gives you a fallback at every step — and lets you squeeze every bit of compatibility out of your ARM system.

##
Enjoying the project? A ⭐ goes a long way!
