# Vim Fugitive - Complete Guide

The **ultimate** Git wrapper for Vim/Neovim. Use Git without leaving your editor!

## 🎯 Quick Reference

### Your Custom Keymaps

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>gs` | `:Git` | Open Git status (main command) ⭐ |
| **In Fugitive Buffer:** | | |
| `<leader>p` | `:Git push` | Push to remote |
| `<leader>P` | `:Git pull --rebase` | Pull with rebase |
| `<leader>t` | `:Git push -u origin` | Set upstream branch |
| **In Merge Conflicts:** | | |
| `gu` | `diffget //2` | Get changes from left (ours) |
| `gh` | `diffget //3` | Get changes from right (theirs) |

---

## 📚 Core Commands

### **Git Status (The Main Interface)**

```vim
:Git                 " Or <leader>gs
```

This opens the **Git status window** - your command center!

#### **In the Status Window:**

| Key | Action | Example Use Case |
|-----|--------|------------------|
| `s` | **Stage file/hunk** | Stage changes under cursor |
| `u` | **Unstage file/hunk** | Unstage changes |
| `=` | **Toggle inline diff** | See changes without opening file |
| `>` | **Insert inline diff** | Add diff below |
| `<` | **Remove inline diff** | Collapse diff |
| `dd` | **:Git diff** | View full diff |
| `dv` | **:Gvdiffsplit** | Visual diff (3-way) |
| `-` | **Stage/unstage** | Quick toggle |
| `cc` | **Commit** | Opens commit message buffer |
| `ca` | **Commit --amend** | Amend last commit |
| `cw` | **Commit --amend (reword)** | Just change message |
| `X` | **Discard changes** | Careful! Removes changes |
| `gq` | **Close status** | Exit the window |
| `<CR>` | **Open file** | Jump to file under cursor |
| `o` | **Open in split** | Open file in horizontal split |
| `O` | **Open in tab** | Open file in new tab |

---

## 🔥 Essential Workflows

### **1. Stage, Commit, Push**

```vim
<leader>gs           " Open Git status
" Navigate to changed file
s                    " Stage file (or use visual mode to stage hunks)
cc                   " Commit (opens commit message buffer)
" Write commit message and :wq
<leader>p            " Push to remote
```

### **2. Review Changes Before Staging**

```vim
<leader>gs           " Open status
" Move cursor to file
=                    " Toggle inline diff
" Review changes
s                    " Stage if good
```

### **3. Partial Staging (Stage Hunks)**

```vim
<leader>gs           " Open status
" Navigate to file
=                    " Show inline diff
V                    " Visual line mode
" Select the hunk you want
s                    " Stage only selected lines
```

### **4. Commit --amend**

```vim
<leader>gs           " Open status
ca                   " Commit --amend (add to last commit)
" Or
cw                   " Just reword the message
```

### **5. Undo Staging**

```vim
<leader>gs           " Open status
" Navigate to staged file
u                    " Unstage
```

---

## 🔀 Merge Conflict Resolution

### **When You Have Conflicts:**

```vim
<leader>gs           " See conflicted files (marked with "UU")
dv                   " Open 3-way diff on conflicted file
```

#### **3-Way Diff Layout:**

```
┌──────────────┬──────────────┬──────────────┐
│   //2        │   Working    │   //3        │
│   (Ours)     │   File       │   (Theirs)   │
│   Target     │   (Result)   │   Merge      │
└──────────────┴──────────────┴──────────────┘
```

#### **Resolve Conflicts:**

