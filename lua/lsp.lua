local set_keybindings = function(client, buf)
	vim.api.nvim_buf_set_keymap(buf, 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(buf, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(buf, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(buf, 'n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(buf, 'n', 'gq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(buf, 'n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(buf, 'n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(buf, 'n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {noremap = true})
	vim.api.nvim_buf_set_option(buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

require'lspconfig'.intelephense.setup{
	on_attach = set_keybindings,
	init_options = {
		storagePath = '/home/stephen/.cache/intelephense',
		globalStoragePath = '/home/stephen/.cache/intelephense'
	},
	settings = {
		intelephense = {
			stubs = { 'apache', 'bcmath', 'bz2', 'calendar', 'com_dotnet', 'Core', 'ctype', 'curl', 'date', 'dba', 'dom', 'enchant', 'exif', 'FFI', 'fileinfo', 'filter', 'fpm', 'ftp', 'gd', 'gettext', 'gmp', 'hash', 'iconv', 'imap', 'intl', 'json', 'ldap', 'libxml', 'mbstring', 'meta', 'mysqli', 'oci8', 'odbc', 'openssl', 'pcntl', 'pcre', 'PDO', 'pdo_ibm', 'pdo_mysql', 'pdo_pgsql', 'pdo_sqlite', 'pgsql', 'Phar', 'posix', 'pspell', 'readline', 'Reflection', 'session', 'shmop', 'SimpleXML', 'snmp', 'soap', 'sockets', 'sodium', 'SPL', 'sqlite3', 'standard', 'superglobals', 'sysvmsg', 'sysvsem', 'sysvshm', 'tidy', 'tokenizer', 'wordpress', 'xml', 'xmlreader', 'xmlrpc', 'xmlwriter', 'xsl', 'Zend OPcache', 'zip', 'zlib' }
		}
	}
}

require'lspconfig'.tsserver.setup{
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		set_keybindings()
	end,
	handlers = {
		["textDocument/publishDiagnostics"] = function() end,
		["textDocument/formatting"] = function() end
	}
}

require'lspconfig'.diagnosticls.setup{
	on_attach = set_keybindings,
	cmd = { 'diagnostic-languageserver', '--stdio' },
	filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
	init_options = {
		linters = {
			eslint = {
				command = './node_modules/.bin/eslint',
				rootPatterns = { '.git' },
				debounce = 100,
				args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
				sourceName = 'eslint',
				parseJson = {
					errorsRoot = '[0].messages',
					line = 'line',
					column = 'column',
					endLine = 'endLine',
					endColumn = 'endColumn',
					message = '[eslint] ${message} [${ruleId}]',
					security = 'severity'
				},
				securities = {
					[2] = 'error',
					[1] = 'warning'
				}
			},
		},
		filetypes = {
			javascript = 'eslint',
			javascriptreact = 'eslint',
			typescript = 'eslint',
			typescriptreact = 'eslint',
		},
		formatters = {
			prettier = {
				command = './node_modules/.bin/prettier',
				args = { '--stdin-filepath', '%filename' },
				rootPatterns = { '.git' },
				ignore = { '.git', 'node_modules/*' },
				requiredFiles = { '.prettierrc' },
			},
		},
		formatFiletypes = {
			javascript = 'prettier',
			javascriptreact = 'prettier',
			json = 'prettier',
			typescript = 'prettier',
			typescriptreact = 'prettier'
		},
	},
}
