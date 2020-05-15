set ISOIFY=C:\ISOIFY
set NETDRV=C:\ISOIFY\NETDRV
mkdir %ISOIFY%
mkdir %NETDRV%
copy *.* %ISOIFY%
cd NETDRV
copy *.* %NETDRV%
C:
cd %ISOIFY%
initnet.bat
