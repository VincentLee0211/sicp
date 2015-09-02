#|
Louis Reasoner 在练习42时遇到了麻烦, 他的 queens 过程看起来能行, 但却运行极慢.

当 Louis 请 Eva Lu Ator 帮忙时, 她指出他在 flatmap 里交换了嵌套映射的顺序, 将它写成了:
|#

(flatmap (lambda (new-row)
           (map (lambda (rest-of-queens)
                  (adjoin-position new-row k rest-of-queens))
                (queen-cols (sub1 k))))
         (enumerate-interval 1 board-size))

#|
请解释一下, 为什么这样交换顺序会使程序运行得非常慢.
估计一下, 用 Louis 的程序去解决八皇后问题大约需要多少时间, 假定练习42中的程序需要时间 T 求解这一难题
|#

;; 先生成(1 ... 8)的序列, 对每一个数值, 都需要计算一次(queen-cols (sub1 k))操作, 重复计算次数太多

;; 8T
