#|
对于 x 的某个给定值, 求出一个多项式在 x 的值, 也可以形式化为一种累积.

假定需要求下面多项式的值:
anx^n + a(n-1)x^(n-1) + ... + a1x + a0

采用著名的 Horner 规则, 可以构造出下面的计算:
(... (anx + a(n-1))x + ... + a1)x + a0

换句话说, 我们可以从 an 开始, 乘以 x, 再加上 a(n-1), 乘以 x, 如此下去, 直到处理玩 a0
请填充下面的模板, 做出一个利用 Horner 规则求多项式的过程.
假定多项式的系数安排在一个序列里, 从 a0 直到 an

例如, 为了计算 1 + 3x + 5x^3 + x^5 在 x = 2 的值, 你需要求值:
|#

;; higher-terms 是上一级的求值结果, 本次的结果计算: higher * x + this
(define horner-eval
  (lambda (x coefficient-sequence)
    (accumulate (lambda (this-coeff higher-terms)
                  (+ this-coeff (* x higher-terms)))
                0
                coefficient-sequence)))

(horner-eval 2 '(1 3 0 5 0 1))
