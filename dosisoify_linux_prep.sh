#!/bin/bash

BR='-------------------'

# Set my working directory to be the same as this script
WD="$(dirname $0)"
cd "${WD}"

# Set my image name and mount point
IMAGE="dosisoify_floppy.img"
MNTPOINT="dosisoify_floppy_mount"

mkdir "${MNTPOINT}" 2>/dev/null

# Build the image
# A 3.5" DOS floppy is 2 sides, 80 tracks, 18 sectors per track, 512 bytes per sector
echo "${BR}"
echo "Building floppy disk image..."
dd if=/dev/zero of="${IMAGE}" bs=512 count=$((2*80*18))
sync
mkfs.vfat -F12 -n DOSISOIFY -I -v "${IMAGE}"
sync
echo "Floppy disk image complete"

# Mount the image
sudo umount -f "${MNTPOINT}" 2>/dev/null
sudo mount -o loop,uid=$(id -u),gid=$(id -g) "${IMAGE}" "${MNTPOINT}"
echo "${BR}"
echo "Floppy image mounted to:"
df -hT "${MNTPOINT}"

echo "${BR}"
echo "Downloading necessary tools..."
mkdir downloads 2>/dev/null
cd downloads

## SHSUCD CD mounting tools
## http://adoxa.altervista.org/shsucdx/index.html
#wget -c --content-disposition 'http://adoxa.altervista.org/shsucdx/dl.php?f=shsucd'
wget -c 'http://adoxa.altervista.org/shsucdx/shcd3-5.zip'
mkdir shcd3-5 2>/dev/null
unzip -o shcd3-5.zip -d shcd3-5

## unzip
wget -c 'http://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/repositories/1.2/archiver/unzip.zip'
mkdir unzip 2>/dev/null
unzip -o unzip.zip -d unzip

## mtcp
wget -c 'http://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/repositories/1.2/net/mtcp.zip'
mkdir mtcp 2>/dev/null
unzip -o mtcp.zip -d mtcp

## wget
wget -c 'http://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/repositories/1.2/net/wget.zip'
mkdir wget 2>/dev/null
unzip -o wget.zip -d wget

## CWSDMPI - DOS Protected Mode Interface - libraries for tools
wget -c 'http://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/repositories/1.2/util/cwsdpmi.zip'
mkdir cwsdmpi 2>/dev/null
unzip -o cwsdpmi -d cwsdmpi

## Crynwr open source DOS Packet Drivers
wget -c 'http://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/repos/net/crynwr.zip'
mkdir crynwr 2>/dev/null
unzip -o crynwr.zip -d crynwr

echo "${BR}"
echo "Copying tools to floppy image..."

cp -vf ./shcd3-5/shsucdx.com ../${MNTPOINT}/
cp -vf ./shcd3-5/shsucdhd.exe ../${MNTPOINT}/
cp -vf ./mtcp/PROGS/MTCP/DHCP.EXE ../${MNTPOINT}/
cp -vf ./wget/BIN/WGET.EXE ../${MNTPOINT}/
cp -vf ./cwsdmpi/BIN/CWSDPMI.EXE ../${MNTPOINT}/

mkdir ../${MNTPOINT}/NETDRV 2>/dev/null
cp -vf crynwr/DRIVERS/CRYNWR/PCNTPK.COM ../${MNTPOINT}/NETDRV

cd ..

for i in {1..20}
  do
  uuidgen >> ${MNTPOINT}/random.cfg
done

cp -vf *.cfg *.bat ${MNTPOINT}/
unix2dos ${MNTPOINT}/*.bat
unix2dos ${MNTPOINT}/*.cfg

sync

echo "${BR}"
echo "Final floppy size"
df -hT ${MNTPOINT}


sudo umount -f "${MNTPOINT}"

echo "${BR}"
echo "Complete - ${IMAGE} is now ready."
echo 'You can copy it to a real 3.5" floppy disk,'
echo 'use it as a virtual floppy in VirtualBox,'
echo 'or use it with a Gotek style floppy emulator.'
echo ""

