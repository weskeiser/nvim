vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.opt.mouse = ""


vim.opt.history = 1000
vim.opt.termguicolors = true
vim.g.mkdp_browser = "/bin/firefox-developer-edition"
vim.opt.swapfile = false
vim.opt.undodir = table.concat({ os.getenv("HOME"), "/.nvim/undodir" })
vim.opt.undofile = true
vim.opt.updatetime = 50

vim.opt.diffopt:append("linematch:60")
vim.opt.shortmess:append("csI")

vim.opt.splitright = true
vim.opt.equalalways = true

vim.opt.showcmdloc = "tabline"
vim.opt.cmdheight = 1

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 99
vim.opt.sidescrolloff = 5

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.smartindent = true
vim.opt.breakindent = true

-- vim.opt.wrapmargin = 2
vim.opt.linebreak = true
vim.opt.breakindent = true
-- vim.opt.textwidth = 100 -- wrapmargin preferred instead

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4 -- keep at default

vim.opt.matchpairs:append({ "<:>" })
vim.g.matchparen_timeout = 20

vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes:1"
vim.opt.showbreak = "↳"
vim.opt.cpoptions:append("_m")
vim.opt.fillchars = {
    diff = "·",
    fold = " ",
    foldopen = "࿈",
    foldsep = "│",
    foldclose = "➟",
    eob = " ",
}

vim.opt.listchars:append({ eol = "↳" })

-- vim.opt.formatoptions:append("tcqrnlv")
-- vim.opt.virtualedit = "all"
-- vim.opt.startofline = true
-- vim.opt.sessionoptions = "blank,curdir,help,tabpages,winsize,resize,terminal"

function _G.Pct_thr()
    local v = vim.v

    if v.virtnum > 0 then return "" end

    local fn                        = vim.fn
    local topmost_line_nr           = fn.line("w0")
    local cursor_line, total_lines  = fn.line("."), fn.line("$")

    local page_height               = vim.fn.winheight(0);
    local visible_lines_scaled_half = (total_lines / page_height) / 2
    local fraction_thr              = total_lines / cursor_line
    local curr_lnum_scaled          = topmost_line_nr + math.floor(page_height / fraction_thr)

    if v.lnum < (curr_lnum_scaled - visible_lines_scaled_half) or v.lnum > (curr_lnum_scaled + visible_lines_scaled_half) then
        return "  "
    end

    return "%#ScrollBar#⫸ %*"
end

function _G.StatusNumbers()
    local v = vim.v

    if v.virtnum > 0 then
        return ""
    end

    if v.relnum == 0 then
        -- return table.concat({ v.lnum, "%#LineNrIcon#🭮 🭬" })
        return table.concat({ v.lnum, "%#LineNrIcon# ⫸" })
        -- return table.concat({ v.lnum, " %#CLineCurr#🭬" })
    end

    if v.lnum == vim.fn.line("w$") then
        local lines_below = vim.fn.line("$") - vim.fn.line("w$")
        if lines_below > 0 then
            return lines_below
        end
    elseif v.lnum == vim.fn.line("w0") then
        local lines_above = vim.fn.line("w0") - 1
        if lines_above > 0 then return lines_above end
    end

    if v.relnum % 5 == 0 then
        if v.relnum % 10 == 0 then
            if v.relnum == 10 then
                return "├───"
            end
            if v.relnum == 20 then
                return "├┼──"
            end
            if v.relnum == 30 then
                return "├┼┼─"
            end
            if v.relnum == 10 then
                return "├┼┼┼"
            end

            return "────"
        end

        return "╶──"
    end

    return "╶"
end

-- vim.opt.statuscolumn = "%{%v:lua.Pct_thr()%}%#SignColumn#%s%=%{%v:lua.StatusNumbers()%}%#None# "
vim.opt.statuscolumn = "%{%v:lua.Pct_thr()%}%=%{%v:lua.StatusNumbers()%}%#None#%s"

-- return "🮥 "
-- 🭨 🭨 🮊▶ 🮚 🭨▶

-- vim.opt.pumblend = 0

vim.opt.foldenable = false
-- vim.opt.foldopen:remove("hor")
-- vim.opt.foldlevel = 99
-- vim.opt.foldmethod = "expr"
-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- foldcodumn auto produces lag
-- vim.opt.foldcolumn = "5"
--
-- vim.opt.foldminlines = 2
-- vim.opt.foldlevelstart = 0 -- causes refresh on bufenter
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- vim.opt.redrawtime = 100
-- vim.g.loaded_matchparen = 1
-- vim.opt.columns = 80
-- vim.opt.breakindentopt = "shift:8"
-- vim.opt.viewoptions:remove("options")
-- vim.opt.colorcolumn = "80"
