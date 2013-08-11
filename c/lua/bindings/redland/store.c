#include "store.h"
#include "defs.h"
#include "world.h"
#include <lauxlib.h>

int
lua_bindings_redland_store_add(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -2
      ,  store_userdata_type );
   librdf_statement **pp_stmt =  (librdf_statement **) luaL_checkudata(
         L
      ,  -1
      ,  stmt_userdata_type );

   lua_pop(L, 2);

   int result =  librdf_storage_add_statement(*pp_store, *pp_stmt);
   lua_pushnumber(L, result);

   return 1;
}

int
lua_bindings_redland_store_clone(lua_State *L) {
   librdf_storage **pp_arg =  (librdf_storage **) luaL_checkudata(
         L
      ,  -1
      ,  store_userdata_type );

   lua_pop(L, 1);

   lua_bindings_redland_store_new_mt(L);
   return lua_bindings_redland_store_wrap(
         L
      ,  librdf_new_storage_from_storage(*pp_arg) );
}

int
lua_bindings_redland_store_close(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -1
      ,  store_userdata_type );

   lua_pop(L, 1);

   if (librdf_storage_close(*pp_store)) {
      luaL_error(L, "error: could not close storage");
   }

   return 0;
}

int
lua_bindings_redland_store_context_add(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -3
      ,  store_userdata_type );
   librdf_node **pp_context =  (librdf_node **) luaL_checkudata(
         L
      ,  -2
      ,  node_userdata_type );
   librdf_statement **pp_stmt =  (librdf_statement **) luaL_checkudata(
         L
      ,  -1
      ,  stmt_userdata_type );

   lua_pop(L, 3);

   int result =  librdf_storage_context_add_statement(
         *pp_store
      ,  *pp_context
      ,  *pp_stmt );
   lua_pushnumber(L, result);

   return 1;
}

int
lua_bindings_redland_store_context_del(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -3
      ,  store_userdata_type );
   librdf_node **pp_context =  (librdf_node **) luaL_checkudata(
         L
      ,  -2
      ,  node_userdata_type );
   librdf_statement **pp_stmt =  (librdf_statement **) luaL_checkudata(
         L
      ,  -1
      ,  stmt_userdata_type );

   lua_pop(L, 3);

   if (librdf_storage_context_remove_statement(
         *pp_store
      ,  *pp_context
      ,  *pp_stmt )) {
      luaL_error(L, "error: could not delete statement");
   }

   return 0;
}

int
lua_bindings_redland_store_del(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -2
      ,  store_userdata_type );
   librdf_statement **pp_stmt =  (librdf_statement **) luaL_checkudata(
         L
      ,  -1
      ,  stmt_userdata_type );

   lua_pop(L, 2);

   if (librdf_storage_remove_statement(*pp_store, *pp_stmt)) {
      luaL_error(L, "error: could not delete statement");
   }

   return 0;
}

int
lua_bindings_redland_store_get_feature(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -2
      ,  store_userdata_type );
   librdf_uri **pp_feature =  (librdf_uri **) luaL_checkudata(
         L
      ,  -1
      ,  uri_userdata_type );

   lua_pop(L, 2);

   librdf_node *result =  librdf_storage_get_feature(
         *pp_store
      ,  *pp_feature );
   if (result) {
      lua_bindings_redland_node_new_mt(L);
      return lua_bindings_redland_node_wrap(L, result);
   } else {
      return 0;
   }
}

int
lua_bindings_redland_store_get_world(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -1
      ,  store_userdata_type );

   lua_pop(L, 1);

   librdf_world *p_world =  librdf_storage_get_world(
         *pp_store );
   if (p_world) {
      lua_bindings_redland_node_new_mt(L);
      return lua_bindings_redland_world_wrap(L, p_world);
   } else {
      return 0;
   }
}

int
lua_bindings_redland_store_is_containing(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -2
      ,  store_userdata_type );
   librdf_statement **pp_stmt =  (librdf_statement **) luaL_checkudata(
         L
      ,  -1
      ,  stmt_userdata_type );

   lua_pop(L, 2);

   int result =  librdf_storage_contains_statement(*pp_store, *pp_stmt);
   if (result > 0) {
      luaL_error(L, "error: illegal statement");
   } else {
      lua_pushboolean(L, result);
      return 1;
   }
}

int
lua_bindings_redland_store_is_supporting_query(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -2
      ,  store_userdata_type );
   librdf_query **pp_query =  (librdf_query **) luaL_checkudata(
         L
      ,  -1
      ,  query_userdata_type );

   lua_pop(L, 2);

   lua_pushboolean(L, librdf_storage_supports_query(*pp_store, *pp_query));
   return 1;
}

