use "collections/pointered_type_extended.sig";
use "general/double_map.sig";
use "general/double_structure.sig";
use "general/pair_type.sig";
use "general/sum_type.sig";

signature DoublePointeredTypeExtended =
   sig
      structure FstType: PointeredTypeExtended
      structure SndType: PointeredTypeExtended
      structure BaseType: SumType
      structure ContainerType: PairType
      structure PointerType: SumType
      structure BaseStructure: DoubleStructure
      structure BaseStructureMap: DoubleMap
      sharing BaseType.FstType = FstType.BaseType
      sharing BaseType.SndType = SndType.BaseType
      sharing ContainerType.FstType = FstType.ContainerType
      sharing ContainerType.SndType = SndType.ContainerType
      sharing PointerType.FstType = FstType.PointerType
      sharing PointerType.SndType = SndType.PointerType
      sharing BaseStructure.FstStruct =  FstType.BaseStructure
      sharing BaseStructure.SndStruct =  SndType.BaseStructure
      sharing BaseStructureMap.Start =  BaseStructure
      sharing BaseStructureMap.End =  BaseStructure
      sharing BaseStructureMap.FstMap =  FstType.BaseStructureMap
      sharing BaseStructureMap.SndMap =  SndType.BaseStructureMap

      val empty:     ContainerType.T
      val is_empty:  ContainerType.T -> bool
      val select:    PointerType.T * ContainerType.T -> BaseType.T Option.option

      val all:        (BaseType.T -> bool) -> ContainerType.T -> bool
      val all_zip:    (BaseType.T * BaseType.T -> bool) -> (ContainerType.T * ContainerType.T) -> bool

      val is_in:      BaseType.T * ContainerType.T -> bool
      val subeq:      ContainerType.T * ContainerType.T -> bool

      val transition: (BaseType.T * 'b -> 'b Option.option) -> ContainerType.T -> 'b -> 'b

      val base_map:   BaseStructureMap.Map.T -> BaseType.T -> BaseType.T

   end;
