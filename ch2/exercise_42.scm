#|
"八皇后谜题"问的是怎样将八个皇后摆在国际象棋棋盘上, 使得任意一个皇后都不能攻击另一个皇后(也就是说, 任意两个皇后都不在同一行, 同一列或者同一对角线上)

解决这一谜题的一种方法按一个方向处理棋盘, 每次在每一列里放一个皇后. 如果现在已经放好了 k-1 个皇后, 第 k 个皇后就必须放在不会被已在棋盘上的任何皇后攻击的位置上.

我们可以递归地描述这一过程: 假定我们已经生成了在棋盘的前 k-1 列中放置 k-1个皇后的所有可能方式, 现在需要的就是对于其中的每种方式, 生成出将下一个皇后放在第 k 列中每一行的扩充集合. 而后过滤它们, 只留下能使位于第 k 列的皇后与其他皇后相安无事的那些扩充.

这样就能产生出将第 k 个皇后放置在前 k 列的所有格局的序列. 继续这一过程, 我们将能产生出这一谜题的所有解, 而不是一个解

将这一解法实现为一个过程 queens, 令它返回在 n * n 棋盘上放 n 个皇后的所有解的序列.
|#

#|
'(())                                                   ;; 0中可能

'()                                                     ;; 没有可能

'((1 6) (2 2) (3 7) (4 1) (5 4) (6 8) (7 5) (8 3))      ;; 一种可能
|#
(define queens.v1
  (lambda (board-size)
    ;; 返回在棋盘的前 k 列中放皇后的所有格局的序列
    (define queen-cols
      (lambda (k)
        (if (= k 0)
            (list empty-board)
            (filter (lambda (positions) (safe? k positions))
                    (flatmap (lambda (rest-of-queens) ;; rest-of-queens 在前 k-1 列放置 k-1个皇后的一种方式
                               (map (lambda (new-row)  ;; 在第 k 列放置所考虑的行编号
                                      (adjoin-position new-row k rest-of-queens))
                                    (enumerate-interval 1 board-size)))
                             (queen-cols (sub1 k)))))))
    ;; 将一个新的行列格局加入一个格局集合
    (define adjoin-position
      (lambda (new-row k rest-of-queens)
        (append rest-of-queens (list (list k new-row)))))
    ;; 确定在一个格局中, 在第 k 列的皇后相对于其他列的皇后是否为安全的
    (define safe?
      (lambda (k positions)
        (define recur
          (lambda (item rest)
            (if (null? rest)
                #t
                (and (not (or (= (cadar rest) (abs (- (cadr item) (- k (caar rest)))))
                              (= (cadar rest) (abs (+ (cadr item) (- k (caar rest)))))
                              (= (cadar rest) (cadr item))))
                     (recur item (cdr rest))))))
        (let ((position (list-ref positions (sub1 k)))
              (rest-of-positions (reverse (list-tail (reverse positions) 1))))
          (recur position rest-of-positions))))
    ;; 空的格局集合
    (define empty-board '())
    (queen-cols board-size)))

#|
'(())

'((6 2 7 1 4 8 5 3))
|#
(define queens.v2
  (lambda (board-size)
    (define queen-cols
      (lambda (k)
        (if (zero? k)
            (list empty-board)
            (filter (lambda (positions) (safe? k positions))
                    (flatmap (lambda (rest-of-queens)
                               (map (lambda (new-row)
                                      (adjoin-position new-row k rest-of-queens))
                                    (enumerate-interval 1 board-size)))
                             (queen-cols (sub1 k)))))))
    (define empty-board '())
    (define adjoin-position
      (lambda (new-row k rest-of-queens)
        (append rest-of-queens (list new-row))))
    (define safe?
      (lambda (k positions)
        (define recur
          (lambda (item rest index)
            (if (null? rest)
                #t
                (and (not (or (= (car rest) (abs (- item (- k index))))
                              (= (car rest) (abs (+ item (- k index))))
                              (= (car rest) item)))
                     (recur item (cdr rest) (add1 index))))))
        (let ((cr (list-ref positions (sub1 k)))
              (rest (reverse (list-tail (reverse positions) 1))))
          (recur cr rest 1))))
    (queen-cols board-size)))

(define sub1 (lambda (x) (- x 1)))

(define add1 (lambda (x) (+ x 1)))

(define map
  (lambda (proc seq)
    (if (null? seq)
        '()
        (cons (proc (car seq))
              (map proc (cdr seq))))))

(define flatmap
  (lambda (proc seq)
    (accumualte append '() (map proc seq))))

(define accumualte
  (lambda (op init seq)
    (if (null? seq)
        init
        (op (car seq)
            (accumualte op init (cdr seq))))))

(define enumerate-interval
  (lambda (low high)
    (if (> low high)
        '()
        (cons low (enumerate-interval (add1 low) high)))))
