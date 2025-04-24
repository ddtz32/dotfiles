local last_win

---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    {
      "<Leader>e",
      function()
        if vim.bo.filetype == "neo-tree" then
          last_win = nil
        else
          last_win = vim.api.nvim_get_current_win()
        end
        vim.cmd "Neotree toggle reveal"
      end,
      desc = "Toggle Exploer",
    },
    {
      "<Leader>o",
      function()
        if vim.bo.filetype == "neo-tree" then
          if last_win and vim.api.nvim_win_is_valid(last_win) then
            vim.api.nvim_set_current_win(last_win)
            last_win = nil
          end
        else
          last_win = vim.api.nvim_get_current_win()
          vim.cmd.Neotree "focus"
        end
      end,
      desc = "Toggle Explorer Focus",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      desc = "Open Neo-Tree on startup with directory",
      -- make a group to be able to delete it later
      group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
      callback = function()
        local f = vim.fn.expand "%:p"
        if vim.fn.isdirectory(f) ~= 0 then
          require("lazy").load { plugins = { "neo-tree.nvim" } }
          -- neo-tree is loaded now, delete the init autocmd
          vim.api.nvim_clear_autocmds { group = "NeoTreeInit" }
        end
      end,
    })
  end,
  opts = {
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    commands = {
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if node:has_children() and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      child_or_open = function(state)
        local node = state.tree:get_node()
        if node:has_children() then
          if not node:is_expanded() then -- if unexpanded, expand
            state.commands.toggle_node(state)
          else -- if expanded and has children, seleect the next child
            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          end
        else -- if has no children
          state.commands.open(state)
        end
      end,
    },
    window = {
      mappings = {
        h = "parent_or_close",
        l = "child_or_open",
      },
    },
    filesystem = {
      filtered_items = {
        always_show = {
          "build",
        },
      },
      hijack_netrw_behavior = "open_current",
    },
  },
}
