
# My Dotfiles

Personal dotfiles for macOS, managed using a **bare Git repository**.

Includes configuration for:

* `zsh`
* `starship`
* `fzf` (with `fd`)
* `yazi`
* `neovim`
* `ghostty`

---

## 📦 Repository Structure

Tracked files typically include:

* `~/.zshrc`
* `~/.gitconfig`
* `~/.config/starship.toml`
* `~/.config/yazi/`
* `~/.config/nvim/`
* `~/.config/ghostty/`

❌ **Not tracked**

* Secrets (`.env`, tokens)
* SSH private keys
* History files (`.zsh_history`)
* OS junk (`.DS_Store`)

---

## 🚀 Setup on a New Mac

### 2️⃣ Clone the dotfiles repo (bare)

```bash
git clone --bare https://github.com/Rohitjk/dotfiles.git $HOME/.dotfiles
```

---

### 3️⃣ Create the `dot` alias

```bash
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

Hide untracked files:

```bash
dot config --local status.showUntrackedFiles no
```

---

### 4️⃣ Check out the dotfiles

```bash
dot checkout
```

#### If checkout fails due to existing files

Back them up safely:

```bash
mkdir -p ~/.dotfiles-backup
dot checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | xargs -I{} mv {} ~/.dotfiles-backup/
dot checkout
```

---

### 5️⃣ Persist the alias

Add this to `~/.zshrc`:

```zsh
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

Reload:

```bash
source ~/.zshrc
```

---

### 6️⃣ Install required tools

```bash
brew bundle
```

---

## 🔍 fzf Usage

fzf is configured to use `fd` for fast, `.gitignore`-aware searching.

### Common shortcuts

| Shortcut | Action                       |
| -------- | ---------------------------- |
| `Ctrl-R` | Fuzzy search command history |
| `Ctrl-T` | Fuzzy file picker            |
| `Alt-C`  | Fuzzy directory jump         |

### Standalone

```bash
fzf
```

---

## 📁 Yazi Usage

Yazi is the terminal file manager, integrated with the shell.

### Commands

| Command | Action                                        |
| ------- | --------------------------------------------- |
| `y`     | Open Yazi, **cd into last directory on exit** |
| `yy`    | Open Yazi without changing directory          |
| `yf`    | Pick a file/dir via fzf and open in Yazi      |

### Inside Yazi

| Key     | Action                               |
| ------- | ------------------------------------ |
| `e`     | Open file in `$EDITOR` (e.g. `nvim`) |
| `q`     | Quit                                 |
| `h / l` | Parent / enter directory             |

---
# SSH Hosts Selector

A tiny helper that lets you fuzzy-search and SSH into hosts defined in `~/.ssh/config` using `fzf`.

## Usage

Run:

```bash
ssh-hosts
```
You’ll get an interactive fuzzy list of all SSH hosts from ~/.ssh/config.

Type to filter

Press Enter to connect

Press Esc to cancel
---

## ⭐ Starship

Starship provides the shell prompt.

Useful command:

```bash
starship explain
```

A custom module displays **📁 yazi** when inside a Yazi session.

---

## 🔄 Managing Dotfiles

### Add a new file

```bash
dot add ~/.config/yazi
dot commit -m "Update yazi config"
dot push
```

### Pull updates on another machine

```bash
dot pull
```

---


