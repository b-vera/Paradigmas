#lang racket
;(require racket/trace)

;Clásico fibonacci , funciona hasta con (fibo 40) aprox y se hace inviable en tiempo
(define fibo (lambda
                 (n)
               (if (or (= n 0) (= n 1))
                   1
                   (+ (fibo (- n 1)) (fibo (- n 2)))
                )
              )
)

(define obtenerPromesa (lambda (listaPromesas n)
                         (if (null? listaPromesas )
                             null
                             (if (= (car (car listaPromesas)) n)
                                 (car (cdr (car listaPromesas)))
                                 (obtenerPromesa (cdr listaPromesas) n)
                             )
                          )
                        )
)
q
(define existePromesaEnLista (lambda
                                 (listaPromesas n)
                               (not (null? (obtenerPromesa listaPromesas n)))
                             )
)

(define agregarPromesa (lambda (listaPromesas n)

                         (let*
                             (
                              (resultadoFiboN-1 (fiboAyuda (- n 1) listaPromesas))
                              (resultadoFiboN-2 (fiboAyuda (- n 2) (car resultadoFiboN-1)))
                              )
                           (cons (list n
                                       (delay (+
                                               (cdr resultadoFiboN-1)
                                               (cdr resultadoFiboN-2)
                                               )
                                         )
                                       )
                                 (car resultadoFiboN-2)
                           )
                         )
                        )
)

(define fiboAyuda (lambda
                 (n listaPromesas)
               (if (or (= n 0) (= n 1))
                   (cons listaPromesas 1)
                   (if (existePromesaEnLista listaPromesas n)
                       (cons listaPromesas (force (obtenerPromesa listaPromesas n))) 
                       (let
                         (
                          (nvaListaPromesas (agregarPromesa listaPromesas n))
                          )
                         (cons nvaListaPromesas (force (obtenerPromesa nvaListaPromesas n)))
                        )
                   )
                )
              )
)

;Funciona no se hasta cuanto, es rápido
(define fiboRapido (lambda (n) (force (second (car (car (fiboAyuda n '())))))))