# dotfiles

## a few neat features

- zsh configured with [prezto](https://github.com/sorin-ionescu/prezto).
- nice fonts for the terminal and coding.
- Mac packages installed with [homebrew][]. Mac apps installed with [homebrew-cask][] and [mas][].
- Useful git aliases
- Optional git commit signing with GPG

## prerequisites

- homebrew (If on macOS) - **Install this first**
- git: `brew install git`
- ansible >= 1.6: `brew install ansible`

## install

- [Fork](https://github.com/sloria/dotfiles/fork) this repo.
- Clone your fork.

```bash
# Replace git url with your fork
# NOTE: It is important that you clone to ~/dotfiles
git clone https://github.com/YOU/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

- Update the following variables in `group_vars/local` (at a minimum)
  - `full_name`: Your name, which will be attached to commit messages, e.g. "Steven Loria"
  - `git_user`: Your Github username.
  - `git_email`: Your git email address.
- Optional, but recommended: Update `group_vars/local` with the programs you want installed by [homebrew][], [homebrew-cask][], and npm.
  - `mac_homebrew_packages`: Utilities that don't get installed by the roles.
  - `mac_cask_packages`: Mac Apps you want installed with [homebrew-cask][].
- Edit `local_env.yml` as you see fit. Remove any roles you don't use. Edit roles that you do use.
- Run the installation script.

```bash
./bin/dot-bootstrap
```

## updating your local environment

Once you have the dotfiles installed you can run the following command to rerun the ansible playbook:

```bash
dot-update
```

You can optionally pass role names

```bash
dot-update git python
```

## commands

There are three main commands in the `bin` directory for setting up and updating development environments:

- `dot-bootstrap`: sets up local environment by executing all roles in `local_env.yml`.
- `dot-update`: updates local environment by executing all roles in `local_env.yml` except for the ones tagged with "bootstrap".

## special files

All configuration is done in `~/dotfiles`. Each role may contain (in addition to the typical ansible directories and files) a number of special files

- **role/\*.zsh**: Any files ending in `.zsh` get loaded into your environment.
- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.

## notes

**vscode**

Use built-in Settings Sync to sync VSCode settings.

**macOS keyboard settings**

There are a few keyboard customizations that must be done manually:

- Turning repeat speed up to 11.

![Keyboard settings](https://user-images.githubusercontent.com/2379650/34223505-91f95072-e58d-11e7-9b36-78aec4203b0d.png "Key repeat settings")

- Mapping Caps Lock to Ctrl.

![Modifier keys](https://user-images.githubusercontent.com/2379650/34223523-a2c8e4e4-e58d-11e7-9532-d74b95d8408a.png)

**login message**

You can add a message to the login screen using the following command:

```
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "This laptop is connected to an iCloud account and is valueless if lost. Contact (123) 456-7890 if found. Reward included."
```

## troubleshooting

If you get an error about Xcode command-line tools, you may need to run

```
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```
