# Fugitive Cheatsheet - Quick Reference

## Your Keymaps
```vim
<leader>gs    Git status (START HERE!)
<leader>p     Push
<leader>P     Pull --rebase
<leader>t     Push -u origin (set upstream)
gu            Get ours (merge conflicts)
gh            Get theirs (merge conflicts)
```

## In Git Status Window

### Basic Operations
```
s         Stage file/hunk
u         Unstage
-         Toggle stage/unstage
cc        Commit
ca        Commit --amend
X         Discard changes (careful!)
=         Toggle inline diff
<CR>      Open file
gq        Close status
```

### Navigation
```
j/k       Move up/down
]c        Next change
[c        Previous change
```

## Common Workflows

### Quick Commit & Push
```vim
<leader>gs    " Status
s             " Stage
cc            " Commit
" Write message, :wq
<leader>p     " Push
```

### Selective Staging
```vim
<leader>gs    " Status
=             " Show diff
V             " Visual select
s             " Stage selection
```

### Merge Conflicts
```vim
<leader>gs    " Status
dv            " 3-way diff
gu / gh       " Get ours/theirs
]c            " Next conflict
:wq           " Save
s             " Stage resolved file
cc            " Commit
```

## Essential Commands
```vim
:Git                " Or just :G
:Git log            " History
:Git blame          " Who changed what
:Git diff           " See changes
:Gvdiffsplit        " Visual diff
:Git stash          " Stash changes
:Git branch         " List branches
```

## Diff Mode
```
]c        Next change
[c        Previous change
do        Diff obtain (get from other)
dp        Diff put (put to other)
```

## Pro Tips
- Start every git operation with `<leader>gs`
- Use `=` to preview changes before staging
- Visual select (`V`) + `s` for partial staging
- `cc` opens commit buffer - write msg and `:wq`
- In merge conflicts: `gu` = yours, `gh` = theirs

## Full Guide
See: `~/.config/nvim/FUGITIVE_GUIDE.md`
