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


local function serialize(name, object, tabs)
	local output = {tabs .. name .. " = {" .. "\n"}
	
	for k,v in pairs(object) do
		local valueType = type(v)
		
		if valueType == "string" then
			output[#output+1] = tabs .. serializeKey(k) .. string.format("%q",v)
		elseif valueType == "table" then
			output[#output+1] = serialize(serializeKeyForTable(k), v, tabs.."\t")
		elseif valueType == "number" then
			output[#output+1] = tabs .. serializeKey(k) .. v
		elseif valueType == "boolean" then
			output[#output+1] = tabs .. serializeKey(k) .. tostring(v)
		else
			output[#output+1] = tabs .. serializeKey(k) .. "\"" .. tostring(v) .. "\""
		end
		
		if next(object,k) then
			output[#output+1] = ",\n"
		end
	end
	output[#output+1] = "\n" .. tabs .. "}"
	return table.concat(output)
end

return function (name, object, tabs)
	if not tabs then tabs = "" end
	return serialize(name, object, tabs)
end