(ql:quickload "cl-ppcre")
(defvar *scanner* (cl-ppcre:create-scanner "([a-zA-Z]+)[ \\s]+\\(([\\d]+)\\)(?:[ \\s]+\\-\\>[ \\s]+([a-zA-Z]+(?:[ \\s]*\\,[ \\s]*(?:[a-zA-Z]+))*))?"))

(defun process-line (line)
      (multiple-value-bind (match strings) (cl-ppcre:scan-to-strings *scanner* line)
        (let ((trim (lambda (x) (string-trim '(#\Space #\Tab #\Newline) x))))
            (let ((element-name (funcall trim (elt strings 0)))
                  (element-weight (funcall trim (elt strings 1))))
               (format t "Element name: ~a~% Element weight: ~a~%" element-name element-weight)
               (when (elt strings 2)
                 (let ((tokens (map 'list trim (cl-ppcre:split "\," (elt strings 2)))))
                   (map nil #'(lambda (x) (format t " --> ~a~%" x)) tokens)))))))



(let ((in (open "input.test.txt" :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil) while line do
          (process-line line)))
  (close in))

; (let ((scanner (cl-ppcre:create-scanner "([a-zA-Z]+)[ \\s]+\\(([\\d]+)\\)(?:[ \\s]+\\-\\>[ \\s]+([a-zA-Z]+(?:[ \\s]*\\,[ \\s]*(?:[a-zA-Z]+))*))?")))
;   (multiple-value-bind (match strings) (cl-ppcre:scan-to-strings scanner "foo (13)")
;     (format t "match: ~a~%" match)
;     (dotimes (x (length strings))
;       (format t "Capture ~a: ~a~%" x (aref  strings x)))))
