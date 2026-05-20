---
name: stack-pr-on-worktree
description: 既存 worktree のブランチを親として、現ブランチを stacked PR の土台になる位置に rebase する
---

引数: `<parent-branch>` (必須) — 親にしたい既存 worktree のブランチ名

現在のブランチを `$ARGUMENTS` の上に rebase し、stacked PR を作れる位置に整える。
**commit / push / PR 作成は行わない**。土台作りまで。

## 前提

- 現在 git worktree の中にいる
- `$ARGUMENTS` が別の worktree で checkout 済み
- 親 worktree 側は clean、現 worktree も rebase 可能な状態

## 手順

### 1. 引数バリデーション

`$ARGUMENTS` が空、または存在しないブランチならエラーで止めてユーザーに尋ねる。

### 2. 状態収集 (Bash 並列)

- `git worktree list` で親ブランチの checkout パスを特定
- `git fetch origin` で最新 ref を取得
- `git rev-parse origin/<base-branch> <parent-branch>` (base-branch は通常 `develop`、リポジトリにより異なるなら `gh repo view --json defaultBranchRef -q .defaultBranchRef.name` 等で取得)
- `git merge-base origin/<base-branch> <parent-branch>` で先行差分を確認
- 親 worktree パスで `git -C <path> status --short` (clean か)
- 現 worktree で `git status --short` (clean か、または rebase 可能か)

親ブランチが別 worktree で checkout されていなかった、または現 worktree がダーティな場合は止めてユーザーに対処を仰ぐ。

### 3. 親ブランチを base に rebase するか確認

`merge-base(origin/<base-branch>, <parent-branch>) == origin/<base-branch>` なら親ブランチは tip に乗っている → スキップ。

ずれている場合、ユーザーに **「親ブランチ `<parent-branch>` を origin/<base-branch> に rebase するか？」** を必ず確認する。

- Yes → 親 worktree のパスで `git -C <親worktreeパス> rebase origin/<base-branch>` を実行。conflict が出たら停止して報告。
- No → 現状の親ブランチ tip にそのまま乗せる。

### 4. 現ブランチを親ブランチに rebase

```bash
git rebase <parent-branch>
```

conflict が出たら停止してユーザーに報告。自動解決は試みない。

### 5. upstream 罠の事前解消

```bash
git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null
```

upstream が現ブランチ名 (`origin/<current-branch>`) 以外を指している場合 (典型例: `origin/develop` を継承している) 、`git branch --unset-upstream` を実行する。

理由: そのまま `git push -u origin <current-branch>` を打つと refspec が `<current-branch> -> develop` に解釈され、protected branch hook に拒否される罠がある。これを事前に潰しておく。

### 6. 完了報告

以下を簡潔に出力する。

- 現在の HEAD コミット / 親ブランチ tip / origin/<base-branch> tip の関係 (3点を1行ずつ)
- 親ブランチに依存変更が含まれる場合は手動で install / codegen が必要な旨を一言添える
- stacked PR を作る時は **base に `<parent-branch>` を指定する** こと
- push する時は `git push -u origin <current-branch>:<current-branch>` の **同名 refspec** を使うこと (upstream を解除しているので)

## やってはいけないこと

- 親ブランチの rebase を確認なしに実行する (親 worktree 側のローカル状態を勝手に動かさない)
- 親 worktree に uncommitted changes があるのに rebase を強行する
- 現 worktree に uncommitted changes があるのに rebase を強行する
- conflict が発生したのに自動解決を試みる (止めて報告)
- commit / push / PR 作成まで進める (skill のスコープ外)
- `git push --force` を skill 内で実行する
