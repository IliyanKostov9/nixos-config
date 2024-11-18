selection=$(find . -type f -o -type d | fzf --cycle --border=thinblock --border-label='| Search here |' --preview 'bat --color=always --style=numbers --theme=base16-256 --line-range=:500 {} || tree -C {}' --preview-label='Preview');

if [ -d "$selection" ]; then
    cd "$selection"
else
    cd "$(dirname "$selection")"
fi
