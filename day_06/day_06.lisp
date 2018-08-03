(ql:quickload "split-sequence")

(defun fill-memory (memory pos val)
  (loop for i from 1 to val do
        (let ((cur (mod (+ pos i) (length memory))))
          (incf (elt memory cur)))))
(defun process-memory (memory counter stack)
  (format t "Step ~a: ~a~%" counter memory)
  (let* ((max-val (apply #'max memory))
         (max-pos (position max-val memory)))
    (setf (elt memory max-pos) 0)
    (fill-memory memory max-pos max-val)
    (format t "After refilling: ~a~%" memory)
    (when (or (< 50000 counter) (find memory stack :test #'equal))
      (format t "Length of the loop: ~a~%" (- counter (position memory (reverse stack) :test #'equal)))
      (format t "Loop found after ~a steps~%" (1+ counter))
      (return-from process-memory counter))
    (push (copy-list memory) stack)
    (process-memory memory (1+ counter) stack)))

(let ((in (open "input.real.txt" :if-does-not-exist nil)))
  (when in
    (let ((line-in (read-line in nil)))
       (when line-in
         (let* ((tokens (split-sequence:split-sequence-if #'(lambda (c) (or (char= c #\Space) (char= c #\tab))) line-in :remove-empty-subseqs t))
                (numbers (map 'list #'parse-integer tokens))
                (stack nil))
           (format t "Initial memory configuration: ~a~%" numbers)
           (process-memory numbers 0 stack))))
    (close in)))
