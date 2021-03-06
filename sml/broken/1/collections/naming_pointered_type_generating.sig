use "general/binary_relation.sig";
use "general/eqs.sig";
use "general/map.sig";
use "collections/all_zip.sig";
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
                  val eq: T * T -> bool
               end
            structure PointerType:
               sig
                  type T =  string Option.option ref
                  val eq: T * T -> bool
               end
            structure BaseStructure: Eqs
            structure BaseStructureMap: Map
            sharing BaseStructure = BaseType
            sharing BaseStructureMap.Start = BaseStructure
            sharing BaseStructureMap.End = BaseStructure

            val empty: ContainerType.T
            val is_empty: ContainerType.T -> bool
            val select: PointerType.T * ContainerType.T -> BaseType.T Option.option

            val all:        (BaseType.T -> bool) -> ContainerType.T -> bool
            val all_zip:    (BaseType.T * BaseType.T -> bool) -> (ContainerType.T * ContainerType.T) -> bool

            val is_in:      BaseType.T * ContainerType.T -> bool
            val subeq:      ContainerType.T * ContainerType.T -> bool

            val base_map:   BaseStructureMap.Map.T -> BaseType.T -> BaseType.T

            val transition: (BaseType.T * 'b -> 'b Option.option) -> ContainerType.T -> 'b -> 'b

         end

      structure AllZip:
         sig
            structure BinaryRelation: BinaryRelation
            structure PointeredType:
               sig
                  structure BaseType: Eqs
                  structure ContainerType:
                     sig
                        type T =  PointeredTypeExtended.ContainerType.T
                     end
                  structure PointerType:
                     sig
                        type T =  string Option.option ref
                     end

                  structure BaseStructure: Eqs
                  structure BaseStructureMap: Map
                  sharing BaseStructure = BaseType
                  sharing BaseStructureMap.Start = BaseStructure
                  sharing BaseStructureMap.End = BaseStructure

                  val empty:     ContainerType.T
                  val is_empty:  ContainerType.T -> bool
                  val select:    PointerType.T * ContainerType.T -> BaseType.T Option.option

                  val base_map:  BaseStructureMap.Map.T -> BaseType.T -> BaseType.T

               end

            val result: BinaryRelation.Relation.T -> PointeredType.ContainerType.T * PointeredType.ContainerType.T -> bool

         end
      sharing AllZip.PointeredType.BaseType =  PointeredTypeExtended.BaseType
      sharing AllZip.PointeredType.BaseStructure =  PointeredTypeExtended.BaseStructure
      sharing AllZip.PointeredType.BaseStructureMap =  PointeredTypeExtended.BaseStructureMap

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

