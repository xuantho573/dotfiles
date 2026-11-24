return {
  settings = {
    nixd = {
      nixpkgs = { expr = "import <nixpkgs> { }" },
      formatting = { command = { "nixfmt" } },
      options = {
        home_manager = {
          -- expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations.'
          --   .. os.getenv("USER")
          --   .. ".options",
          expr = '(builtins.getFlake (builtins.getEnv "NH_FLAKE")).darwinConfigurations.M4.options.home-manager.users.type.getSubOptions []',
        },
        darwin = {
          -- expr = "(builtins.getFlake (builtins.toString ./.)).darwinConfigurations.simple.options.home-manager.users.type.getSubOptions []",
          expr = '(builtins.getFlake (builtins.getEnv "NH_FLAKE")).darwinConfigurations.M4.options',
          -- expr = '(builtins.getFlake ("git+file:///Users/xuantho573/projects/personal/dotfiles")).darwinConfigurations'
          --   .. ".simple"
          --   .. ".options",
        },
      },
    },
  },
}
