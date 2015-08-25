;; 证明 Fib(n) 是最接近 (q^n)/(5^1/2) 的整数, 其中 q = (1 + 5^1/2) / 2
;; 证明 Fib(n) = (q^n - r^n) / (5^1/2)

#|

;; 归纳法证明 Fib(n) = ...

;; 当 n = 0 时, Fib(0) = (q^0 - r^0) / (5^1/2) = 0
;; 当 n = 1 时, Fib(1) = (q^1 - r^1) / (5^1/2) = (5^1/2) / (5^1/2) = 1

;; 假设当 n 时, Fib(n) 成立
;; Fib(n-1) = (q^(n-1) - r^(n-1)) / (5^1/2)
;; Fib(n) = (q^n - r^n) / (5^1/2)
;;
;; q, r 都是 q^2 = q + 1的解 
;;
;; Fib(n+1) = Fib(n) + Fib(n+1)
;;          = (q^n + q^(n-1) - r^n - r^(n-1)) / (5^1/2)
;;          = (q^(n-1) (1+q) - r^(n-1) (1+r)) / (5^1/2)
;;          = (q^(n-1) q^2 - r^(n-1) r^2) / (5^1/2)
;;          = (q^(n+1) - r^(n+1)) / (5^1/2)

;; Fib(n) 的近似值
;; r = (1 - 5^1/2) / 2 ~~ -0.6
;; r^n ~~ 0
;; Fib(n) ~~ (q^n) / (5^1/2)

|#