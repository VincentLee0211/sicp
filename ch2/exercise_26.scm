;; 假定已将 x 和 y 定义为如下的两个表:

(define x '(1 2 3))
(define y '(4 5 6))

;; 解释器对于下面各个表达式将打印什么结果

(append x y)               ;; append 将另一个序列的元素追加到序列的后面

'(1 2 3 4 5 6)

(cons x y)                 ;; cons 将一个单元添加到序列的最前面
'((1 2 3) 4 5 6)

(list x y)                 ;; 将 N 个单元组成新的序列
'((1 2 3) (4 5 6))
