OPEN_NMT_PATH=OpenNMT-py
DATA_PATH=EN_PT-BR
TRAIN_PATH=$DATA_PATH/corpus_treinamento
TEST_PATH=$DATA_PATH/corpus_teste
SRC_LAN=en
TGT_LAN=pt

# Training
echo "Training with biLSTM"
python3 $OPEN_NMT_PATH/train.py \
    -data $TRAIN_PATH/preprocessed/fapesp-v2.atok.low \
    -save_model $DATA_PATH/nmt_model/nmt_model \
    -gpuid 0 \
    -word_vec_size 300 \
    -pre_word_vecs_enc vectors-en-torch.enc.pt \
    -pre_word_vecs_dec vectors-en-torch.dec.pt

# LSTM bidirecional (Encoder/Decoder) Architecture
"""
NMTModel(
  (encoder): RNNEncoder(
    (embeddings): Embeddings(
      (make_embedding): Sequential(
        (emb_luts): Elementwise(
          (0): Embedding(50002, 300, padding_idx=1)
        )
      )
    )
    (rnn): LSTM(300, 500, num_layers=2, dropout=0.3)
  )
  (decoder): InputFeedRNNDecoder(
    (embeddings): Embeddings(
      (make_embedding): Sequential(
        (emb_luts): Elementwise(
          (0): Embedding(50004, 300, padding_idx=1)
        )
      )
    )
    (dropout): Dropout(p=0.3)
    (rnn): StackedLSTM(
      (dropout): Dropout(p=0.3)
      (layers): ModuleList(
        (0): LSTMCell(800, 500)
        (1): LSTMCell(500, 500)
      )
    )
    (attn): GlobalAttention(
      (linear_in): Linear(in_features=500, out_features=500, bias=False)
      (linear_out): Linear(in_features=1000, out_features=500, bias=False)
    )
  )
  (generator): Sequential(
    (0): Linear(in_features=500, out_features=50004, bias=True)
    (1): Cast()
    (2): LogSoftmax()
  )
)
"""

