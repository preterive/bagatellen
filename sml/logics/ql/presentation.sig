use "logics/contecteds.sig";
use "logics/literals.sig";
use "logics/proof.sig";
use "logics/ql/constructors.sig";
use "logics/ql/qualifier.sig";

signature Presentation =
   sig
      structure Contecteds: Contecteds
      structure QLConstructors: QLConstructors
      structure Literals: Literals
      structure Proof: Proof
      structure Qualifier: Qualifier
      sharing Contecteds.Constructors =  QLConstructors
      sharing Contecteds.Literals =  Literals
      sharing Literals.Constructors =  QLConstructors
      sharing QLConstructors.Qualifier =  Qualifier
      sharing Proof.Constructors =  QLConstructors
      sharing Proof.Contecteds =  Contecteds

      type state

      val typecheck: state -> Proof.Multi.T
      val add_module: string -> state -> state
      val add_qualifier: string * string * string -> state -> state Option.option

      val get_normalform: state -> string -> Qualifier.T Option.option
      val ceq: state -> string * string -> bool
   end;
