local MALEMetaVariable =  require "logics.male.MetaVariable"
local MetaVariable =  MALEMetaVariable:__new()

package.loaded["logics.pel.MetaVariable"] =  MetaVariable
local Compound =  require "logics.pel.Compound"
local List =  require "base.type.List"
local String =  require "base.type.String"

function MetaVariable:new()
   return MALEMetaVariable.new(self)
end

function MetaVariable:new_compound(symbol, sub_term_list)
   return Compound:new(synbol, sub_term_list)
end

function MetaVariable:get_compound_cast()
end

function MetaVariable:destruct_compound(var_ctxt, symbol, arity)
   local this_val =  self:get_val()
   if this_val
   then
      return this_val:destruct_compound(var_ctxt, symbol, arity)
   else
      local new_sub_term_list =  List:empty_list_factory()
      for i = 1, arity
      do local next_var =  self:new_instance()
         new_sub_term_list:append(next_var)
      end
      if self:set_val(var_ctxt, new_compound)
      then
         return new_sub_term_list
      end
   end
end

function MetaVariable:get_name()
   return self.name
end

function MetaVariable:set_name(name)
   self.name =  name
end

function MetaVariable:get_non_nil_name()
   return self:get_name() or String:string_factory("?")
end

function MetaVariable:__diagnose_single_line(indentation)
   indentation:insert(String:string_factory("(logics::pel::MetaVariable ["))
   indentation:insert(String:string_factory(tostring(self)))
   indentation:insert(String:string_factory("] "))
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
