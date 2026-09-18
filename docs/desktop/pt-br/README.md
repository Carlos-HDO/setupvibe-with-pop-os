# SetupVibeD — Edição Desktop

> Configuração de ambiente de desenvolvimento multiplataforma — v0.41.11

Instala e configura um stack de desenvolvedor completo em um comando. Suporta macOS e as principais distribuições Linux.

## Requisitos do Sistema

|                   | Suportado                       |
| ----------------- | ------------------------------- |
| **macOS**          | 12 Monterey ou superior         |
| **Ubuntu**         | 24.04+                          |
| **Pop!_OS**        | 24.04+                          |
| **Debian**         | 12+                             |
| **Zorin OS**       | 18+                             |
| **Linux Mint**     | 21+                             |
| **Arquiteturas**   | x86_64 (amd64), ARM64 (aarch64) |

> **Não** execute com `sudo` no macOS — o Homebrew se recusa a instalar como root. Execute normalmente e o script solicitará sua senha quando necessário.

## Instalação

### Modo Interativo (Escolha fase por fase com explicações)

```bash
curl -sSL desktop.setupvibe.dev | bash
```

Ou localmente:

```bash
bash desktop.sh
```

### Modo Automático (Instala todas as 14 fases sem confirmação individual)

```bash
curl -sSL desktop.setupvibe.dev | bash -s -- --yes
```

Ou localmente:

```bash
bash desktop.sh --yes
```

O script exibe um roteiro interativo com a descrição de cada fase (Laravel, Docker, IA, etc.) e permite decidir se instala ou pula (`↷ Skipped`) cada uma delas.

## Skill de setup

Use `$setupvibe-setup` quando precisar escolher a edição, repetir a instalação
ou conferir o ambiente. Depois que o SetupVibe terminar, instale as skills de
cada projeto com `npx skills add <origem>`.

---

## O Que é Instalado (14 Fases)

Cada etapa possui uma descrição detalhada e pode ser selecionada ou pulada individualmente durante a instalação interativa:

### Etapa 1 — Sistema Base e Ferramentas de Build

**Linux:** instalação via APT — `build-essential`, `git`, `wget`, `unzip`, `curl`, `tmux`, `ffmpeg`, `imagemagick`, bibliotecas SSL/compressão e o repositório APT do Charmbracelet (para o `glow`).

**macOS:** depende do Xcode Command Line Tools (verifica e encerra se não estiver presente). As ferramentas base são instaladas via Homebrew na próxima etapa.

### Etapa 2 — Homebrew

- **macOS:** instala o Homebrew se ausente, depois instala ferramentas base (`wget`, `curl`, `tmux`, `ffmpeg`, `imagemagick`, `openssl`, `readline`, etc.)
- **Linux:** instala o Linuxbrew em `/home/linuxbrew/.linuxbrew`. Adiciona entradas de PATH ao `~/.bashrc`, `~/.profile`, `~/.zshrc`. Executa `brew upgrade` se já presente

### Etapa 3 — Ecossistema PHP 8.5

| Componente          | macOS                                       | Linux                                                                                               |
| ------------------- | ------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| PHP 8.5             | via Homebrew                                | via PPA ondrej/php (Ubuntu) ou sury.org (Debian)                                                    |
| Extensões           | redis, xdebug, imagick via PECL             | php8.5-{curl,mbstring,xml,zip,bcmath,intl,mysql,pgsql,sqlite3,gd,imagick,redis,mongodb,yaml,xdebug} |
| Composer            | via Homebrew                                | binário em `~/.local/bin/composer`                                                                  |
| Laravel installer   | `composer global require laravel/installer` | igual                                                                                               |

### Etapa 4 — Ecossistema Ruby

