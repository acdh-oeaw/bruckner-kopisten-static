# bin/bash

rm main.zip
rm -rf ./data
wget https://github.com/acdh-oeaw/bruckner-kopisten-data/archive/refs/heads/main.zip
unzip main
mv bruckner-kopisten-data-main/data ./data
rm -rf bruckner-kopisten-data-main
rm main.zip
