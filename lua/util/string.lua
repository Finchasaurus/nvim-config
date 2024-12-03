local String = {}

function String.wrap(inputText, maxLength)
    local wrappedText = {}
    local currentLine = ""

    for word in inputText:gmatch("%S+") do
        if #currentLine + #word + 1 <= maxLength then
            if currentLine == "" then
                currentLine = word
            else
                currentLine = currentLine .. " " .. word
            end
        else
            table.insert(wrappedText, currentLine)
            currentLine = word
        end
    end

    if currentLine ~= "" then
        table.insert(wrappedText, currentLine)
    end

    return table.concat(wrappedText, "\n")
end

return String
