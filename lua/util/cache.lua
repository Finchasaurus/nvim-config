local function read_file(filepath)
  local file = io.open(filepath, "r")
  if file then
    local content = file:read("*a")
    file:close()
    return content
  end
end

local function write_file(filepath, content)
  local file = io.open(filepath, "w")
  if file then
    file:write(content)
    file:close()
    return true
  end
  return false
end

local function load(filepath)
  local content = read_file(filepath)
  if content and content ~= "" then
    local decoded = vim.fn.json_decode(content)
    if type(decoded) == "table" then
      return decoded
    end
  end
end

local function save(filepath, content)
  local encoded = vim.fn.json_encode(content)
  return write_file(filepath, encoded)
end

return {
  load = load,
  save = save,
}
