vim.cmd [[
  autocmd FileType go set noexpandtab shiftwidth=8 tabstop=8 softtabstop=0
  autocmd FileType json syntax match Comment +\/\/.\+$+
  autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
  autocmd FileType vue set expandtab shiftwidth=4 tabstop=8 softtabstop=0
]]

if vim.filetype then
  vim.filetype.add({
    pattern = {
      [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
      [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
      [".*/group_vars/.*/.*%.ya?ml"] = "yaml.ansible",
      [".*/pb-.*%.ya?ml"] = "yaml.ansible",
      [".*/playbook.*%.ya?ml"] = "yaml.ansible",
      [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
      [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
      [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
      [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
      [".*/molecule/.*%.ya?ml"] = "yaml.ansible",
    },
  })
else
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
      "*/host_vars/*.yml",
      "*/host_vars/*.yaml",
      "*/group_vars/*.yml",
      "*/group_vars/*.yaml",
      "*/group_vars/*/*.yml",
      "*/group_vars/*/*.yaml",
      "*/pb-*.yml",
      "*/pb-*.yaml",
      "*/playbook*.yml",
      "*/playbook*.yaml",
      "*/playbooks/*.yml",
      "*/playbooks/*.yaml",
      "*/roles/*/tasks/*.yml",
      "*/roles/*/tasks/*.yaml",
      "*/roles/*/handlers/*.yml",
      "*/roles/*/handlers/*.yaml",
      "*/tasks/*.yml",
      "*/tasks/*.yaml",
      "*/molecule/*.yml",
      "*/molecule/*.yaml",
    },
    callback = function()
      vim.bo.filetype = "yaml.ansible"
    end,
  })
end

