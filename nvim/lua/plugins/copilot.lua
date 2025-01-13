local prompts = {
    Explain = "Please explain how the following code works.",
    Review = "Please review the following code and provide suggestions for improvement.",
    Tests = "Please explain how the selected code works, then generate unit tests for it.",
    Refactor = "Please refactor the following code to improve its clarity and readability.",
    FixCode = "Please fix the following code to make it work as intended.",
    BetterNamings = "Please provide better names for the following variables and functions.",
    Documentation = "Please provide documentation for the following code.",
    JsDocs = "Please provide JsDocs for the following code.",
    DocumentationForGithub = "Please provide documentation for the following code ready for GitHub using markdown.",
    CreateAPost =
    "Please provide documentation for the following code to post it in social media, like Linkedin, it has be deep, well explained and easy to understand. Also do it in a fun and engaging way.",
    Spelling = "Please correct any grammar and spelling errors in the following text.",
    Wording = "Please improve the grammar and wording of the following text.",
    Concise = "Please rewrite the following text to make it more concise.",
    Ask = "I have a question about the following code.",
}

-- First, convert the prompts table to a format Telescope can use
local function get_prompt_selections()
    local selections = {}
    for name, prompt in pairs(prompts) do
        table.insert(selections, {
            name = name,
            prompt = prompt
        })
    end
    return selections
end

-- Create the Telescope picker
local function prompt_picker()
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local previewers = require('telescope.previewers')

    -- Create custom previewer
    local prompt_previewer = previewers.new_buffer_previewer({
        title = "Prompt Preview",
        define_preview = function(self, entry)
            -- Get the buffer for preview
            local bufnr = self.state.bufnr

            -- Clear the buffer
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})

            -- Add a header
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
                "Prompt: " .. entry.value.name,
                string.rep("-", 40), -- Separator line
                "",
                -- Add the actual prompt content
                entry.value.prompt
            })

            -- Set buffer options
            vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
            vim.api.nvim_buf_set_option(bufnr, 'filetype', 'markdown')
        end
    })

    -- Create the picker
    pickers.new({}, {
        prompt_title = 'Select Prompt',
        finder = finders.new_table({
            results = get_prompt_selections(),
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.name,
                    ordinal = entry.name,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        previewer = prompt_previewer,
        layout_config = {
            width = 0.9,
            height = 0.8,
            preview_width = 0.5,
        },
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                -- Insert the selected prompt text at cursor position
                vim.api.nvim_put({ selection.value.prompt }, 'c', true, true)
            end)
            return true
        end,
    }):find()
end

vim.keymap.set('n', '<leader>ap', prompt_picker)

return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
        ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
        provider = "copilot",                  -- Recommend using Claude
        auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
        behaviour = {
            auto_suggestions = false,          -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
        },
        mappings = {
            --- @class AvanteConflictMappings
            diff = {
                ours = "co",
                theirs = "ct",
                all_theirs = "ca",
                both = "cb",
                cursor = "cc",
                next = "]x",
                prev = "[x",
            },
            suggestion = {
                accept = "<M-l>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
            },
            jump = {
                next = "]]",
                prev = "[[",
            },
            submit = {
                normal = "<CR>",
            },
            sidebar = {
                apply_all = "A",
                apply_cursor = "a",
            },
        },
        hints = { enabled = false },
        windows = {
            ---@type "right" | "left" | "top" | "bottom"
            position = "left",    -- the position of the sidebar
            wrap = true,          -- similar to vim.o.wrap
            width = 30,           -- default % based on available width
            sidebar_header = {
                enabled = true,   -- true, false to enable/disable the header
                align = "center", -- left, center, right for title
                rounded = false,
            },
            input = {
                prefix = "> ",
                height = 5, -- Height of the input window in vertical layout
            },
            edit = {
                start_insert = false, -- Start insert mode when opening the edit window
            },
            ask = {
                floating = true,        -- Open the 'AvanteAsk' prompt in a floating window
                start_insert = false,    -- Start insert mode when opening the ask window
                ---@type "ours" | "theirs"
                focus_on_apply = "ours", -- which diff to focus after applying
            },
        },
        highlights = {
            ---@type AvanteConflictHighlights
            diff = {
                current = "DiffText",
                incoming = "DiffAdd",
            },
        },
        --- @class AvanteConflictUserConfig
        diff = {
            autojump = true,
            ---@type string | fun(): any
            list_opener = "copen",
            --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
            --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
            --- Disable by setting to -1.
            override_timeoutlen = 500,
        },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        {
            "github/copilot.vim",
            enabled = false,
        },
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
        {
            "nvim-telescope/telescope.nvim",
            requires = { { 'nvim-lua/plenary.nvim' } }
        },
    },
}
