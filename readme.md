using fasttext to classify DGA domain(Domain Generation Algorithm)

* step1 : install fasttext, you can follow this tutorial: https://github.com/facebookresearch/fastText#building-fasttext

* step2 : run `train.sh`


also, i try to train it with different epochs, you can see it in below lines.
**Notice**: May be difference in your compute
```shell
$ fasttext supervised -input dga.txt -output dga.model
Read 3M words
Number of words:  1144820
Number of labels: 43
Progress: 100.0% words/sec/thread:   82367 lr:  0.000000 loss:  0.481382 ETA:   0h 0m

$ fasttext supervised -input dga.txt -output dga.model.25e  -epoch 25
Read 3M words
Number of words:  1144820
Number of labels: 43
Progress: 100.0% words/sec/thread:   79372 lr:  0.000000 loss:  0.120817 ETA:   0h 0m

$ fasttext supervised -input dga.txt -output dga.model.250e  -epoch 250
Read 3M words
Number of words:  1144820
Number of labels: 43
Progress: 100.0% words/sec/thread:   76673 lr:  0.000000 loss:  0.013514 ETA:   0h 0m
```

```shell
$ fasttext test dga.model.25e.bin dga.txt 1
N       1167495
P@1     0.986
R@1     0.986
Number of examples: 1167495

$ fasttext test dga.model.bin dga.txt 1
N       1167495
P@1     0.944
R@1     0.944
Number of examples: 1167495

$ fasttext test dga.model.250e.bin dga.txt 1
N       1167495
P@1     1
R@1     1
Number of examples: 1167495
```