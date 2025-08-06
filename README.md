# alt-tab
macOS has a builtin keybinding that can be used to switch between apps/windows on
the current desktop, `Move focus to active or next window`. The builtin function
behaves in a weird way occasionally, this small program is meant as a
predictable replacement.

```bash
swift build -c release
```

It will switch to the next available inactive *application* on the current desktop.

This program does not switch focus between windows of the same application, for
that, use the builtin `Move focus to next window` shortcut.

For a more complete solution see
[lwouis/alt-tab-macOS](https://github.com/lwouis/alt-tab-macos).

## Remap methods

### skhd
```bash
# ~/.skhdrc
lalt - tab : alt-tab
```

### Karabiner
```json
{
    "description": "Alt-tab for current workspace",
    "manipulators": [
        {
            "from": {
                "key_code": "tab",
                "modifiers": {
                    "mandatory": ["left_option"],
                    "optional": ["any"]
                }
            },
            "to": [{ "shell_command": "~/.local/bin/alt-tab > /tmp/.alt-tab.log" }],
            "type": "basic"
        }
    ]
}
```