| Componente      | macOS                       | Linux                                   |
| --------------- | --------------------------- | --------------------------------------- |
| rbenv           | via Homebrew                | clonado do GitHub em `~/.rbenv`         |
| ruby-build      | via Homebrew                | clonado em `~/.rbenv/plugins/ruby-build` |
| Ruby            | 3.4.10 compilado via rbenv  | igual                                   |
| Bundler + Rails | `gem install bundler rails` | igual                                   |

### Etapa 5 — Linguagens

| Linguagem | macOS                      | Linux                                              |
| --------- | -------------------------- | -------------------------------------------------- |
| Python 3  | `python@3.14` via Homebrew | via APT (`python3`, `python3-pip`, `python3-venv`) |
| uv        | via script de instalação   | igual                                              |
| qrcode    | `pip --user` com CLI `qr`  | igual                                              |
| Go        | via Homebrew               | binário 1.26.5 verificado em `~/.local/go`         |
| Rust      | via rustup                 | igual                                              |

### Etapa 6 — JavaScript

| Ferramenta | macOS                     | Linux                   |
| ---------- | ------------------------- | ----------------------- |
| Node.js 24 | `node@24` via Homebrew    | via repositório APT NodeSource |
| PNPM       | `npm install -g pnpm`     | igual                   |
| PM2        | `npm install -g pm2`      | igual                   |
| Bun        | via script de instalação  | igual                   |

No Linux, os pacotes npm globais usam o prefixo gravável `~/.npm-global` do
usuário-alvo, mesmo quando o instalador é executado por `sudo`. PNPM, PM2
e Bun são validados após a instalação.

### Etapa 7 — DevOps

| Ferramenta         | macOS                            | Linux                                                                        |
| ------------------ | -------------------------------- | ---------------------------------------------------------------------------- |
| Docker             | Docker Desktop via Homebrew Cask | docker-ce + docker-compose-plugin + docker-buildx-plugin via Docker APT repo |
| Portainer          | via Docker Compose em `~/.setupvibe` | mesmo |
| Ansible            | via Homebrew                     | via PPA ansible/ansible (Ubuntu) ou ansible-core (Debian)                    |
| GitHub CLI (`gh`)  | via Homebrew                     | via repositório APT do GitHub                                                |

### Etapa 8 — Ferramentas Unix Modernas

Instaladas via Homebrew em ambas as plataformas.

| Ferramenta   | Descrição                             |
| ------------ | ------------------------------------- |
| `bat`        | `cat` com realce de sintaxe           |
| `eza`        | Substituto moderno do `ls`            |
| `zoxide`     | `cd` mais inteligente                 |
| `fzf`        | Buscador fuzzy (com atalhos de shell) |
| `ripgrep`    | Substituto rápido do `grep`           |
| `fd`         | Substituto rápido do `find`           |
| `lazygit`    | Interface terminal para git           |
| `lazydocker` | Interface terminal para Docker        |
| `neovim`     | Vim moderno                           |
| `glow`       | Renderizador de Markdown              |
| `jq`         | Processador JSON                      |
| `tldr`       | Páginas simplificadas fornecidas por `tlrc` |
| `fastfetch`  | Ferramenta de informações do sistema  |
| `duf`        | `df` moderno                          |
| `mise`       | Gerenciador de versões de runtime     |

### Etapa 9 — Rede, Monitoramento e Tailscale

**macOS:** `wget`, `nmap`, `mtr`, `htop`, `btop`, `glances`, `speedtest-cli` via Homebrew. `bandwhich`, `gping`, `trippy`, `rustscan` via Cargo. `ctop` via Homebrew. Tailscale via Cask.

**Linux:** mesmas ferramentas via APT + Cargo + binário ctop verificado com SHA-256 em `~/.local/bin`. Tailscale via script oficial de instalação.

### Etapa 10 — Servidor SSH *(somente Linux)*

- Instala `openssh-server`
- Habilita e inicia o serviço systemd `ssh`
- Configura `PermitRootLogin prohibit-password` e `PasswordAuthentication yes`
- Faz backup do `sshd_config` original antes de modificar