int
lua_bindings_redland_store_is_there_object(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -3
      ,  store_userdata_type );
   librdf_node **pp_node =  (librdf_node **) luaL_checkudata(
         L
      ,  -2
      ,  node_userdata_type );
   librdf_node **pp_property =  (librdf_node **) luaL_checkudata(
         L
      ,  -1
      ,  node_userdata_type );

   lua_pop(L, 3);

   int result =  librdf_storage_has_arc_out(
         *pp_store
      ,  *pp_node
      ,  *pp_property );
   lua_pushboolean(L, result);
   return 1;
}

int
lua_bindings_redland_store_is_there_subject(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -3
      ,  store_userdata_type );
   librdf_node **pp_node =  (librdf_node **) luaL_checkudata(
         L
      ,  -2
      ,  node_userdata_type );
   librdf_node **pp_property =  (librdf_node **) luaL_checkudata(
         L
      ,  -1
      ,  node_userdata_type );

   lua_pop(L, 3);

   int result =  librdf_storage_has_arc_in(
         *pp_store
      ,  *pp_node
      ,  *pp_property );
   lua_pushboolean(L, result);
   return 1;
}

int
lua_bindings_redland_store_gc(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -1
      ,  store_userdata_type );

   lua_pop(L, 1);

   librdf_free_storage(*pp_store);

   return 0;
}

int
lua_bindings_redland_store_lookup(lua_State *L) {
   librdf_world **pp_world =  (librdf_world **) luaL_checkudata(
         L
      ,  -2
      ,  world_userdata_type );
   const unsigned int idx =  (const unsigned int) luaL_checkinteger(L, -1);

   lua_pop(L, 2);

   {
      const char *name;
      const char *label;
   
      if (librdf_storage_enumerate(*pp_world, idx, &name, &label)) {
         return 0;
      } else {
         lua_newtable(L);

         if (name) {
            lua_pushstring(L, name);
            lua_setfield(L, -2, "name");
         }

         if (label) {
            lua_pushstring(L, label);
            lua_setfield(L, -2, "label");
         }

         return 1;
      }
   }
}

int
lua_bindings_redland_store_new(lua_State *L) {
   librdf_world **pp_world =  (librdf_world **) luaL_checkudata(
         L
      ,  -4
      ,  world_userdata_type );
   librdf_hash **pp_hash =  (librdf_hash **) luaL_checkudata(
         L
      ,  -3
      ,  hash_userdata_type );
   const char *storage_name =  luaL_checkstring(L, -2);
   const char *name =  luaL_checkstring(L, -1);

   lua_pop(L, 4);

   librdf_storage *p_store =  librdf_new_storage_with_options(
         *pp_world
      ,  storage_name
      ,  name
      ,  *pp_hash );
   if (p_store) {
      lua_bindings_redland_store_new_mt(L);
      return lua_bindings_redland_store_wrap(L, p_store);
   } else {
      return 0;
   }
}

int
lua_bindings_redland_store_open(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -2
      ,  store_userdata_type );
   librdf_model **pp_model =  (librdf_model **) luaL_checkudata(
         L
      ,  -1
      ,  model_userdata_type );

   lua_pop(L, 2);

   if (librdf_storage_open(*pp_store, *pp_model)) {
      luaL_error(L, "error: could not open storage");
   }

   return 0;
}

int
lua_bindings_redland_store_set_feature(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -3
      ,  store_userdata_type );
   librdf_uri **pp_feature =  (librdf_uri **) luaL_checkudata(
         L
      ,  -2
      ,  uri_userdata_type );
   librdf_node **pp_value =  (librdf_node **) luaL_checkudata(
         L
      ,  -2
      ,  node_userdata_type );

   lua_pop(L, 3);

   int result =  librdf_storage_set_feature(
         *pp_store
      ,  *pp_feature
      ,  *pp_value );
   lua_pushnumber(L, result);
   return 1;
}

int
lua_bindings_redland_store_size(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -1
      ,  store_userdata_type );

   lua_pop(L, 1);

   int result =  librdf_storage_size(*pp_store);
   lua_pushnumber(L, result);

   return 1;
}

int
lua_bindings_redland_store_sync(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -1
      ,  store_userdata_type );

   lua_pop(L, 1);

   if (librdf_storage_sync(*pp_store)) {
      luaL_error(L, "error: sync");
   }

   return 0;
}

