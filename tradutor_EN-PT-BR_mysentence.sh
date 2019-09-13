OPEN_NMT_PATH=OpenNMT-py
DATA_PATH=../EN_PT-BR
TRAIN_PATH=$DATA_PATH/corpus_treinamento
TEST_PATH=$DATA_PATH/corpus_teste
SRC_LAN=en
TGT_LAN=pt

# Teste
echo "Testando"
python3 $OPEN_NMT_PATH/translate.py \
    -model $DATA_PATH/trained_model/EN-PT+EcommerceData+Glove-EN/nmt_model_*_100000.pt \
    -src $TEST_PATH/teste.en.atok \
    -tgt $TEST_PATH/teste.pt.atok \
    -replace_unk \
    -output $TEST_PATH/teste.output
