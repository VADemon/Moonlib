function saveit(name,object,tab)	local type=type	local tostring=tostring	if not tab then tab = "" end	file:write(tab..name.." = {" .. "\n")	local comma = true		local function thatkey(k)		if type(k)=="number" then		--	return "[" .. k .. "]"			return k		end		return k	end	local function key_number(k,v)		if type(k)=="number" then			return "\t"		end		return "\t[\"" .. k .. "\"] = "	end	local tabs = tab		for k,v in pairs(object) do		local the_type = type(v)		local old_k = k		local k = thatkey(k)		local k_string = key_number(old_k,v)		--print("tabs: " .. tabs .."!")		--print(old_k)		if the_type == "string" then			file:write(tabs .. k_string .. string.format("%q",v))		elseif the_type == "table" then			saveit(k, v, tabs.."\t")		elseif the_type == "number" then			file:write(tabs .. k_string .. tostring(v))		elseif the_type == "boolean" then			if object[k] then x="true" else x="false" end			file:write(tabs .. k_string .. x)			x=nil		else			file:write(tabs .. "\t" .. k .. ": it is a " .. type(v))		end		if next(object,old_k) then file:write(",\n") else file:write("\n") end		--local comma = false	end	tabs = tabs .. "\t"	file:write(tab .. "}")end