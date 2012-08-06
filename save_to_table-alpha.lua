function saveit(name,object,tab)
	local type=type
	local tostring=tostring
	if not tab then tab = "" end
	file:write(tab..name.." = {" .. "\n")
	local comma = true
	
	local function thatkey(k)
		if type(k)=="number" then
			return "[" .. k .. "]"
		end
		return k
	end
	local tabs = tab
	for k,v in pairs(object) do
		local the_type = type(v)
		local k = thatkey(k)

		--print("tabs: " .. tabs .."!")
		if the_type == "string" then
			file:write(tabs .. "\t" .. k .. " = " .. string.format("%q",v))
		elseif the_type == "table" then
			saveit(k, v, tabs.."\t")
		elseif the_type == "number" then
			file:write(tabs .. "\t" .. k .. " = " .. tostring(v))
		elseif the_type == "boolean" then
			if object[k] then x="true" else x="false" end
			file:write(tabs .. "\t" .. k .. " = " .. x)
			x=nil
		else
			file:write(tabs .. "\t" .. k .. ": it is a " .. type(v))
		end
		if comma then file:write(",\n") else file:write("\n") end
		--local comma = false
	end
	tabs = tabs .. "\t"
	file:write(tab .. "}")
end