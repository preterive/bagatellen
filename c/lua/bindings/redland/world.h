#ifndef LUA_BINDINGS_REDLAND_WORLD_H
#define LUA_BINDINGS_REDLAND_WORLD_H
#include <librdf.h>
#include <lua.h>

int
lua_bindings_redland_world_gc(lua_State *);

int
lua_bindings_redland_world_new(lua_State *);

int
lua_bindings_redland_world_new_mt(lua_State *);

int
lua_bindings_redland_world_wrap(lua_State *, librdf_world *);

int
luaopen_bindings_redland_world(lua_State *);

#endif
