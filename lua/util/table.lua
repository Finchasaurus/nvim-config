local function get_rand_key(t)
  local ks = {}
  for k in pairs(t) do
    table.insert(ks, k)
  end
  return ks[math.random(#ks)]
end

return {
  get_rand_key = get_rand_key,
}
