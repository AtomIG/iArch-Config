# Keyboard Layout

This is a keyboard layout file that works with `xmodmap` or `xinit` and can be set as default 
by changing the top lines as follows (this is when you have the Xmodmap file in the `~/.config/keyboard` directory such as I do):

```` diff
#!/bin/sh

userresources=$HOME/.Xresources
- usermodmap=$HOME/.Xmodmap
+ usermodmap=$HOME/.config/keyboard/Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

````

## What does ***my*** Keyboard Layout do?

My keyboard layout switches the keys I've listed below. Why? It started because I was typing LaTeX and 
I found it was too difficult to regularly use `Shift + 4`  to regularly type `$`  to do inline math and then
stretch to reach `\` to make displayed equations. So I made the following custom layout which moves 
`$` and `\` into one key.

What you Press on Keyboard | What gets typed on screen
:-------------------------:|:------------------------:
`\`                        | `:`
`;`                        | `\`
`Shift + 4` or `$`         | `\|`
`Shift + \` or `\|`        | `;`
`Shift + ;` or `:`         | `$`
etc.
