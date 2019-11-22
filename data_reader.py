import pandas as pd
import csv
import re
import os

PATH = '/home/jessica/Projects/NMTe/data/EN->PT-BR-ecommerce-datasets/original/preprocess/to_txt/'
#PATH = '/home/jessica/Projects/NMTe/data/EN->PT-BR-ecommerce-datasets/original/preprocess/not/teste/'
OUTPUT = '/home/jessica/Projects/NMTe/data/EN->PT-BR-ecommerce-datasets/original/preprocess/output/'
#OUTPUT = '/home/jessica/Projects/NMTe/data/EN->PT-BR-ecommerce-datasets/original/preprocess/not/teste/'

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
                        #product_en = re.sub('[\W\_]', ' ', product_en) #Remove caracteres especiais
                        product_en = re.sub(' +', ' ', product_en) #Remove espaço duplicado
                        product_en = re.sub('[\[*\]]', ' ', product_en)
                        product_en = re.sub(r'\b(\w+)( \1\b)+', r'\1', product_en) #Remove palavras duplicadas
                        f_en.write((str(product_en.strip().lower())) + '\n')

                        #Portuguese
                        product = p.replace('Detalhes sobre ', '')
                        product = product.replace('- mostrar título no original', '')
                        product = product.replace('Novo anúncio', '')
                        #product = re.sub('[\W\_]', ' ', product)
                        product = re.sub(' +', ' ', product)
                        product = re.sub('[\[*\]]', ' ', product)
                        product = re.sub(r'\b(\w+)( \1\b)+', r'\1', product)
                        f.write((str(product.strip().lower())) + '\n') #.lower()
        print('finish')
        f.close()
        f_en.close()


def parallel_data_to_tsv():
    OUTPUT_FILES = '/home/jessica/Projects/NMTe/data/crawler/amazon_lucas/'
    file_pt = pd.read_csv(OUTPUT_FILES + 'amazon.pt', delimiter="\n", header=None, encoding='utf-8', engine='python') #, quoting=csv.QUOTE_NONE
    file_en = pd.read_csv(OUTPUT_FILES + 'amazon.en', delimiter="\n", header=None, encoding='utf-8', engine='python') #, quoting=csv.QUOTE_NONE
    #print(file_en)
    df = pd.DataFrame(file_en + '\t' + file_pt)
    #df = pd.DataFrame(file_en)
    #dfpt = pd.DataFrame(file_pt)
    #df.to_csv('/home/jessica/Projects/NMTe/AutoML-Translate/data/ebay.english.txt', sep='\n', encoding='utf-8', index=False)
    #dfpt.to_csv('/home/jessica/Projects/NMTe/AutoML-Translate/data/ebay.portuguese.txt', sep='\n', encoding='utf-8', index=False)
    df.to_csv(OUTPUT_FILES + 'amazon.tsv', sep='\t', encoding='utf-8', index=False, quoting=csv.QUOTE_NONE, escapechar='¬', na_rep="£") #quoting=csv.QUOTE_NONE, , quotechar='"', escapechar='\\' sep='\t',


def teste():
    OUTPUT_FILES = '/home/jessica/Projects/NMTe/data/crawler/amazon_lucas/'
    together = ''
    with open(OUTPUT_FILES + 'amazon.tsv', 'a+', encoding='utf8') as f:
        with open(OUTPUT_FILES + 'amazon.en') as f1, open(OUTPUT_FILES + 'amazon.pt') as f2:
            for line_en, line_pt in zip(f1, f2):
                together = line_en.strip() + '\t' + line_pt.strip()
                f.write(together + '\n')
            print('finish')
            f.close()
            f1.close()
            f2.close()

def clean_ebay_data():
    OUTPUT_FILES = '/home/jessica/Projects/NMTe/data/crawler/amazon_lucas/'
    with open(OUTPUT_FILES + 'amazon_pt.txt', 'r', encoding='utf8') as s:
        with open(OUTPUT_FILES + 'amazon.pt', 'a+', encoding='utf8') as f:
            lista = s.readlines()
            for line in lista:
                product_en = re.sub(' +', ' ', str(line))  # Remove espaço duplicado
                product_en = re.sub('[\[*\]]', ' ', product_en)
                #product_en = re.sub('[\W\_]', ' ', product_en) #Remove caracteres especiais
                product_en = re.sub(r'\b(\w+)( \1\b)+', r'\1', product_en)  # Remove palavras duplicadas
                f.write((product_en.strip().lower()) + '\n')
            print('finish')
            f.close()

#def read_Amazon_data():
    #conn = psycopg2.connect(database="amazon_public", host="localhost", user="jessica", password="1234")
    #cur = conn.cursor()
    #cur.execute("INSERT INTO scrapy_en_pt_db (pt_title, en_title, product_code ) VALUES (%s, %s, %s) RETURNING id",
    #conn.commit()


teste()