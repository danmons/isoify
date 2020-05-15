# ISOify
DOS ISOify - A floppy image containing all the tools needed to mount an ISO file in DOS as a virtual CDROM.

A very simple set of scripts to build a 1.44MB 3.5" Floppy Disk image with just enough tools and
* Download an ISO image to your DOS machine, from either a NAS or the Internet over HTTP
* Mount that ISO image up as a virtual CDROM, without the need for real hardware

The floppy drive image is built in Linux.  It might work in Windows10+WSL2, I don't know.  I'll try that one day.

Once created, the image can be mounted in VirtualBox, Loaded onto a Gotek/Flashfloppy style device, or raw-written to a real 3.5" 1.44MB Double Sided HD floppy disk.

I didn't make the amazing tools that these scripts downloads and organises.  In particular I'd like to thank the following projects for keeping DOS alive:
* FreeDOS, and in particular Jim Hall - http://freedos.org
* SHSUCD, and in particular Jason Hood - http://adoxa.altervista.org/shsucdx/index.html

