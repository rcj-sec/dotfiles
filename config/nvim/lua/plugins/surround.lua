return {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    opts = {
    surrounds = {
      ["n"] = {
        add = { "**", "**" },
        find = "%*%*.-%*%*",
        delete = "^(%*%*)().-(%*%*)()$",
      },
      ["u"] = {
        add = { "<u>", "</u>" },
        find = "<u>.-</u>",
        delete = "^(<u>)().-(</u>)()$",
        },
    },
    }, }
