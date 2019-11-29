import pandas as pd

file = pd.read_csv('/home/jessica/Documents/Projects/corpora/b2w-products/results-20190822-165010.csv') #, sep = ';'
df = pd.DataFrame(file)
product_list = df['name'].tolist()
with open('/home/jessica/Documents/Projects/corpora/b2w-products/product-title/product-title.txt', 'a+', encoding='utf8') as f:
    for p in product_list:
        #print(p)
        f.write((str(p)).lower() + '\n')
    print('finish')
f.close()