cat all-printings.json |
    jq '.data | to_entries[].value.cards[].flavorText | select( . != null)' |  # pull out flavor text
    sed 's/\\n/ /g' |  # replace \n with space
    sed 's/^"//g' |  # remove leading quotes
    sed 's/"$//g' |  # remove trailing quotes
    sed 's/{[A-Z]}//g' |  # remove stuff in {}
    sed 's/[^a-zA-Z ]//g' |  # remove any special characters
    sed 's/^[ ]*//g' | # remove leading white space
    sed 's/[ ]*$//g' | # remove trailing white space
    sort -u |  # sort and remove duplicates
    tr '[:upper:]' '[:lower:]' >magic-flavor.txt  # lowercase and write to file
