return {
  ---@param lib string
  ---@return string
  get_node_module_lib = function(lib)
    return vim.fs.joinpath(os.getenv("NIX_PROFILE"), "lib/node_modules", lib)
  end,
}
