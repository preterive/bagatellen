use "general/map.sig";
use "general/type.sig";

signature PointeredType =
   sig
      structure BaseType: Type
      structure ContainerType: Type
      structure PointerType: Type
      structure SingletonMap: Map
      sharing SingletonMap.Start = BaseType
      sharing SingletonMap.End = ContainerType

      val empty:     ContainerType.T
      val select:    PointerType.T * ContainerType.T -> BaseType.T Option.option
      val singleton: PointerType.T -> SingletonMap.T

   end;
