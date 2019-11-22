OPEN_NMT_PATH=OpenNMT-py
DATA_PATH=EN_PT-BR
TRAIN_PATH=$DATA_PATH/corpus_treinamento
TEST_PATH=$DATA_PATH/corpus_teste
SRC_LAN=en
TGT_LAN=pt

# Translation
echo "Translating"
python3 $OPEN_NMT_PATH/translate.py \
    -model $DATA_PATH/trained_model/nmt_model_*_100000.pt \
    -src $TEST_PATH/nmte.pt-en.test-a.en.atok \
    -tgt $TEST_PATH/nmte.pt-en.test-a.pt.atok \
    -replace_unk \
    -output $TEST_PATH/nmte.output.pt