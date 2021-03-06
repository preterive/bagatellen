use "probe_5.ml";

(*
structure MyQLPresentation =  Presentation (
   struct
      structure PTG =  MyQLLiteralsPointeredTypeGenerating
      structure CX =  MyQLContecteds
      structure L =  MyQLLiterals
      structure LC =  MyQLLiteralsConstruction
      structure M =  Modules
      structure NM =
      structure NO =
      structure P =  MyQLProof
      structure C =  MyQLConstructors
      structure Q =  Qualifier
      structure UV =
      structure V =  MyQLLiteralsConstruction.Variables
      structure VC =  MyQLVariableContexts
      structure VCPTM =
      structure VCPS =  MyQLVariablesPointeredSingleton
      structure LPTM =
      structure LPS =  MyQLLiteralsPointeredSingleton
      structure OPTM =
      structure OPS =
   end );
*)

structure MyPPrintConfig: PPrintConfig =
   struct
      type config = {indent: int, page_width: int}
      val config =  { indent = 3, page_width = 72 }
   end;

structure MyPPrintBase: PPrintBase =  PPrintBase(MyPPrintConfig);

structure MyPPrintIndentBase: PPrintIndentBase =  PPrintIndentBase (
   struct
      structure B = MyPPrintBase
      structure C = MyPPrintConfig
   end );

structure MyQLPPrintPolymorphicPPrinting: PPrintPolymorphicPPrinting =  PPrintPolymorphicPPrinting (
   struct
      structure ContextType =  MyQLVariableContexts.VariableContext
      structure PPrintIndentBase =  MyPPrintIndentBase
   end );

structure MyPELPPrintPolymorphicPPrinting: PPrintPolymorphicPPrinting =  PPrintPolymorphicPPrinting (
   struct
      structure ContextType =  MyPEL.MyPELVariableContexts.VariableContext
      structure PPrintIndentBase =  MyPPrintIndentBase
   end );

structure MyDblPPrintPolymorphicPPrinting: PPrintPolymorphicPPrinting =  PPrintPolymorphicPPrinting (
   struct
      structure ContextType =  MyQualifiedPEL.MyPELVariableContexts.VariableContext
      structure PPrintIndentBase =  MyPPrintIndentBase
   end );

structure MyQLPPrintPolymorphicSetalike: PPrintPolymorphicSetalikes =  PPrintPolymorphicSetalikes (
   struct
      structure ContextType =  MyQLVariableContexts.VariableContext
      structure DelimConfig =  PPrintCommaDelim
      structure PPrintIndentBase =  MyPPrintIndentBase
   end );

structure MyPELPPrintPolymorphicSetalike: PPrintPolymorphicSetalikes =  PPrintPolymorphicSetalikes (
   struct
      structure ContextType =  MyPEL.MyPELVariableContexts.VariableContext
      structure DelimConfig =  PPrintCommaDelim
      structure PPrintIndentBase =  MyPPrintIndentBase
   end );

structure MyQLPPrintPolymorphicSetalike: PPrintPolymorphicSetalikes =  PPrintPolymorphicSetalikes (
   struct
      structure ContextType =  MyPEL.MyPELVariableContexts.VariableContext
      structure DelimConfig =  PPrintCommaDelim
      structure PPrintIndentBase =  MyPPrintIndentBase
   end );

structure MyQLBinaryRelation: TypeBinaryRelation =
   struct
      structure Domain =  MyQLLiteralsConstruction.Variables
      structure Relation =
         struct
            type T =  Domain.T * Domain.T -> bool
         end
      fun apply r (a, b) =  r(a, b)
   end;

structure MyQLNPTG: NamingPointeredTypeGenerating =  NamingPointeredTypeGenerating (
   struct
      structure BaseType =  MyQLLiteralsConstruction.Variables
      structure BaseStructureMap =  MyQLVariablesMap
      structure BinaryRelation =  MyQLBinaryRelation
      structure PolymorphicContainerType =  NamingPolymorphicContainerType
   end );

structure MyPELBinaryRelation: TypeBinaryRelation =
   struct
      structure Domain =  MyPELLiteralsConstruction.Variables
      structure Relation =
         struct
            type T =  Domain.T * Domain.T -> bool
         end
      fun apply r (a, b) =  r(a, b)
   end;

structure MyPELNPTG: NamingPointeredTypeGenerating =  NamingPointeredTypeGenerating (
   struct
      structure BaseType =  MyPELLiteralsConstruction.Variables
      structure BaseStructureMap =  MyPEL.MyPELVariablesMap
      structure BinaryRelation =  MyPELBinaryRelation
      structure PolymorphicContainerType =  NamingPolymorphicContainerType
   end );

structure MyDblBinaryRelation: TypeBinaryRelation =
   struct
      structure Domain =  MyQualifiedLiteralsConstruction.Variables
      structure Relation =
         struct
            type T =  Domain.T * Domain.T -> bool
         end
      fun apply r (a, b) =  r(a, b)
   end;

structure MyDblNPTG: NamingPointeredTypeGenerating =  NamingPointeredTypeGenerating (
   struct
      structure BaseType =  MyQualifiedLiteralsConstruction.Variables
      structure BaseStructureMap =  MyQualifiedPEL.MyPELVariablesMap
      structure BinaryRelation =  MyDblBinaryRelation
      structure PolymorphicContainerType =  NamingPolymorphicContainerType
   end );

(*
structure MyQLPPrintableLiterals: PPrintPPrintableLiterals =  PPrintPPrintableLiterals (
   struct
      structure NPT =  MyQLNPTG
      structure Constr =  MyQLLiteralsConstruction
      structure Lit =  MyQLLiterals
      structure VarCtxt =  MyQLVariableContexts
      structure PP =  MyQLPPrintPolymorphicPPrinting
      structure PS =  MyQLPPrintPolymorphicSetalike
   end );
*)
