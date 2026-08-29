# Repository instructions for Codex

## Git and GitHub safety policy

Codex may modify files in the working tree as required for development tasks.

However, Codex MUST NOT perform any operation that writes to Git metadata,
changes Git history, changes refs, changes the Git index, modifies remotes,
or changes state on GitHub.

### Git operations that are allowed

Only read-only Git commands are allowed, for example:

- `git status`
- `git diff`
- `git diff --stat`
- `git log`
- `git show`
- `git branch --show-current`
- `git rev-parse`
- `git remote -v`

Read-only Git commands may be used to inspect the repository and review changes.

### Git operations that are forbidden

Do NOT run any Git command that modifies repository state.

This includes, but is not limited to:

- `git add`
- `git commit`
- `git commit --amend`
- `git merge`
- `git rebase`
- `git cherry-pick`
- `git revert`
- `git reset`
- `git restore`
- `git checkout`
- `git switch`
- `git stash`
- `git clean`
- `git tag`
- `git branch` when creating, deleting, or modifying branches
- `git fetch`
- `git pull`
- `git push`
- `git remote add`
- `git remote remove`
- `git remote set-url`
- `git config` when changing configuration
- any direct modification of files inside `.git/`

Do not stage files.

Do not create commits.

Do not amend commits.

Do not create, modify, move, or delete branches.

Do not create or delete tags.

Do not push anything to any remote.

Do not fetch or pull from remotes.

Do not alter Git history.

Do not attempt to leave the working tree clean by committing, resetting,
restoring, stashing, or discarding changes.

All modifications made by Codex must remain as uncommitted working-tree
changes for the user to inspect and handle manually.

## GitHub operations

GitHub must also be treated as read-only.

Do NOT perform actions that modify GitHub state, including but not limited to:

- creating or merging pull requests
- closing or reopening pull requests
- creating or modifying issues
- posting comments or reviews
- approving pull requests
- creating releases
- modifying releases
- deleting releases
- creating GitHub tags or refs
- modifying repository settings
- modifying branch protection or rulesets
- modifying labels, milestones, or projects
- uploading release assets
- triggering or re-running workflows if doing so changes remote state

Do not use `gh`, GitHub APIs, MCP tools, or any other mechanism to perform
write operations against GitHub.

Read-only inspection of GitHub information is allowed when needed.

## Releases

Codex MUST NOT create or modify releases.

In particular, Codex must not:

- create release tags
- create GitHub releases
- generate and publish releases
- upload release artifacts
- modify release notes on GitHub
- increment versions as part of a release operation unless the user explicitly
  asks only for a local source-file change

Release management is performed manually by the repository owner.

## End-of-task behavior

After completing a development task:

1. Run relevant tests and validation tools if appropriate.
2. Leave all source changes uncommitted.
3. Do not stage any files.
4. Do not commit.
5. Do not push.
6. Do not create a branch, tag, pull request, or release.
7. Report which files were changed.
8. Report which tests or validation commands were run.
9. Optionally show `git status` and/or `git diff --stat` for review.

The user is responsible for all Git and GitHub write operations.
