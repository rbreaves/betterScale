# betterScale
BetterScale helps Gnome &amp; Budgie x11 users perfectly scale their desktop.

This is something any HiDPI laptop, or even normal HD, user may want as it will properly scale to a size that is easily readable while remaining fully clear,crisp and sharp. No more messing around with dot files and setting DPI parameters all throughout your system.

BetterScale uses a similar concept for scaling as macs do by enabling Gnomes experimental scaling support & increasing the graphics framebuffer. Then betterScale will scale the framebuffer back down using xrandr.

<img src="https://i.imgur.com/u1zuBli.jpg" width="75%" height="75%">
<img src="https://i.imgur.com/Tsv3ril.jpeg" width="25%" height="25%">

### betterScale v0.1
- Single monitor only
- Gnome & Budgie support only

### Instructions
Simply copy the repo & run the setup file. That's it.
```
git clone https://github.com/rbreaves/betterScale.git
cd betterScale
./setup.sh
```

### TODO
- [Support multi-monitor (already done but not scripted yet)](https://www.reddit.com/r/UsabilityPorn/comments/ryo099/1920x1080_monitor_w_2880x1800_macbook_perfectly/)
- Support custom scale percentages &/or resolution destinations
- Combine with xeventbind & systemd to daemonize betterScale (will prompt user to re-apply if set resolution ever changes)


### Resources

https://wiki.archlinux.org/title/HiDPI
