# Git Profile Manager

A modern **terminal UI tool** for managing multiple Git identities using directory-based configurations.

It helps developers who maintain **multiple Git accounts (personal, work, etc.)** automatically apply the correct Git identity based on the repository directory.

The tool uses Git's **`includeIf` conditional configuration** and provides a clean **TUI interface powered by `gum` and `fzf`**.

---

# Features

* Create and manage **multiple Git profiles**
* Generate a **new SSH key** or select an **existing key**
* Automatically **copy SSH public key to clipboard**
* Configure Git identity using **directory-based `includeIf` rules**
* Add multiple **repository parent paths**
* View profile configuration and associated paths
* Add additional paths to an existing profile
* Remove paths from a profile
* Delete profiles cleanly
* Automatically creates missing directories

---

# How It Works

Git Profile Manager uses Git's conditional configuration.

Example:

```ini
[includeIf "gitdir:~/Sites/personal/**"]
path = ~/.gitconfig.personal
```

This means any repository inside:

```
~/Sites/personal/
```

will automatically use:

```
~/.gitconfig.personal
```

This allows seamless switching between Git identities without modifying SSH hosts or repository URLs.

---

# Example Git Configuration

## Global config (`~/.gitconfig`)

```ini
[init]
    defaultBranch = main

[core]
    excludesfile = ~/.gitignore

[pull]
    rebase = false

[includeIf "gitdir:~/Sites/personal/**"]
path = ~/.gitconfig.personal

[includeIf "gitdir:~/Sites/company/**"]
path = ~/.gitconfig.company
```

---

## Profile config (`~/.gitconfig.personal`)

```ini
[user]
email = example@gmail.com
name = Your Name

[github]
user = "username"

[core]
sshCommand = "ssh -i ~/.ssh/personal_key -o IdentitiesOnly=yes"
```

---

# Installation

Currently the installer supports **Arch Linux**.

Run:

```bash
curl -fsSL https://raw.githubusercontent.com/rahulprgrmr/git-profile-manager/main/install.sh | bash
```

This will:

* install `git-profile-manager`
* install required dependencies
* place the executable in `~/.local/bin`

---

# Dependencies

The installer installs the following packages:

```
gum
fzf
wl-clipboard
openssh
curl
```

Manual installation (Arch Linux):

```bash
sudo pacman -S gum fzf wl-clipboard openssh curl
```

---

# Usage

Run the tool:

```bash
git-profile-manager
```

You will see a menu:

```
Add Git Profile
List Profiles
Add Path to Profile
Remove Path from Profile
Delete Profile
Exit
```

---

# Creating a Profile

Steps performed by the tool:

1. Enter profile name
2. Enter Git name and email
3. Generate a new SSH key or choose an existing key
4. Public key is copied to the clipboard
5. Add repository parent directories

Example directories:

```
~/Sites/personal
~/Personal
```

The tool automatically:

* creates missing directories
* creates `.gitconfig.<profile>`
* updates `~/.gitconfig`

---

# Adding Additional Paths

You can attach new directories to an existing profile.

Example:

```
~/Work
```

Any repository inside that directory will automatically use the selected Git profile.

---

# Removing Paths

Removes a directory mapping from a profile and cleans the corresponding `includeIf` rule.

---

# Deleting Profiles

Deleting a profile will:

* remove `~/.gitconfig.<profile>`
* remove all `includeIf` entries pointing to it from `~/.gitconfig`

---

# Directory Structure Example

```
~/Sites
 ├── personal
 │   ├── project1
 │   └── project2
 │
 └── company
     ├── backend
     └── frontend

~/Personal
 ├── dotfiles
 └── scripts
```

Git identities automatically apply based on the directory.

---

# Why This Tool Exists

Managing multiple Git accounts often requires:

* SSH host aliases
* modifying repository URLs
* manually switching Git identity

Git Profile Manager avoids these issues by using Git's built-in **conditional configuration system**.

Once configured, you can clone repositories normally:

```bash
git clone git@github.com:user/repo.git
```

and the correct identity will be applied automatically.

---

# Recommended Workflow

Organize repositories like:

```
~/Sites/personal
~/Sites/company
~/Personal
```

Each directory maps to a Git profile.

---

# License

MIT License
