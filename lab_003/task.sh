
mkdir -p ~/cat_002
cd ~/cat_002
echo "Current directory: $(pwd)"
cd -

echo "==touch=="
touch bohdan_001.txt bohdan_002.txt
ls -l

echo "==cp=="
cp bohdan_001.txt bohdan_copy_001.txt
ls -l

echo "==mv=="
mv bohdan_002.txt bohdan_renamed_002.txt
ls -l

echo "==file=="
echo "Hello world!" > bohdan_003.txt
file bohdan_003.txt

echo "==file globbing"
echo "loss = 0.0001" > training_score_matching_unet_fold_001.log
echo "*.txt"
ls *.txt

echo "==?=="
touch abc1.txt abc2.txt abc3.txt abc04.txt
ls abc?.txt

echo "==*.log=="
ls *.log

echo "==find=="
find . -type f -name "*.log"

echo "==rm=="
touch bohdan_123.txt
find . -type f -name bohdan_123.txt
rm bohdan_123.txt
find . -type f -name bohdan_123.txt

echo "==tar=="
tar -cvf submit_001.tar abc?.txt
ls -lh submit_001.tar

echo "==gzip=="
gzip -k submit_001.tar
ls -lh submit_001.tar.gz

echo "==bzip2=="
bzip2 -k submit_001.tar
ls -lh submit_001.tar.bz2

echo "==zip=="
zip final_submit.zip abc?.txt
ls -lh final_submit.zip

echo "=== dd / cat ==="
mkdir -p source test
echo "Creating 10 MB file: source/test.img"
dd if=/dev/zero of=source/test.img bs=1M count=10 status=none
echo "Copying with cat: source/test.img -> test/test_cat.img"
time cat source/test.img > test/test_cat.img
echo "Copying with dd: source/test.img -> test/test_dd.img"
time dd if=source/test.img of=test/test_dd.img bs=1M status=none
ls -lh source/test.img test/

