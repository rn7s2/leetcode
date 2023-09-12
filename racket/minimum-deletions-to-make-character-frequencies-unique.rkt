#lang racket

(define (char-counts s)
  (foldl (λ (ch counts)
           (hash-update counts ch add1 0))
         (make-immutable-hash)
         (string->list s)))

(define (max-free-count unique-counts count)
  (define num (sub1 count))
  (cond [(zero? num) 0]
        [(set-member? unique-counts num)
         (max-free-count unique-counts (sub1 count))]
        [else num]))

(define/contract (min-deletions s)
  (-> string? exact-integer?)
  (cdr (foldl (λ (kv ret)
                (match-let ([(cons _ count) kv]
                            [(cons unique-counts deletions) ret])
                  (cond [(set-member? unique-counts count)
                         (let ([new-count (max-free-count unique-counts count)])
                           (cons (set-add unique-counts new-count)
                                 (+ deletions (- count new-count))))]
                        [else (cons (set-add unique-counts count) deletions)])))
              (cons (set) 0)
              (hash->list (char-counts s)))))

(min-deletions "ceabaacb")
