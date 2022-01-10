# betterScale
BetterScale helps Gnome &amp; Budgie x11 users perfectly scale their desktop.

This is something any HiDPI laptop, or even normal HD, user may want as it will properly scale to a size that is easily readable while remaining fully clear, crisp and sharp. No more messing around with dot files and setting DPI parameters all throughout your system.

BetterScale uses a similar concept for scaling as macs do by enabling Gnomes experimental scaling support & increasing the graphics framebuffer. Then betterScale will scale the framebuffer back down using xrandr.

**Macbook Pro Retina 2880x1800**

<img src="https://i.imgur.com/XRynAhY.jpg" width="25%" height="25%">

**Standard HD Laptop 1920x1080**

<img src="https://i.imgur.com/IbUG1kX.jpg" width="75%" height="75%">


### betterScale v0.1
- Single monitor only ([next release will support multi-monitors](https://www.reddit.com/r/UsabilityPorn/comments/ryo099/1920x1080_monitor_w_2880x1800_macbook_perfectly/))
- Gnome & Budgie support only

### Instructions
Simply copy the repo & run the setup file. That's it.
```
git clone https://github.com/rbreaves/betterScale.git
cd betterScale
./setup.sh
```

#### How to Uninstall
For now the closest thing to removal is to simply re-run the setup and select option 10. That will set your native resolution and undo the experimental GDK scaling and xrandr scaling. You can manually remove the `/usr/share/X11/xorg.conf.d/20-intel.conf` file if you want, but if you are not using intel then it will not impact you either way. The file only exists to remove tearing (happens regardless of scaling) or mouse cursor flickering issues caused by scaling.

### TODO
- [Support multi-monitor (already done but not scripted yet)](https://www.reddit.com/r/UsabilityPorn/comments/ryo099/1920x1080_monitor_w_2880x1800_macbook_perfectly/)
- Support custom scale percentages &/or resolution destinations
- Combine with xeventbind & systemd to daemonize betterScale (will prompt user to re-apply if set resolution ever changes)


### Resources

https://wiki.archlinux.org/title/HiDPI
