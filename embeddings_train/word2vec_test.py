import gensim
from gensim.models import KeyedVectors
import numpy as np
import tensorflow as tf
from tensorflow.contrib.tensorboard.plugins import projector

outp = "./model/word2vec_s300.txt"

model = KeyedVectors.load_word2vec_format(outp, unicode_errors="ignore")

#print(model.wv.most_similar(positive=['gastando', 'melhorou'], negative=['melhorando']))
#print(model.wv.most_similar(positive=['mundo']))

#print(model.wv.most_similar(positive=['tv'], negative=['48"']))
print("Vocabulary Size: {0}".format(len(model.vocab)))

#Important Parameters
VOCAB_SIZE = len(model.vocab)
EMBEDDING_DIM = model["notebook"].shape[0]

w2v = np.zeros((VOCAB_SIZE, EMBEDDING_DIM))

tsv_file_path = "/home/jessica/Documents/Projects/NeuralTranslate/TradutorNeural/TradutorNeural/embeddings_train/model_tf/tensorboard/metadata.tsv"
with open(tsv_file_path,'w+', encoding='utf8') as file_metadata:
    for i,word in enumerate(model.index2word[:VOCAB_SIZE]):
        w2v[i] = model[word]
        file_metadata.write(word+'\n')

TENSORBOARD_FILES_PATH = "/home/jessica/Documents/Projects/NeuralTranslate/TradutorNeural/TradutorNeural/embeddings_train/model_tf/tensorboard"

#Tensorflow Placeholders
X_init = tf.placeholder(tf.float32, shape=(VOCAB_SIZE, EMBEDDING_DIM), name="embedding")
X = tf.Variable(X_init)

#Initializer
init = tf.global_variables_initializer()

#Start Tensorflow Session
sess = tf.Session()
sess.run(init, feed_dict={X_init: w2v})

#Instance of Saver, save the graph.
saver = tf.train.Saver()
writer = tf.summary.FileWriter(TENSORBOARD_FILES_PATH, sess.graph)

#Configure a Tensorflow Projector
config = projector.ProjectorConfig()
embed = config.embeddings.add()
embed.metadata_path = tsv_file_path

#Write a projector_config
projector.visualize_embeddings(writer,config)

#save a checkpoint
saver.save(sess, TENSORBOARD_FILES_PATH+'/model.ckpt', global_step = VOCAB_SIZE)

#close the session
sess.close()