local dap = require(("dap"))
require("dapui").setup()
require("nvim-dap-virtual-text").setup()

vim.keymap.set("n", "<Leader>cn", require("dap").continue)
vim.keymap.set("n", "<Leader>si", require("dap").step_into)
vim.keymap.set("n", "<Leader>so", require("dap").step_over)
vim.keymap.set("n", "<Leader>sto", require("dap").step_out)
vim.keymap.set("n", "<Leader>db", require("dap").toggle_breakpoint)
vim.keymap.set("n", "<Leader>dB", function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
vim.keymap.set("n", "<Leader>dr", require "dapui".toggle)

dap.adapters.python = {
    type = "executable",
    command = "python",
    args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            return "/usr/bin/python"
        end,
    },


}

dap.adapters.go = {
    {
        type = "executable",
        command = "go",
--
    }



}
