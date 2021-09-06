# Chromium rofi tab-switching mode


## Requirements:
0. [`rofi`](https://github.com/davatorium/rofi)
1. [`jq`](https://stedolan.github.io/jq/)
2. [`chrome-remote-interface`](https://github.com/cyrus-and/chrome-remote-interface)
3. [`xdotool`](https://github.com/jordansissel/xdotool)
3. `chrome`/`chromium` configured to run a remote debugger on port 9222. (see: [Arch wiki](https://wiki.archlinux.org/index.php/chromium#Making_flags_persistent) for persistence) `--remote-debugging-port=9222`


## Instructions
1. Clone repository
2. Alter your `rofi` config by adding `tabs:<PATH_TO_REPO>/chromium-rofi-mode.sh` to the `modi` entry or use that string when calling `rofi`


## Notes:
This idea isn't mine alone, a few others have had similar:

 - https://github.com/kevinmorio/rofi-switch-browser-tabs
 - https://github.com/davatorium/rofi/issues/214
 - (I'm sure there are more, this is merely what I encountered)

While I believe that other solutions work fine here, I like this variant made here for a few key reasons:
1. Passing the tab ID allows for a more conflict-free and stable tab-selection
2. Activating the window afterwards with `xdotool` is a subtle but super useful touch for me


## Known issues:
#### Mismatching titles
Some sites have displayed titles that do not match what is shown in the debugging interface. For example, YouTube and Google Drive are key offenders here. I'm not sure exactly what mechanism is causing this. When this happens, the tab can still be activated, but the window switching might not work as `xdotool` might not be able to match the window title name.

#### Unloaded tabs
Sometimes (primarily when a window is restored via Ctrl-Shift-t after startup), a tab can exist but not yet be loaded. Despite it showing up in the tab bar on chrome, until it is viewed and loaded, it will not show up here.
