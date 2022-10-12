-- Example config in lua

-- if morning change theme to solarizd if night to nord in lua

-- time in lua

local time = os.date("*")
local 

vim.g.solarized_italic_comments = true
vim.g.solarized_italic_keywords = true
vim.g.solarized_italic_functions = true
vim.g.solarized_italic_variables = false
vim.g.solarized_contrast = true
vim.g.solarized_borders = false
vim.g.solarized_disable_background = false

-- Load the colorscheme
require('solarized').set()

-- time in lua
--[=[
-- use local function
vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = true 
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
--]=]
--require('nord').set()

