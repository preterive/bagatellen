use "general/eqs.sig";
use "collections/naming_pointered_type_extension.sig";
use "collections/naming_polymorphic_pointered_type.sml";
use "collections/pointered_type.fun";

functor NamingPointeredTypeExtension(B: Eqs): NamingPointeredTypeExtension =
   struct
      structure NamingPolymorphicPointeredType =  NamingPolymorphicPointeredType
      structure StringType =  NamingPolymorphicPointeredType.PointerType
      structure PointeredType =  PointeredType(
         struct
            structure B =  B
            structure PPT =  NamingPolymorphicPointeredType
         end )

      val sum =  NamingPolymorphicPointeredType.sum

      val add        =  NamingPolymorphicPointeredType.p_add B.eq
      val adjoin     =  NamingPolymorphicPointeredType.adjoin
      val transition =  NamingPolymorphicPointeredType.full_transition
      val get_name   =  NamingPolymorphicPointeredType.p_get_name B.eq
      val set_name   =  NamingPolymorphicPointeredType.p_set_name B.eq
      val uniquize   =  NamingPolymorphicPointeredType.uniquize

   end;