#lang racket
(define (myMap f l)
  (if (null? l)
      null
      (cons (f (car l)) (myMap f (cdr l)))))

(define (myFilter f l)
  (if (null? l)
      null
      (if (f (car l))
          (cons (car l) (myFilter f (cdr l)))
          (myFilter  f (cdr l))
       )))

(define (myAppend l1 l2)
  (if (null? l1)
      l2
      (cons (car l1) (myAppend (cdr l1) l2))))
                          
(define (myReverse l)
  (if (null? l)
      null
      (myAppend (myReverse (cdr l)) (cons (car l) null))))

(define (myReverseRC l)
  (define (myReverseRC2 l Laux)
    (if (null? l)
      Laux
      (myReverseRC2 (cdr l) (cons (car l) Laux))))
  (myReverseRC2 l null))
;(myReverseRC (list 1 2 3 4))      
;                 L          Laux
;(myReverseRC2 (list 1 2 3) null)
;(myReverseRC2 (list 2 3) (cons 1 null))
;(myReverseRC2 (list 3) (cons 2 (cons 1 null)))
;(myReverseRC2 null (cons 3 (cons 2 (cons 1 null))))

;y(x)=2x^3+5x^6+20x^100

;0 Representacion
;(list (list 2 5 20) (list 3 6 100))
;(list (cons 2 3) (cons 5 6) (cons 20 100))
;(list 0 0 0 2 0 0 0 5 0 0 0 0 0 0 0 . . . . . . . 20)

;1 constructores
(define (termino coef expo)
  (if (and (number? coef) (number? expo))
      (cons coef expo)
      null
   )
)

;pertenencia 
(define (termino? t)
  (and (cons? t) (number? (car t)) (number? (cdr t))))

(define getCoef car)

(define getExp cdr)

(define (polinomio lCoef lExpo)
   (define (polinomioAux lCoef lExpo)
      (if (null? lCoef)
          null
          (cons (termino (car lCoef) (car lExpo)) (polinomioAux (cdr lCoef) (cdr lExpo)))
        )
   )
 (if (= (length lCoef) (length lExpo))
     (polinomioAux lCoef lExpo)
     null
 )
)
 
(define (polinomio2 . terminos)
  (define (checkTerminos terminos)
    (if (null? terminos)
        #t
        (and (termino? (car terminos)) (checkTerminos (cdr terminos)))
    )
  )
  (if (checkTerminos terminos)
      terminos
      null
  )
 )

(define (mas . o)
  (define (masAux lo)
    (if (null? lo)
        0
        (+ (car lo) (masAux (cdr lo))))
  )
  (masAux o)
)

;Selectores

;Modificadores

;Otras funciones
;Evaluacion
;y(x)=2x^3+5x^6+20x^100
;Y(5)=2*5^3+5*5^6+20*5^100

(define getCurrentTermino car)
(define getNextTermino cdr)

(define (evaluar p x)
  (if (null? p)
     0
     (let ([ct (getCurrentTermino p)])
       (+ (* (getCoef ct) (expt x (getExp ct))) (evaluar (getNextTermino p) x))
     )
  )
)

(define (evaluarRC p x)
  (define (evaluarAux p x acum)
    (if (null? p)
        acum
        (let ([ct (getCurrentTermino p)])
          (evaluarAux (getNextTermino p) x (+ acum (* (getCoef ct) (expt x (getExp ct)))))
          )
        )
    )
  (evaluarAux p x 0)
)