| Key | Action | When to Use |
|-----|--------|-------------|
| `gu` | Get from left (//2 - ours) | Keep your changes |
| `gh` | Get from right (//3 - theirs) | Accept their changes |
| `]c` | Next conflict | Jump to next conflict |
| `[c` | Previous conflict | Jump to previous conflict |

**Workflow:**
1. Position cursor on conflict
2. Press `gu` (keep yours) or `gh` (take theirs)
3. Press `]c` to go to next conflict
4. Repeat until all resolved
5. `:wq` to save
6. Stage with `s` in Git status
7. `cc` to commit the merge

---

## 📖 Git Log & History

### **View Commit History**

```vim
:Git log                    " View log
:Git log --oneline         " Compact log
:Git log --graph           " Visual graph
:Git log -p                " Log with diffs
:Git log -- %              " Log for current file

" Or use short form
:G log
```

### **Navigate Log:**
- `<CR>` on a commit to see details
- `o` to open in split
- `q` to close

### **View File at Specific Commit**

```vim
:Gedit SHA               " Open file at commit SHA
:Gedit HEAD~3            " Open file 3 commits ago
:Gedit main:file.txt     " Open file from main branch
```

---

## 🌿 Branch Operations

### **Branch Commands**

```vim
:Git branch              " List branches
:Git branch new-feature  " Create branch
:Git checkout main       " Switch to branch
:Git checkout -b feat    " Create and switch

" Or shorter
:G branch
:G checkout -b feature/awesome
```

### **View Branches in Status**

```vim
<leader>gs              " Open status
" Top of window shows current branch
```

---

## 🔍 Blame & History

### **Git Blame (Line-by-Line History)**

```vim
:Git blame              " Show blame in split
" Or
:G blame

" In blame window:
```
- `<CR>` on a commit to see full commit
- `o` to open commit in split
- `q` to close blame

### **See Who Changed a Line:**

```vim
" Position cursor on line
:Git blame
" Shows commit SHA, author, date for that line
```

---

## 📝 Diff Commands

### **Compare Changes**

```vim
:Git diff                " Unstaged changes
:Git diff --staged       " Staged changes
:Git diff HEAD           " All changes
:Git diff main           " Compare with main branch

" Visual diff
:Gvdiffsplit            " 3-way diff
:Gvdiffsplit main       " Compare with main
```

### **In Diff Mode:**

| Command | Action |
|---------|--------|
| `]c` | Next change |
| `[c` | Previous change |
| `do` | Diff obtain (get changes from other file) |
| `dp` | Diff put (put changes to other file) |
| `:diffupdate` | Refresh diff |
| `:q` | Close diff window |

---

## 💡 Advanced Commands

### **Stash**

```vim
:Git stash              " Stash changes
:Git stash pop          " Apply and remove stash
:Git stash list         " List stashes
:Git stash apply        " Apply without removing
```

### **Reset**

```vim
:Git reset HEAD~1       " Undo last commit (keep changes)
:Git reset --hard HEAD~1  " Undo last commit (discard changes) ⚠️
:Git reset --soft HEAD~1  " Undo commit (keep staged)
```

### **Revert**

```vim
:Git revert SHA         " Create new commit undoing changes
```

### **Cherry-pick**

```vim
:Git cherry-pick SHA    " Apply commit from another branch
```

---

## 🎨 Tips & Tricks

### **1. Commit from Anywhere**

```vim
:Git commit            " Commit without opening status
:Git commit -a         " Stage all and commit
:Git commit --amend    " Amend last commit
```

### **2. Quick Status Check**

```vim
:G                     " Super short form!
```

### **3. Open GitHub/GitLab**

```vim
:GBrowse               " Open current file on GitHub (needs vim-rhubarb)
:GBrowse SHA           " Open commit on GitHub
```

### **4. Search Commits**

```vim
:Git log --grep="bug fix"     " Search commit messages
:Git log -S"function_name"    " Search for code changes
```

### **5. Interactive Rebase**

```vim
:Git rebase -i HEAD~3  " Interactive rebase last 3 commits
```

---

## 🚀 Pro Workflows

### **Workflow 1: Quick Commit**

```vim
<leader>gs    → =    → s    → cc    → <message>    → :wq    → <leader>p
(Status)      (Diff)  (Stage) (Commit)  (Write msg)   (Save)   (Push)
```

### **Workflow 2: Review & Stage Selectively**

```vim
<leader>gs              " Open status
" For each file:
=                       " View changes
V (select lines)        " Select good changes
s                       " Stage selection
X (on bad changes)      " Discard bad changes
cc                      " Commit when done
```

### **Workflow 3: Fix Merge Conflicts**

```vim
<leader>gs              " See conflicts
dv                      " 3-way diff
]c                      " Jump to conflict
gu or gh                " Resolve
]c                      " Next conflict
(repeat)
:wq                     " Save
s                       " Stage in status
cc                      " Commit merge
```

---

## ⚙️ Configuration Tips

Your current config already has great keymaps! Here are some optional additions:

```lua
-- Add to fugitive.lua if you want more keymaps:
vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit<CR>", { desc = "Git diff split" })
vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "Git log" })
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
```

---

## 🆘 Common Issues

### **"Not a git repository"**
Make sure you're in a git repo: `:!git status`

### **Commit buffer won't close**
Write and quit: `:wq` or `ZZ`

### **Can't stage partial hunks**
Use visual mode (`V`) to select lines, then `s`

### **Merge conflict markers still there**
After resolving, stage the file: `s` in git status

---

## 📚 Quick Reference Card

```vim
" Essential
<leader>gs        Git status (main hub)
s                 Stage
u                 Unstage  
cc                Commit
ca                Commit amend
X                 Discard changes
=                 Toggle diff

" Navigation
]c / [c           Next/prev change
<CR>              Open file
o                 Open in split

" Merge
dv                3-way diff
gu                Get ours (left)
gh                Get theirs (right)

" Push/Pull
<leader>p         Push
<leader>P         Pull --rebase
```

---

## 🎓 Learning Path

1. **Day 1:** Master `<leader>gs`, `s`, `cc`, `<leader>p`
2. **Day 2:** Learn `=` (inline diff) and selective staging
3. **Day 3:** Practice `:Git log` and `:Git blame`
4. **Day 4:** Master merge conflict resolution with `dv`, `gu`, `gh`
5. **Day 5:** Explore advanced commands (stash, rebase, etc.)

---

## 🔗 Resources

- `:help fugitive` - Built-in help
- [GitHub: tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
- Your config: `~/.config/nvim/lua/bertholdo/plugins/fugitive.lua`

---

**Remember:** The Git status window (`<leader>gs`) is your home base. Everything starts there! 🏠
