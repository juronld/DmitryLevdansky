"""
В домашнем задании будем практиковать JOIN и проведем аналогию с командой merge в Python.
Задача будет следующая:
Дано:
2 набора данных в виде таблиц. Вашей задачей будет
1 Изучить функцию merge в python
2 Создать в БД 2 таблицы, заполнить их тестовыми данными
3 Записать данные из этих двух таблиц в эксель файл с помощью создания python скрипта. Создать датасет, который мы запишем в файл двумя способами: с помощью JOIN в запросе, с помощью создания двух отдельных датафреймов с последующим их объединением с помощью команды merge

Di, [30.10.2024 12:56]
student_id name course_id
1 Alice 101
2 Bob 102
3 Charlie 101
4 Dave 103

course_id course_name teacher
101 Math Mr. Brown
102 Physics Dr. Green
103 Chemistry Ms. White
"""
import pandas as pd
from sqlalchemy import create_engine

# Параметры подключения
server = 'JURON\\SQLEXPRESSDE'  # Например, 'localhost' или '127.0.0.1'
database = 'AdventureWorks2017'  # Название вашей базы данных

# Строка подключения
connection_string = f'mssql+pyodbc://{server}/{database}?driver=ODBC+Driver+17+for+SQL+Server'

# Подключение к базе данных
engine = create_engine(connection_string)
print("Подключение успешно!")

# 1 вариант
query_join = """SELECT s.student_id, s.name_student, s.course_id, c.course_name, c.teacher
FROM Student s
JOIN Courses c ON s.course_id=c.course_id"""

df_join = pd.read_sql(query_join, engine)
df_join.to_excel('student_join.xlsx', index=False)

# 2 вариант
df_students = pd.read_sql("SELECT * FROM Student", engine)
df_courses = pd.read_sql("SELECT * FROM Courses", engine)

df_merged = pd.merge(df_students, df_courses, on='course_id')
df_merged.to_excel('student_merge.xlsx', index=False)

# Закрытие подключения
engine.dispose()