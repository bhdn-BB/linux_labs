trap 'jobs -pr | xargs -r kill 2>/dev/null' EXIT

echo "==ps=="
ps -o pid,ppid,stat,ni,comm -p $$
ps aux | head

echo "==jobs, bg and fg=="
set -m
sleep 2 &
kill -STOP "$!"
sleep 1
jobs -l
bg %1
jobs -l
fg %1

echo "==SIGHUP=="
sleep 300 &
kill -HUP "$!"
wait "$!" 2>/dev/null

echo "==SIGTERM=="
sleep 300 &
kill -TERM "$!"
wait "$!" 2>/dev/null

echo "==SIGKILL=="
sleep 300 &
kill -KILL "$!"
wait "$!" 2>/dev/null

echo "==pgrep and killall=="
cp "$(command -v sleep)" ./lab7_wait
chmod u+x ./lab7_wait
./lab7_wait 300 &
./lab7_wait 300 &
pgrep -a -x lab7_wait
killall lab7_wait
wait 2>/dev/null

echo "==pgrep and pkill=="
./lab7_wait 300 &
pgrep -a -x lab7_wait
pkill -TERM -x lab7_wait
wait 2>/dev/null

echo "==nohup=="
nohup sh -c 'sleep 1; echo "nohup process completed"' > nohup.log 2>&1 &
ps -o pid,ppid,stat,comm -p "$!"
wait "$!"
cat nohup.log

echo "==screen=="
if command -v screen > /dev/null; then
    screen -dmS lab7_screen sh -c 'sleep 30'
    screen -ls
    screen -S lab7_screen -X quit
else
    echo "screen is not installed"
fi

echo "==top=="
top -b -n 1 | head -n 15

echo "==htop=="
if command -v htop > /dev/null; then
    htop --version
else
    echo "htop is not installed"
fi

echo "==free=="
free -h

echo "==nice and renice=="
nice -n 10 sleep 30 &
ps -o pid,ni,stat,comm -p "$!"
renice 15 -p "$!"
ps -o pid,ni,stat,comm -p "$!"
kill -TERM "$!"
wait "$!" 2>/dev/null
set +m
