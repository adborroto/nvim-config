-- nvim-dap configuration (python-focused)

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local dap = prequire("dap")
local dapui = prequire("dapui")
local dap_python = prequire("dap-python")
local dap_virtual_text = prequire("nvim-dap-virtual-text")

if not (dap and dapui and dap_python and dap_virtual_text) then
  return
end

-- ui setup
dapui.setup({})
dap_virtual_text.setup({
  commented = true, -- show virtual text alongside comment
})

-- python adapter
-- prefer debugpy from mason if available, otherwise fall back to system python3.
-- if debugpy is missing, show a friendly message and skip dap-python setup
local mason_debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
local python_path = "python3"

if vim.fn.executable(mason_debugpy) == 1 then
  python_path = mason_debugpy
end

local function has_debugpy(py)
  local cmd = string.format("%s -c \"import debugpy\" 2>/dev/null", py)
  local ok = os.execute(cmd)
  return ok == true or ok == 0
end

if not has_debugpy(python_path) then
  vim.notify(
    "python debug: debugpy is not installed. install via :MasonInstall debugpy or pip install debugpy",
    vim.log.levels.WARN
  )
else
  dap_python.setup(python_path)
end

-- signs
vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "", -- or "❌"
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = "", -- or "→"
  texthl = "DiagnosticSignWarn",
  linehl = "Visual",
  numhl = "DiagnosticSignWarn",
})

-- automatically open dap ui when session starts
if dap.listeners and dap.listeners.after and dap.listeners.after.event_initialized then
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
end

local opts = { noremap = true, silent = true }

-- toggle breakpoint
vim.keymap.set("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, opts)

-- continue / start
vim.keymap.set("n", "<leader>dc", function()
  dap.continue()
end, opts)

-- step over
vim.keymap.set("n", "<leader>do", function()
  dap.step_over()
end, opts)

-- step into
vim.keymap.set("n", "<leader>di", function()
  dap.step_into()
end, opts)

-- step out
vim.keymap.set("n", "<leader>dO", function()
  dap.step_out()
end, opts)

-- terminate debugging
vim.keymap.set("n", "<leader>dq", function()
  dap.terminate()
end, opts)

-- toggle dap ui
vim.keymap.set("n", "<leader>du", function()
  dapui.toggle()
end, opts)
