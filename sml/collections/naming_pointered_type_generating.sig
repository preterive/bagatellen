use "general/eqs.sig";
use "collections/naming_polymorphic_container_type.sig";

signature NamingPointeredTypeGenerating =
   sig
      structure PolymorphicContainerType: NamingPolymorphicContainerType

      structure PointeredTypeExtended:
         sig
            structure BaseType: Eqs
            structure ContainerType:
               sig
                  type T =  BaseType.T PolymorphicContainerType.T
               end
            structure PointerType:
               sig
                  type T =  string Option.option ref
               end
            structure BaseStructure: Eqs
            sharing BaseStructure = BaseType
      
            val empty: ContainerType.T
            val is_empty: ContainerType.T -> bool
            val select: PointerType.T * ContainerType.T -> BaseType.T Option.option

            val all:        (BaseType.T -> bool) -> ContainerType.T -> bool
            val all_zip:    (BaseType.T * BaseType.T -> bool) -> (ContainerType.T * ContainerType.T) -> bool
      
            val is_in:      BaseType.T * ContainerType.T -> bool
            val subeq:      ContainerType.T * ContainerType.T -> bool
      
            val transition: (BaseType.T * 'b -> 'b Option.option) -> ContainerType.T -> 'b -> 'b

      end
 
      val singleton: PointeredTypeExtended.PointerType.T * PointeredTypeExtended.BaseType.T -> PointeredTypeExtended.ContainerType.T

      val sum:        PointeredTypeExtended.ContainerType.T * PointeredTypeExtended.ContainerType.T -> PointeredTypeExtended.ContainerType.T
      val union:      PointeredTypeExtended.ContainerType.T * PointeredTypeExtended.ContainerType.T -> PointeredTypeExtended.ContainerType.T
 
      val add:        PointeredTypeExtended.BaseType.T -> PointeredTypeExtended.ContainerType.T -> PointeredTypeExtended.ContainerType.T
      val adjoin:     string * PointeredTypeExtended.BaseType.T * PointeredTypeExtended.ContainerType.T -> PointeredTypeExtended.ContainerType.T
      val transition: (string Option.option * PointeredTypeExtended.BaseType.T * 'b -> 'b Option.option) -> PointeredTypeExtended.ContainerType.T -> 'b -> 'b
 
      val get_name :  PointeredTypeExtended.BaseType.T
                      -> PointeredTypeExtended.ContainerType.T -> string option
      val set_name :  string * PointeredTypeExtended.BaseType.T
                      -> PointeredTypeExtended.ContainerType.T -> bool
      val uniquize :  PointeredTypeExtended.ContainerType.T -> unit

   end;

