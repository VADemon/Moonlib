There are my improved version of Saving table to a file (aka Serializing) in Lua.
They're all based on the code snippet by _df_   http://www.forums.evilmana.com/lua-help/save-a-table-to-a-file/msg14319/#msg14319

#### Features:
* Saving strings, numbers, boolean(s) and tables
* Human-readable data (with tabs, spaces etc.)
* When a key is a string without special characters, it won't be inside brackets

* !!! You CANNOT save infinite values ( math.huge )
#### How-To:
Arguments
* Name under which it will be saved | you can also try to write code in here
* Table object that will be serialized
* Optional: How many tabs do you want here


#### Example code
MySerialize = dofile("serialize.lua") -- loads it as function
serializedTable_string = MySerialize("nameOfMyTable", string, "\t\t\t") 

file = io.open("test", "w")
file:write( serializedTable_string )
file:close()