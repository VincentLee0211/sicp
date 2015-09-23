;; 数字模拟电路

;; 基本功能块
;;
;; (get-signal <wire>)
;; 返回连线上信号的当前值
;;
;; (set-signal! <wire> <new value>)
;; 将连线上的信号修改为新的值
;;
;; (add-action! <wire> <procedure of no arguments>)
;; 断言, 只要在连线上的信号值改变, 指定过程就需要执行
;;
;; (after-delay <time> <procedure>)
;; 延迟加载

;; 定义反门

;; 定义与门

;; 定义或门

;; 半加器

;; 全加器

;; 级联进位器
