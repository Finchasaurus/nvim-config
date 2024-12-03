-- catppuccin.lua
local base = {
    red = "#ff657a",
    maroon = "#F29BA7",
    peach = "#ff9b5e",
    yellow = "#eccc81",
    green = "#a8be81",
    teal = "#9cd1bb",
    sky = "#A6C9E5",
    sapphire = "#86AACC",
    blue = "#5d81ab",
    lavender = "#66729C",
    mauve = "#b18eab"
}

local extend_base = function(value)
    return vim.tbl_extend("force", base, value)
end

return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
        background = {
            dark = "frappe",
            light = "latte"
        },
        color_overrides = {
            latte = extend_base({
                text = "#202027",
                subtext1 = "#263168",
                subtext0 = "#4c4f69",
                overlay2 = "#737994",
                overlay1 = "#838ba7",
                base = "#fcfcfa",
                mantle = "#EAEDF3",
                crust = "#DCE0E8",
                pink = "#EA7A95",
                mauve = "#986794",
                red = "#EC5E66",
                peach = "#FF8459",
                yellow = "#CAA75E",
                green = "#87A35E"
            }),
            frappe = extend_base({
                text = "#fcfcfa",
                surface2 = "#535763",
                surface1 = "#3a3d4b",
                surface0 = "#30303b",
                base = "#202027",
                mantle = "#1c1d22",
                crust = "#171719"
            })
        }
    }
}
