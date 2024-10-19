import pandas as pd
import requests
import json

#Напишите функцию, которая загружает данные из API и фильтрует их по заданному пользователем условию.
def cur_date(): # Функция получения курса валют на сегодня
    url = f'https://api.nbrb.by/exrates/rates?periodicity=0'
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        return data
    else:
        print(f"Ошибка при запросе: {response.status_code}")
        return None

cur = pd.DataFrame([{
        'Cur_Abbreviation': item['Cur_Abbreviation'],
        'Cur_Name': item['Cur_Name'],
        'Cur_OfficialRate': item['Cur_OfficialRate']
    } for item in cur_date()])
print(cur)
#cur.to_excel('Files/cur_actual.xlsx')

#col = input('Введите столбец для фильтрации (Cur_Abbreviation, Cur_Name, Cur_OfficialRate): ')
if_k = input('Введите условие для фильтрации по столбцу Cur_OfficialRate ( >, <, =, >=, <=) : ')
ourinput_rate = float(input('Введите числовое значение для фильтрации по столбцу Cur_OfficialRate: ' ))
ourinput_name = str(input('Введите текст на русском языке для фильтрации по столбцу Cur_Name : '))

result = cur.query(f'Cur_OfficialRate {if_k} @ourinput_rate')
#result = cur[cur[f'Cur_OfficialRate {if_k} {ourinput_rate}']]

print(result)
#filtered_df = cur[cur[f'{col}'].str.contains(f'{ourinput}', na=False)]
filtered_df = cur[cur['Cur_Name'].str.contains(f'{ourinput_name}', na=False)]
print(filtered_df)

#Напишите программу, которая загружает данные из нескольких CSV-файлов, объединяет их,сортирует по нескольким столбцам и сохраняет результат в новый файл.