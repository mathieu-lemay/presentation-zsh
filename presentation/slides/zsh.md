<h2>
    <span class="title-accent">//</span>
    Welcome
</h2>

to ZSH for Dummies

<div class="version">
Version 0.0.0-preAlpha1
</div>

---

## zsh: Your Terminal, But Smarter

**How to type less and enjoy your shell**

* Practical
* Opinionated
* Demo-driven

---

## Subjects

* Introduction
* Auto completion
* Keyboard shortcuts
* History
* Prompt
* Aliases / Functions
* Bonus Topics

---

## Why zsh?

* Default shell on macOS
* bash-compatible (mostly)
* Better:
  * Completion
  * History
  * Interactivity
* It's the one I use

---

## Nomenclature

Terminal / Shell? wat?

---

## Terminal

An electronic or electromechanical hardware device that can be used for entering data into, and transcribing data from, a computer or a computing system.

Some early terminals were called TeleTYpewriter, **TTY** for short.

---

## Terminal Emulator

Software that simulates a physical terminal, sometimes called pseudo-tty.

Common terminal emulators are
* iTerm2
* Kitty
* Alacritty
* Ghostty
* macOS Terminal (if you really hate yourself)

*Now you know why so many have TTY in their name*

---

## Shell
The command interpreter running inside the terminal. It processes your commands and talks to the operating system.

Common shells are
* sh (Bourne shell)
* Bash (Bourne Again SHell)
* Zsh (Z shell)
* fish (friendly interactive shell)

---

## The 1st rule of shell club is

**Press &lt;TAB&gt;**

---

## The 2nd rule of shell club is

**PRESS &lt;TAB&gt;**

---

## Auto Completion

zsh completion is:

* Context-aware
* Discoverable
* Faster (and safer) than typing

Enable with
```sh
autoload -Uz compinit
compinit
```

Examples:

```sh
$ git ch<TAB>
$ docker ru<TAB>
$ ssh <TAB>
```

---

## Completion Is Documentation

```sh
$ git checkout <TAB>
```

* Local branches
* Remote branches
* Tags

You don’t need to memorize flags.

---

## Full Path Completion

```sh
# Ain't nobody got time to type /u<TAB>/l<TAB>/s<TAB>
$ cd /u/l/s<TAB>
```

* Expands everything it can
* Stops on ambiguity

---

## Completion Configuraton

```sh
# Add a visual menu select
zstyle ':completion:*' menu select
# Add completion for cd ..
zstyle ':completion:*' special-dirs true
# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
```

Small configs that make life so much easier.

---

## Auto correction

Zsh offers basic command auto correction
```sh
setopt correct # Enable autocorrect
```

Useful for fat fingers
```sh
zsh@zsh-demo ~ % gti clone https://github.com/mathieu-lemay/dotfiles.git
zsh: correct 'gti' to 'git' [nyae]? y
Cloning into 'dotfiles'...
```

---

## Keyboard Shortcuts

Stop abusing Backspace.

zsh = Emacs keybindings by default.

---

## Essential Shortcuts

| Action          | Shortcut        |
| --------------- | --------------- |
| Delete word     | Ctrl-w          |
| Paste word      | Ctrl-y          |
| Delete to start | Ctrl-u          |
| Delete to end   | Ctrl-k          |
| Start / End     | Ctrl-a / Ctrl-e |
| Clear prompt    | Ctrl-c          |
| Clear screen    | Ctrl-l          |
| Exit shell      | Ctrl-d          |

---

## Custom shortcuts

You can add define your own

```sh
# Press Ctrl-v + <key> to get the code
bindkey "^[[1~" beginning-of-line # Home
bindkey "^[[4~" end-of-line       # End
bindkey "^[[1;5D" backward-word   # Ctrl-left
bindkey "^[[1;5C" forward-word    # Ctrl-right
```

---

## History

* zsh keeps a history of commands
* You can use ↑ and ↓ for basic navigation
* But...

---

## Abusing ↑

<img src="https://i.redd.it/ainf8qaw2bs81.gif" height="500" />

Don't be this person

---

## Improving ↑

We can make ↑ smarter

```sh
# Optional, to have the cursor move to the end of the line
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Remove `-end` if you want the cursor to stay in place
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# "^[[A" and "^[[B" are up and down, we'll get back to those
```

Now try
```sh
git<↑>
```

* Much faster
* Matches only the start
* Find the last `ls` by typing `ls` and up once

---

## History Search

Incremental history search:

```text
Ctrl-r
```

* Search while typing
* Matches anywhere
* Reversible
* Ctrl-c cancels

---

## Fun Shortcuts

```sh
# !! -> last command
$ make me a sandwich
> What? Make it yourself
$ sudo !!
> sudo make me a sandwich
> Okay.

# !$ -> last argument
$ echo "I don't want a" !$
> echo "I don't want a" sandwich
> I don't want a sandwich
```

Obligatory <a href="https://xkcd.com/149/">xkcd</a>

---

## Command History Matters

zsh history:

* Persistent
* Configurable
* Can be shared across terminals

---

## Sensible History Defaults

```sh
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate.
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks before recording entry.
```

---

## Extra History Config

```sh
setopt INC_APPEND_HISTORY   # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY        # Share history between all sessions.
setopt HIST_IGNORE_DUPS     # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE    # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS    # Don't write duplicate entries in the history file.
```

---

## Prompt

The shell's prompt is fully configurable

