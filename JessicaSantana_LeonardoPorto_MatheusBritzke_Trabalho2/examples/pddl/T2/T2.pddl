
(define (domain agente-de-iluminacao)
  (:requirements :strips)
  (:predicates (agente ?place)
           (PosAtual ?agente ?place)  
           (EscadaPosicionada ?obj)
           (EmCimaEscada ?obj)
           (ForaDaEscada ?obj) 
           (Sala ?place)
           (Deposito ?place)
           (Escada ?obj)
           (Lampada ?obj)
           (Carrega1 ?obj)
           (Carrega2 ?obj)
           (LampadaQueimada ?place)
           (LampadaOk ?place))

  (:action IRCorredorSala
     :parameters (?x ?y ?z)
     :precondition ( and (Corredor ?x) (Sala ?y) (agente ?z) (PosAtual ?z ?x))
     :effect (and (PosAtual ?z ?y) (not (PosAtual ?z ?x))) )
  
  (:action PEGARLampada
     :parameters (?x ?y ?z)
     :precondition (and (Deposito ?x) (agente ?z) (PosAtual ?z ?x) (Lampada ?y))
     :effect (CARREGA1 ?y))
  
  (:action TROCARLAMPADA 
     :parameters (?x ?y ?z ?w)
     :precondition (and (Sala ?x) (LampadaQueimada ?x) (agente ?w) (PosAtual ?w ?x) (Lampada ?y) (CARREGA1 ?y) (Escada ?z) (CARREGA2 ?z) (EmCimaEscada ?z))
     :effect (and (LampadaOK ?x) (not (CARREGA1 ?y)) (not (LampadaQueimada ?x)) (EmCimaEscada ?z) (CARREGA2 ?z) ))


  (:action PEGAREscada
     :parameters (?x ?y ?z)
     :precondition (and (Deposito ?x) (agente ?z) (PosAtual ?z ?x) (Escada ?y))
     :effect  (CARREGA2 ?y))


  (:action IRCorredorDeposito
     :parameters (?x ?y ?z)
     :precondition (and (Corredor ?x) (Deposito ?y) (agente ?z) (PosAtual ?z ?x))
     :effect (and (PosAtual ?z ?y) (not (PosAtual ?z ?x))))


(:action IRDepositoCorredor
     :parameters (?x ?y ?z)
     :precondition (and (Deposito ?x) (Corredor ?y) (agente ?z) (PosAtual ?z ?x) )
     :effect  (and (PosAtual ?z ?y)  (not (PosAtual ?z ?x))))

(:action IRSalaCorredor
     :parameters (?x ?y ?z ?l)
     :precondition (and (Sala ?x) (Escada ?l) (ForaDaEscada ?l) (Corredor ?y) (agente ?z) (PosAtual ?z ?x))
     :effect (and  (PosAtual ?z ?y) (not (PosAtual ?z ?x))))

(:action PosicionarEscada
     :parameters (?x ?y ?z)
     :precondition (and (Sala ?x) (Escada ?y) (CARREGA2 ?y) (ForaDaEscada ?y)(agente ?z) (PosAtual ?z ?x) )
     :effect (EscadaPosicionada ?y))

(:action SubirEscada
     :parameters (?x ?y ?z)
     :precondition (and (Sala ?x) (Escada ?y) (EscadaPosicionada ?y) (agente ?z) (PosAtual ?z ?x) )
     :effect (and(EmCimaEscada ?y) (not (ForaDaEscada ?y))))

(:action DescerEscada
     :parameters (?x ?y ?z)
     :precondition (and (Sala ?x) (Escada ?y) (EmCimaEscada ?y) (agente ?z) (PosAtual ?z ?x) (CARREGA2 ?y) )
     :effect (and (ForaDaEscada ?y) (not (EmCimaEscada ?y)) (CARREGA2 ?y) ))



  )