return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "vim", "markdown" },
      highlight = { enable = true },
      indent = { enable = true },
	auto_install = { enable = true },
    })
  end,
}
