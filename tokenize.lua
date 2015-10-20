-- @param str:	Input string
-- @param delimeter:	Character that separates different words. Default: Space
-- @param removeQuotes:	Remove first and last quote characters of a long string word

return function (str, delimeter, removeQuotes)
	local delimeter = (delimeter and ("[^".. delimeter .."]+")) or "[^ ]+"	-- may lead to problems when using multiliteral delimeters
	local wordList = {}
	local append = false	-- if true, then the currently found word will be appended to the last one
	local lastUsedQuote = ""	-- make sure we're looking for the same quote char that was used to open the long string: "hello 'i am' here"
	
	for word in str:gmatch(delimeter) do

		if append == false then
			-- search for a new quoted string beginning: "hello ...
			local firstChar = word:sub(1, 1)
			
			if firstChar == "\"" or firstChar == "'" then
				append = true
				lastUsedQuote = firstChar
			end
			
			wordList[ #wordList + 1 ] = word
			
		else 	-- append = true
			wordList[ #wordList ] = wordList[ #wordList ] .. " " .. word	-- appending to the last long string: "hello world ...
			
			local lastChar = word:sub(-1)
			
			if (lastChar == lastUsedQuote) and word:sub(-2, -2) ~= "\\" then	-- ends with the same quote that is not escaped?
				-- this is the last word of the long string, stop appending any further words
				append = false
				
				if removeQuotes then	-- remove the quotes from the final word
					wordList[ #wordList ] = wordList[ #wordList ]:sub(2, -2)
				end
			end
		end
		
	end
	
	return wordList
end