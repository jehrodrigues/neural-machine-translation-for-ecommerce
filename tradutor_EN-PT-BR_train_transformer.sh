OPEN_NMT_PATH=OpenNMT-py
DATA_PATH=EN_PT-BR
TRAIN_PATH=$DATA_PATH/corpus_treinamento
TEST_PATH=$DATA_PATH/corpus_teste
SRC_LAN=en
TGT_LAN=pt

# Training
echo "Training with Transformer"

python3  $OPEN_NMT_PATH/train.py \
        -data $TRAIN_PATH/preprocessed/fapesp-v2.atok.low \
        -save_model $DATA_PATH/nmt_model/nmt_model \
        -layers 6 \
        -rnn_size 512 \
        -word_vec_size 512 \
        -transformer_ff 2048 \
        -heads 8  \
        -encoder_type transformer \
        -decoder_type transformer \
        -position_encoding \
        -train_steps 200000 \
        -max_generator_batches 2 \
        -dropout 0.1 \
        -batch_size 4096 \
        -batch_type tokens \
        -normalization tokens \
        -accum_count 2 \
        -optim adam \
        -adam_beta2 0.998 \
        -decay_method noam \
        -warmup_steps 8000 \
        -learning_rate 2 \
        -max_grad_norm 0 \
        -param_init 0 \
        -param_init_glorot \
        -label_smoothing 0.1 \
        -valid_steps 10000 \
        -save_checkpoint_steps 10000 \
        -world_size 4 \
        -gpu_ranks 1

