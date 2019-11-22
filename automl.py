from google.cloud import translate_v3beta1 as translate
client = translate.TranslationServiceClient()
project_id = '451037467963'
location = 'us-central1'
model = 'projects/451037467963/locations/us-central1/models/TRL1327246874167476224'
parent = client.location_path(project_id, location)
OUTPUT = './EN_PT-BR/corpus_teste/'


def get_source():
    with open(OUTPUT + 'amazon.en', 'r', encoding='utf8') as source:
        with open(OUTPUT + 'automl2.output', 'a+', encoding='utf8') as out:
            lista = source.readlines()
            for line in lista:
                print(str(line))
                target = get_translation(line)
                out.write(target)
        out.close()
    source.close()


def get_translation(text):
    response = client.translate_text(
        parent=parent,
        contents=[text],
        model=model,
        mime_type='text/plain',  # mime types: text/plain, text/html
        source_language_code='en',
        target_language_code='pt')

    for translation in response.translations:
        return translation.translated_text


get_source()