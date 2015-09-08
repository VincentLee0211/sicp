#|
Eva Lu Ator 输入了表达式:

(car ''abracadabra)

令她吃惊的是解释器打印出的是 quote, 请解释
|#

;; 'x 是 (quote x) 的语法糖

;; (car ''abracadabra)
;; (car (quote (quote abracadabra)))
;; quote
