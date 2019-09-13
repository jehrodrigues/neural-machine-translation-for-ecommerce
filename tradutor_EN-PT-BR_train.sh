OPEN_NMT_PATH=OpenNMT-py
DATA_PATH=EN_PT-BR
TRAIN_PATH=$DATA_PATH/corpus_treinamento
TEST_PATH=$DATA_PATH/corpus_teste
SRC_LAN=en
TGT_LAN=pt

# Treinamento
echo "Treinando"
python3 $OPEN_NMT_PATH/train.py \
    -data $TRAIN_PATH/preprocessed/fapesp-v2.atok.low \
    -save_model $DATA_PATH/nmt_model/nmt_model \
    -gpuid 0 \
    -word_vec_size 300 \
    -pre_word_vecs_enc vectors-en-torch.enc.pt \
    -pre_word_vecs_dec vectors-en-torch.dec.pt

#python3  $OPEN_NMT_PATH/train.py \
        #-data $TRAIN_PATH/preprocessed/fapesp-v2.atok.low \
        #-save_model $DATA_PATH/nmt_model/nmt_model \
        #-layers 6 \
        #-rnn_size 512 \
        #-word_vec_size 512 \
        #-transformer_ff 2048 \
        #-heads 8  \
        #-encoder_type transformer \
        #-decoder_type transformer \
        #-position_encoding \
        #-train_steps 200000 \
        #-max_generator_batches 2 \
        #-dropout 0.1 \
        #-batch_size 4096 \
        #-batch_type tokens \
        #-normalization tokens \
        #-accum_count 2 \
        #-optim adam \
        #-adam_beta2 0.998 \
        #-decay_method noam \
        #-warmup_steps 8000 \
        #-learning_rate 2 \
        #-max_grad_norm 0 \
        #-param_init 0 \
        #-param_init_glorot \
        #-label_smoothing 0.1 \
        #-valid_steps 10000 \
        #-save_checkpoint_steps 10000 \
        #-world_size 4 \
        #-gpu_ranks 1
