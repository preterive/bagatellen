use "collections/eqs.sig";

signature DictSet =
   sig
      structure Eqs: Eqs

      type 'a dict
      type set

      val empty_d:    'a dict
      val map_d:      ('a -> 'b) -> 'a dict -> 'b dict
      val keys:       'a dict -> set
      val deref:       Eqs.T * 'a dict -> 'a Option.option
      val set_d:       Eqs.T * 'a * 'a dict -> 'a dict

      val empty_s:     set
      val map_s:       (Eqs.T -> Eqs.T) -> set -> set
      val singleton:   Eqs.T -> set
      val is_member_s: Eqs.T * set -> bool
      val drop_s:      Eqs.T * set -> set
      val insert_s:    Eqs.T * set -> set
      val union:       set * set -> set
      val cut:         set * set -> set
      val subseteq_s:  set * set -> bool

   end;