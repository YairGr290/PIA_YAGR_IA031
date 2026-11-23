;; Problema: dos tesis, una sola impresora (sin papel al inicio)
(define (problem entrega-dos-tesis)
  (:domain imprenta-tesis)

  (:objects
    tesis-ana tesis-luis - tesis
    imp1 - impresora
    ana luis - cliente)

  (:init
    (en-recepcion tesis-ana)
    (en-recepcion tesis-luis)
    (pedido-de tesis-ana ana)
    (pedido-de tesis-luis luis)
    (sin-papel imp1))

  (:goal (and (entregada tesis-ana ana)
              (entregada tesis-luis luis)))
)
