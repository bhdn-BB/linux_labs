for i in {1..8}
do
    printf -v num "%03d" "$i"
    mkdir "lab_$num"
done