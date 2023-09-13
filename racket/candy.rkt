#lang racket

(define (enumerate lst)
  (map cons lst (build-list (length lst) values)))

(define (empty-graph)
  '(() ()))

(define (graph-empty? g)
  (and (empty? (vertices g))
       (empty? (edges g))))

(define (extend-graph g x y)
  (match-let ([(list v e) g])
    (define edges (cons (cons x y) e))
    (list v edges)))

(define (in-deg edges u)
  (length (filter (λ (e) (= (cdr e) u)) edges)))

(define vertices first)
(define edges second)

(define (remove-vertex-and-arc g u)
  (list (filter (λ (v) (not (= u v))) (vertices g))
        (filter (λ (e) (not (= u (car e)))) (edges g))))

(define (make-graph ratings)
  (define (helper x rest graph)
    (if (null? rest)
        graph
        (match-let ([(cons r idx) x]
                    [(cons nr nidx) (car rest)])
          (cond [(< r nr)
                 (helper (car rest)
                         (cdr rest)
                         (extend-graph graph idx nidx))]
                [(> r nr)
                 (helper (car rest)
                         (cdr rest)
                         (extend-graph graph nidx idx))]
                [else (helper (car rest) (cdr rest) graph)]))))
  (define zipped (enumerate ratings))
  (define no-vertices (helper (car zipped) (cdr zipped) (empty-graph)))
  (list (build-list (length ratings) values) (edges no-vertices)))

(define (topo g)
  (define (helper g layer sum)
    (cond [(graph-empty? g) sum]
          [else (define bare-v (filter (λ (v)
                                         (zero? (in-deg (edges g) v)))
                                       (vertices g)))
                (helper (foldl (λ (v g) (remove-vertex-and-arc g v)) g bare-v)
                        (add1 layer)
                        (+ sum (* layer (length bare-v))))]))
  (helper g 1 0))

(define/contract (candy ratings)
  (-> (listof exact-integer?) exact-integer?)
  (topo (make-graph ratings)))

(candy '(1 0 2))
(candy '(1 2 2))
(candy '(1 3 2 2 1))
