require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- -- Mapeamento para abrir o LazyGit em modo flutuante
-- "n" significa modo normal
-- "<leader>gg" será o atalho (Espaço + g + g)
map("n", "<leader>gg", function()
  require("nvchad.term").toggle { 
    pos = "float", 
    id = "lazygit", 
    cmd = "lazygit" 
  }
end, { desc = "Terminal Toggle LazyGit" })
