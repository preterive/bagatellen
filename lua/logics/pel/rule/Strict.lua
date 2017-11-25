local Resolve =  require "logics.male.rule.Resolve"

local Strict =  Resolve:__new()

package.loaded["logics.pel.rule.Strict"] =  Strict
local Clause =  require "logics.male.Clause"
local Compound =  require "logics.pel.Compound"
local DefSymbol =  require "logics.pel.DefSymbol"
local List =  require "base.type.List"
local MetaVariable =  require "logics.pel.ObjectVariable"
local ObjectVariable =  require "logics.pel.ObjectVariable"
local Set =  require "base.type.Set"

function Strict:new(symbol, arity, place)
   local conclusion_var =  ObjectVariable:new()
   local args =  List:empty_list_factory()
   for i = 1, arity
   do if i == place
      then
         args:append(conclusion_var)
      else
         args:append(MetaVariable:new())
      end
   end
   local premis_term =  Compound:new(symbol, args)
   local def_symbol =  DefSymbol:new()
   local premis =  Compound:new(def_symbol, premis_term)
   local conclusion =  Compound:new(def_symbol, conclusion_var)
   local premises =  Set:empty_set_factory()
   premises:add(premis)

   local clause =  Clause:new(premises, conclusion)
   return Resolve.new(self, clause)
end

function Strict:get_eq_refl_cast()
end

function Strict:get_eq_symm_cast()
end

function Strict:get_eq_trans_cast()
end

function Strict:get_eq_cong_cast()
end

function Strict:get_strict_cast()
   return self
end

return Strict
