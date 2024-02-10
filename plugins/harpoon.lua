return {
  "ThePrimeagen/harpoon",
  lazy = false,
  branch = "harpoon2",
  init = function()
    local harpoon = require "harpoon"

    -- REQUIRED
    harpoon:setup {}
    -- REQUIRED
    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
    vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "Add current file to harpoon" })
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}
