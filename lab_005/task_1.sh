
echo "==1 Create file=="
echo "Hello laboratory 5!" > bohdan_005.txt
ls -l

echo "==2 Create user and group=="
if ! getent group laba5_group > /dev/null; then
    sudo groupadd laba5_group
fi
if ! id bohdan_02 > /dev/null 2>&1; then
    sudo useradd -m bohdan_02
fi
sudo usermod -aG laba5_group "$(whoami)"
sudo usermod -aG laba5_group bohdan_02
sudo chgrp laba5_group bohdan_005.txt
groups "$(whoami)"
groups bohdan_02

echo "==3 File permissions=="
chmod u=rw,g=rw,o=r bohdan_005.txt
stat -c '%A %a %U %G %n' bohdan_005.txt

echo "==4 Home directory permissions=="
stat -c '%A %a %U %G %n' "$HOME"

echo "==5 Read file=="
cat bohdan_005.txt

echo "==6 Remove read permission for owner and group=="
chmod ug-r bohdan_005.txt
stat -c '%A %a %U %G %n' bohdan_005.txt
cat bohdan_005.txt || echo "Reading is denied for the file owner"

echo "==7 Remove write permission from file=="
chmod u=rw,g=rw,o=r bohdan_005.txt
chmod a-w bohdan_005.txt
echo "This text must not be added" >> bohdan_005.txt || echo "Writing is denied"
rm bohdan_005.txt
echo "The file was removed because deletion depends on directory permissions"
echo "Hello laboratory 5 again!" > bohdan_005.txt
sudo chgrp laba5_group bohdan_005.txt
chmod a=r bohdan_005.txt

echo "==8 Remove write permission from directory=="
chmod u-w .
rm bohdan_005.txt || echo "Deletion is denied because the directory is not writable"
chmod u+w .
ls -l bohdan_005.txt

echo "==9 Create subdirectory and file=="
mkdir -p subcatalog
echo "Text inside subdirectory" > subcatalog/subfile.txt
chmod u=rwx,go=rx subcatalog
stat -c '%A %a %U %G %n' subcatalog
ls -la subcatalog

echo "==10 Remove execute permission from subdirectory=="
chmod u-x subcatalog
stat -c '%A %a %U %G %n' subcatalog

echo "==11 Try to enter subdirectory=="
cd subcatalog || echo "Cannot enter the subdirectory without execute permission"

echo "==12 Try to list subdirectory=="
ls subcatalog
ls -l subcatalog || echo "Names are visible, but metadata is unavailable without execute permission"
cat subcatalog/subfile.txt || echo "The file cannot be opened without execute permission on the directory"
chmod u+x subcatalog
