OPEN_NMT_PATH=OpenNMT-py
DATA_PATH=EN_PT-BR
TRAIN_PATH=$DATA_PATH/corpus_treinamento
TEST_PATH=$DATA_PATH/corpus_teste
SRC_LAN=en
TGT_LAN=pt

# Teste
echo "Testando"
python3 $OPEN_NMT_PATH/translate.py \
    -model $DATA_PATH/trained_model/nmt_model_*_100000.pt \
    -src $TEST_PATH/fapesp-v2.pt-en.test-a.en.atok \
    -tgt $TEST_PATH/fapesp-v2.pt-en.test-a.pt.atok \
    -replace_unk \
    -output $TEST_PATH/fapesp-v2.pt-en.test-a.output

python3 $OPEN_NMT_PATH/translate.py \
    -model $DATA_PATH/trained_model/nmt_model_*_100000.pt \
    -src $TEST_PATH/fapesp-v2.pt-en.test-b.en.atok \
    -tgt $TEST_PATH/fapesp-v2.pt-en.test-b.pt.atok \
    -replace_unk \
    -output $TEST_PATH/fapesp-v2.pt-en.test-b.output

# Destokenizar
if [ ! -f $TEST_PATH/fapesp-v2.pt-en.test-a.detok ]; then
    perl detokenizer.perl -l en < $TEST_PATH/fapesp-v2.pt-en.test-a.output > $TEST_PATH/fapesp-v2.pt-en.test-a.detok;
fi
if [ ! -f $TEST_PATH/fapesp-v2.en-pt.test-b.detok ]; then
    perl detokenizer.perl -l en < $TEST_PATH/fapesp-v2.pt-en.test-b.output > $TEST_PATH/fapesp-v2.pt-en.test-b.detok;
fi

# Calculo BLEU
echo "Calculando BLEU"
# test-a
if [ ! -f $TEST_PATH/fapesp-v2.pt-en.test-a.pt.sgm ]; then
perl formata-mteval-v14.pl $TEST_PATH/fapesp-v2.pt-en.test-a.pt src en pt $TEST_PATH/fapesp-v2.pt-en.test-a.pt.sgm;
fi
if [ ! -f $TEST_PATH/fapesp-v2.pt-en.test-a.en.sgm ]; then
perl formata-mteval-v14.pl $TEST_PATH/fapesp-v2.pt-en.test-a.en ref en pt $TEST_PATH/fapesp-v2.pt-en.test-a.en.sgm;
fi
if [ ! -f $TEST_PATH/fapesp-v2.pt-en.test-a.detok.sgm ]; then
perl formata-mteval-v14.pl $TEST_PATH/fapesp-v2.pt-en.test-a.detok test en pt $TEST_PATH/fapesp-v2.pt-en.test-a.detok.sgm;
fi
perl mteval-v14.pl -r $TEST_PATH/fapesp-v2.pt-en.test-a.en.sgm \
                   -s $TEST_PATH/fapesp-v2.pt-en.test-a.pt.sgm \
                   -t $TEST_PATH/fapesp-v2.pt-en.test-a.detok.sgm > $TEST_PATH/test-a.bleu

# test-b
if [ ! -f $TEST_PATH/fapesp-v2.pt-en.test-b.pt.sgm ]; then
perl formata-mteval-v14.pl $TEST_PATH/fapesp-v2.pt-en.test-b.pt src en pt $TEST_PATH/fapesp-v2.pt-en.test-b.pt.sgm;
fi
if [ ! -f $TEST_PATH/fapesp-v2.pt-en.test-b.en.sgm ]; then
perl formata-mteval-v14.pl $TEST_PATH/fapesp-v2.pt-en.test-b.en ref en pt $TEST_PATH/fapesp-v2.pt-en.test-b.en.sgm;
fi
if [ ! -f $TEST_PATH/fapesp-v2.pt-en.test-b.detok.sgm ]; then
perl formata-mteval-v14.pl $TEST_PATH/fapesp-v2.pt-en.test-b.detok test en pt $TEST_PATH/fapesp-v2.pt-en.test-b.detok.sgm;
fi
perl mteval-v14.pl -r $TEST_PATH/fapesp-v2.pt-en.test-b.en.sgm \
                   -s $TEST_PATH/fapesp-v2.pt-en.test-b.pt.sgm \
                   -t $TEST_PATH/fapesp-v2.pt-en.test-b.detok.sgm > $TEST_PATH/test-b.bleu
