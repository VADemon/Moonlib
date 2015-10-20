return function (str, delimeter)
	local wordList = {}
	local tempStr = ""
	local concatenateSuccessor = false
	local delimeter = delimeter or "%S+"
	
	for word in str:gmatch(delimeter) do
		local char = word:sub(1,1)
		if char == "'" or char == '"' then
			concatenateSuccessor = true
			tempStr = word
		else
			if concatenateSuccessor then
				tempStr = tempStr .. " " .. word
				local char = word:sub(-1,-1)
				if char == "'" or char == '"' then
					wordList[ #wordList + 1 ] = tempStr
					tempStr = ""
					concatenateSuccessor = false
				end
			else
				wordList[ #wordList + 1 ] = word
			end
		end
		--print(word)
	end
	
	return wordList
end

-- print(unpack(tokenize("!Hello, everyone here is Direwolf20! 'Today' I'm gonna show you how to fuck 'fat chicks")))
-- > fail