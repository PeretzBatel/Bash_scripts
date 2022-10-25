#! /bin/bash

is_verbose="0"
is_recursive="0"

source_files=()

unpacking_options=("gunzip" "bunzip2" "unzip" "uncompress")

function operate_archives {
    _input="$1"
    if [[ -d $_input ]]; then
        if [ "$is_recursive" = "1" ]; then
            echo "Checking files in $_input"
            for item in $_input/*; do
                operate_archives $item
            done
        fi
    elif [[ $(file $_input) =~ "Zip" ]]; then
        if [[ "$is_verbose" -eq "1" ]]; then
            echo "Extracting Zip $_input"
        fi
        unzip -o -qq $_input -d .
    elif [[ $(file $_input) =~ "gzip" ]]; then
        if [[ "$is_verbose" -eq "1" ]]; then
            echo "Extracting  gzip $_input"
        fi
        gunzip -d -f $archive

    elif [[ $(file $_input) =~ "bzip2" ]]; then
        if [[ "$is_verbose" -eq "1" ]]; then
            echo "Extracting bzip2 $_input"
        fi
        bunzip2 -f $archive
    elif [[ $(file $_input) =~ "compress'd" ]]; then
        if [[ "$is_verbose" -eq "1" ]]; then
            echo "Extracting $_input"
        fi
        uncompress -f $archive
    else
        echo "nothing to do with $_input"
    fi
}

while getopts rv option; do
    case "${option}" in
    r)
        is_recursive="1"
        ;;
    v)
        is_verbose="1"
        ;;
    esac
done

input_args="$*"
for item in ${input_args}; do
    if [ "$item" = "-r" ] || [ "$item" = "-v" ]; then
        continue
    else
        files+=("$item")
    fi
done

for archive in ${files[@]}; do
    if [[ -d $archive ]]; then

        for item in $archive/*; do
            operate_archives $item
        done
    else
        operate_archives $archive
    fi

done
