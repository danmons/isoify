# ISOify
DOS ISOify - A floppy image containing all the tools needed to mount an ISO file in DOS as a virtual CDROM.

A very simple set of scripts to build a 1.44MB 3.5" Floppy Disk image with just enough tools and
* Download an ISO image to your DOS machine, from either a NAS or the Internet over HTTP
* Mount that ISO image up as a virtual CDROM, without the need for real hardware

The floppy drive image is built in Linux. It'll also work in Windows 10 2004 with WSL2 running a Linux install that way.

Once created, the image can be mounted in VirtualBox, Loaded onto a Gotek/Flashfloppy style device, or raw-written to a real 3.5" 1.44MB Double Sided HD floppy disk.

I didn't make the amazing tools that these scripts downloads and organises.  In particular I'd like to thank the following projects for keeping DOS alive:
* FreeDOS, and in particular Jim Hall - http://freedos.org
* SHSUCD author Jason Hood - http://adoxa.altervista.org/shsucdx/index.html
* Cyrnwr for making open source DOS packet drivers - http://crynwr.com/drivers/
* mTCP author Michael Brutman - http://www.brutman.com/mTCP/

# Usage
This has been tested on a DOS VM running on VirtualBox.  Currently there is only one packet driver for the "PCnet-FAST III (Am79C973)" network card running in bridge mode.  A larger variety of packet drivers to support more cards (virtual and real) is planned soon.

This assumes you have a DHCP server on your network.  

Run "dosisoify_linux_prep.sh" in a Linux flavour of some sort to build the floppy image.  You'll need:
* sudo access to mount/umount the loopback image
* mkfs.fvat to create the file system
* uuidgen to make some random data for a DOS SSL seed
* unzip to decompress things downloaded 
* unix2dos to convert all text files to DOS EOL encoding

It will create a floppy image called "dosisoify_floppy.img".  Mount it in VirtualBox, copy it to your Gotek/Flashfloppy USB stick, or raw-write/dd it to a real floppy.

On your DOS machine (has been tested in VirtualBox MS-DOS 6.22 and FreeDOS 1.2), navigate to A: and run "SETUP.BAT".

This will copy everything to C:\ISOIFY

Change to C: and "CD C:\ISOIFY", and run
* INITNET.BAT - this will load the packet driver into high memory and request an IP address from a DHCP server
* DEMO.BAT - this will download the FreeDOS 1.2 installer CD and mount it as your next available drive letter

TODO: 
* Add lots more packet drivers
* Attempt to load the right one automagically 
* Attempt to fetch other tools like CURL
* Find a way to support TLS1.3 for newer HTTPS connections / certificates
