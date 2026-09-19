
echo "==create file=="
echo "The forest becomes quiet after heavy rain" > nature.txt
echo "Wild birds fly over the green valley" >> nature.txt
echo "The river flows slowly between high mountains" >> nature.txt
echo "Bright sunlight reaches the forest in the morning" >> nature.txt
cat nature.txt

echo "==stdin=="
wc -w < nature.txt
nature=$(< nature.txt)
echo "$nature"

echo "==stdout=="
echo "The weather is sunny today" > output1.txt
echo "Content of output.txt:"
cat output1.txt

echo "==stderr=="
echo "Trying to open a missing file:"
ls missing_file_ht94hy43y34.txt 2> errors.log
echo "Error was saved to errors.log:"
cat errors.log

echo "==stdout and stderr=="
ls nature.txt missing_file_ht94hy43y34.txt > stdout.log 2> stderr.log
echo "Normal output:"
cat stdout.log
echo "Errors:"
cat stderr.log

echo "==append=="
echo "The wind is strong" > weather.txt
echo "The sky is cloudy" >> weather.txt
echo "The temperature is low" >> weather.txt
cat weather.txt

echo "==pipe=="
cat nature.txt | grep "forest"

echo "==grep -i=="
grep -i "FoREsT" nature.txt

echo "==grep -v=="
grep -v "forest" nature.txt

echo "==grep -n=="
grep -n "The" nature.txt

echo "==regex start=="
grep "^The" nature.txt

echo "==regex end=="
grep "rain$" nature.txt

echo "==regex OR=="
grep -E "birds|river" nature.txt

echo "==pipe chain=="
cat nature.txt | grep "The" | wc -

echo "==regex phone numbers=="
echo "+14155552671" > phones.txt
echo "+442071838750" >> phones.txt
echo "+4915123456789" >> phones.txt
echo "+33142345678" >> phones.txt
echo "+380671234567" >> phones.txt
cat phones.txt
echo "Ukrainian number:"
grep -E "^\+380" phones.

echo "==sort numbers=="
echo "42" > numbers.txt
echo "7" >> numbers.txt
echo "105" >> numbers.txt
echo "18" >> numbers.txt
echo "3" >> numbers.txt
echo "Original:"
cat numbers.txt
echo "Sorted:"
sort -n numbers.txt
