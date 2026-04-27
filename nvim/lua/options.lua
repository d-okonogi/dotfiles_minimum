-- lua/options.lua
-- Neovim の基本オプション設定

-----------------------------------------------------------
-- 基本設定
-----------------------------------------------------------
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileformats = { "unix", "dos", "mac" }

vim.opt.number = true -- 行番号を表示
vim.opt.relativenumber = true -- 相対行番号
vim.opt.cursorline = true -- カーソル行をハイライト
vim.opt.showmatch = true -- 括弧の対応を表示
vim.opt.termguicolors = true -- True Color 有効化
vim.opt.signcolumn = "yes" -- 常にサイン列を表示（gitsignsなど用）

vim.opt.wrap = false -- 行の折り返しを無効
vim.opt.scrolloff = 8 -- 上下に余白を確保
vim.opt.sidescrolloff = 8

vim.opt.tabstop = 4 -- タブ幅
vim.opt.shiftwidth = 4 -- 自動インデント時のスペース数
vim.opt.expandtab = true -- タブをスペースに変換
vim.opt.smartindent = true -- スマートインデント

vim.opt.ignorecase = true -- 検索時に大文字小文字を無視
vim.opt.smartcase = true -- ただし大文字を含むときは区別
vim.opt.incsearch = true -- 検索入力中にハイライト
vim.opt.hlsearch = true -- 検索結果をハイライト

vim.opt.clipboard = "unnamedplus" -- システムクリップボード共有
vim.opt.mouse = "a" -- マウス操作を有効化

vim.opt.updatetime = 250 -- CursorHold イベントの遅延を短縮
vim.opt.timeoutlen = 300 -- マッピングの待ち時間（短め）

vim.opt.splitbelow = true -- 横分割は下に開く
vim.opt.splitright = true -- 縦分割は右に開く

vim.opt.swapfile = false -- スワップファイルを作らない
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true -- 永続 undo

vim.opt.autoread = true -- 外部で変更されたファイルを自動読み込み

-----------------------------------------------------------
-- 表示関連
-----------------------------------------------------------
vim.opt.laststatus = 3 -- グローバルステータスライン
vim.opt.showmode = false -- モード表示を消す（lualineが代替）
vim.opt.cmdheight = 1 -- コマンドラインの高さ
vim.opt.pumheight = 10 -- 補完ポップアップの最大行数
vim.opt.conceallevel = 2 -- Markdownなどでのconceal動作
vim.opt.list = true -- 不可視文字を表示
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-----------------------------------------------------------
-- netrw 無効化（oil.nvim 用）
-----------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-----------------------------------------------------------
-- leader キー
-----------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-----------------------------------------------------------
-- UI改善オプション
-----------------------------------------------------------
-- 余白に表示する記号など
vim.opt.fillchars = {
    eob = " ", -- バッファ末尾の~を非表示
    fold = " ", -- 折りたたみ行のマーク
    diff = "╱", -- diff表示のマーク
}

-----------------------------------------------------------
-- 終了時に自動的に検索ハイライトを解除するコマンド
-----------------------------------------------------------
vim.cmd([[
  augroup clear_search_highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
  augroup END
]])
