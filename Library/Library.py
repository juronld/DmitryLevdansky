import pandas as pd
from sqlalchemy import create_engine

# Параметры подключения
server = 'JURON\\SQLEXPRESSDE'  # Например, 'localhost' или '127.0.0.1'
database = 'Library_db'  # Название вашей базы данных

# Строка подключения
connection_string = f'mssql+pyodbc://{server}/{database}?driver=ODBC+Driver+17+for+SQL+Server'

# Подключение к базе данных
engine = create_engine(connection_string)
print("Подключение успешно!")

# Читаем данные из файла xlsx
df1 = pd.read_excel('d:/Data_engineer/Projects/DmitryLevdansky/Library/Books.xlsx')
df2 = pd.read_excel('d:/Data_engineer/Projects/DmitryLevdansky/Library/Borrowers.xlsx')
df3 = pd.read_excel('d:/Data_engineer/Projects/DmitryLevdansky/Library/Loans.xlsx')

#print(df3)
#df3['LoanDate'] = pd.to_datetime(['LoanDate'],format='%Y%m%d')

# Загружаем данные в таблицы в базу данных Library_db
try:
    df1.to_sql('Books', con=engine, if_exists='append', index=False)
    print('Данные успешно загружены в таблицу Books')
    df2.to_sql('Borrowers', con=engine, if_exists='append', index=False)
    print('Данные успешно загружены в таблицу Borrowers')
    df3.to_sql('Loans', con=engine, if_exists='append', index=False)
    print('Данные успешно загружены в таблицу Loans')
except Exception as e:
    print("Ошибка при загрузке данных в SQL Server:")
    print(f"Ошибка: {e}")