# Transformer Architecture
"""
NMTModel(
  (encoder): TransformerEncoder(
    (embeddings): Embeddings(
      (make_embedding): Sequential(
        (emb_luts): Elementwise(
          (0): Embedding(50002, 512, padding_idx=1)
        )
        (pe): PositionalEncoding(
          (dropout): Dropout(p=0.1)
        )
      )
    )
    (transformer): ModuleList(
      (0): TransformerEncoderLayer(
        (self_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (feed_forward): PositionwiseFeedForward(
          (w_1): Linear(in_features=512, out_features=2048, bias=True)
          (w_2): Linear(in_features=2048, out_features=512, bias=True)
          (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
          (dropout_1): Dropout(p=0.1)
          (relu): ReLU()
          (dropout_2): Dropout(p=0.1)
        )
        (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (dropout): Dropout(p=0.1)
      )
      (1): TransformerEncoderLayer(
        (self_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (feed_forward): PositionwiseFeedForward(
          (w_1): Linear(in_features=512, out_features=2048, bias=True)
          (w_2): Linear(in_features=2048, out_features=512, bias=True)
          (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
          (dropout_1): Dropout(p=0.1)
          (relu): ReLU()
          (dropout_2): Dropout(p=0.1)
        )
        (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (dropout): Dropout(p=0.1)
      )
      (2): TransformerEncoderLayer(
        (self_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (feed_forward): PositionwiseFeedForward(
          (w_1): Linear(in_features=512, out_features=2048, bias=True)
          (w_2): Linear(in_features=2048, out_features=512, bias=True)
          (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
          (dropout_1): Dropout(p=0.1)
          (relu): ReLU()
          (dropout_2): Dropout(p=0.1)
        )
        (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (dropout): Dropout(p=0.1)
      )
      (3): TransformerEncoderLayer(
        (self_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (feed_forward): PositionwiseFeedForward(
          (w_1): Linear(in_features=512, out_features=2048, bias=True)
          (w_2): Linear(in_features=2048, out_features=512, bias=True)
          (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
          (dropout_1): Dropout(p=0.1)
          (relu): ReLU()
          (dropout_2): Dropout(p=0.1)
        )
        (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (dropout): Dropout(p=0.1)
      )
      (4): TransformerEncoderLayer(
        (self_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (feed_forward): PositionwiseFeedForward(
          (w_1): Linear(in_features=512, out_features=2048, bias=True)
          (w_2): Linear(in_features=2048, out_features=512, bias=True)
          (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
          (dropout_1): Dropout(p=0.1)
          (relu): ReLU()
          (dropout_2): Dropout(p=0.1)
        )
        (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (dropout): Dropout(p=0.1)
      )
      (5): TransformerEncoderLayer(
        (self_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (feed_forward): PositionwiseFeedForward(
          (w_1): Linear(in_features=512, out_features=2048, bias=True)
          (w_2): Linear(in_features=2048, out_features=512, bias=True)
          (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
          (dropout_1): Dropout(p=0.1)
          (relu): ReLU()
          (dropout_2): Dropout(p=0.1)
        )
        (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (dropout): Dropout(p=0.1)
      )
    )
    (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
  )
  (decoder): TransformerDecoder(
    (embeddings): Embeddings(
      (make_embedding): Sequential(
        (emb_luts): Elementwise(
          (0): Embedding(50004, 512, padding_idx=1)
        )
        (pe): PositionalEncoding(
          (dropout): Dropout(p=0.1)
        )
      )
    )
    (transformer_layers): ModuleList(
      (0): TransformerDecoderLayer(
        (self_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (context_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (feed_forward): PositionwiseFeedForward(
          (w_1): Linear(in_features=512, out_features=2048, bias=True)
          (w_2): Linear(in_features=2048, out_features=512, bias=True)
          (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
          (dropout_1): Dropout(p=0.1)
          (relu): ReLU()
          (dropout_2): Dropout(p=0.1)
        )
        (layer_norm_1): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (layer_norm_2): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (drop): Dropout(p=0.1)
      )
      (1): TransformerDecoderLayer(
        (self_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (context_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (feed_forward): PositionwiseFeedForward(
          (w_1): Linear(in_features=512, out_features=2048, bias=True)
          (w_2): Linear(in_features=2048, out_features=512, bias=True)
          (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
          (dropout_1): Dropout(p=0.1)
          (relu): ReLU()
          (dropout_2): Dropout(p=0.1)
        )
        (layer_norm_1): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (layer_norm_2): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (drop): Dropout(p=0.1)
      )
      (2): TransformerDecoderLayer(
        (self_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (context_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (feed_forward): PositionwiseFeedForward(
          (w_1): Linear(in_features=512, out_features=2048, bias=True)
          (w_2): Linear(in_features=2048, out_features=512, bias=True)
          (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
          (dropout_1): Dropout(p=0.1)
          (relu): ReLU()
          (dropout_2): Dropout(p=0.1)
        )
        (layer_norm_1): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (layer_norm_2): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (drop): Dropout(p=0.1)
      )
      (3): TransformerDecoderLayer(
        (self_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (context_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (feed_forward): PositionwiseFeedForward(
          (w_1): Linear(in_features=512, out_features=2048, bias=True)
          (w_2): Linear(in_features=2048, out_features=512, bias=True)
          (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
          (dropout_1): Dropout(p=0.1)
          (relu): ReLU()
          (dropout_2): Dropout(p=0.1)
        )
        (layer_norm_1): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (layer_norm_2): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (drop): Dropout(p=0.1)
      )
      (4): TransformerDecoderLayer(
        (self_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (context_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (feed_forward): PositionwiseFeedForward(
          (w_1): Linear(in_features=512, out_features=2048, bias=True)
          (w_2): Linear(in_features=2048, out_features=512, bias=True)
          (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
          (dropout_1): Dropout(p=0.1)
          (relu): ReLU()
          (dropout_2): Dropout(p=0.1)
        )
        (layer_norm_1): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (layer_norm_2): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (drop): Dropout(p=0.1)
      )
      (5): TransformerDecoderLayer(
        (self_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (context_attn): MultiHeadedAttention(
          (linear_keys): Linear(in_features=512, out_features=512, bias=True)
          (linear_values): Linear(in_features=512, out_features=512, bias=True)
          (linear_query): Linear(in_features=512, out_features=512, bias=True)
          (softmax): Softmax()
          (dropout): Dropout(p=0.1)
          (final_linear): Linear(in_features=512, out_features=512, bias=True)
        )
        (feed_forward): PositionwiseFeedForward(
          (w_1): Linear(in_features=512, out_features=2048, bias=True)
          (w_2): Linear(in_features=2048, out_features=512, bias=True)
          (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
          (dropout_1): Dropout(p=0.1)
          (relu): ReLU()
          (dropout_2): Dropout(p=0.1)
        )
        (layer_norm_1): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (layer_norm_2): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
        (drop): Dropout(p=0.1)
      )
    )
    (layer_norm): LayerNorm(torch.Size([512]), eps=1e-06, elementwise_affine=True)
  )
  (generator): Sequential(
    (0): Linear(in_features=512, out_features=50004, bias=True)
    (1): Cast()
    (2): LogSoftmax()
  )
)
"""