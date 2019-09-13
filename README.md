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
```

## Usage

### Preprocessing text file (in order to train NMT models)

```
bash tradutor_EN-PT-BR_preprocess.sh
```

### Train Model

```
bash tradutor_EN-PT-BR_train.sh
```

### Evaluation

Test a-b with BLEU
```
bash tradutor_EN-PT-BR_test.sh
```