function saveit(name,object,tab)
	local type=type
	local tostring=tostring
	local string=string
	if not tab then tab = "" end
	
	local output = tab..name.." = {" .. "\n"
	
	local function serializeKey(k) -- optimizing return string for number values
		if type(k)=="number" then
			return "[" .. k .. "]" -- return /[1337]/	if number
		end
		if string.find(k,"[^A-z_-]") then -- contains special symbols?
			return "[\"" .. k .. "\"]"
		end
		return k -- return /leet/	if string
	end
	
	local function key_number(k,v)
		if type(k)=="number" then
			return "\t"
		end
		if string.find(k,"[^A-z_-]") then
			return "\t[\"" .. k .. "\"] = "
		end
		return "\t" .. k .. " = "
	end
	
	local currentTabs = tab
	
	for k,v in pairs(object) do
		local the_type = type(v)
		local old_k = k
		local k_asString = serializeKey(k)

		if the_type == "string" then
			output = output .. currentTabs .. key_number(old_k,v) .. string.format("%q",v)
		elseif the_type == "table" then
			output = output .. saveit(serializeKey(k), v, currentTabs.."\t")
		elseif the_type == "number" then
			output = output .. currentTabs .. key_number(old_k,v) .. v
		elseif the_type == "boolean" then
			output = output .. currentTabs .. key_number(old_k,v) .. tostring(object[k])
		else
			output = output .. currentTabs .. key_number(old_k,v) .. "\"" .. the_type .. ": " .. tostring(object[k]) .. "\"" -- I believe there were good reasons not to use /v/
		end
		
		if next(object,old_k) then
			output = output .. ",\n"
		else
			output = output .. "\n"
		end

	end

	return output .. currentTabs .. "}"
end