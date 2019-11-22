# Neural Machine Translation for e-commerce

The Neural Machine Translation for e-commerce (NMTe) project is a specific translator for the e-commerce domain. It aims to translate product names from English (source language) to Brazilian Portuguese (target language).

---

### Contents

* [Installation](#installation)
* [Usage](#usage)
  * [Preprocessing text file](#preprocessing-text-file)
  * [Train model](#train-model)
  * [Evaluation](#evaluation)

---

## Installation
```
virtualenv venv -p python3
source venv/bin/activate
pip install -r requirements.txt

#Install Rouge
cd rouge/pyrouge
pip install -e .
pyrouge_set_rouge_path <~/nmte/rouge/rouge/tools/ROUGE-1.5.5>
python -m pyrouge.test

cd rouge/rouge/tools/ROUGE-1.5.5/data/
rm WordNet-2.0.exc.db
./WordNet-2.0-Exceptions/buildExeptionDB.pl ./WordNet-2.0-Exceptions ./smart_common_words.txt ./WordNet-2.0.exc.db
```

## Usage

### Preprocessing text file (in order to train NMT models)

```
bash tradutor_EN-PT-BR_preprocess.sh
```

### Train Model

Train with transformer architecture
```
bash tradutor_EN-PT-BR_train_transformer.sh
```

Train with LSTM architecture
```
bash tradutor_EN-PT-BR_train_LSTM.sh
```

### Evaluation

Translation with NMTe model
```
bash tradutor_EN-PT-BR_translate.sh
```

Translation with Google AutoML model
```
Autenticar APIs Google
export GOOGLE_APPLICATION_CREDENTIALS="~/totemic-bonus-247114-d4ecf7d1a964.json"

python automl.py
```

Testing with BLEU and ROUGE metrics
```
bash tradutor_EN-PT-BR_test.sh
```

### Interface Web
```
-Put the trained model in OpenNMT-py/available_models/
-Configure the conf.json file
```

Start the Client
```
cd client
python client.py
```

Start the Server
```
cd OpenNMT-py
python server.py
```