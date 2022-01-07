cat all-printings.json |
    jq '.data | to_entries[].value.cards[].flavorText | select( . != null)' |
    sed 's/\\n/ /g' |
    sed 's/^"//g' |
    sed 's/"$//g' |
    sed 's/{[A-Z]}//g' |
    sed 's/[^a-zA-Z ]//g' |
    sed 's/^[ ]*//g' |
    sort |
    tr '[:upper:]' '[:lower:]' |
    uniq >magic-flavor.txt
