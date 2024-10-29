<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b>
<p align="center">
<br>"Функціональний і імперативний
підходи до роботи зі списками"</br>
з дисципліни "Вступ до функціонального програмування"
</p>

<div style="display: flex; justify-content: flex-end;">
  <div style="border: 0px; padding: 10px;">
    <p>Студент: Чоловенко Дмитро Володимирович</p>
    <p>Група: КВ-13</p>
    <p>Рік: 2024</p>
  </div>
</div>

## Загальне завдання  
Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і
імперативно.
1. Функціональний варіант реалізації має базуватись на використанні рекурсії і
конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного списку.
Не допускається використання: псевдо-функцій, деструктивних операцій, циклів,
функцій вищого порядку або функцій для роботи зі списками/послідовностями, що
використовуються як функції вищого порядку. Також реалізована функція не має
бути функціоналом (тобто приймати на вхід функції в якості аргументів).
2. Імперативний варіант реалізації має базуватись на використанні циклів і
деструктивних функцій (псевдофункцій). Не допускається використання функцій
вищого порядку або функцій для роботи зі списками/послідовностями, що
використовуються як функції вищого порядку. Тим не менш, оригінальний список

цей варіант реалізації також не має змінювати, тому перед виконанням
деструктивних змін варто застосувати функцію copy-list (в разі необхідності).
Також реалізована функція не має бути функціоналом (тобто приймати на вхід
функції в якості аргументів).
Алгоритм, який необхідно реалізувати, задається варіантом (п. 3.1.1). Зміст і шаблон звіту
наведені в п. 3.2.
Кожна реалізована функція має бути протестована для різних тестових наборів. Тести
мають бути оформленні у вигляді модульних тестів (наприклад, як наведено у п. 2.3)..

## Варіант №4
<p align="center">
<img src="variant4.png" alt="Варіант 4">
</p>  

## Лістинг функції `insertion-sort-functional / insert`
``` lisp
(defun insert (element sorted-list)
  (cond ((null sorted-list) (list element))
        ((<= element (first sorted-list))
         (cons element sorted-list))
        (t (cons (first sorted-list) (insert element (rest sorted-list))))))

(defun insertion-sort-functional (list)
  (if (null list)
      '()
      (insert (first list) (insertion-sort-functional (rest list)))))
```
### Тестові набори
``` lisp
(defun check-insertion-sort (name function input expected)
  (format t "~:[FAILED~;passed~] ~a~%" 
          (equal (funcall function input) expected) 
          name))

(defun test-insertion-sort-functional ()
  (format t "~%Running tests for functional method~%")
  (check-insertion-sort "Functional test 1" 'insertion-sort-functional '(3 1 4 1 5 9) '(1 1 3 4 5 9))
  (check-insertion-sort "Functional test 2" 'insertion-sort-functional '(2 3 1) '(1 2 3))
  (check-insertion-sort "Functional test 3" 'insertion-sort-functional '() '()))
```
### Тестування
```
Running tests for functional method
passed Functional test 1
passed Functional test 2
passed Functional test 3
```
## Лістинг функції `list-set-symmetric-difference`
```lisp
(defun insertion-sort-imperative (list)
  (let ((sorted (copy-list list)))
    (loop for i from 1 below (length sorted) do
      (let ((element (elt sorted i))
            (j i))
        (loop while (and (> j 0) (> (elt sorted (1- j)) element)) do
          (setf (elt sorted j) (elt sorted (1- j)))
          (decf j))
        (setf (elt sorted j) element)))
    sorted))
```
### Тестові набори
```lisp
(defun check-insertion-sort (name function input expected)
  (format t "~:[FAILED~;passed~] ~a~%" 
          (equal (funcall function input) expected) 
          name))

(defun test-insertion-sort-imperative ()
  (format t "~%Running tests for imperative method~%")
  (check-insertion-sort "Imperative test 1" 'insertion-sort-imperative '(3 1 4 1 5 9) '(1 1 3 4 5 9))
  (check-insertion-sort "Imperative test 2" 'insertion-sort-imperative '(2 3 1) '(1 2 3))
  (check-insertion-sort "Imperative test 3" 'insertion-sort-imperative '() '()))
```
### Тестування
```
Running tests for imperative method
passed Imperative test 1
passed Imperative test 2
passed Imperative test 3
```
