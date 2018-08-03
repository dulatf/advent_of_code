(let ((in (open "input.real.txt" :if-does-not-exist nil)))
  (when
      (defvar *input-string* (read-line in)))
  (close in))
(format t "~a~%~%" *input-string*)
(defvar *input-numbers* 
  (loop for c across *input-string* 
        collect (parse-integer (string c))))
(format t "~a~%" *input-numbers*)

(defun sum-repeated (numbers)
 "Compute sum of repeated numbers"
 (let ((acc 0))
  (loop for idx below (length numbers) do 
   (let* ((this (nth idx numbers))
    (next-idx (if (= (1+ idx) (length numbers)) 0 (1+ idx)))
    (next (nth next-idx numbers)))
     (if (= this next)
      (setf acc (+ acc this)))))
  (return-from sum-repeated acc)))

(defun sum-repeated-offset (numbers offset)
 "Compute sum of repeated numbers"
 (let ((acc 0))
  (loop for idx below (length numbers) do 
   (let* ((this (nth idx numbers))
    (next-idx (mod (+ idx offset) (length numbers)))
    (next (nth next-idx numbers)))
     (if (= this next)
      (setf acc (+ acc this)))))
  (return-from sum-repeated-offset acc)))


(format t "~a~%" (sum-repeated *input-numbers*))
(format t "~a~%" (sum-repeated-offset *input-numbers* (/ (length *input-numbers*) 2)))
