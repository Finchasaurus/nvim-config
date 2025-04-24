local function wrap(txt, len)
  local wrapped = {}
  local curr = ""

  for word in txt:gmatch("%S+") do
    if #curr + #word + 1 <= len then
      if curr == "" then
        curr = word
      else
        curr = curr .. " " .. word
      end
    else
      table.insert(wrapped, curr)
      curr = word
    end
  end

  if curr ~= "" then
    table.insert(wrapped, curr)
  end

  return table.concat(wrapped, "\n")
end

return {
  wrap = wrap,
}
