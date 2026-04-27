# Neovim 設定ドキュメント

## 概要

[lazy.nvim](https://github.com/folke/lazy.nvim) をプラグインマネージャーとして使用した Neovim 設定です。  
リーダーキーは **`<Space>`**、ローカルリーダーキーは **`,`** です。

---

## プラグイン一覧

| プラグイン | 役割 |
|---|---|
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP / ツールのインストール管理 |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | ツールの自動インストール |
| [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) | カラースキーム |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | タブ/バッファラインの UI 改善 |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | バッファ編集ベースのファイラー |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | シンタックスハイライト・パース |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | ファジーファインダー |
| [coc.nvim](https://github.com/neoclide/coc.nvim) | LSP クライアント・補完エンジン |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | コメントトグル |
| [black-nvim](https://github.com/averms/black-nvim) | Python フォーマッター (black) |

### Mason で自動インストールされるツール

`stylua` / `shfmt` / `black` / `pyright` / `clang-format` / `html-lsp` / `clangd`

### coc.nvim の自動インストール拡張

`coc-clangd` / `coc-json` / `coc-html` / `coc-emmet` / `coc-pyright`

---

## キーマップ

> `<leader>` = `<Space>`

### 一般操作

| モード | キー | 動作 |
|---|---|---|
| Normal / Visual / Operator | `0` | 行の最初の非空白文字へ移動（カウント指定時は絶対行頭の col 0 へ） |
| Normal / Visual / Operator | `<leader>0` | 絶対行頭（col 0）へ移動 |
| Normal / Insert / Command | `<C-a>` | 行頭へ移動 |
| Normal / Insert / Command | `<C-e>` | 行末へ移動 |
| Insert | `jj` | ノーマルモードへ戻る（`<Esc>` と同等） |

### タブ操作

| モード | キー | 動作 |
|---|---|---|
| Normal | `<leader>l` | 次のタブへ移動 |
| Normal | `<leader>h` | 前のタブへ移動 |

### コメント（Comment.nvim）

| モード | キー | 動作 |
|---|---|---|
| Normal / Insert | `<leader>/` | 現在行のコメントをトグル |
| Visual | `<leader>/` | 選択範囲のコメントをトグル（行コメント） |

### ファイラー（oil.nvim）

`<leader>e` でフローティングウィンドウを開いたあと、以下のキーが使えます。

| モード | キー | 動作 |
|---|---|---|
| Normal | `<leader>e` | Oil をフローティングウィンドウで開く / 閉じる |
| Oil 内 | `<C-h>` | 親ディレクトリへ移動 |
| Oil 内 | `<leader>\|` | 選択ファイルを垂直分割で開く |
| Oil 内 | `<leader>-` | 選択ファイルを水平分割で開く |
| Oil 内 | `<leader>t` | 選択ファイルを新しいタブで開く |
| Oil 内 | `<C-r>` | ディレクトリ表示を更新 |
| Oil 内 | `q` | Oil を閉じる |

> Oil はバッファとして扱えるファイラーです。ファイル名を直接編集して `:w` することでリネームや移動ができます。

### LSP / 補完（coc.nvim）

#### 補完ポップアップが表示されているとき（Insert モード）

| キー | 動作 |
|---|---|
| `<Tab>` | 次の補完候補へ移動 |
| `<CR>` | 選択中の補完候補を確定 |

#### コード参照 / ナビゲーション（Normal モード）

| キー | 動作 |
|---|---|
| `gd` | カーソル下のシンボルの **定義** へジャンプ |
| `gy` | カーソル下のシンボルの **型定義** へジャンプ |
| `gi` | カーソル下のシンボルの **実装** へジャンプ |
| `gr` | カーソル下のシンボルの **参照一覧** を表示 |
| `K` | カーソル下のシンボルの **ドキュメント** をフローティングウィンドウで表示 |

---

## 自動フォーマット（保存時）

ファイル保存（`BufWritePre`）時に対応するフォーマッターが自動実行されます。

| ファイル種別 | フォーマッター | 備考 |
|---|---|---|
| `*.py` | `black` | `--quiet` オプション |
| `*.sh` / `*.bash` / `*.zsh` | `shfmt` | インデント 2 スペース |
| `*.lua` | `stylua` | |
| `*.html` / `*.htm` | `tidy` | インデント 2 スペース |
| `*.c` / `*.h` / `*.cpp` / `*.hpp` | `clang-format` | |

フォーマッターが見つからない場合はエラーメッセージが通知されます。

### その他の保存時フック

- **ディレクトリの自動作成**: 保存先ディレクトリが存在しない場合、自動的に作成します。
- **タブ→スペース変換**: Makefile 以外のファイルで `:retab` を自動実行します。

---

## 主なオプション

| オプション | 値 | 説明 |
|---|---|---|
| `number` / `relativenumber` | on | 行番号・相対行番号の表示 |
| `tabstop` / `shiftwidth` | 4 | タブ幅・インデント幅 |
| `expandtab` | on | タブをスペースに変換 |
| `clipboard` | `unnamedplus` | システムクリップボードと共有 |
| `undofile` | on | セッションをまたいだ undo 履歴 |
| `wrap` | off | 行折り返しを無効 |
| `scrolloff` | 8 | スクロール時の上下余白 |
| `ignorecase` + `smartcase` | on | 検索の大文字小文字: 通常は無視、大文字混じりは区別 |
| `splitbelow` / `splitright` | on | 分割は下・右に開く |
| `swapfile` | off | スワップファイルを作成しない |
| `mouse` | `a` | 全モードでマウス操作を有効 |

### カラースキーム

[nightfox](https://github.com/EdenEast/nightfox.nvim) を使用します。読み込めない場合はデフォルトのダークテーマにフォールバックします。
