# Config

NOTE: This hasn't been updated in quite a while. If you're using this yourself,
what you find under the cut may not be accurate anymore.

<details>
<summary>old config</summary>

## i3config

| Keybind | Command | Notes |
| ------: | :------ | :---- |
| Mod | alt | |
| $mod+Return | Start a terminal | |
| $mod+Shift+q | Kill the window | |
| $mod+F4 | Kill the window | |
| $mod+d | Run dmenu | |
| $mod+h | Focus to the left | Default window mode |
| $mod+l | Focus to the right | Default window mode |
| $mod+j | Focus to the down | Default window mode |
| $mod+k | Focus to the up | Default window mode |
| $mod+Shift+h | Move window to the left | |
| $mod+Shift+l | Move window to the right | |
| $mod+Shift+j | Move window to the down | |
| $mod+Shift+k | Move window to the up | |
| $mod+slash | Split in horizontal direction | |
| $mod+apostrophe | Split in vertial direction | |
| $mod+grave | Lock computer | |
| h, j, k, l | Resize a window | Resize mode |
| $mod+r | Enter or exit resize mode | |
| PrintScr | Take a picture of the whole screen | |
| Shift+PrintScr | Take a picture of the selected window | |
| $mod+t | Execute firetools | |
| $mod+i | Move window to scratchpad | |
| $mod+u | Move window from scratchpad | |

## ranger

| Keybind | Command | Notes |
| ------: | :------ | :---- |
| DD | Move file to trash | Uses `gio` |
| Dl | List files in trash | Uses `gio` |
| F3 | Toggle image previews | |
| F5 | Kill image previewer | |

## tmux

| Keybind | Command | Notes |
| ------: | :------ | :---- |
| C-v     | Prefix | |
| / | Split horizontally | |
| " | Split vertically | |
| ; or : | Show command prompt | |
| h, j, k, l | Select/move/resize windows | |
| v | Starts selection | Copy mode |
| y | Copies (yanks) selection | Copy mode |
| C-q | Toggles rectangle copy | Copy mode |
| % | Select last window | |
| \` | Toggles status line | |

## vim

| Keybind | Command | Notes |
| ------: | :------ | :---- |
| <C-e\> | | Leader |
| Leader+r | Execute file | python, shell, html, markdown, javascript, etc. |
| Leader+n | Edit next file | |
| Leader+p | Edit previous file | |
| Leader+x | Save and quit | |
| Leader+q | Exit without saving | |
| Leader+h | Toggle search highlighting | |
| <C-w\>tc | Create a new tab | |
| <C-w\>tq | Quit out of the tab | |
| <C-w\>tm | Moves tab to location | Must be filled in when called |
| <C-w\>"  | Splits window horizontally | |
| <C-w\>/  | Splits window vertically | |
| <C-s\>   | Saves current file | |
| ;        | Enters command mode | |
| <S-u\>   | Redo | |
| K | Move current line up 1 | |
| J | Move current line down 1 | |
| <C-c\>   | Removes margins and other visual aspects | Made for copying from tmux |

</details>
