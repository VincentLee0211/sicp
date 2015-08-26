#|
过程 for-each 与 map 类似, 它以一个过程和一个元素表为参数, 但它并不返回结果的表, 只是将这一过程从左到右应用于各个元素, 将过程应用于元素得到的值都丢掉不用.

for-each 通常用于那些执行了某些动作的过程, 如打印等.

看下面例子:
|#

(define for-each
  (lambda (proc items)
    (if (null? items)
        'done
        (begin (proc (car items))
               (for-each proc (cdr items))))))

(for-each (lambda (x) (newline) (display x))
          '(57 321 88))
