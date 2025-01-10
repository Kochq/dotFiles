-- Define prompts for Copilot
local prompts = {
    Explain = "Please explain how the following code works.",
    Review = "Please review the following code and provide suggestions for improvement.",
    Tests = "Please explain how the selected code works, then generate unit tests for it.",
    Refactor = "Please refactor the following code to improve its clarity and readability.",
    FixCode = "Please fix the following code to make it work as intended.",
    FixError = "Please explain the error in the following text and provide a solution.",
    BetterNamings = "Please provide better names for the following variables and functions.",
    Documentation = "Please provide documentation for the following code.",
    JsDocs = "Please provide JsDocs for the following code.",
    DocumentationForGithub = "Please provide documentation for the following code ready for GitHub using markdown.",
    CreateAPost =
    "Please provide documentation for the following code to post it in social media, like Linkedin, it has be deep, well explained and easy to understand. Also do it in a fun and engaging way.",
    SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
    SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
    Summarize = "Please summarize the following text.",
    Spelling = "Please correct any grammar and spelling errors in the following text.",
    Wording = "Please improve the grammar and wording of the following text.",
    Concise = "Please rewrite the following text to make it more concise.",
    Ask = "I have a question about the following code.",
}

return {
    -- GitHub Copilot plugin
    { "github/copilot.vim" },

    -- Copilot Chat plugin configuration
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
        opts = {
            question_header = "## User ",
            answer_header = "## Copilot ",
            error_header = "## Error ",
            prompts = prompts,
            auto_follow_cursor = false,
            show_help = false,
            config = {
                chat_autocomplete = true -- Added to replace deprecated integration
            },
            mappings = {
                complete = { detail = "Use @<Tab> or /<Tab> for options.", insert = "<Tab>" },
                close = { normal = "q", insert = "<C-c>" },
                reset = { normal = "<C-x>", insert = "<C-x>" },
                submit_prompt = { normal = "<CR>", insert = "<C-CR>" },
                accept_diff = { normal = "<C-y>", insert = "<C-y>" },
                yank_diff = { normal = "gmy" },
                show_diff = { normal = "gmd" },
                show_help = { normal = "gmh" },
            },
        },
        config = function(_, opts)
            local chat = require("CopilotChat")
            local select = require("CopilotChat.select")

            -- Set default selection method
            opts.selection = select.unnamed

            -- Setup Copilot Chat with the provided options
            chat.setup(opts)

            -- Set buffer-specific options when entering Copilot buffers
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-*",
                callback = function()
                    vim.opt_local.relativenumber = true
                    vim.opt_local.number = true

                    local ft = vim.bo.filetype
                    if ft == "copilot-chat" then
                        vim.bo.filetype = "markdown"
                    end
                end,
            })
        end,
        event = "VeryLazy",
        keys = {
            {
                "<leader>ap",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
            },
            {
                "<leader>ap",
                ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
                mode = "x",
            },
            {
                "<leader>ai",
                function()
                    local input = vim.fn.input("Ask Copilot: ")
                    if input ~= "" then
                        vim.cmd("CopilotChat " .. input)
                    end
                end,
            },
            {
                "<leader>aa",
                function()
                    local chat = require("CopilotChat")
                    chat.ask(prompts.Ask, { selection = require("CopilotChat.select").visual })
                end,
                mode = "x",
            },

            { "<leader>ac", "<cmd>CopilotChat<cr>",             mode = "n" },
            { "<leader>ac", "<cmd>CopilotChat<cr>",             mode = "x" },
            -- Try to fix the current error on the file
            { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>" },
            -- Select openai model
            { "<leader>a?", "<cmd>CopilotChatModels<cr>" },
        },
    },
}
