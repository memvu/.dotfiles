

1. Install Apple's Command Line Tools, which are prerequisites for Git and Homebrew.

```zsh
xcode-select --install
```

2. Set up SSH key

3. Clone repo into new hidden directory.

```zsh
git clone git@github.com:hondeorua/.dotfiles.git
```

4. Run script to set up everything (well not system preferences yet)

```zsh
cd ~/.dotfiles/
./setup.sh
```

## if wanna use firecrawl, it needs api key, the current setup store key in .env, which is not
tracked by git. if create .env, remember to chmod 600 .env.




## TODO List

- Learn how to use [`defaults`](https://macos-defaults.com/#%F0%9F%99%8B-what-s-a-defaults-command) to record and restore System Preferences and other macOS configurations.
- Change keymap for harpoon for instant access even in insert mode
- Write own plugin for live-preview
    - python3 -m http server
    - auto reload
    - keymap
    - auto close serve
)!
