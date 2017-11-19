local Variable =  require "logics.male.Variable"

local MetaVariable =  Variable:__new()

package.loaded["logics.male.MetaVariable"] =  MetaVariable

function MetaVariable:new()
   local retval =  Variable.new(self)
   return retval
end

function MetaVariable:get_variable_cast()
   return self:get_meta_variable_cast()
end

function MetaVariable:get_meta_variable_cast()
   return self
end

function MetaVariable:get_object_variable_cast()
   local this_val =  self:get_val()
   if this_val
   then
      return this_val:get_object_variable_cast()
   end
end

function MetaVariable:assign_object_variable_to_meta_variable(variable)
   return true
end

-- undefined; by definition as division by zero is undefined!!!
function MetaVariable:equate(val)
end

return MetaVariable
