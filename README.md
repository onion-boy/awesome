screenshots:
![dashboard screenshot](https://i.imgur.com/iZrANXx.png)
![spotify screenshot](https://i.imgur.com/cigYkAJ.png)
![spotify screenshot](https://i.imgur.com/UxaWP7V.png)

### Installing (from scratch)
- install `xorg-server xorg-xinit awesome xterm spotify firefox-developer-edition wget alsa-utils vlc xfce4-taskmanager xfce4-power-manager xfce4-settings scrot pcmanfm picom geany file-rooler dmenu`
- clone into `~/.config/awesome`
```
cd ~/.config
git clone https://github.com/onion-boy/awesome
```
- install fonts: | `space mono` | `cascadia code` | `red hat display` |
- copy spotify cli script to bin (credit to [@streetturle](https://github.com/streetturtle)) ([link](https://gist.github.com/streetturtle/fa6258f3ff7b17747ee3))
```
cp util/spotify/sp /usr/local/bin/
```
- move `picom.conf`
```
mv picom.conf ~/.config/picom.conf
```
- add to `.xinitrc`
```
exec awesome
```

### Installing (basic)
- install fonts: | `space mono` | `cascadia code` | `red hat display` |
- copy `util/spotify/sp` to bin (credit to [@streetturle](https://github.com/streetturtle)) ([link](https://gist.github.com/streetturtle/fa6258f3ff7b17747ee3))
- move `picom.conf`

### Plan
- populate notification section
- add brightness/volume slider
- add process monitor
- add alt tab widget
- add more dockbar icons
- make dockbar icons usable
- finish dock popup on the right

### Issues
- There is some issue with this repository getting corrupted on my computer, so I have had to replace the master branch like 4 times which is why the commits are messed up
- Annoying glitch where the order of the dock icons gets changed 
- `client.get()` or `screen.all_clients` both returning empty tables