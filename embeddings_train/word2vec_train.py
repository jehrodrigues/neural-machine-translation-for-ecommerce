import os
import gzip
from gensim.models import Word2Vec
from gensim.models.word2vec import LineSentence


class MySentences(object):
    def __init__(self, dirname):
        self.dirname = dirname

    def __iter__(self):
        for fname in os.listdir(self.dirname):
            for line in open(os.path.join(self.dirname, fname)):
                yield line.split()

sentences = MySentences('./corpora/preprocess')  # a memory-friendly iterator
#documents = read_input('/home/jessica/Documentos/UFSCar/Pesquisa/Projeto/sense2vec-master/bin/corpora/corpora/corpora_tokenized/corpora_tokenized.tar.gz')
print('terminou corpus')
#sg=1: skigram
#sg=0: cbow
model = Word2Vec(sentences, sg=1, size=300, window=5)
print('finish train')
model.init_sims(replace=True)
model.wv.save_word2vec_format('./model/word2vec_s300.txt', binary=False)
print('finish')