import pandas as pd

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
    file = pd.read_excel('/home/jessica/Documents/Projects/NeuralTranslate/data/EN->PT-BR-ecommerce-datasets/ebay-04.09.19-de-para.xlsx')  # , sep = ';'
    df = pd.DataFrame(file)
    product_list = df['product-name-pt'].tolist()
    #product_list = df['product-name'].tolist()
    with open('/home/jessica/Documents/Projects/NeuralTranslate/data/EN->PT-BR-ecommerce-datasets/ebay.pt.txt', 'a+', encoding='utf8') as f:
        for p in product_list:
            #product = p.replace('Details about ', '')
            #product = product.replace('- show original title', '')
            product = p.replace('Detalhes sobre ', '')
            product = product.replace('- mostrar título no original', '')
            print(product.strip())
            f.write((str(product.strip())).lower() + '\n')
    print('finish')
    f.close()


read_EBAY_data()