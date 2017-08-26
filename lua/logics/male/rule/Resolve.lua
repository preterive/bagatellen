local Rule =  require "logics.male.Rule"

local Resolve =  Rule:__new()


package.loaded["logics.male.rule.Resolve"] =  Resolve
local Indentation =  require "base.Indentation"
local Set =  require "base.type.Set"
local String =  require "base.type.String"

function Resolve:get_resolve()
   return self
end

function Resolve:new(key, substitution)
   local retval =  Rule.new(Resolve)
   retval.key =  key
   retval.substitution =  substitution
   return retval
end

function Resolve:get_key()
   return self.key
end

function Resolve:get_substitution()
   return self.substitution
end

function Resolve:apply(proof_state, goal)
   return proof_state:resolve(
         self:get_key()
      ,  self:get_substitution()
      ,  goal )
end

function Resolve:apply_substitution(substitution)
   self.get_substitution():apply_substitution(substitution)
end

function Resolve:get_axiom(prs)
   local axiom =  prs:deref(self:get_key()):__clone()
   axiom:apply_substitution(self:get_substitution())
   return axiom
end

function Resolve:get_conclusion(prs)
   local conclusion =  prs:deref(self:get_key()):get_conclusion():__clone()
   conclusion:apply_substitution(self:get_substitution())
   return conclusion
end

function Resolve:is_blind(proof)
   local axiom =  self:get_axiom(proof:get_prs())
   return not proof:is_containing(axiom:get_premises())
end

function Resolve:get_blind_goal_set(proof)
   local retval =  Set:empty_set_factory()
   local axiom =  self:get_axiom(proof:get_prs())
   for premise in axiom:get_premises():elems()
   do if not proof:deref(premise)
      then
         retval:add(premise)
      end
   end
   return retval
end

function Resolve:__eq(other)
   local retval =  false
   local other_resolve =  other:get_resolve()
   if other_resolve
   then
      retval =
            self:get_key():__eq(other_resolve:get_key())
        and self:get_substitution():__eq(other_resolve:get_subsitution())
        and Rule.__eq(self, other)
   end
   return retval
end

function Resolve:__diagnose_single_line(indentation)
   indentation:insert(String:string_factory("(logics.male.Resolve "))
   self:get_key():__diagnose_single_line(indentation)
   indentation:insert(String:string_factory(" "))
   self:get_substitution():__diagnose_single_line(indentation)
   indentation:insert(String:string_factory(")"))
end

function Resolve:__diagnose_multiple_line(indentation)
   indentation:insert(String:string_factory("(logics.male.Resolve"))
   local is_last_elem_multiple_line =  true
   indentation:insert_newline()
   local deeper_indentation =
      indentation:get_deeper_indentation_factory {}
   is_last_elem_multiple_line =
      self:get_key():__diagnose_complex(deeper_indentation)
   deeper_indentation:insert_newline()
   is_last_elem_multiple_line =
      self:get_substitution():__diagnose_complex(deeper_indentation)
   deeper_indentation:save()
   indentation:insert(String:parenthesis_off_depending_factory(is_last_elem_multiple_line))
end

return Resolve
