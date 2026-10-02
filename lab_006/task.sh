
mkdir -p owner_directory
echo "Ownership demonstration" > owner_file.txt
ln -sfn owner_file.txt owner_link

echo "==id and whoami=="
id
whoami

echo "==chown for file, directory and symbolic link=="
sudo chown "nobody:$(id -gn nobody)" owner_file.txt
sudo chown "nobody:$(id -gn nobody)" owner_directory
sudo chown -h "nobody:$(id -gn nobody)" owner_link
ls -ld owner_file.txt owner_directory owner_link
sudo chown "$(whoami):$(id -gn)" owner_file.txt
sudo chown "$(whoami):$(id -gn)" owner_directory
sudo chown -h "$(whoami):$(id -gn)" owner_link

echo "==umask=="
mkdir -p umask_demo
touch umask_demo/default_file.txt
mkdir -p umask_demo/default_directory
umask
stat -c '%A %a %n' umask_demo/default_file.txt umask_demo/default_directory
(
    umask 027
    touch umask_demo/restricted_file.txt
    mkdir -p umask_demo/restricted_directory
    umask
)
stat -c '%A %a %n' umask_demo/restricted_file.txt umask_demo/restricted_directory

echo "==hard and symbolic links=="
mkdir -p links_demo
echo "Original text" > links_demo/original.txt
ln links_demo/original.txt links_demo/hard_link.txt
ln -s original.txt links_demo/symbolic_link.txt
ls -li links_demo
echo "Added through hard link" >> links_demo/hard_link.txt
cat links_demo/original.txt
rm links_demo/original.txt
cat links_demo/hard_link.txt
cat links_demo/symbolic_link.txt || echo "The symbolic link is broken after deleting its target"
