
mkdir -p sgid_directory sticky_directory
touch suid_demo

if ! getent group laba5_group > /dev/null; then
    sudo groupadd laba5_group
fi
if ! id bohdan_02 > /dev/null 2>&1; then
    sudo useradd -m bohdan_02
fi

echo "==SUID=="
chmod u=rwx,go=rx suid_demo
chmod u+s suid_demo
stat -c '%A %a %U %G %n' suid_demo
find /usr/bin -type f -perm -4000 2>/dev/null | head

echo "==SGID=="
sudo chgrp laba5_group sgid_directory
chmod u=rwx,g=rwx,o=rx sgid_directory
chmod g+s sgid_directory
touch sgid_directory/inherited_group.txt
stat -c '%A %a %U %G %n' sgid_directory
stat -c '%A %a %U %G %n' sgid_directory/inherited_group.txt

echo "==Sticky bit=="
chmod a=rwx sticky_directory
chmod a+t sticky_directory
echo "File owned by $(whoami)" > sticky_directory/owner_file.txt
stat -c '%A %a %U %G %n' sticky_directory
sudo -u bohdan_02 rm sticky_directory/owner_file.txt || echo "Sticky bit prevents another user from deleting this file"
rm sticky_directory/owner_file.txt

