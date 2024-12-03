local Cache = {}

local function readFile(filePath)
    local file = io.open(filePath, "r")
    if file then
        local content = file:read("*all")
        file:close()
        return content
    end
end

local function writeFile(filePath, content)
    local file = io.open(filePath, "w")
    if file then
        file:write(content)
        file:close()
        return true
    end
    return false
end

function Cache.loadCache(filePath)
    local content = readFile(filePath)
    if content and content ~= "" then
        return vim.fn.json_decode(content)
    end
end

function Cache.saveCache(filePath, data)
    local encodedData = vim.fn.json_encode(data)
    return writeFile(filePath, encodedData)
end

return Cache
