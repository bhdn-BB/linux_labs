
echo "User: $(who)"
echo "OS: $(uname -a)"
echo "Date: $(date)"
echo "Directory: $(pwd)"

export UNIVERSITY="KPI"
echo "Env: $(env | grep UNIVERSITY)"

echo "PATH: $PATH"

mkdir -p ~/cat_001
cd ~/cat_001
echo "After cd: $(pwd)"

echo "Dirs: $(dirs)"

shopt -s expand_aliases
alias hi='echo Alias works'
hi
