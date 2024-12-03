local Table = {}

function Table.getRandomKey(tbl)
    local keys = {}
    for key in pairs(tbl) do
        table.insert(keys, key)
    end
    return keys[math.random(#keys)]
end

return Table
