#|
在对应用程序做软件测试时, 能够统计出在计算过程中某个给定过程被调用的次数常常很有用处.
请写出一个过程 make-monitored, 它以一个过程f作为输入, 该过程本身有一个输入.
make-monitored返回的结果是第三个过程, 比如说mf, 它将用一个内部计数器维持着自己被调用的次数.
如果mf的输入是特殊符号how-many-calls?, 那么mf就返回内部计数器的值;
如果输入是特殊符号reset-count, 那么mf就将计数器重新设置为0;
对于任何其他输入, mf将返回过程f应用于这一输入的结果, 并将内部计数器加一.
|#

(define make-monitored
  (let ((init 0))
    (lambda (f)
      (lambda (m)
        (cond [(eq? m 'how-many-calls?) init]
              [(eq? m 'reset-count) (set! init 0) init]
              [else (set! init (add1 init)) (f m)])))))

(define add1 (lambda (x) (+ x 1)))
