use "logics/constructors.sig";
use "logics/literals.sig";
use "logics/literals/in.sig";

functor Literals(I: LiteralsIn): Literals =
   struct
      structure LiteralsIn =  I

      structure Variables =
         struct
            type Base = I.T
            type T =  Base I.PV.Variable
            val eq =  I.PV.eq
            val copy =  I.PV.copy
            val fcopy =  I.PV.fcopy
         end

      fun get_val (p as I.Construction(c, xi)) =  p
        | get_val (p as I.Variable x)
        = case (I.PV.get_val x) of
             Option.NONE => p
          |  Option.SOME k => get_val k

      structure Out =
         struct
            type T =  I.PT.BaseType.T

            fun equate(k, l)
              = case (get_val (I.destruct k), get_val (I.destruct l)) of
                   (I.Construction(c, xi), I.Construction(d, ypsilon))
                => if I.C.eq(c, d)
                   then
                     multi_equate(xi, ypsilon)
                  else
                     false
                |  (I.Construction(c, xi), I.Variable y) =>  false
                |  (I.Variable x, l)
                => I.PV.set_val l x
            and multi_equate(xi, ypsilon) =  I.PT.all_zip (equate) (xi, ypsilon)

           fun eq(k, l)
              = case (get_val (I.destruct k), get_val (I.destruct l)) of
                   (I.Construction(c, xi), I.Construction(d, ypsilon))
                      => I.C.eq(c, d) andalso multi_eq(xi, ypsilon)
                |  (I.Construction(c, xi), I.Variable y) => false
                |  (I.Variable x, I.Construction(d, ypsilon)) => false
                |  (I.Variable x, I.Variable y) =>  I.PV.eq(x, y)
            and multi_eq(xi, ypsilon) =  I.PT.all_zip (eq) (xi, ypsilon)

         end

      structure Multi =
         struct
            type T =  I.PT.ContainerType.T

            val equate =  Out.multi_equate
            val eq =  Out.multi_eq
         end

      structure Construction =
         struct
            type T =  I.T
         end
   
      val transition =  I.PT.transition

   end;
