curl https://mtgjson.com/api/v5/AllPrintings.json |
    jq '.data | to_entries[].value.cards[].flavorText | select( . != null)' |
    sed 's/\\n/ /g' |
    sed 's/^"//g' |
    sed 's/"$//g' |
    sed 's/{[A-Z]}//g' |
    sed 's/[^a-zA-Z ]//g' |
    sed 's/^[ ]*//g' |
    sort |
    uniq >magic-flavor.txt