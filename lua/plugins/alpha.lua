return {
  "goolord/alpha-nvim",
  opts = function(_, dashboard)
    local banners = require("tables.banners")
    local table_util = require("util.table")
    local cache_util = require("util.cache")
    local string_util = require("util.string")

    local cached_file = vim.fn.stdpath("config") .. "/cache/quote.json"
    math.randomseed(os.time())

    local banner = banners["kitty"] or table_util.get_rand_key(banners)
    dashboard.section.header.val = banner

    dashboard.section.footer.val = "Fetching quote..."

    local function fetch_quote(callback)
      local api_url = "https://api.animechan.io/v1/quotes/random"
      local current_time = os.time()
      local cached_data = cache_util.load(cached_file)

      if cached_data and (current_time - cached_data.timestamp) < 3600 then
        callback(string_util.wrap(cached_data.quote, 64))
        return
      end

      require("plenary.job")
        :new({
          command = "curl",
          args = { "-s", api_url },
          on_exit = function(job, return_val)
            if return_val == 0 then
              local result = table.concat(job:result(), "\n")
              vim.schedule(function()
                local decoded = vim.fn.json_decode(result)
                if
                  decoded
                  and decoded.data
                  and decoded.data.content
                  and decoded.data.character
                  and decoded.data.character.name
                then
                  local quote = string.format('"%s" - %s', decoded.data.content, decoded.data.character.name)
                  cache_util.save(cached_file, {
                    quote = quote,
                    timestamp = current_time,
                  })
                  callback(string_util.wrap(quote, 64))
                else
                  callback("Error: Could not fetch quote")
                end
              end)
            else
              callback("Error: API request failed")
            end
          end,
        })
        :start()
    end

    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyVimStarted",
      callback = function()
        vim.schedule(function()
          fetch_quote(function(quote)
            local lines = type(quote) == "string" and vim.split(quote, "\n") or quote
            dashboard.section.footer.val = lines
            dashboard.section.footer.opts.h1 = "AlphaFooter"
            pcall(vim.cmd.AlphaRedraw)
          end)
        end)
      end,
    })
  end,
}
