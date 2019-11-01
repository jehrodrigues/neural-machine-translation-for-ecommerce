import pandas as pd
import re
import os

PATH = '/home/jessica/Projects/NMTe/data/EN->PT-BR-ecommerce-datasets/original/preprocess/to_txt/'
OUTPUT = '/home/jessica/Projects/NMTe/data/EN->PT-BR-ecommerce-datasets/original/preprocess/output/'

def read_BIGDATA_data():
    file = pd.read_csv('/home/jessica/Documents/Projects/corpora/b2w-products/results-20190822-165010.csv') #, sep = ';'
    df = pd.DataFrame(file)
    product_list = df['name'].tolist()
    with open('/home/jessica/Documents/Projects/corpora/b2w-products/product-title/product-title.txt', 'a+', encoding='utf8') as f:
        for p in product_list:
            #print(p)
            f.write((str(p)).lower() + '\n')
        print('finish')
    f.close()


def read_EBAY_data():
    entries = os.listdir(PATH)
    for entry in entries:
        print(entry)
        file = pd.read_excel(PATH + entry)
        #file = pd.read_csv('/home/jessica/Projects/NMTe/data/EN->PT-BR-ecommerce-datasets/my/scrapy_parallel.csv', sep=';')  # , sep = ';'
        df = pd.DataFrame(file)
        product_list = df.values.tolist()
        #product_list_en = df['product-name'].tolist()
        with open(OUTPUT + 'ebay.pt.txt', 'a+', encoding='utf8') as f:
            with open(OUTPUT + 'ebay.en.txt', 'a+', encoding='utf8') as f_en:
                for p, pen in product_list:
                    if isinstance(p, str) and p.strip() != "" and p.strip() != "null" and isinstance(pen, str) and pen.strip() != "" and pen.strip() != "null":
                        #English
                        product_en = pen.replace('Details about ', '')
                        product_en = product_en.replace('- show original title', '')
                        product_en = re.sub('[\W\_]', ' ', product_en)
                        product_en = re.sub(' +', ' ', product_en)
                        product_en = re.sub('[\[*\]]', ' ', product_en)
                        f_en.write((str(product_en.strip().lower())) + '\n')

                        #Portuguese
                        product = p.replace('Detalhes sobre ', '')
                        product = product.replace('- mostrar título no original', '')
                        product = re.sub('[\W\_]', ' ', product)
                        product = re.sub(' +', ' ', product)
                        product = re.sub('[\[*\]]', ' ', product)
                        f.write((str(product.strip().lower())) + '\n') #.lower()
        print('finish')
        f.close()
        f_en.close()


def parallel_data_to_tsv():
    file_pt = pd.read_csv(OUTPUT + 'ebay.pt.txt', delimiter="\n", header=None, encoding='utf-8', engine='python') #, skiprows=[14316, 18877]
    file_en = pd.read_csv(OUTPUT + 'ebay.en.txt', delimiter="\n", header=None, encoding='utf-8', engine='python') #, error_bad_lines=False
    #print(file_en)
    df = pd.DataFrame(file_en + '\t' + file_pt)
    #df = pd.DataFrame(file_en)
    #dfpt = pd.DataFrame(file_pt)
    #df.to_csv('/home/jessica/Projects/NMTe/AutoML-Translate/data/ebay.english.txt', sep='\n', encoding='utf-8', index=False)
    #dfpt.to_csv('/home/jessica/Projects/NMTe/AutoML-Translate/data/ebay.portuguese.txt', sep='\n', encoding='utf-8', index=False)
    df.to_csv(OUTPUT + 'nmte.en-pt.tsv', sep='\t', encoding='utf-8', index=False)


def clean_ebay_data():
    OUTPUT_FILES = '/home/jessica/Projects/NMTe/data/EN->PT-BR-ecommerce-datasets/original/preprocess/output/'
    #file_pt = pd.read_csv(OUTPUT_FILES + 'nmte.pt-en.train.pt', delimiter="\n", header=None, encoding='utf-8', engine='python') #, skiprows=[14316, 18877]
    file_en = pd.read_csv(OUTPUT_FILES + 'nmte.pt-en.train.en', delimiter="\n", header=None, encoding='utf-8', engine='python') #, error_bad_lines=False
    dfen = pd.DataFrame(file_en)
    #dfpt = pd.DataFrame(file_pt)
    product_list_en = dfen.values.tolist()
    #product_list_pt = dfpt.values.tolist()
    for p in product_list_en:
        print(p.lower())
    #dfpt.to_csv(OUTPUT_FILES + 'nmte.pt-en.train-lower.pt', sep='\n', encoding='utf-8', index=False)
    dfen.to_csv(OUTPUT_FILES + 'nmte.pt-en.train-lower.en', sep='\n', encoding='utf-8', index=False)

#def read_Amazon_data():
    #conn = psycopg2.connect(database="amazon_public", host="localhost", user="jessica", password="1234")
    #cur = conn.cursor()
    #cur.execute("INSERT INTO scrapy_en_pt_db (pt_title, en_title, product_code ) VALUES (%s, %s, %s) RETURNING id",
    #conn.commit()


parallel_data_to_tsv()