#!/bin/bash

declare -i counter=1
declare -i ledCount=$1 #parameter

if [[ $ledCount -eq 0 ]]; then
    ledCount=50
fi

walk_dir () {    
    shopt -s nullglob dotglob

    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            walk_dir "$pathname"
        else
            case "$pathname" in
                *.wled|*.doc)
                {
                    filename="$(basename $pathname)"
                    prefix="${filename%.*}"
                    printf ',"%u":{"n":"%02u %s","ql":"%02u","on":true,"bri":32,"transition":7,"mainseg":0,"seg":[{"id":0,"start":0,"stop":%u,"grp":1,"spc":0,"of":0,"on":true,"bri":255,"n":"%s","col":[[255,160,0],[0,0,0],[0,0,0]],"fx":187,"sx":128,"ix":128,"f1x":128,"f2x":128,"f3x":128,"pal":11,"sel":true,"rev":false,"rev2D":false,"mi":false,"rot2D":false},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0}]}\n' "$counter" "$counter" "$prefix" "$counter" "$ledCount" "$prefix" >> presets.json
                    counter=counter+1
                }
            esac
        fi
    done
}

touch presets.json

printf '{"0":{}\n' > presets.json
printf ',"1":{"n":"01 Drip","ql":"01","on":true,"bri":32,"transition":7,"mainseg":0,"seg":[{"id":0,"start":0,"stop":%u,"grp":1,"spc":0,"of":0,"on":true,"bri":255,"col":[[255,160,0],[0,0,0],[0,0,0]],"fx":96,"sx":128,"ix":128,"f1x":128,"f2x":128,"f3x":128,"pal":11,"sel":true,"rev":false,"rev2D":false,"mi":false,"rot2D":false},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0},{"stop":0}]}\n' "$ledCount" >> presets.json

counter=2

walk_dir "."

printf '}\n' >> presets.json
