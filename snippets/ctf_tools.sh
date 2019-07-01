pacman -S gdb capstone binwalk qemu ding-libs unicorn
pacman -S checksec ropper radare2
pacman -S python-opengl arj cpio mtd-utils p7zip squashfs-tools unrar
yolo -S ropgadget
mkvirtualenv -p /usr/bin/python2.7 ctf || workon ctf
pip install angr pwntools
# panda #TODO
# angr
#pwntools
# afl+ qemu (installed previously)
git clone https://github.com/zardus/preeny.git ~/progs/src/preeny && cd + make
git clone https://github.com/wapiflapi/villoc ~/progs/src/villoc
git clone https://github.com/pwndbg/pwndbg ~/progs/src/pwndbg
