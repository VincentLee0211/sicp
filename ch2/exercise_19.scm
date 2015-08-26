#|
请考虑上节的兑换零钱方式计数程序.
如果能够轻而易举地改变程序里所用的兑换币就更好了. 譬如说, 那样我们就能计算出1英镑的不同兑换方式的数目.在写前面那个程序时, 有关币种的知识中有一部分出现在过程 first-denomination 里, 另一部分出现在过程里 count-change. 如果能够用一个表来提供可用于兑换的硬币就更好了.

我们希望重写出过程 cc, 使其第二个参数是一个可用硬币的币值表, 而不是一个指定可用硬币种类的整数.
而后我们就可以针对各种货币定义出一些表:
|#

(define us-coins '(50 25 10 5 1))

(define uk-coins '(100 50 20 10 5 2 1 0.5))

#|
然后我们就可以通过如下方式调用 cc:

(cc 100 us-coins)
292

为了做到这件事, 我们需要对程序 cc 做一些修改.
它仍然居右同样的形式, 但将以不同的方式访问自己的第二个参数

请基于表结构上的基本操作, 定义出过程 first-denomination, except-first-denomination 和 no-more?
表 coin-valus 的排列顺序会影响 cc 给出的答案吗? 为什么?
|#

(define cc
  (lambda (amount coin-values)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (no-more? coin-values)) 0)
          (else (+ (cc amount (except-first-denomination coin-values))
                   (cc (- amount (first-denomination coin-values)) coin-values))))))

(define no-more? null?)

(define except-first-denomination cdr)

(define first-denomination car)
