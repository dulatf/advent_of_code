(ql:quickload "split-sequence")
(let ((in (open "input.real.txt" :if-does-not-exist nil)))
  (when in
    (defvar *numbers* (loop for line = (read-line in nil)
    while line collect (let
        ((tokens (split-sequence:split-sequence-if
            #'(lambda (c) (or (char= c #\Space) (char= c #\tab)))
            line :remove-empty-subseqs t)))
        (let 
         ((nums (map 'list #'parse-integer tokens)))
         nums))))
   (close in)))

(defun compute-checksum (line) 
 (let ((minval (apply #'min line))
       (maxval (apply #'max line)))
  (- maxval minval)))
(defun compute-checksum-even (line)
 (loop for i below (length line) do
  (loop for j below (length line) do
   (unless (= i j)
    (let ((x (nth i line))
          (y (nth j line)))
      (when (= 0 (mod x y))
       (return-from compute-checksum-even (/ x y))))))))

(let ((spreadsheet (remove nil *numbers*)))
    (format t "~a~%" spreadsheet)
    (let ((line-checksums (map 'list #'compute-checksum-even spreadsheet)))
     (format t "~a~%" line-checksums)
     (format t "~a~%" (apply #'+ line-checksums))))

