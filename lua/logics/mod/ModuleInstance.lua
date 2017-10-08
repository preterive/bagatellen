local Type =  require "base.type.aux.Type"

local ModuleInstance =  Type:__new()

package.loaded["logics.mod.ModuleInstance"] =  ModuleInstance
local Indentation =  require "base.Indentation"
local Set =  require "base.type.Set"
local String =  require "base.type.String"

function ModuleInstance:new()
   local retval =  self:__new()
   retval.set_of_qual_assgnm =  Set:empty_set_factory()
   return retval
end

function ModuleInstance:_get_new_set_of_qual_assgnm(qualifier)
   local new_set_of_qual_assgnm =  Set:empty_set_factory()
   for qual_assgnm in self.set_of_qual_assgnm:elems()
   do local new_qual_assgnm =  qual_assgnm:get_chopped_copy(qualifier)
      if new_qual_assgnm
      then
         new_set_of_qual_assgnm:add(new_qual_assgnm)
      end
   end
   return new_set_of_qual_assgnm
end

function ModuleInstance:__diagnose_single_line(indentation)
   indentation:insert(String:string_factory("(logics::mod::ModuleInstance "))
   self.set_of_qual_assgnm:__diagnose_single_line(indentation)
   indentation:insert(String:string_factory(")"))
end

function ModuleInstance:__diagnose_multiple_line(indentation)
   indentation:insert(String:string_factory("(logics::mod::ModuleInstance"))
   indentation:insert_newline()
   local is_last_elem_multiple_line =  true
   do
      local deeper_indentation =
         indentation:get_deeper_indentation_factory {}
      is_last_elem_multiple_line =  self.set_of_qual_assgnm:__diagnose_complex(deeper_indentation)
      deeper_indentation:save()
   end
   indentation:insert(String:parenthesis_off_depending_factory(is_last_elem_multiple_line))
end

return ModuleInstance
