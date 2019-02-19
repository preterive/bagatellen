use "general/eqs.sig";
use "collections/pointered_type.sig";
use "collections/string_type.sig";

signature NamingPointeredTypeExtension =
   sig
     structure StringType: StringType
     structure PointeredType: PointeredType
     sharing PointeredType.PointerType =  StringType

     val sum:        PointeredType.ContainerType.T * PointeredType.ContainerType.T -> PointeredType.ContainerType.T

     val add:        PointeredType.BaseType.T -> PointeredType.ContainerType.T -> PointeredType.ContainerType.T
     val adjoin:     string * PointeredType.BaseType.T * PointeredType.ContainerType.T -> PointeredType.ContainerType.T
     val transition: (string Option.option * PointeredType.BaseType.T * 'b -> 'b Option.option) -> PointeredType.ContainerType.T -> 'b -> 'b

     val get_name :  PointeredType.BaseType.T
                     -> PointeredType.ContainerType.T -> string option
     val set_name :  string * PointeredType.BaseType.T
                     -> PointeredType.ContainerType.T -> bool
     val uniquize :  PointeredType.ContainerType.T -> unit
   end;

