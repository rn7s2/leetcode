#lang racket

; 找到一条路径, 从固定起点出发能够经过所有给定边
; 想不出好办法, 暴力吧
; DFS 整张图, 记录用过的机票 (注意重复), 找到一条长度为 (length tickets) 的就停止

(define (make-mappings airports)
  (define (helper airports idx mapping back-mapping)
    (cond [(empty? airports) (cons mapping back-mapping)]
          [(hash-has-key? mapping (car airports))
           (helper (cdr airports) idx mapping back-mapping)]
          [else (helper (cdr airports)
                        (add1 idx)
                        (hash-set mapping (car airports) idx)
                        (hash-set back-mapping idx (car airports)))]))
  (helper airports 0 (make-immutable-hash) (make-immutable-hash)))

(define (all-airports tickets)
  (sort (set->list
         (foldl (λ (ticket airports)
                  (match-let ([(list from to) ticket])
                    (define tmp (if (set-member? airports from)
                                    airports
                                    (set-add airports from)))
                    (if (set-member? tmp to)
                        tmp
                        (set-add tmp to))))
                (set)
                tickets))
        string<?))

(define (tickets->edges tickets airport-idx)
  (foldl (λ (ticket edges)
           (match-let ([(list from to) ticket])
             (cons (cons (hash-ref airport-idx from)
                         (hash-ref airport-idx to))
                   edges)))
         '()
         tickets))

(define (next-hops edges u covered-edges)
  (map (λ (e) (match-let ([(cons _ to) e]) to))
       (filter (λ (e)
                 (match-let ([(cons from to) e])
                   (and (= from u)
                        (< (count (λ (arc) (equal? arc e)) covered-edges)
                           (count (λ (arc) (equal? arc e)) edges)))))
               edges)))

(define (path->string airports path)
  (foldl (λ (edge str)
           (match-let ([(cons from to) edge])
             (string-append str (hash-ref airports to))))
         (hash-ref airports (car (car path)))
         path))

(define (path->string-list airports path)
  (reverse (foldl (λ (edge str-lst)
                    (match-let ([(cons from to) edge])
                      (cons (hash-ref airports to) str-lst)))
                  (list (hash-ref airports (car (car path))))
                  path)))

(define (dfs start edges path-len)
  (define (search-from u step covered-edges)
    (cond [(= step path-len) (list covered-edges)]
          [else
           (define vs (next-hops edges u covered-edges))
           (cond [(empty? vs) '()]
                 [else
                  (define next-hop-paths
                    (foldl append
                           '()
                           (map (λ (v)
                                  (search-from v
                                               (add1 step)
                                               (cons (cons u v)
                                                     covered-edges)))
                                vs)))
                  next-hop-paths])]))
  (define result (search-from start 0 '()))
  (map (λ (path) (reverse path)) result))

(define/contract (find-itinerary tickets)
  (-> (listof (listof string?)) (listof string?))

  (match-define (cons name->id id->name) (make-mappings (all-airports tickets)))
  (define edges (tickets->edges tickets name->id))
  
  (define paths (dfs (hash-ref name->id "JFK") edges (length tickets)))
  
  (define zip (map (λ (path) (cons path (path->string id->name path))) paths))
  (define min-path
    (car (foldl (λ (pair min) (if (string<? (cdr pair) (cdr min)) pair min))
                (car zip)
                (cdr zip))))
  (path->string-list id->name min-path))

(find-itinerary '[["MUC" "LHR"] ["JFK" "MUC"] ["SFO" "SJC"] ["LHR" "SFO"]])
(find-itinerary '[["JFK" "SFO"] ["JFK" "ATL"] ["SFO" "ATL"] ["ATL" "JFK"] ["ATL" "SFO"]])
(find-itinerary '[["EZE" "AXA"] ["TIA" "ANU"] ["ANU" "JFK"] ["JFK" "ANU"] ["ANU" "EZE"] ["TIA" "ANU"] ["AXA" "TIA"] ["TIA" "JFK"] ["ANU" "TIA"] ["JFK" "TIA"]])
