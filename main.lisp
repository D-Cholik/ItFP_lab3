(defun insert (element sorted-list)
  (cond ((null sorted-list) (list element))
        ((<= element (first sorted-list))
         (cons element sorted-list))
        (t (cons (first sorted-list) (insert element (rest sorted-list))))))

(defun insertion-sort-functional (list)
  (if (null list)
      '()
      (insert (first list) (insertion-sort-functional (rest list)))))

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

(defun check-insertion-sort (name function input expected)
  (format t "~:[FAILED~;passed~] ~a~%" 
          (equal (funcall function input) expected) 
          name))

(defun test-insertion-sort-functional ()
  (format t "~%Running tests for functional method~%")
  (check-insertion-sort "Functional test 1" 'insertion-sort-functional '(3 1 4 1 5 9) '(1 1 3 4 5 9))
  (check-insertion-sort "Functional test 2" 'insertion-sort-functional '(2 3 1) '(1 2 3))
  (check-insertion-sort "Functional test 3" 'insertion-sort-functional '() '()))

(defun test-insertion-sort-imperative ()
  (format t "~%Running tests for imperative method~%")
  (check-insertion-sort "Imperative test 1" 'insertion-sort-imperative '(3 1 4 1 5 9) '(1 1 3 4 5 9))
  (check-insertion-sort "Imperative test 2" 'insertion-sort-imperative '(2 3 1) '(1 2 3))
  (check-insertion-sort "Imperative test 3" 'insertion-sort-imperative '() '()))

(test-insertion-sort-functional)
(test-insertion-sort-imperative)