### Etapa 11 — Shell (ZSH & Prompt Colorido Customizado)

- Instala ZSH pelo APT no Linux. O ZSH já é padrão no macOS
- Instala Oh My Zsh (sem interação)
- Clona os plugins `zsh-autosuggestions`, `zsh-syntax-highlighting` e ativa `history-substring-search` (com setas `↑` e `↓`)
- Instala Nerd Fonts: **FiraCode** e **JetBrains Mono**. Usa Homebrew Cask no macOS e baixa a v3.4.0 em `~/.local/share/fonts` no Linux
- Configura o prompt colorido clássico (`Hora` + `Usuário@Host` + `Diretório` + `Git Branch via vcs_info`) com histórico compartilhado incremental
- Baixa scripts auxiliares de [`bin/`](../../../bin) para `~/.setupvibe/bin`. Veja [Executáveis](../../pt-br/EXECUTABLES.md)
- Instala o arquivo modular de aliases em `~/.config/zsh/aliases.zsh` ([`conf/aliases.zsh`](../../../conf/aliases.zsh))
- Baixa o `.zshrc` adequado:
  - macOS → [`conf/zshrc-macos.zsh`](../../../conf/zshrc-macos.zsh)
  - Linux → [`conf/zshrc-linux.zsh`](../../../conf/zshrc-linux.zsh)
- Cria `~/.zshrc.local` para aliases e configurações pessoais; as atualizações nunca o sobrescrevem.

### Etapa 12 — Tmux e Plugins

