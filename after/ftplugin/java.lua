local ok, jdtls = pcall(require, "bertholdo.configs.jdtls")
if ok then
	jdtls.start_or_attach(0)
end
