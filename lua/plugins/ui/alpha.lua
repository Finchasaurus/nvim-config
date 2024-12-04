local banners = require("tables.banners")
local tableUtil = require("util.table")
local cacheUtil = require("util.cache")
local stringUtil = require("util.string")

local cachedFile = vim.fn.stdpath("config") .. "/cache/quote.json"
math.randomseed(os.time())

local banner = nil
local quote_placeholder = "Fetching quote..."

local function btn_gen(label, shortcut, hl_label, hl_icon)
    return {
        type = "button",
        on_press = function()
            local key = api.nvim_replace_termcodes(shortcut:gsub("%s", ""):gsub("LDR", "<leader>"), true, false, true)
            api.nvim_feedkeys(key, "normal", false)
        end,
        val = label,
        opts = {
            position = "center",
            shortcut = shortcut,
            cursor = 5,
            width = 25,
            align_shortcut = "right",
            hl_shortcut = "AlphaKeyPrefix"
        }
    }
end

local function fetchQuote(callback)
    local api_url = "https://animechan.io/api/v1/quotes/random"
    local currentTime = os.time()
    local cachedData = cacheUtil.loadCache(cachedFile)

    if cachedData and (currentTime - cachedData.timestamp) < 3600 then
        callback(stringUtil.wrap(cachedData.quote, 64))
        return
    end

    require("plenary.job"):new({
        command = "curl",
        args = {"-s", api_url},
        on_exit = function(job, return_val)
            if return_val == 0 then
                local result = table.concat(job:result(), "\n")
                vim.schedule(function()
                    local decoded = vim.fn.json_decode(result)
                    if decoded and decoded.data and decoded.data.content and decoded.data.character and
                        decoded.data.character.name then
                        local quote = string.format('"%s" - %s', decoded.data.content, decoded.data.character.name)

                        cacheUtil.saveCache(cachedFile, {
                            quote = quote,
                            timestamp = currentTime
                        })

                        callback(stringUtil.wrap(quote, 64))
                    else
                        callback("Error: Could not fetch quote - " .. decoded.message)
                    end
                end)
            else
                callback("Error: API request failed")
            end
        end
    }):start()
end

local heading = {
    type = "text",
    val = banners[banner and banner or tableUtil.getRandomKey(banners)],
    opts = {
        position = "center"
    }
}

local footing = {
    type = "text",
    val = quote_placeholder,
    opts = {
        position = "center"
    }
}

local title = {
    type = "text",
    val = [[
	┌── ⋆⋅☆⋅⋆ ──┐
	   TheoVim
	└── ⋆⋅☆⋅⋆ ──┘ 
	]],
    opts = {
        position = "center"
    }
}

local buttons = {
    type = "group",
    val = {btn_gen("  New File", "n", "AlphaButtonLabelText", "WildMenu"),
           btn_gen("  Restore Session", "s", "AlphaButtonLabelText", "Boolean"),
           btn_gen("  Quit", "q", "AlphaButtonLabelText", "Boolean")},
    opts = {
        position = "center",
        spacing = 1
    }
}

local layout = {{
    type = "padding",
    val = 1
}, heading, {
    type = "padding",
    val = 1
}, title, {
    type = "padding",
    val = 0
}, buttons, {
    type = "padding",
    val = 0
}, footing}

local options = {
    layout = layout
}

return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    init = false,
    dependencies = {"echasnovski/mini.icons", "nvim-lua/plenary.nvim"},
    config = function()
        require("alpha").setup(options)

        fetchQuote(function(quote)
            footing.val = quote
            require("alpha").redraw()
        end)
    end
}
