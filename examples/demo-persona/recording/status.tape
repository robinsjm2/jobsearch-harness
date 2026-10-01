Output status.mp4

Set Shell zsh
Set FontSize 15
Set Width 1400
Set Height 900
Set Padding 20
Set TypingSpeed 40ms
Set WaitTimeout 20m
Set Theme "Catppuccin Mocha"

Hide
Type "for v in ${(k)parameters[(I)CLAUDE*]}; do unset $v; done; export PATH=$HOME/.local/bin:/opt/homebrew/bin:$PATH PS1='$ ' && cd /Users/Shared/jobsearch-demo && ./.recording/card.sh 'application status check' start"
Enter
Sleep 1s
Show
Sleep 6s
Hide
Type "clear"
Enter
Sleep 500ms
Show

Type "claude"
Enter
Wait+Screen@60s /Try "/
Sleep 3s
Type "Any updates on my applications? Check my email and update my tracker, including anything that's missing."
Sleep 1s
Enter
Wait+Screen /· done \d/
Sleep 10s
Hide
Type "/exit"
Enter
Sleep 2s
Type "./.recording/card.sh 'application status check' end"
Enter
Sleep 1s
Show
Sleep 6s
