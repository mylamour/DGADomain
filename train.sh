#!/usr/bin/env bash
#
# Copyright (c) 2018-present, Mour, Inc.
# All rights reserved.
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree. An additional grant
# of patent rights can be found in the PATENTS file in the same directory.

dgafile="dga.txt"
legitfile="all_legit.txt"

if [ ! -f "$dgafile" ];
then
    echo "$0: File '${dgafile}' not found. We Will Start Download It!"
    wget http://data.netlab.360.com/feeds/dga/dga.txt
fi

if [ ! -f "$legitfile" ];
then
    echo "$0: File '${legitfile}' not found. We Will Start Download It!"
    wget https://raw.githubusercontent.com/andrewaeva/DGA/master/all_legit.txt
fi

sed '1,18d' dga.txt | awk '{print "__label__"$1 " " $2}' > dga.train
awk '{print "__label__normal" " " $1}' all_legit.txt > legit.train
cat dga.train legit.train > data.train

echo "Your Training Results Would be in  demo folder"
mkdir -p demo && mv data.train demo && cd demo

command -v fasttext >/dev/null 2>&1 || { echo >&2 "Please Make Sure your fastext was installed.  Aborting."; exit 1; }

fasttext supervised -input data.train -output dga.model

echo "Trainging Over. Now We Computing the precision and recall at k"
fasttext test dga.model.bin data.train 1

echo "
You can try it with below this:
* fasttext supervised -input train.txt -output model
* fasttext supervised -input train.txt -output model -epoch 250
* fasttext test model.bin test.txt 1
* fasttext predict model.bin test.txt k
* fasttext predict dga.model.250e.bin -
* fasttext predict dga.model.250e.bin - 5
* fasttext predict-prob model.bin test.txt k
* fasttext print-sentence-vectors model.bin < text.txt
"