```sh
# <user>@<host> <current-working-dir> <sudo-indicator>
PROMPT="%n@%m %~ %# "

# Alternative with only the last part of the current directory
PROMPT="%n@%m %1~ %# "

# 🌈 Colors are _tight_
PROMPT="%F{green}%n%f@%F{magenta}%m%f %F{blue}%~%f %# "
```

Example
```sh
zsh@zsh-demo ~ % cd src
zsh@zsh-demo ~/src % cd mime
zsh@zsh-demo ~/src/mime % export PROMPT="%n@%m %1~ %# "
zsh@zsh-demo mime %
```

---

## Aliases vs Functions

```sh
alias g='git'

mkcd() {
  mkdir -p "$1" && cd "$1"
}
```

Functions scale better.

---

## Useful `ls` aliases

```sh
alias ls='ls --color=auto -v --group-directories-first'
alias ll='ls -lh'
alias la='ls -A'
alias lf='ls -lhA'
```

---

## My First `.zshrc`

```sh
autoload -Uz compinit
compinit

PROMPT="%F{green}%n%f@%F{magenta}%m%f %F{blue}%~%f %# "
EDITOR=vim

# Setup History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate.
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks before recording entry.

# Add a visual menu select
zstyle ':completion:*' menu select
# Add completion for cd ..
zstyle ':completion:*' special-dirs true
# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Enable autocorrect
setopt correct

# Better ↑
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Nice `ls` aliases
alias ls='ls --color=auto -v --group-directories-first'
alias ll='ls -lh'
alias la='ls -A'
alias lf='ls -lhA'
```

This is enough (says the guy who has 1428 lines of zsh code in his dotfiles repo.)

---

## Advanced Topics
* 🔎 fzf: Fuzzy Find All the Things!
* 🌱 direnv: Automatically load .env files
* 🚀 starship: Fancy dynamic prompt

---

## fzf: Fuzzy Everything

fzf = interactive text filtering

```sh
# Load fzf. Path will vary per platform
. /usr/share/zsh/plugins/fzf/fzf.plugin.zsh
```

Easy integration with zsh

---

## fzf + History

`Ctrl-r` on steroids

* Visual
* Multi-line
* Fast

---

## fzf + Files

* `Ctrl-t`: find files in the current directory
* `Alt-c`: find directories in the current directory
* `... **<TAB>`: fuzzy completion

---

## fzf Configuration

```sh
export FZF_DEFAULT_OPTS="--reverse -1"
export FZF_COMPLETION_TRIGGER=";;"
export FZF_COMPLETION_OPTS="--tiebreak=end --preview 'cat {} | head -200'"
export FZF_CTRL_T_OPTS="--tiebreak=end --preview 'cat {} | head -200'"
export FZF_ALT_C_OPTS="--tiebreak=end --preview 'tree {} | head -200'"
```

---

## fzf as a command

```sh
vim $(fzf -m)
git checkout $(git branch | fzf)
cd $(find . -type d | fzf)
```

Text streams → UI.

---

## 🚀 Starship prompt

The minimal, blazing-fast, and infinitely customizable prompt for any shell!

```sh
# Custom prompt with starship
eval "$(starship init zsh)"
```

---

## 🚀 Starship configuration

```toml
# Replace the '❯' symbol in the prompt with '➜' and '✘'
[character]
success_symbol = '[➜](bold green)'
error_symbol = '[✘](bold red)'

# Disable the prompt showing we're in a container
[container]
disabled = true
```

For details: https://starship.rs/config/

---

## 🦇 bat: 🐈 cat with color

<img src="https://i.imgflip.com/ahsur4.jpg" height="500" />

---

## 🦇 bat: 🐈 cat with color

* 🌈 Syntax highlighting
* 🦀 Developped in Rust
* ⚡️ Blazing fast ™

```sh
# Use bat instead of cat
alias cat='bat --'

# Can also be configured with a config file
export BAT_STYLE=plain  # Just output the file, nothing else
export BAT_THEME=ansi   # Use the terminal's base theme
```

---

## eza: `ls` but nicer

* 🦀 Developped in Rust
* ⚡️ Blazing fast ™

```sh
alias ls='eza --group-directories-first'
alias ll='ls -l --time-style=long-iso -b'
alias la='ls -a'
alias lf='ll -a'
```

---

## direnv

Your shell should react to directories.

---

## direnv Workflow

```sh
$ echo 'export FOO=bar' > .envrc
$ direnv allow
$ direnv edit
$ cd ..
$ cd -
```

* Auto-load
* Auto-unload
* Safe by default

---

## Hot Reload

Reload, Don’t Restart

```sh
source ~/.zshrc
```

⚡️ Iterate fast.

---

## Takeaways

* Press Tab
* Seriously, press Tab
* History is powerful
* fzf makes it swagtastic
* Did I mention press Tab?

---

## Special Thanks

<img
    src="https://lh3.googleusercontent.com/pw/AP1GczNjv0M6JmVMtNiWJe8PXEkRiyyebb0OVPkIZQK-r3uuD2hXSksRxOAaNnHSDeeph040tGTpprsmbjPebpH_1hovPCViH-EcaCTTCIxUCOwZYvkdoYQus3Px4J4z7oFgvoQM42ajCPiRgu_0br4sjJwIBQ=w1144-h1524-s-no?authuser=0"
    style="max-height: 450px; object-fit: contain;"
/>

Thanks to Saturn and Neptune,<br />
for whatever it is they are doing.