int
lua_bindings_redland_store_transaction_commit(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -1
      ,  store_userdata_type );

   lua_pop(L, 1);

   if (librdf_storage_transaction_commit(*pp_store)) {
      luaL_error(L, "error: transaction commit");
   }

   return 0;
}

int
lua_bindings_redland_store_transaction_rollback(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -1
      ,  store_userdata_type );

   lua_pop(L, 1);

   if (librdf_storage_transaction_rollback(*pp_store)) {
      luaL_error(L, "error: transaction rollback");
   }

   return 0;
}

int
lua_bindings_redland_store_transaction_start(lua_State *L) {
   librdf_storage **pp_store =  (librdf_storage **) luaL_checkudata(
         L
      ,  -1
      ,  store_userdata_type );

   lua_pop(L, 1);

   if (librdf_storage_transaction_start(*pp_store)) {
      luaL_error(L, "error: transaction start");
   }

   return 0;
}


/* ------------------------------------------------------------ */

int
lua_bindings_redland_store_new_mt(lua_State *L) {
   luaL_newmetatable(L, store_userdata_type);

   lua_pushcfunction(L, &lua_bindings_redland_store_gc);
   lua_setfield(L, -2, "__gc");

   return 1;
}

int
lua_bindings_redland_store_wrap(lua_State *L, librdf_storage *p_store) {
   if (p_store) {
      librdf_storage **pp_store =  (librdf_storage **) lua_newuserdata(
            L
         ,  sizeof(librdf_storage *) );
      *pp_store =  p_store;

      lua_bindings_redland_store_new_mt(L);
      lua_setmetatable(L, -2);
   
      return 1;
   } else {
      return 0;
   }
}

int
luaopen_bindings_redland_store(lua_State *L) {
   lua_newtable(L);

   lua_pushcfunction(L, &lua_bindings_redland_store_add);
   lua_setfield(L, -2, "add");

   lua_pushcfunction(L, &lua_bindings_redland_store_clone);
   lua_setfield(L, -2, "__clone");

   lua_pushcfunction(L, &lua_bindings_redland_store_close);
   lua_setfield(L, -2, "close");

   lua_pushcfunction(L, &lua_bindings_redland_store_context_add);
   lua_setfield(L, -2, "context_add");

   lua_pushcfunction(L, &lua_bindings_redland_store_context_del);
   lua_setfield(L, -2, "context_del");

   lua_pushcfunction(L, &lua_bindings_redland_store_del);
   lua_setfield(L, -2, "del");

   lua_pushcfunction(L, &lua_bindings_redland_store_get_feature);
   lua_setfield(L, -2, "get_feature");

   lua_pushcfunction(L, &lua_bindings_redland_store_get_world);
   lua_setfield(L, -2, "get_world");

   lua_pushcfunction(L, &lua_bindings_redland_store_is_containing);
   lua_setfield(L, -2, "is_containing");

   lua_pushcfunction(L, &lua_bindings_redland_store_is_supporting_query);
   lua_setfield(L, -2, "is_supporting_query");

   lua_pushcfunction(L, &lua_bindings_redland_store_is_there_object);
   lua_setfield(L, -2, "is_there_object");

   lua_pushcfunction(L, &lua_bindings_redland_store_is_there_subject);
   lua_setfield(L, -2, "is_there_subject");

   lua_pushcfunction(L, &lua_bindings_redland_store_lookup);
   lua_setfield(L, -2, "lookup");

   lua_pushcfunction(L, &lua_bindings_redland_store_new);
   lua_setfield(L, -2, "new");

   lua_pushcfunction(L, &lua_bindings_redland_store_open);
   lua_setfield(L, -2, "open");

   lua_pushcfunction(L, &lua_bindings_redland_store_set_feature);
   lua_setfield(L, -2, "set_feature");

   lua_pushcfunction(L, &lua_bindings_redland_store_size);
   lua_setfield(L, -2, "size");

   lua_pushcfunction(L, &lua_bindings_redland_store_sync);
   lua_setfield(L, -2, "sync");

   lua_pushcfunction(L, &lua_bindings_redland_store_transaction_commit);
   lua_setfield(L, -2, "transaction_commit");

   lua_pushcfunction(L, &lua_bindings_redland_store_transaction_rollback);
   lua_setfield(L, -2, "transaction_rollback");

   lua_pushcfunction(L, &lua_bindings_redland_store_transaction_start);
   lua_setfield(L, -2, "transaction_start");

   return 1;
}
