import pandas as pd
import pyodbc

# Укажите параметры подключения
server = 'JURON\\SQLEXPRESSDE'  # Имя вашего сервера
database = 'Shop_db'  # Имя вашей базы данных
driver = '{ODBC Driver 17 for SQL Server}'  # Убедитесь, что этот драйвер установлен

# Создаем строку подключения
connection_string = (f'DRIVER={driver};'
                     f'SERVER={server};'
                     f'DATABASE={database};'
                     f'Trusted_Connection=yes;')

# Подключаемся к базе данных
try:
    connection = pyodbc.connect(connection_string)
    print("Подключение успешно!")

    # Создаем курсор для выполнения запросов
    cursor = connection.cursor()

    # Загружаем данные из файлов в таблицы
    try:
        # Читаем данные из файла и загружаем в датафрейм
        df_categories = pd.read_csv('d:/Data_engineer/Projects/DmitryLevdansky/SQL/Shop/categories.csv')
        df_products = pd.read_csv('d:/Data_engineer/Projects/DmitryLevdansky/SQL/Shop/products.csv')
        df_orders = pd.read_csv('d:/Data_engineer/Projects/DmitryLevdansky/SQL/Shop/orders.csv')
        df_order_items = pd.read_csv('d:/Data_engineer/Projects/DmitryLevdansky/SQL/Shop/order_items.csv')

        # Функция для загрузки данных из DataFrame в таблицу
        def load_data_to_sql(table_name, df):
            for index, row in df.iterrows():
                # Формируем SQL-запрос для вставки данных
                columns = ', '.join(df.columns)
                placeholders = ', '.join(['?'] * len(row))
                sql = f'INSERT INTO {table_name} ({columns}) VALUES ({placeholders})'
                cursor.execute(sql, row.tolist())
            print(f'Данные в таблицу {table_name} успешно загружены!')

        # Загружаем данные в каждую таблицу
        load_data_to_sql('Categories', df_categories)
        load_data_to_sql('Products', df_products)
        load_data_to_sql('Orders', df_orders)
        load_data_to_sql('Order_items', df_order_items)

        # Фиксируем изменения
        connection.commit()

    except Exception as e:
        print(f'Ошибка при загрузке данных: {e}')

finally:
    cursor.close()  # Закрываем курсор
    connection.close()  # Закрываем соединение
    print('Программа завершена')