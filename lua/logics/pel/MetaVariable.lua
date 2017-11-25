local MALEMetaVariable =  require "logics.male.MetaVariable"

local MetaVariable =  MALEMetaVariable:__new()

package.loaded["logics.pel.MetaVariable"] =  MetaVariable
local Compound =  require "logics.pel.Compound"
local List =  require "base.type.List"
local String =  require "base.type.String"

function MetaVariable:new()
   return MALEMetaVariable.new(self)
end

function MetaVariable:new_compound(symbol, arg_list)
   return Compound:new(symbol, arg_list)
end

function MetaVariable:get_compound_cast()
end

function MetaVariable:copy()
   return self.__index:new()
end

function MetaVariable:destruct_compound(symbol, arity)
   local this_val =  self:get_val()
   if this_val
   then
      return this_val:destruct_compound(symbol, arity)
   else
-- map/reduce et al.!!!
      local arg_list =  List:empty_list_factory()
      for i = 1, arity
      do arg_list:append(self:copy())
      end
      local val =  self:new_compound(symbol, arg_list)
      self:set_val(val)
      return arg_list
   end
end

function MetaVariable:get_name()
   return self.name
end

function MetaVariable:set_name(name)
   self.name =  name
end

function MetaVariable:get_non_nil_name()
   return self:get_name() or String:string_factory("???")
end

function MetaVariable:__diagnose_single_line(indentation)
   indentation:insert(String:string_factory("(logics::pel::MetaVariable ["))
   indentation:insert(String:string_factory(tostring(self)))
   indentation:insert(String:string_factory("] "))
indentation:insert(String:string_factory(tostring(self:get_value_store())))
   indentation:insert(self:get_non_nil_name())
   local this_val =  self:get_val()
   if this_val
   then
      indentation:insert(String:string_factory(" "))
      self:get_val():__diagnose_single_line(indentation)
   end
   indentation:insert(String:string_factory(")"))
end

function MetaVariable:__diagnose_multiple_line(indentation)
   local is_last_elem_multiple_line =  true

   indentation:insert(String:string_factory("(logics::pel::MetaVariable ["))
   indentation:insert(String:string_factory(tostring(self)))
   indentation:insert(String:string_factory("] "))
indentation:insert(String:string_factory(tostring(self:get_value_store())))
   indentation:insert(self:get_non_nil_name())
   local this_val =  self:get_val()
   if this_val
   then
      indentation:insert_newline()
      local deeper_indentation =
         indentation:get_deeper_indentation_factory {}
      is_last_elem_multiple_line
         =  this_val:__diagnose_complex(deeper_indentation)
      deeper_indentation:save()
   end
   indentation:insert(String:parenthesis_off_depending_factory(is_last_elem_multiple_line))
end

return MetaVariable
