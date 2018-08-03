(defun jump (stack pointer counter)
  (when (<= (length stack) pointer)
    (format t "Exited the maze after ~a jumps.~%" counter)
    (return-from jump))
  (let ((next (elt stack pointer)))
    (incf (elt stack pointer))
    (return-from jump (jump stack (+ pointer next) (+ counter 1)))))

(defun jump2 (stack pointer counter)
  (when (<= (length stack) pointer)
    (format t "Exited the maze after ~a jumps.~%" counter)
    (return-from jump2))
  (let ((next (elt stack pointer)))
    (if (>= next 3) (decf (elt stack pointer)) (incf (elt stack pointer)))
    (return-from jump2 (jump2 stack (+ pointer next) (+ counter 1)))))


(let ((in (open "input.test.txt" :if-does-not-exist nil)))
  (when in
    (let ((numbers (loop for line = (read-line in nil) while line collect
          (parse-integer line))))
      (format t "~a~t" numbers)
      (jump numbers 0 0))
    (close in)))

(let ((in (open "input.real.txt" :if-does-not-exist nil)))
  (when in
    (let ((numbers (loop for line = (read-line in nil) while line collect
          (parse-integer line))))
      (format t "~a~t" numbers)
      (jump2 numbers 0 0))
    (close in)))


