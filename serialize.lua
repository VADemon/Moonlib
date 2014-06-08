return function (name, object, tabs)
	local function serializeKeyForTable(k)
		if type(k)=="number" then
			return "[" .. k .. "]" -- return /[1337]/	if number
		end
		if string.find(k,"[^A-z_-]") then --special symbols in it?
			return "[\"" .. k .. "\"]"
		end
		return k -- /leet/	if string
	end

	local function serializeKey(k)
		if type(k)=="number" then
			return "\t[" .. k .."] = "
		end
		if string.find(k,"[^A-z_-]") then
			return "\t[\"" .. k .. "\"] = "
		end
		return "\t" .. k .. " = "
	end

	if not tabs then tabs = "" end

	local function serialize(name, object, tabs)
		local output = tabs .. name .. " = {" .. "\n"
		
		for k,v in pairs(object) do
			local valueType = type(v)
			
			if valueType == "string" then
				output = output .. tabs .. serializeKey(k) .. string.format("%q",v)
			elseif valueType == "table" then
				output = output .. serialize(serializeKeyForTable(k), v, tabs.."\t")
			elseif valueType == "number" then
				output = output .. tabs .. serializeKey(k) .. v
			elseif valueType == "boolean" then
				output = output .. tabs .. serializeKey(k) .. tostring(v)
			else
				output = output .. tabs .. serializeKey(k) .. "\"" .. tostring(v) .. "\""
			end
			
			if next(object,k) then
				output = output .. ",\n"
			else
				return output .. "\n" .. tabs .. "}"
			end
		end
	end
	
	return serialize(name, object, tabs)
end