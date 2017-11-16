local Type =  require "base.type.aux.Type"

local Constant =  Type:__new()

package.loaded["logics.ql.Constant"] =  Constant

function Constant:new(symbol, qualifier)
   local retval =  self:__new()
   retval.symbol =  symbol
   retval.qualifier =  qualifier
   return retval
end

function Constant:get_symbol()
   return self.symbol
end

function Constant:get_qualifier()
   return self.qualifier
end

function Constant:get_variable()
end

function Constant:get_constant()
   return self
end

function Constant:append_qualifier(qualifier)
   self.qualifier:append_qualifier(qualifier)
end

function Constant:be_a_variable(variable)
end

function Constant:destruct_constant(constant)
   if self == constant
   then
      return self
   end
end

function Constant:equate(other)
   local other_constant =  other:destruct_constant(self)
   if other_constant
   then
      return true
   else
      return false
   end
end

function Constant:devar(var_assgnm)
   return self
end

function Constant:__eq(other)
   local retval =  false
   local other_constant =  other:get_constant()
   if other_constant
   then
      retval =
            self:get_symbol() == other:get_symbol()
        and self:get_qualifier() == other:get_qualifier()
   end
   return retval
end

return Constant
