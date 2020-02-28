## Simple ISO-8859-1 to UTF-8 Converter
Usage: iso88591_to_utf8( latin-1 string )


##Tokenizer
The command tokenizer turns a command string into separate arguments.

####Features:
* Separates words (arguments) by space or any other delimeter
* Arguments with spaces inside are possible
* Both double-quotes and single-quotes are supported

####Examples
* ``` !hello this is a 'perfect example' of how "it should" work and \"shall it fail\" then idk. ```

Turns into:

1. !hello  
2. this  
3. is  
4. a  
5. perfect example  
6. of  
7. how  
8. it should  
9. work  
10. and  
11. \"shall  
12. it  
13. fail\"  
14. then  
15. idk  



##Table Serialization in Lua
Originally based on the code snippet by ```_df_```
http://www.forums.evilmana.com/lua-help/save-a-table-to-a-file/msg14319/#msg14319

#### Features:
* Saving strings, numbers, boolean(s) and tables
* User-friendly output (with tabs, spaces etc.)
* !!! There's an issue saving a _math.huge_ number
* When a table key doesn't contain special characters, it'll be written without squared brackets


##### Function arguments:
* __Name__ under which the table will be saved (string)
* __Table object__ that will be serialized
* _Optional:_ Preceding tabs (a string of "\t\t" characters)


##### Example code
```lua
MySerialize = dofile("serialize.lua") -- loads it as function
serializedTable_string = MySerialize("nameOfMyTable", string, "\t\t\t") 

file = io.open("test", "w")
file:write( serializedTable_string )
file:close()
```
