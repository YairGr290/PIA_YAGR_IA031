;; Dominio: imprenta universitaria de tesis
;; Una tesis pasa por etapas: recepcion -> revision -> impresion ->
;; encuadernacion -> empaque -> entrega. La impresora gasta su papel
;; en cada impresion y hay que recargarla antes de la siguiente.
(define (domain imprenta-tesis)
  (:requirements :strips :typing)

  (:types
    tesis impresora cliente)

  (:predicates
    (en-recepcion ?t - tesis)            ; tesis recien recibida, sin revisar
    (revisada ?t - tesis)                ; formato revisado, lista para imprimir
    (impresa ?t - tesis)                 ; ya salio de la impresora
    (encuadernada ?t - tesis)            ; ya tiene pasta y encuadernado
    (empacada ?t - tesis)                ; lista para entregarse
    (entregada ?t - tesis ?c - cliente)  ; entregada a su cliente
    (pedido-de ?t - tesis ?c - cliente)  ; a quien pertenece la tesis
    (con-papel ?i - impresora)           ; impresora cargada de papel
    (sin-papel ?i - impresora))          ; impresora sin papel

  (:action revisar-formato
    :parameters (?t - tesis)
    :precondition (en-recepcion ?t)
    :effect (and (revisada ?t)
                 (not (en-recepcion ?t))))

  (:action cargar-papel
    :parameters (?i - impresora)
    :precondition (sin-papel ?i)
    :effect (and (con-papel ?i)
                 (not (sin-papel ?i))))

  (:action imprimir
    :parameters (?t - tesis ?i - impresora)
    :precondition (and (revisada ?t) (con-papel ?i))
    :effect (and (impresa ?t)
                 (sin-papel ?i)
                 (not (revisada ?t))
                 (not (con-papel ?i))))

  (:action encuadernar
    :parameters (?t - tesis)
    :precondition (impresa ?t)
    :effect (and (encuadernada ?t)
                 (not (impresa ?t))))

  (:action empacar
    :parameters (?t - tesis)
    :precondition (encuadernada ?t)
    :effect (and (empacada ?t)
                 (not (encuadernada ?t))))

  (:action entregar
    :parameters (?t - tesis ?c - cliente)
    :precondition (and (empacada ?t) (pedido-de ?t ?c))
    :effect (and (entregada ?t ?c)
                 (not (empacada ?t))))
)
