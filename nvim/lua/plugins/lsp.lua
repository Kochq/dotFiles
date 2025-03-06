return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
            pattern = "*.component.html",
            callback = function()
                vim.bo.filetype = "angular.html"  -- Algunos temas tienen mejor soporte para este nombre
            end
        })

        require("conform").setup({
            formatters_by_ft = {
                html = { "prettier" },
                htmlangular = { "prettier" }, -- Añade esta línea específica
                typescriptreact = { "prettier" },
                typescript = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                json = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
            }
        })
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "svelte",
                "ts_ls",
                "eslint",
                "gopls",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                clangd = function()
                    require("lspconfig").clangd.setup {
                        cmd = { "clangd", "--fallback-style=webkit" },
                        root_dir = function() return vim.loop.cwd() end,
                        on_attach = function(client, bufnr)
                            -- Additional configuration
                        end
                    }
                end,
                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,
                lua_ls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
                emmet_language_server = function()
                    require("lspconfig").emmet_language_server.setup {
                        filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "php" },
                        -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
                        -- **Note:** only the options listed in the table are supported.
                        init_options = {
                            ---@type table<string, string>
                            includeLanguages = {},
                            --- @type string[]
                            excludeLanguages = {},
                            --- @type string[]
                            extensionsPath = {},
                            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
                            preferences = {},
                            --- @type boolean Defaults to `true`
                            showAbbreviationSuggestions = true,
                            --- @type "always" | "never" Defaults to `"always"`
                            showExpandedAbbreviation = "always",
                            --- @type boolean Defaults to `false`
                            showSuggestionsAsSnippets = false,
                            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
                            syntaxProfiles = {},
                            --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
                            variables = {},
                        },
                    }
                end,
                ts_ls = function()
                    require("lspconfig").ts_ls.setup {
                        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", },
                    }
                end,
                eslint = function()
                    require("lspconfig").eslint.setup({
                        on_attach = function(client, bufnr)
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                buffer = bufnr,
                                command = "EslintFixAll",
                            })
                        end,
                    })
                end,
                angularls = function()
                    vim.keymap.set("n", "<leader>fo", ":lua require('conform').format()<CR>")

                    require("lspconfig").angularls.setup {
                        on_attach = function(client, bufnr)
                        end
                    }
                end
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
