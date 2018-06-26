#lang racket
(define (polinomio Lcoefs Lexps)
  (if (and (list? Lcoefs) (list? Lexps))
           (if (and (length Lcoefs) (length Lexps))
               (if (null? Lcoefs)
                   null
                   (cons (cons (car Lcoefs) (car Lexps)) (polinomio (cdr Lcoefs) (cdr Lexps)))
               )
            null
       )
       null
   )
 )

(define (polTermino coeficiente exponente)
  (if (and (number? coeficiente) (number? exponente))
      (cons coeficiente exponente)
      null
   )
  )

(define (polTermino? t)
  (if (cons? t)
      (and (number? (car t)) (number? (cdr t)))
      #f
   )
 )

(define (getCoeficiente pt)
  (if (polTermino? pt)
      (car pt)
      0
      )
  )

(define (getExponente pt)
  (if (polTermino? pt)
      (cdr pt)
      0
      )
  )

(define (setCoeficiente pt newCoef)
  (if (polTermino? pt)
      (polTermino newCoef (getExponente pt))
      null
      )
  )
      
(define (setExponente pt newExpt)
  (if (polTermino? pt)
      (polTermino (getCoeficiente pt) newExpt)
      null
      )
  )

(define (polinomio2 . args)
  (define (polAux arg)
   (if (null? arg)
          null
          (if (polTermino? (car arg))
              (cons (car arg) (polAux (cdr arg)))
              null
           )
       )
  )
  (polAux args)
)
      
  
(define (polinomio? p)
  (if (list? p)
      (if (null? p)
          #t
          (and (polTermino? (car p)) (polinomio? (cdr p)))
       )
      #f
   )
  )

(define (getTermino p exp)
  (if (and (polinomio? p) (number? exp))
      (if (null? p)
          null
          (if (= exp (cdr (car p)))
              (car p)
              (getTermino (cdr p) exp)
           )
          )
      null
      )
  )
      
  (define (getTermino2 p exp)
    (define (sumCoefs p exp)
         (if (null? p)
             0
             (if (= exp (cdr (car p)))
                 (+ (caar p) (sumCoefs (cdr p) exp))
                  (sumCoefs (cdr p) exp)
              )
          )
     )
  (if (and (polinomio? p) (number? exp))
      (if (null? p)
          null
          (if (= exp (cdr (car p)))
              (polTermino (+ (caar p) (sumCoefs (cdr p) exp )) (cdr (car p)))
              (getTermino (cdr p) exp)
           )
          )
      null
      )
  )               

(define (eqTermino? t1 t2)
   (if (and (polTermino? t1) (polTermino? t2))
       (and (= (getCoeficiente t1) (getCoeficiente t2)) 
            (= (getExponente t1) (getExponente t2)))
       #f
    )
  )

(define (setTermino p terminoOld terminoNew)
  (if (and (polinomio? p) (polTermino? terminoOld) (polTermino? terminoNew))
      (if (null? p)
          null
          (if (eqTermino? (car p) terminoOld)
              (cons terminoNew (setTermino (cdr p) terminoOld terminoNew))
              (cons (car p) (setTermino (cdr p) terminoOld terminoNew))
           )

       )
      null
      ))
      

(define (evaluarPol p x)
(define p1 (polinomio2 (polTermino 3 5) (polTermino 8 15) (polTermino 6 100) (polTermino 4 1000)))