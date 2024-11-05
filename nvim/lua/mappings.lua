require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", {
  desc = "CMD enter command mode",
})
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local telescope_builtin = require "telescope.builtin"
map("n", "<leader>ff", telescope_builtin.git_files, {
  desc = "Telescope find git files",
})
