import pandas as pd
import requests
import json

#1 Напишите функцию, которая принимает JSON-строку и выводит данные в виде словаря Python.

def json_to_dict(json_string):
    data = json.loads(json_string)
    return data

json_string = '{"name": "Dmitriy", "age" : "34", "city" : "Minsk"}'
result = json_to_dict(json_string)
print('Данные в виде словаря Python:', result)

#2 Напишите код, который загружает данные из Excel-файла, подсчитывает количество строк и выводит результат.

# Создаем словарь
data = {
    "Сезон": ["Зима", "Весна", "Лето", "Осень"],
    "Начало": ["21 декабря", "21 марта", "21 июня", "23 сентября"],
    "Конец": ["20 марта", "20 июня", "22 сентября", "20 декабря"],
    "Температура": ["Низкая", "Умеренная", "Высокая", "Умеренная"]
}

df = pd.DataFrame(data)
# Записываем в файл excel
df.to_excel('Files/Времена_года.xlsx', index=False)
print(df)

# Читаем созданный файл
df = pd.read_excel('Files/Времена_года.xlsx')
# Подсчитываем количеcтво строк
print(f'Количество строк в файле: {df.shape[0]}')

#3 Напишите функцию, которая загружает данные из API и обрабатывает их, выводя только нужные поля. (по аналогии с примером, который мы смотрели на уроке)

def cur_date(): # Функция получения курса валют на сегодня
    url = f'https://api.nbrb.by/exrates/rates?periodicity=0'
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        return data
    else:
        print(f"Ошибка при запросе: {response.status_code}")
        return None

# Создаем DataFrame
currencies = pd.DataFrame([{
    'Cur_Abbreviation': item['Cur_Abbreviation'],
    'Cur_Name': item['Cur_Name'],
    'Cur_OfficialRate': item['Cur_OfficialRate']
}for item in cur_date()])

# Переименовываем колонки
currencies.rename(columns={'Cur_Abbreviation': 'Валюта', 'Cur_Name': 'Название валюты', 'Cur_OfficialRate': 'Курс к BYN' }, inplace=True)
print(currencies)

# Записываем в файл
currencies.to_excel('Files/currencies_ondate.xlsx',index=False)

#4 Напишите программу, которая загружает данные из нескольких Excel файлов, объединяет их и сохраняет в новый файл.

df1 = pd.read_excel('Files/Example/currencies_ondate1.xlsx')
df2 = pd.read_excel('Files/Example/currencies_ondate2.xlsx')
df3 = pd.read_excel('Files/Example/currencies_ondate3.xlsx')
result = pd.concat([df1,df2,df3], axis=0, ignore_index=1)
print(result)
result = result[['Название валюты', 'Валюта', 'Курс к BYN']] # Меняем столбцы местами для сохранения
result.to_excel('Files/Example/currencies_all.xlsx', index=False)

#5 Напишите код, который загружает данные из API, выполняет предварительную обработку(например, фильтрацию) и сохраняет результат в Excel-файл.

top = int(input('Топ криптовалют по рыночной капитализации, введите количество (максимум 1000): '))
if top > 1000:
    top = 1000  # Ограничение на 1000
page_count = (top + 249) // 250  # Вычисляем количество страниц, так как сайт дает выводить не больше 250 на 1 странице

def market_cap(top): # Функция получения топ криптовалют по рыночной капитализации
    url = f'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page={page_count}'
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        return data
    elif response.status_code == 429:
        print("Слишком много запросов. Ожидание 60 секунд...")
        time.sleep(60)  # Ждем 60 секунд перед повтором
    else:
        print(f"Ошибка при запросе: {response.status_code}")
        return None

# Создаем DataFrame
top_coins = pd.DataFrame([{
    'market_cap_rank': item['market_cap_rank'],
    'symbol': item['symbol'],
    'name': item['name'],
    'current_price': item['current_price'],
    'price_change_percentage_24h': item['price_change_percentage_24h']}
    for item in market_cap(top)])

top_coins = top_coins[top_coins['price_change_percentage_24h'] > 0] # Фильтрую криптовалюты, которые выросли за последние 24 часа
top_coins = top_coins.sort_values(by='price_change_percentage_24h', ascending=False) # Фильтруем от большего к меньшему значению

# Записываем в файл эксель
top_coins.to_excel('Files/top1.xlsx',index=False)

print(top_coins)


