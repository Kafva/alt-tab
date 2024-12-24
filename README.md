# alt-tab
macOS has a builtin keybinding that can be used to switch between windows on
the current desktop: `Move focus to active or next window`. This function
behaves in a weird way occasionally, this small program is meant as a
predictable replacement. It will switch to the next available inactive window
on the current desktop. Use Karabiner elements with `shell_command` to map it
to an actual key. It is only meant to work well for workflows with two windows
per desktop.

```bash
swift build -c release
```

For a more complete solution see [lwouis/alt-tab-macOS](https://github.com/lwouis/alt-tab-macos).
