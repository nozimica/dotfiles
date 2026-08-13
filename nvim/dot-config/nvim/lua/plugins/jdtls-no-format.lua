-- Disable jdtls formatting capability so it never reformats code
-- (even on manual <leader>cf, jdtls won't be used as a formatter)
return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      jdtls = {
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
    },
  },
}
