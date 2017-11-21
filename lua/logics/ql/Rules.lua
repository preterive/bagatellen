local Clause =  require "logics.male.Clause"
local MetaVariable =  require "logics.ql.MetaVariable"
local ObjectVariable =  require "logics.ql.ObjectVariable"
local Resolve =  require "logics.male.rule.Resolve"
local Set =  require "base.type.Set"
local ToLiteral =  require "logics.ql.ToLiteral"
local VarAssgnm =  require "logics.male.VarAssgnm"

local Rules =  require "logics.male.Rules"


function Rules:gen_refl()
   local var =  ObjectVariable:new()
   local conclusion =  ToLiteral:new(var, var)
   local premises =  Set:empty_set_factory()
   local clause =  Clause:new(premises, conclusion)
   return Resolve:new(clause)
end

function Rules:gen_trans()
   local lhs_var =  ObjectVariable:new()
   local mid_var =  ObjectVariable:new()
   local rhs_var =  ObjectVariable:new()
   local mid_meta_var =  MetaVariable:new(mid_var)
   local lhs_cath =  ToLiteral:new(lhs_var, mid_meta_var)
   local rhs_cath =  ToLiteral:new(mid_meta_var, rhs_var)
   local hypoth =  ToLiteral:new(lhs_var, rhs_var)

   local conclusion =  hypoth
   local premises =  Set:empty_set_factory()
   premises:add(lhs_cath)
   premises:add(rhs_cath)

   local clause =  Clause:new(premises, conclusion)
   return Resolve:new(clause)
end

function Rules:gen_td()
   local lhs_var =  ObjectVariable:new()
   local mid_var =  ObjectVariable:new()
   local rhs_var =  ObjectVariable:new()
   local lhs_meta_var =  MetaVariable:new(mid_var)
   local lhs_cath =  ToLiteral:new(lhs_meta_var, mid_var)
   local rhs_cath =  ToLiteral:new(mid_var, rhs_var)
   local hypoth =  ToLiteral:new(lhs_meta_var, rhs_var)

   local conclusion =  rhs_cath
   local premises =  Set:empty_set_factory()
   premises:add(lhs_cath)
   premises:add(hypoth)

   local clause =  Clause:new(premises, conclusion)
   return Resolve:new(clause)
end

function Rules:gen_trans_literal(to_literal)
   local var_assgnm =  VarAssgnm:new()
   local devared_literal =  to_literal:devar(var_assgnm)
   local rhs_var =  ObjectVariable:new()
   local premis =  ToLiteral(to_literal:get_rhs_term(), rhs_var)
   local conclusion =  ToLiteral(to_literal:get_lhs_term(), rhs_var)
   local premises =  Set:empty_set_factory()
   premises:add(premis)

   local clause =  Clause:new(premises, conclusion)
   return Resolve:new(clause)
end

return Rules
