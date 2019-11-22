OPEN_NMT_PATH=OpenNMT-py
DATA_PATH=EN_PT-BR
TRAIN_PATH=$DATA_PATH/corpus_treinamento
TEST_PATH=$DATA_PATH/corpus_teste
SRC_LAN=en
TGT_LAN=pt

mkdir -p $DATA_PATH/nmt_model $TRAIN_PATH/preprocessed

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

# Preprocessing
echo "Preprocessing"
python3 $OPEN_NMT_PATH/preprocess.py \
    -train_src $TRAIN_PATH/fapesp-v2.pt-en.train.en.atok \
    -train_tgt $TRAIN_PATH/fapesp-v2.pt-en.train.pt.atok \
    -valid_src $TRAIN_PATH/fapesp-v2.pt-en.dev.en.atok \
    -valid_tgt $TRAIN_PATH/fapesp-v2.pt-en.dev.pt.atok \
    -save_data $TRAIN_PATH/preprocessed/fapesp-v2.atok.low \
    -lower
