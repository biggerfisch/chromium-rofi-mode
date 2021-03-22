#!/bin/bash

if [[ "$ROFI_RETV" -eq "0" ]]; then
    # This line is kinda wacky, with the wrapping `echo -en`. However, I wasn't sure how else to do this.
    # jq pitches a fit with a null byte and generally just doesn't do escape codes well, so those needed to rendered
    # outside of it. I tried a bash for-loop on the tab list with a seperate line printing the `info`, but that
    # was about 7-10 times slower and caused a _noticable_ rofi startup delay. So, back to weird wrapping echo we are
    # jq is run with `-j` and all escape codes (incl. newline) must have an escaped backslash (`\\`).
    chrome-remote-interface list | echo -en "$(jq -rj '.[] | select(.type == "page") | ([.title[0:30] + (" " * 30)[(.title | length):30], .url] | join(" ")) + "\\0info\\x1f" + .id + "\\n"')"
else
    TAB_ID="$ROFI_INFO"
    TAB_TITLE="$(chrome-remote-interface list | jq -r --arg tab_id "$TAB_ID" 'map(select(.id == $tab_id))[] | .title')"

    # This will switch the tab to active
    chrome-remote-interface activate "$TAB_ID"

    # Activate the window that is now named the same as the tab.
    # This will sometimes fail for sites that (somehow?) set a different tab title than is displayed (google most often)
    # the printf quotes the title which means xdotool handles parens and likely other special characters
    xdotool search --name "$(printf "%q" "${TAB_TITLE}")" windowactivate
fi
