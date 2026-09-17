
# Bind Ctrl+L to print "Bohdan"
bind -x '"\C-l":echo Bohdan'
# Press Ctrl+L -> prints: Bohdan
# Restore default Ctrl+L behavior (clear screen)
bind '"\C-l":clear-screen'
