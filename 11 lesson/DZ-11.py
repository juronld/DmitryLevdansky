#1 Напишите код, который пытается преобразовать введённое пользователем значение в число.
#Обработайте исключение ValueError, если пользователь введёт строку, не являющуюся числом.

try:
    a = int(input('Введите число:'))
    print(a)
except ValueError:
    print('Некорректный ввод! Введите число!')
else:
    print(f'Введено число: {a}')


#2 Напишите программу, которая обрабатывает ввод целого числа пользователем. Если ввод
# некорректен (например, буквы), программа должна вывести сообщение об ошибке.

try:
    ourNumber = int(input('Введите целое число: '))
except Exception as e:
    print(f'Введено не целое число! Ошибка: {e}')
else:
    print(f'Введено целое число: {ourNumber}')

#3 Напишите программу, которая просит пользователя ввести индекс элемента в списке и
# выводит этот элемент. Обработайте исключение IndexError на случай ввода
# недопустимого индекса.

ourList = [1, 'Hello', 5, 4.5, 'Это строка']
try:
    ourInput = int(input('Введите индекс элемента в списке: '))
    print(f'Элемент: {ourList[ourInput]}')
except IndexError:
    print('Введен не существующий индекс элемента в списке!')
except Exception as t:
    print(f'Ошибка: {t}')

#4 Напишите функцию, которая принимает список чисел и возвращает их среднее значение.
# Обработайте исключение ZeroDivisionError, если список пустой.

def avgList(numbers):
    try:
        return sum(numbers) / len(numbers)
    except ZeroDivisionError:
        return "Список пустой! Среднее значение невозможно вычислить."

print(avgList([1, 5, 30, 44, 51]))  # 3.0
print(avgList([]))


#5 Напишите код, который использует try-except-else-finally, чтобы обработать
# ошибку деления на ноль и вывести сообщение после завершения блока try.

try:
    # Запрашиваем у пользователя два числа
    x = int(input('Введите 1 число: ' ))
    y = int(input('Введите 2 число: ' ))

    # Делим x на y
    print(x / y)
except ZeroDivisionError:
    print('Ведите второе число больше 0!')
else:
    print('Успешно')
finally:
    print('Завершение программы')


#6 Напишите программу, которая запрашивает у пользователя два числа и выполняет деление.
# Если ввод не является числом или деление на ноль, программа должна обрабатывать эти
# исключения и продолжать запрашивать ввод до тех пор, пока не будут введены корректные
# значения.

def getNumber(prompt):
    while True:
        try:
            return float(input(prompt))
        except ValueError:
            print("Ошибка: Введите корректное число.")

def ourNumbers():
    while True:
        num1 = getNumber("Введите первое число: ")
        num2 = getNumber("Введите второе число: ")
        try:
            result = num1 / num2
            print(f"Результат деления: {result}")
            break  # Выход из цикла
        except ZeroDivisionError:
            print("Ошибка: Деление на ноль невозможно. Пожалуйста, введите другое число.")
        finally:
            print('Завершение программы')

ourNumbers() #вызов функции

#7 Напишите функцию, которая принимает список и индекс. Если индекс выходит за пределы
# списка, функция должна выбрасывать пользовательское исключение и обрабатывать его в
# основной программе.
def elementIndex(my_list, index):
    if index < 0 or index >= len(my_list):
        raise Exception(f"Индекс {index} выходит за пределы списка.")
    return my_list[index]

def main():
    my_list = [10, 20, 30, 40, 50]
    index = 7
    try:
        element = elementIndex(my_list, index)
        print(f"Элемент по индексу {index}: {element}")
    except Exception as e:
        print(f"Ошибка: {e}")

main()


#8 Напишите программу, которая обрабатывает несколько возможных исключений:
# ValueError, ZeroDivisionError и IndexError. Программа должна просить
# пользователя ввести список чисел и индекс, по которому будет выполнено деление элемента
# списка на введённое число.
def main():
    while True:
        try:
            # Запрашиваем у пользователя ввод списка чисел
            user_input = input("Введите список чисел, разделённых запятыми: ")
            num_list = [float(num.strip()) for num in user_input.split(",")]

            # Запрашиваем индекс
            index = int(input("Введите индекс элемента для деления: "))

            # Запрашиваем делитель
            divisor = float(input("Введите число, на которое хотите разделить: "))

            # Получаем элемент по индексу и выполняем деление
            element = num_list[index]
            result = element / divisor

            print(f"Результат деления {element} на {divisor} равен {result}")
            break  # Выход из цикла при успешном выполнении

        except ValueError as ve:
            print(f"Ошибка: некорректный ввод {ve}")
        except ZeroDivisionError:
            print("Ошибка: деление на ноль")
        except IndexError:
            print("Ошибка: индекс выходит за пределы списка")
        except Exception as e:
            print(f"Произошла непредвиденная ошибка: {e}")

main()