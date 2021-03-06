use "probe_2.ml";

signature AbstractLiteralsConstruction =
   sig
      structure Variables:
         sig
            type T
            structure Base:
               sig
                  structure Single:
                     sig
                        type T
                        val eq: T * T -> bool
                     end
                  structure Multi:
                     sig
                        type T
                        val eq: T * T -> bool
                     end
               end

            val new:         T
            val eq:          T * T -> bool
            val copy:        T -> T
            val get_val:     T -> Base.Single.T Option.option
            val is_bound:    T -> bool
            val is_settable: T -> bool
            val set_val:     Base.Single.T -> T -> bool
         end
   end;

functor MyPEL(MyPELLiteralsConstruction: AbstractLiteralsConstruction) =
   struct
      structure MyPELLiteralsBinaryRelation: BaseBinaryRelation =
         struct
            structure Domain =  MyPELLiteralsConstruction.Variables.Base.Single
            structure Relation =
               struct
                  type T =  Domain.T * Domain.T -> bool
               end
            fun apply f (x, y) = f (x, y)
            fun get_binary_relation f =  f
         end;
      
      structure MyPELLiteralsMap: BaseMap =
         struct
            structure Start =  MyPELLiteralsConstruction.Variables.Base.Single
            structure End =  MyPELLiteralsConstruction.Variables.Base.Single
            structure Map =
               struct
                  type T =  Start.T -> End.T
               end
      
            fun apply f x =  f x
            fun get_map f =  f
         end;
      
      structure MyPELLiteralsPointeredTypeGenerating =  NamingPointeredTypeGenerating (
         struct
            structure BaseType =  MyPELLiteralsConstruction.Variables.Base.Single;
            structure BaseStructureMap =  MyPELLiteralsMap;
            structure BinaryRelation =  MyPELLiteralsBinaryRelation;
            structure PolymorphicContainerType =  NamingPolymorphicContainerType;
         end );
      
      structure MyPELVariablesDictSet =  DictSet(MyPELLiteralsConstruction.Variables)
      structure MyPELOccurences =  Occurences(MyPELVariablesDictSet)
      
      structure MyPELDictMap =  DictMap(
         struct
            structure DS =  MyPELVariablesDictSet
            structure End =  MyPELLiteralsConstruction.Variables
         end );
      
      structure MyPELVariablesBinaryRelation: BaseBinaryRelation =
         struct
            structure Domain =  MyPELLiteralsConstruction.Variables
            structure Relation =
               struct
                  type T =  Domain.T * Domain.T -> bool
               end
            fun apply f (x, y) = f (x, y)
            fun get_binary_relation f =  f
         end;
      
      structure MyPELVariablesMap: BaseMap =
         struct
            structure Start =  MyPELLiteralsConstruction.Variables
            structure End =  MyPELLiteralsConstruction.Variables
            structure Map =
               struct
                  type T =  Start.T -> End.T
               end
      
            fun apply f x =  f x
            fun get_map f =  f
         end;
      
      structure MyPELVariablesStructure =  VariableAsStructure(
         struct
            structure Variables =  MyPELLiteralsConstruction.Variables
            structure BinaryRelation =  MyPELVariablesBinaryRelation
            structure Map =  MyPELVariablesMap
         end );
      
      structure MyPELVariablesPointeredTypeGenerating =  NamingPointeredTypeGenerating(
         struct
            structure BaseType =  MyPELLiteralsConstruction.Variables
            structure BaseStructureMap =  MyPELVariablesMap
            structure BinaryRelation =  MyPELVariablesBinaryRelation
            structure PolymorphicContainerType =  NamingPolymorphicContainerType
         end );
      
      structure MyPELLiteralsPointeredGeneration =  NamingNamingPointeredGeneration(
         struct
            structure From =  MyPELLiteralsPointeredTypeGenerating
            structure To =  MyPELLiteralsPointeredTypeGenerating
         end );
      
      structure MyPELLiteralsPointeredMap: PointeredBaseMap =
         struct
            structure PointerType =  MyPELLiteralsPointeredTypeGenerating.PointeredTypeExtended.PointerType
            structure Start =  MyPELLiteralsPointeredTypeGenerating.PointeredTypeExtended.BaseType
            structure End =  MyPELLiteralsPointeredTypeGenerating.PointeredTypeExtended.ContainerType
            structure Map =
               struct
                  type T =  PointerType.T * Start.T -> End.T
               end
      
            fun apply f (p, x) =  f (p, x)
            fun get_map f =  f
      
         end;
      
      structure MyPELLiteralsPointeredSingleton =  PointeredBaseSingleton(
         struct
            structure PointeredType =  MyPELLiteralsPointeredTypeGenerating.PointeredTypeExtended
            val singleton =  MyPELLiteralsPointeredTypeGenerating.singleton
         end );
      
      structure MyPELLiteralsComposeMap =  PointeredBaseComposeMap(
         struct
            structure A =  MyPELLiteralsMap
            structure B =  MyPELLiteralsPointeredSingleton.PointeredMap
            structure Result =  MyPELLiteralsPointeredGeneration.PointeredMap
            structure PointerType =  MyPELLiteralsPointeredTypeGenerating.PointeredTypeExtended.PointerType
         end );
      
      structure MyPELLiteralsPointeredFunctor =  PointeredFunctor(
         struct
            structure Start =  MyPELLiteralsPointeredTypeGenerating.PointeredTypeExtended
            structure End =  MyPELLiteralsPointeredTypeGenerating.PointeredTypeExtended
            structure Map =  MyPELLiteralsMap
            structure ComposeMap =  MyPELLiteralsComposeMap
            structure Generation =  MyPELLiteralsPointeredGeneration
            structure PointerType =  MyPELLiteralsPointeredTypeGenerating.PointeredTypeExtended.PointerType
            structure Singleton =  MyPELLiteralsPointeredSingleton
         end );
      
      structure MyPELVariablesPointeredGeneration =  NamingNamingPointeredGeneration(
         struct
            structure From =  MyPELVariablesPointeredTypeGenerating
            structure To =  MyPELVariablesPointeredTypeGenerating
         end );
      
      structure MyPELVariablesPointeredMap: PointeredBaseMap =
         struct
            structure PointerType =  MyPELVariablesPointeredTypeGenerating.PointeredTypeExtended.PointerType
            structure Start =  MyPELVariablesPointeredTypeGenerating.PointeredTypeExtended.BaseType
            structure End =  MyPELVariablesPointeredTypeGenerating.PointeredTypeExtended.ContainerType
            structure Map =
               struct
                  type T =  PointerType.T * Start.T -> End.T
               end
      
            fun apply f (p, x) =  f (p, x)
            fun get_map f =  f
      
         end;
      
      structure MyPELVariablesPointeredSingleton =  PointeredBaseSingleton(
         struct
            structure PointeredType =  MyPELVariablesPointeredTypeGenerating.PointeredTypeExtended
            val singleton =  MyPELVariablesPointeredTypeGenerating.singleton
         end );
      
      structure MyPELVariablesComposeMap =  PointeredBaseComposeMap(
         struct
            structure A =  MyPELVariablesMap
            structure B =  MyPELVariablesPointeredSingleton.PointeredMap
            structure Result =  MyPELVariablesPointeredGeneration.PointeredMap
            structure PointerType =  MyPELVariablesPointeredTypeGenerating.PointeredTypeExtended.PointerType
         end );
      
      structure MyPELVariablesPointeredFunctor =  PointeredFunctor(
         struct
            structure Start =  MyPELVariablesPointeredTypeGenerating.PointeredTypeExtended
            structure End =  MyPELVariablesPointeredTypeGenerating.PointeredTypeExtended
            structure Map =  MyPELVariablesMap
            structure ComposeMap =  MyPELVariablesComposeMap
            structure Generation =  MyPELVariablesPointeredGeneration
            structure PointerType =  MyPELVariablesPointeredTypeGenerating.PointeredTypeExtended.PointerType
            structure Singleton =  MyPELVariablesPointeredSingleton
         end );
      
      structure MyPELVariableContexts =  VariableContexts(
         struct
            structure AZ =  MyPELVariablesPointeredTypeGenerating.AllZip
            structure PF =  MyPELVariablesPointeredFunctor
            structure PT =  MyPELVariablesPointeredTypeGenerating.PointeredTypeExtended
            structure DM =  MyPELDictMap
            structure DS =  MyPELDictMap.DictSet
            structure VM =  MyPELVariablesMap
            structure VarStruct =  MyPELVariablesStructure
         end );
      
      structure MyDblLiteralsStructure: DoubleStructure =  
         struct
            structure FstStruct =  MyQLLiteralsConstruction.Variables.Base.Single;
            structure SndStruct =  MyPELLiteralsConstruction.Variables.Base.Single;
         end;
      
      structure MyDblLiteralsMapPair: PairType =  PairType (
         struct
            structure FstType =  MyQLLiteralsMap.Map;
            structure SndType =  MyPELLiteralsMap.Map;
         end );
      
      structure MyDblLiteralsMap: DoubleMap =  DoubleMap (
         struct
            structure FstMap =  MyQLLiteralsMap;
            structure SndMap =  MyPELLiteralsMap;
            structure Pair =  MyDblLiteralsMapPair;
         end );
      
      structure MyDblLiteralsTypeSum: SumType =  SumType (
         struct
            structure FstType =  MyQLLiteralsConstruction.Variables.Base.Single;
            structure SndType =  MyPELLiteralsConstruction.Variables.Base.Single;
         end );
      
      structure MyDblLiteralsContainerTypePair: PairType =  PairType (
         struct
            structure FstType =  MyQLLiteralsPointeredTypeGenerating.PointeredTypeExtended.ContainerType;
            structure SndType =  MyPELLiteralsPointeredTypeGenerating.PointeredTypeExtended.ContainerType;
         end );
      
      structure MyDblPointerType: SumType =  SumType (
         struct
            structure FstType =  MyQLLiteralsPointeredTypeGenerating.PointeredTypeExtended.PointerType;
            structure SndType =  MyPELLiteralsPointeredTypeGenerating.PointeredTypeExtended.PointerType;
         end );
      
      structure MyDblLiteralsPointeredType: DoublePointeredType =  DoublePointeredType (
         struct
            structure FstType =  MyQLLiteralsPointeredTypeGenerating.PointeredTypeExtended;
            structure SndType =  MyPELLiteralsPointeredTypeGenerating.PointeredTypeExtended;
            structure BaseStructure =  MyDblLiteralsStructure;
            structure BaseType =  MyDblLiteralsTypeSum;
            structure ContainerType =  MyDblLiteralsContainerTypePair;
            structure BaseStructureMap =  MyDblLiteralsMap;
            structure PointerType =  MyDblPointerType;
         end );
      
      structure MyDblLiteralsPointeredTypeExtended: DoublePointeredTypeExtended =  DoublePointeredTypeExtended (
         struct
            structure FstType =  MyQLLiteralsPointeredTypeGenerating.PointeredTypeExtended;
            structure SndType =  MyPELLiteralsPointeredTypeGenerating.PointeredTypeExtended;
            structure FstMap =  MyQLLiteralsMap;
            structure SndMap =  MyPELLiteralsMap;
            structure BaseStructure =  MyDblLiteralsStructure;
            structure BaseStructureMap =  MyDblLiteralsMap;
            structure BaseType =  MyDblLiteralsTypeSum;
            structure ContainerType =  MyDblLiteralsContainerTypePair;
            structure PointerType =  MyDblPointerType;
            structure DoublePointeredType =  MyDblLiteralsPointeredType;
         end );
      
      structure MyDblLiteralsBinaryRelationPair: PairType =  PairType (
         struct
            structure FstType =  MyQLLiteralsBinaryRelation.Relation;
            structure SndType =  MyPELLiteralsBinaryRelation.Relation;
         end );
      
      structure MyDblLiteralsBinaryRelation: DoubleBinaryRelation =  DoubleBinaryRelation (
         struct
            structure FstRelation =  MyQLLiteralsBinaryRelation;
            structure SndRelation =  MyPELLiteralsBinaryRelation;
            structure Pair =  MyDblLiteralsBinaryRelationPair;
         end );
      
      structure MyDblVariablesBinaryRelationPair: PairType =  PairType (
         struct
            structure FstType =  MyQLVariablesBinaryRelation.Relation;
            structure SndType =  MyPELVariablesBinaryRelation.Relation;
         end );
      
      structure MyDblVariablesBinaryRelation: DoubleBinaryRelation =  DoubleBinaryRelation (
         struct
            structure FstRelation =  MyQLVariablesBinaryRelation;
            structure SndRelation =  MyPELVariablesBinaryRelation;
            structure Pair =  MyDblVariablesBinaryRelationPair;
         end );
      
      structure MyDblVariablesMapPair: PairType =  PairType (
         struct
            structure FstType =  MyQLVariablesMap.Map;
            structure SndType =  MyPELVariablesMap.Map;
         end );
      
      structure MyDblVariablesMap: DoubleMap =  DoubleMap (
         struct
            structure FstMap =  MyQLVariablesMap;
            structure SndMap =  MyPELVariablesMap;
            structure Pair =  MyDblVariablesMapPair;
         end );
      
      structure MyDblVariablesSum: SumType =  SumType (
         struct
            structure FstType =  MyQLLiteralsConstruction.Variables;
            structure SndType =  MyPELLiteralsConstruction.Variables;
         end );
      
      structure MyDblVariablesStructure: DoubleVariableStructure =  DoubleVariableStructure (
         struct
            structure Fst =  MyQLVariablesStructure;
            structure Snd =  MyPELVariablesStructure;
            structure Map =  MyDblVariablesMap;
            structure BinaryRelation =  MyDblVariablesBinaryRelation;
            structure BaseType =  MyDblLiteralsTypeSum;
            structure VarType =  MyDblVariablesSum;
         end );
      
      structure MyDblLiteralsMapPair: PairType =  PairType (
         struct
            structure FstType =  MyQLLiteralsPointeredSingleton.PointeredMap.Map;
            structure SndType =  MyPELLiteralsPointeredSingleton.PointeredMap.Map;
         end );
      
      structure MyDblLiteralsPointeredMap: PointeredDoubleMap =  PointeredDoubleMap (
         struct
            structure FstPointeredMap =  MyQLLiteralsPointeredSingleton.PointeredMap;
            structure SndPointeredMap =  MyPELLiteralsPointeredSingleton.PointeredMap;
            structure Pair =  MyDblLiteralsMapPair;
            structure PointerType =  MyDblPointerType;
         end );
      
      structure MyDblLiteralsPointeredSingleton: PointeredDoubleSingleton =  PointeredDoubleSingleton (
         struct
            structure PointeredType =  MyDblLiteralsPointeredType;
            structure PointeredMap =  MyDblLiteralsPointeredMap;
            structure PointerType =  MyDblPointerType;
            structure FstSingleton =  MyQLLiteralsPointeredSingleton;
            structure SndSingleton =  MyPELLiteralsPointeredSingleton;
         end );
      
      structure MyDblLiteralsPointeredComposeResultMapPair: PairType =  PairType (
         struct
            structure FstType =  MyQLLiteralsComposeMap.Result.Map;
            structure SndType =  MyPELLiteralsComposeMap.Result.Map;
         end );
      
      structure MyDblLiteralsPointeredComposeResult: PointeredDoubleMap =  PointeredDoubleMap (
         struct
            structure FstPointeredMap =  MyQLLiteralsComposeMap.Result;
            structure SndPointeredMap =  MyPELLiteralsComposeMap.Result;
            structure Pair =  MyDblLiteralsPointeredComposeResultMapPair;
            structure PointerType =  MyDblPointerType;
         end );
      
      structure MyDblLiteralsPointeredComposeMap: PointeredComposeMap =  PointeredDoubleComposeMap (
         struct
            structure FstCM =  MyQLLiteralsComposeMap;
            structure SndCM =  MyPELLiteralsComposeMap;
            structure ADM =  MyDblLiteralsMap;
            structure BDM =  MyDblLiteralsPointeredSingleton.PointeredMap;
            structure Result =  MyDblLiteralsPointeredComposeResult;
            structure Start =  MyDblLiteralsMap.DoubleStart;
            structure Middle =  MyDblLiteralsMap.DoubleEnd;
            structure End =  MyDblLiteralsPointeredSingleton.PointeredMap.DoubleEnd;
            structure PointerType =  MyDblPointerType;
         end );
      
      structure MyDbLiteralsPointeredGenerationPointeredMapPair: PairType =  PairType (
         struct
            structure FstType =  MyQLLiteralsPointeredGeneration.PointeredMap.Map;
            structure SndType =  MyPELLiteralsPointeredGeneration.PointeredMap.Map;
         end );
      
      structure MyDblLiteralsPointeredGenerationPointeredMap: PointeredDoubleMap =  PointeredDoubleMap (
         struct
            structure FstPointeredMap =  MyQLLiteralsPointeredGeneration.PointeredMap;
            structure SndPointeredMap =  MyPELLiteralsPointeredGeneration.PointeredMap;
            structure Pair =  MyDbLiteralsPointeredGenerationPointeredMapPair;
            structure PointerType =  MyDblPointerType;
         end );
      
      structure MyDblLiteralsPointeredGeneration: PointeredGeneration =  PointeredDoubleGeneration (
         struct
            structure PointeredMap =  MyDblLiteralsPointeredGenerationPointeredMap;
            structure Start =  MyDblLiteralsPointeredType;
            structure End =  MyDblLiteralsPointeredType;
            structure PointerType =  MyDblPointerType;
            structure FstPointeredGeneration =  MyQLLiteralsPointeredGeneration;
            structure SndPointeredGeneration =  MyPELLiteralsPointeredGeneration;
         end );
      
      structure MyDblLiteralsPointeredFunctor: PointeredFunctor =  PointeredFunctor (
         struct
            structure Start =  MyDblLiteralsPointeredType;
            structure End =  MyDblLiteralsPointeredType;
            structure Map =  MyDblLiteralsMap;
            structure ComposeMap =  MyDblLiteralsPointeredComposeMap;
            structure Generation =  MyDblLiteralsPointeredGeneration;
            structure Singleton =  MyDblLiteralsPointeredSingleton;
            structure PointerType =  MyDblPointerType;
         end );
      
      structure MyDblLiteralsAllZipRelationPair: PairType =  PairType (
         struct
            structure FstType =  MyQLLiteralsPointeredTypeGenerating.AllZip.BinaryRelation.Relation;
            structure SndType =  MyPELLiteralsPointeredTypeGenerating.AllZip.BinaryRelation.Relation;
         end );
      
      structure MyDblLiteralsAllZip =  DoubleAllZip (
         struct
            structure Fst =  MyQLLiteralsPointeredTypeGenerating.AllZip;
            structure Snd =  MyPELLiteralsPointeredTypeGenerating.AllZip;
            structure RelationPair =  MyDblLiteralsAllZipRelationPair;
            structure DoublePointeredType =  MyDblLiteralsPointeredType;
         end );
      
      structure MyDblVariablesMapPair: PairType =  PairType (
         struct
            structure FstType =  MyQLVariablesPointeredSingleton.PointeredMap.Map;
            structure SndType =  MyPELVariablesPointeredSingleton.PointeredMap.Map;
         end );
      
      structure MyDblVariablesPointeredMap: PointeredDoubleMap =  PointeredDoubleMap (
         struct
            structure FstPointeredMap =  MyQLVariablesPointeredSingleton.PointeredMap;
            structure SndPointeredMap =  MyPELVariablesPointeredSingleton.PointeredMap;
            structure Pair =  MyDblVariablesMapPair;
            structure PointerType =  MyDblPointerType;
         end );
   end;
