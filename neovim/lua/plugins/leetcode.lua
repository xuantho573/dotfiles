local repo_dir = '~/projects/personal/LeetCode/'
local question_dir = '~/projects/personal/LeetCode/'
local slug_name = ''

return {
  "kawre/leetcode.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    "folke/snacks.nvim",
  },
  opts = {
    -- configuration goes here
    hooks = {
      ---@type fun()[]
      ["enter"] = {
      },

      ---@type fun(question: lc.ui.Question)[]
      ["question_enter"] = {
        function (question)
          local file = question.path(question)
          local problem_regex = "%d+%.[%w-]+"
          if file ~= nil then
            local id_name = string.sub(file, string.find(file, problem_regex))
            local id = string.sub(id_name, string.find(id_name, "%d+"))
            slug_name = string.rep('0', 4 - string.len(id)) .. string.gsub(id_name, '%.', '-')
            question_dir = repo_dir .. slug_name .. '/'
          end
        end
      },

      ---@type fun()[]
      ["leave"] = {
        function ()
          question_dir = repo_dir
        end
      },
    },
  },
  config = function(_, opts)
    local leetcode = require("leetcode")
    leetcode.setup(opts)

    local function fn_start_leetcode_session()
      local current_buffer_name = vim.api.nvim_buf_get_name(0)
      if current_buffer_name == "" then
        vim.cmd("Leet")
      end
    end

    local function fn_deploy()
    end

    local function fn_add_solution()
    end

    local function fn_change_solution()
    end

    local function fn_document_solutions()
      Snacks.terminal.open("nvim " .. question_dir .. 'SOLUTIONS.md', {
        win = {
          relative = 'editor',
          width = 0.8,
          height = 0.8,
          enter = true,
          border = 'rounded',
          title = slug_name,
          title_pos = 'center',
          on_win = function (win)
            local buf = win.buf
            if vim.api.nvim_buf_line_count(buf) <= 1 then
              print(1)
              -- vim.api.nvim_buf_set_lines(buf, 0, 2, false, { "# Solutions", "" })
              -- vim.cmd('w')
            end
          end,
        },
      })
    end

    require("which-key").add({
      mode = { "n" },
      { "<leader>cl", group = "leetcode" },
      { '<leader>cli', fn_start_leetcode_session, desc = "Initialize Leetcode" },
      { '<leader>cld', '<cmd>Leet daily<cr>', desc = "Get Daily Question" },
      { '<leader>cle', '<cmd>Leet exit<cr>', desc = "Exit Leetcode" },
      { '<leader>clr', '<cmd>Leet run<cr>', desc = "Run Test" },
      { '<leader>clc', fn_change_solution, desc = "Change Solution" },
      { '<leader>clS', '<cmd>Leet submit<cr>', desc = "Submit" },
      { '<leader>cls', fn_document_solutions, desc = "Document Solutions" },
      { '<leader>cla', fn_add_solution, desc = "Add A Solution" },
      { '<leader>clD', fn_deploy, desc = "Deploy" },
    })
  end,
}
