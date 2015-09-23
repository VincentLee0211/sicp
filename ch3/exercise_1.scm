#|
一个累加器是一个过程, 反复用数值参数调用它, 就会使它的各个参数累加到一个和数中.
每次调用累加器将返回当前的累加. 请写出一个生成累加器的过程 make-accumulator,
它所生成的每个累加器维持着一个独立的和.
|#

(define make-accumulator
  (lambda (init)
    (lambda (n)
      (set! init (+ init n))
      init)))
