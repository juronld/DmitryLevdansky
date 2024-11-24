import pandas as pd
from sqlalchemy import create_engine

# Укажите параметры подключения
server = 'JURON\\SQLEXPRESSDE'  # Имя вашего сервера
database = 'Shop_db'  # Имя вашей базы данных

# Создаем строку подключения
connection_string = f'mssql+pyodbc://{server}/{database}?driver=ODBC+Driver+17+for+SQL+Server'

# Создаем engine для SQLAlchemy
engine = create_engine(connection_string)

# Подключаемся к базе данных
try:
    connection = engine.connect()  # Используем engine для подключения
    print("Подключение успешно!")

    # Загружаем данные из файлов в таблицы
    try:
        # Читаем данные из файла и загружаем в датафрейм
        df_products = pd.read_csv('d:/Data_engineer/Projects/DmitryLevdansky/Shop/products.csv')
        df_categories = pd.read_csv('d:/Data_engineer/Projects/DmitryLevdansky/Shop/categories.csv')
        df_orders = pd.read_csv('d:/Data_engineer/Projects/DmitryLevdansky/Shop/orders.csv')
        df_order_items = pd.read_csv('d:/Data_engineer/Projects/DmitryLevdansky/Shop/order_items.csv')

        # Загружаем данные из датафрейма в базу данных
        df_categories.to_sql('Categories', con=engine, if_exists='append', index=False)
        print('Данные categories успешно загружены!')

        df_products.to_sql('Products', con=engine, if_exists='append', index=False)
        print('Данные products успешно загружены!')

        df_orders.to_sql('Orders', con=engine, if_exists='append', index=False)
        print('Данные orders успешно загружены!')

        df_order_items.to_sql('Order_Items', con=engine, if_exists='append', index=False)
        print('Данные order_items успешно загружены!')

    except Exception as e:
        print(f'Ошибка при загрузке данных: {e}')

finally:
    connection.close()  # Закрываем соединение
    print('Программа завершена')