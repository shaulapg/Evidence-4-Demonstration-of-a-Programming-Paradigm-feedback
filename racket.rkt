#lang racket

(define (solve p refund win loss)
  (define factor (/ (- 1 p) p))
  (define x (expt factor loss))
  (define y (expt factor (+ win loss)))

  (define pWin (/ (- 1 x) (- 1 y)))
  (define pLoss (- 1 pWin))

  (+ (* pWin win)
     (* -1 pLoss loss (- 1 refund))))

(define (max-expected-profit x p_)
  (define refund (/ x 100.0))
  (define p (/ p_ 100.0))

  (define best (box 0.0))
  (define bestwin (box 1))
  (define loss 1)

  (let loop-loss ()
    (when (not (= p 0))
      (define prev 0.0)
      (define cont #f)
      (define win (unbox bestwin))

      (let loop-win ()
        (define cur (solve p refund win loss))
        (when (> cur (unbox best))
          (set-box! best cur)
          (set-box! bestwin win)
          (set! cont #t))
        (when (>= cur prev)
          (set! prev cur)
          (set! win (+ win 1))
          (loop-win)))

      (when cont
        (set! loss (+ loss 1))
        (loop-loss))))
  
  (unbox best))

(max-expected-profit 0 49.9)
;output: 0.00000000

(max-expected-profit 50 49.85)
;output: 7.101784529895273

(max-expected-profit 100 10.3)
;output: 0.11482720

(max-expected-profit 94 12.45)
;output: 0.07197000

(max-expected-profit 80 39.74)
;output: 0.33154559
