use "general/eqs.sig";
use "collections/pointered_type.sig";
use "logics/variables.sig";

signature VariableContexts =
   sig
      structure PointeredType2: PointeredType2
      structure Variables: Variables
      structure VariableContext:
         sig
            structure Variables: Variables
            type T
            val eq:                  T * T -> bool
            val vmap:                (Variables.T -> Variables.T) -> T -> T
            val filter_bound_vars:   T -> T
            val filter_unbound_vars: T -> T
         end
      sharing VariableContext.Variables =  Variables
      sharing PointeredType2.BaseType =  Variables
      sharing PointeredType2.ContainerType =  VariableContext

      type AlphaConverter

      val alpha_convert:                 VariableContext.T -> AlphaConverter
      val get_variable_context:          AlphaConverter -> VariableContext.T
      val apply_alpha_converter:         AlphaConverter -> Variables.T -> Variables.T

   end;
