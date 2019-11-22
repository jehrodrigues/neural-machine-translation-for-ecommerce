OPEN_NMT_PATH=OpenNMT-py
DATA_PATH=EN_PT-BR
TRAIN_PATH=$DATA_PATH/corpus_treinamento
TEST_PATH=$DATA_PATH/corpus_teste
SRC_LAN=en
TGT_LAN=pt

# Test
echo "Testing"

# Tokeniza textos
echo "Tokenizing texts"
for l in $SRC_LAN $TGT_LAN
do
    for f in $TRAIN_PATH/*.$l
    do
        if [ ! -f $f.atok ]; then
            perl tokenizer.perl -a -no-escape -l $l -q  < $f > $f.atok;
        fi
    done

    for f in $TEST_PATH/*.$l
    do
        if [ ! -f $f.atok ]; then
            perl tokenizer.perl -a -no-escape -l $l -q < $f > $f.atok;
        fi
    done
done

echo "Calculating ROUGE"
cd $OPEN_NMT_PATH
python3 -m tools.test_rouge \
      -c ../$TEST_PATH/nmte.output.pt.atok \
      -r ../$TEST_PATH/nmte.pt-en.test-a.pt.atok

echo "Calculating BLEU"
cd ..
perl $OPEN_NMT_PATH/tools/multi-bleu.perl $TEST_PATH/nmte.pt-en.test-a.pt.atok < $TEST_PATH/nmte.output.pt.atok