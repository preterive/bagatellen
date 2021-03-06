use "general/binary_relation.sig";
use "general/map.sig";
use "general/type.sig";

signature VariableStructure =
   sig
      structure Variables:
         sig
         end
      structure BaseType: Type
      structure BinaryRelation: BinaryRelation
      structure Map: Map
      structure VarType: Type
      sharing BinaryRelation.Domain = Variables
      sharing Map.Start = Variables
      sharing Map.End = Variables

      val copy: Map.Map.T
      val eq:   BinaryRelation.Relation.T
   end;
