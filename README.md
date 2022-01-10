# betterScale
Better Scale helps Gnome &amp; Budgie x11 users perfectly scale their desktop.

Uses a similar concept as scaling on macs by enabling Gnomes experimental scaling support & increasing the graphics framebuffer. Then betterScale will scale the framebuffer back down using xrandr.

## betterScale v0.1
- Single monitor only
- Gnome & Budgie support only

## Instructions
Simply copy the repo & run the setup file. That's it.
```
git clone https://github.com/rbreaves/betterScale.git
cd betterScale
./setup.sh
```

## TODO
- Support multi-monitor (already done but not scripted yet)
- Support custom scale percentages &/or resolution destinations
- Combine with xeventbind & systemd to daemonize betterScale (will prompt user to re-apply if set resolution ever changes)

Resources
https://wiki.archlinux.org/title/HiDPI
