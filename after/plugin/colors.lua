function ColorMyPencils(color)
	--    color = color or "borland"
	color = color or "xcodedarkhc"
	vim.cmd.colorscheme(color)
end

ColorMyPencils()
