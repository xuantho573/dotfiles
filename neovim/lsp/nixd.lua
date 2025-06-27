return {
  filetypes = { "nix" },
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = { expr = "import <nixpkgs> { }" },
      formatting = { command = { "nixfmt" } },
      options = {
        home_manager = {
          expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations.'
            .. os.getenv("USER")
            .. ".options",
        },
      },
    },
  },
}
