#lang racket

(module solution-linear racket
  (provide candy)

  ; 每个位置开始仅需要 1 个高度
  ; left-lifts 的每一项代表该位置受左侧影响需要最小高度
  ; right-lifts 的每一项代表该位置受右侧影响需要最小高度
  ; 两侧的最小高度的较大者即为该位置的高度
  ; 所有位置高度求和即为最终结果
  
  (define (left-lifts ratings)
    (define (lifts r rest lst)
      (cond [(empty? rest) lst]
            [(< r (car rest))
             (lifts (car rest) (cdr rest) (cons (add1 (car lst)) lst))]
            [else (lifts (car rest) (cdr rest) (cons 1 lst))]))
    (reverse (lifts (car ratings) (cdr ratings) '(1))))

  (define (right-lifts ratings)
    (reverse (left-lifts (reverse ratings))))

  (define/contract (candy ratings)
    (-> (listof exact-integer?) exact-integer?)
    (foldl (λ (ll rl sum) (+ (max ll rl) sum))
           0
           (left-lifts ratings)
           (right-lifts ratings))))

(module solution-topo racket
  (provide candy)
  
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
    (topo (make-graph ratings))))

(require 'solution-linear)

(candy '(1 0 2))
(candy '(1 2 2))
(candy '(1 3 2 2 1))