- Clona o [TPM](https://github.com/tmux-plugins/tpm) em `~/.tmux/plugins/tpm`
- Baixa [`conf/tmux-desktop.conf`](../../../conf/tmux-desktop.conf) para `~/.tmux.conf`
- Encerra qualquer sessão tmux em execução para aplicar a nova configuração

Pressione `prefix + I` dentro do tmux para instalar todos os plugins. Consulte [tmux.md](tmux.md) para a referência completa de plugins e atalhos de teclado.

### Passo 13 — Ferramentas de IA (CLI)

Instala pacotes npm globalmente, além do Herdr e do Antigravity CLI pelos seus
manifestos oficiais de releases:

| Ferramenta         | Instalação                       |
| ------------------ | -------------------------------- |
| Agentlytics        | `agentlytics`                    |
| Claude Code        | `@anthropic-ai/claude-code`      |
| OpenAI Codex       | `@openai/codex`                  |
| GitHub Copilot CLI | `@github/copilot`                |
| OpenCode CLI       | `opencode-ai`                    |
| Kimi Code          | `@moonshot-ai/kimi-code`         |
| Skills CLI         | `skills`                         |
| Herdr              | Binário do manifesto oficial     |
| Antigravity CLI    | Binário do manifesto oficial     |

Cada CLI listado é validado após a instalação. O [Herdr](https://github.com/herdrdev/herdr) é instalado em `~/.local/bin` conforme o sistema operacional e a arquitetura detectados. Consulte o [guia do Herdr](../../pt-br/HERDR.md) para entender sessões, atalhos, atualizações e diagnóstico. O Antigravity CLI é instalado em `~/.local/bin` como `agy`: o manifesto versionado e o checksum SHA-512 do próprio feed de releases do Google são resolvidos e verificados diretamente (o bootstrapper oficial Unix não repassa `--skip-aliases`/`--skip-path` ao seu passo interno `agy install`), e então `agy install --skip-aliases --skip-path` é executado explicitamente para não alterar perfis de shell. O **Spec-Kit** é instalado via `uv tool install specify-cli`. Veja o [SPECKIT.md](SPECKIT.md) para o guia completo de Spec-Driven Development e aliases.

### Passo 14 — Finalização e Limpeza

**macOS:** `brew cleanup --prune=all`, `brew autoremove` e remove somente arquivos temporários do SetupVibe.

**Linux:** `apt autoremove`, `apt clean`, remove arquivos temporários e limpa logs do journal. Também limpa `~/.cache/pip`, `~/.cache/composer`, `~/.npm/_npx`, `~/.bundle/cache`.

**Ambos:** configura inicialização automática do PM2 (launchd no macOS, systemd no Linux), executa `pm2 save`, define `pm2:autodump true` e baixa `ecosystem.config.js` com tentativas HTTPS limitadas para `~/ecosystem.config.js`.

Consulte [pm2.md](pm2.md) para a referência completa do PM2.

---

## Configuração do Shell

A arquitetura do shell é modular, separando a inicialização principal dos aliases e das customizações do usuário:

| Arquivo                                               | Propósito / Plataforma | Descrição |
| ----------------------------------------------------- | ---------------------- | --------- |
| [`zshrc-macos.zsh`](../../../conf/zshrc-macos.zsh)    | macOS (`~/.zshrc`)     | PATHs, Oh My Zsh plugins, Starship/Prompt |
| [`zshrc-linux.zsh`](../../../conf/zshrc-linux.zsh)    | Linux (`~/.zshrc`)     | PATHs, Oh My Zsh plugins, Prompt colorido, vcs_info Git, histórico compartilhado |
| [`aliases.zsh`](../../../conf/aliases.zsh)            | `~/.config/zsh/aliases.zsh` | Conjunto completo e categorizado de aliases (Dev, IA, Git, Docker, etc.) e função `upup` |
| `~/.zshrc.local`                                      | Local (todas)          | Customizações e variáveis pessoais do usuário (não sobrescrito pelo instalador) |

### Aliases e Funções em Destaque

| Comando / Alias | Descrição |
| --------------- | --------- |
| `upup`          | Atualização tudo-em-um: APT + Flatpak + Autoremove + Autoclean + updatedb (com flag opcional `-y`) |
| `reload`        | Recarrega as configurações do ZSH (`source ~/.zshrc`) |
| `zconfig`       | Edita o arquivo de configuração do ZSH (`nano ~/.zshrc`) |
| `zlocal`        | Edita as customizações pessoais (`nano ~/.zshrc.local`) |
| `myalias`       | Atalho para gerenciar/visualizar scripts de aliases |
| `ll`, `la`, `l` | Listagens detalhadas e coloridas com `ls` |
| `,`, `..`, `...`| Navegação rápida subindo 1, 2 ou 3 níveis de diretórios |
| `cc`            | Execução Claude CLI (`claude --permission-mode=auto --dangerously-skip-permissions`) |
| `skl`, `skf`, `ska` | Gerenciamento de Agent Skills (list, find, add) |
| `sp`, `spinit`  | Spec-Kit CLI para Spec-Driven Development |
| `gs`, `ga`, `gc`, `gp` | Conjunto completo de atalhos rápidos para Git |
| `d`, `dc`, `dps` | Atalhos de produtividade Docker e Docker Compose |
| `ports` / `ports_l` | Exibe portas e sockets em escuta no Linux (`sudo ss -tuanp`) |
| `syslog`        | Monitoramento do journal do sistema em tempo real (`sudo journalctl -f`) |

### Plugins Oh My Zsh

`git rsync cp extract zoxide fzf zsh-autosuggestions zsh-syntax-highlighting history-substring-search brew gh ansible docker docker-compose laravel composer rails ruby python pip node npm bun golang rust` + `macos` (somente macOS) / `nmap tmux` (somente Linux)

## Contribuição

Contribuições de todos os tamanhos são bem-vindas! Por favor, leia nosso [Guia de Contribuição](../../../CONTRIBUTING.md) para começar.

---

## Licença

Licenciado sob a **GNU General Public License v3.0** — veja [LICENSE](../../../LICENSE) para detalhes.

Mantido por **Carlos Dias** · <carlos.dias.security2026@proton.me>

---
