function saveit(name,object,tabs)
	if not tabs then tabs = "" end

	local output = tabs..name.." = {" .. "\n"

	local function serializeKeyForTable(k) -- optimizing return string for number values
		if type(k)=="number" then
			return "[" .. k .. "]" -- return /[1337]/	if number
		end
		if string.find(k,"[^A-z_-]") then -- contains special symbols?
			return "[\"" .. k .. "\"]"
		end
		return k -- return /leet/	if string
	end

	local function serializeKey(k)
		if type(k)=="number" then
			return "\t"
		end
		if string.find(k,"[^A-z_-]") then
			return "\t[\"" .. k .. "\"] = "
		end
		return "\t" .. k .. " = "
	end


	for k,v in pairs(object) do
		local valueType = type(v)

		if valueType == "string" then
			output = output .. tabs .. serializeKey(k) .. string.format("%q",v)
		elseif valueType == "table" then
			output = output .. saveit(serializeKeyForTable(k), v, tabs.."\t")
		elseif valueType == "number" then
			output = output .. tabs .. serializeKey(k) .. v
		elseif valueType == "boolean" then
			output = output .. tabs .. serializeKey(k) .. tostring(v)
		else
			output = output .. tabs .. serializeKey(k) .. "\"" .. valueType .. ": " .. tostring(v) .. "\"" -- I believe there were good reasons not to use /v/
		end
		
		if next(object,k) then
			output = output .. ",\n"
		else
			return output .. "\n" .. tabs .. "}"
		end

	end

	return output .. tabs .. "}"
end