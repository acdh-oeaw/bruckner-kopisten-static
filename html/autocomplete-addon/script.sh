# bin/bash

echo "reading config.txt"
if [ -f html/autocomplete-addon/config.txt ]
    then
        array=()
        while IFS= read -r line; do
            array+=($line)
        done < html/autocomplete-addon/config.txt
    else
        echo "config.txt not found!"
fi

projectdir=${array[1]}
inputdir=$projectdir/${array[2]}/${array[3]}
outputdir="$projectdir/autocomplete-addon"
filename="${array[0]}.txt"

if [ -f $outputdir/$filename ]
    then
        echo "$outputdir/$filename already exists; delete"
        rm -f "$outputdir/$filename"
fi

if [ -d $inputdir ]
    then
        echo "create file: $filename"
        touch "$outputdir/$filename"
        echo "open inputdir: $inputdir"
        for file in $inputdir/*.json; do
            echo $file | sed -e "s_${projectdir}/__g" >> $outputdir/$filename
        done
        echo "$filename in $outputdir created"
    else
        echo "directory with stems not found! check variables: projectdir, inputdir, outputdir and filename!"
fi