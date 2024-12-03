local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({{"Failed to clone lazy.nvim:\n", "ErrorMsg"}, {out, "WarningMsg"},
                           {"\nPress any key to exit..."}}, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local function getDirs(path)
    local uv = vim.loop
    local ret = {}

    local stats = uv.fs_readdir(uv.fs_opendir(vim.fn.stdpath("config") .. "/" .. "lua" .. "/" .. path, nil, 1000))
    if not stats then
        return {}
    end
    for _, stat in ipairs(stats) do
        if stat.type == "directory" then
            local new_import_path = path .. "/" .. stat.name
            table.insert(ret, {
                import = new_import_path:gsub("/", ".")
            })
            getDirs(new_import_path)
        elseif stat.name == "init.lua" then
            table.remove(ret)
        end
    end
    return ret
end

require("lazy").setup({
    spec = {getDirs("plugins")},
    defaults = {
        lazy = false,
        version = false
    },
    install = {
        colorscheme = {"habamax"}
    },
    checker = {
        enabled = true,
        notify = false
    }
})
