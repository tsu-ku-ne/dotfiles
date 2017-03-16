(define skk-return-key '(generic-return-key))
(define skk-return-key? (make-key-predicate '(generic-return-key?)))
(define skk-latin-conv-key '("/"))
(define skk-latin-conv-key? (make-key-predicate '("/")))
(define skk-conv-wide-latin-key '("<IgnoreCase><Control>q"))
(define skk-conv-wide-latin-key? (make-key-predicate '("<IgnoreCase><Control>q")))
(define skk-conv-opposite-case-key '("<IgnoreCase><Control>u"))
(define skk-conv-opposite-case-key? (make-key-predicate '("<IgnoreCase><Control>u")))
(define skk-begin-completion-key '("tab" "<IgnoreCase><Control>i" skk-new-completion-from-current-comp-key))
(define skk-begin-completion-key? (make-key-predicate '("tab" "<IgnoreCase><Control>i" skk-new-completion-from-current-comp-key?)))
(define skk-next-completion-key '("." "tab" "<IgnoreCase><Control>i"))
(define skk-next-completion-key? (make-key-predicate '("." "tab" "<IgnoreCase><Control>i")))
(define skk-prev-completion-key '(","))
(define skk-prev-completion-key? (make-key-predicate '(",")))
(define skk-new-completion-from-current-comp-key '("<Alt>tab" "<IgnoreCase><Control><Alt>i"))
(define skk-new-completion-from-current-comp-key? (make-key-predicate '("<Alt>tab" "<IgnoreCase><Control><Alt>i")))
(define skk-special-midashi-key '("<IgnoreShift>>" "<IgnoreShift><"))
(define skk-special-midashi-key? (make-key-predicate '("<IgnoreShift>>" "<IgnoreShift><")))
(define skk-vi-escape-key '("escape" "<Control>["))
(define skk-vi-escape-key? (make-key-predicate '("escape" "<Control>[")))
(define skk-state-direct-no-preedit-nop-key '("<IgnoreCase><Control>j"))
(define skk-state-direct-no-preedit-nop-key? (make-key-predicate '("<IgnoreCase><Control>j")))
(define skk-purge-candidate-key '("<IgnoreCase><Shift>x"))
(define skk-purge-candidate-key? (make-key-predicate '("<IgnoreCase><Shift>x")))
