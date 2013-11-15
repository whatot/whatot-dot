# Advanced Git

## Working with subtree merge

[github subtree](https://help.github.com/articles/working-with-subtree-merge)

[kernel.org - How to use the subtree merge strategy](https://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html)

In this example, let’s say you have the repository at ``/path/to/B`` (but it can be a URL as well, if you want). You want to merge the ``master`` branch of that repository to the ``dir-B`` subdirectory in your current branch.

Here is the command sequence you need:

	$ git remote add -f Bproject /path/to/B <1>
	$ git merge -s ours --no-commit Bproject/master <2>
	$ git read-tree --prefix=dir-B/ -u Bproject/master <3>
	$ git commit -m "Merge B project as our subdirectory" <4>

	$ git pull -s subtree Bproject master <5>

1. name the other project "Bproject", and fetch.
2. prepare for the later step to record the result as a merge.
3. read "master" branch of Bproject to the subdirectory "dir-B".
4. record the merge result.
5. maintain the result with subsequent merges using "subtree"

The first four commands are used for the initial merge, while the last one is to merge updates from B project.



## Getting up speed with Git


### A scratchpad of ideas

In the previous chapters, all basic topics were convered. Git has many command options, and in this final page some of those are listed.

Feel free to pick only a few to improve your workflow.

### Tricks by category

1.  Adding files

	git add -u              # add all updated files
	git add .               # add all files in the current folder only
	git add -n              # see what will be added (--dry-run)

2. Removing files

	git rm --cached         # remove a file from git without deleting it
	git clean               # remove untracked files

3. Committing

	git commit --author=".."  # commit a patch with correct author
	git commit -v            # show the diff within the commit message editor
	git commit --amend       # fix a previous commit (only if not pushed!)

	git commit -c commit      # use an old commit message (--reedit-message=...)

4. Branches

	git branch -a               # view all branches
	git branch -r               # view remote branches
	git branch --merged         # view branches which are merged into the current
	git branch --no-merged      # view branches which are not merged into the current

	git branch name commit       # create a branch with different start point

	git checkout -b branch       # create a branch, and switch to it
	git checkout -t origin/name   # quickly start working from a remote branch

	git checkout -              # switch to the previous branch (like cd -)

5. Diffs

	git diff .                 # show diffs of the current folder only
	git diff --stat            # show a diffstat
	git diff --name-status     # show filename + status like svn

	git diff --diff-filter=R   # show renamed files only

	git show commit             # show one commit
	git show v2.6.15:a.txt       # show old version of a file

6. Logging

	git log --decorate                  # show branch/tag labels
	git log -p -C                       # show patches, detect file renames
	git log --name-status               # show filename + status like svn

	git log --stat                      # show a diffstat for each commit
	git log --all --graph --decorate    # show all branches in a graph

	git log --simplify-by-decoration    # show branch start points only
	git log --no-merges                 # hide merge commits

	git log --oneline --name-only from^..to  # show changed files per commit

	git log --format='%h %an %ar - %s'  # timeline with x days ago, etc...

	git log origin/master..HEAD         # show new changes in HEAD, not found in origin/master
	git log HEAD..origin/master         # show newly fetched changes (HEAD can be omitted)

	git shortlog ..origin/master        # summarize fetched changes
	git shortlog -n 10                  # summarize last 10 commits
	git shortlog -n 10 -s               # show authors of last 10 commits

	git blame file                       # find who changed which line
	git blame -C file                    # detect lines which are moved or copied between files

7. Undoing changes

	git checkout -- file          # discard all changes of a file
	git checkout --patch -- file  # discard parts of a file
	git checkout commit -- file    # extract an old file version

	git revert                    # make a commit which reverts something

	git reset HEAD                # unstage something (uses --mixed)
	git reset --hard HEAD         # discard all local changes

8. Rewriting history

	git commit --amend            # correct the previous commit, with the staged changes

	git reset HEAD^               # forget about a commit, load it back into the staging area
	git reset --soft HEAD^        # remove a commit, keep staged and working changes
	git reset --hard HEAD^        # remove a commit, delete working copy changes and staged changes

	git reset --hard ORIG_HEAD    # forget about a merge or rebase, get back to the old HEAD

	git rebase -i origin/master   # rewrite history of new commits

9. Patch files

	git format-patch -o outputdir from..to    # export each commit as patch file

	git apply patchfile            # apply a patch to the working tree
	git am *.patch                 # apply patches from mbox files
	git am maildir/                # apply patches from a maildir

10. Searching

	git grep                  # search through tracked files
	git grep -p               # show function name (--show-function)
	git grep v2.6.15 "foo()"    # search old tree for "foo()"

	git log -Stext             # search through all commits for a changed text

	git bisect                # find which revision contains a bug (see 1, 2)

11. Shares repositories

	git clone --bare dir1 dir2   # convert a repository to a "bare" repository

	git remote add aliasname url  # add a remote repository

	git push origin master        # push master branch
	git push origin master:master  # the same
	git push origin :branch       # delete remote branch
	git push origin :            # push matching branches (the default)
	git push -f                 # force overwriting remote changes (careful!)

12. Stashes

>Stash implementation detail
>    Note that the git stash save works internally by creating a temporary branch. This is visible in the output of git log --all.

	git stash branch branchname   # make a new branch, apply the stash there

13. Listing files

	git ls-files --others        # show untracked files
	git ls-files --deleted       # show deleted files
	git ls-files --unmerged      # show unmerged files

14. Making releases

	git archive --format=tar --prefix=myproject-2.0 v2.0 \
	| gzip > mycode-2.0.tar.gz    # export the tag v2.0 as archive

	git tag                       # list all tags
	git tag name                  # create a light tag (just a reference)
	git tag -a name               # create a annotated tag (with message)
	git tag -s name               # create a GPG signed tag, with message
	git tag -d name               # delete tag

	git push --tags               # push tags

15. Useful aliases

Here is an overview of all aliases, including those used in the previous pages:

	# for convenience:
	git config --global  alias.st           "status"
	git config --global  alias.staged       "diff --staged"
	git config --global  alias.unstage      "reset HEAD"
	git config --global  alias.up           "pull --rebase"

	# memnonics
	git config --global  alias.diff-all     "diff HEAD"

	# nice output info:
	git config --global  alias.log-graph    "log --all --graph --decorate"
	git config --global  alias.log-refs     "log --all --graph --decorate --oneline --simplify-by-decoration --no-merges"
	git config --global  alias.log-timeline "log --format='%h %an %ar - %s'"
	git config --global  alias.diff-stat    "diff -b --stat"

	# finding new commits:
	git config --global  alias.log-local    "log --oneline origin..HEAD"
	git config --global  alias.log-fetched  "log --oneline HEAD..origin/master"

16. Referencing commits

* More referencing syntax

    The rev-parse manual provides more obscure syntax notations, including:

    HEAD@{date} select a date.
    HEAD@{1.month.ago} starts a month ago.
    :/str commit message starting with str.

* Branch names

The name HEAD always points to your current location; e.g. the last commit of your current branch. Remote locations are written in the form location/branch, for example origin/master.

* Visiting parents

A parent commit can be referenced by HEAD^, the grantparent is HEAD^^ or HEAD~2.

When a commit has two parents, HEAD^2 selects the second one.

* Previous values

The syntax HEAD@{1} refers to the previous value of HEAD. This is used by the reflog.

* Ranges

The syntax first..second takes all commits which lead to second, except those which lead to first. It's the same as: ^first second. Likewise, first^..second takes all commits which lead to second, except those with lead to the parent of first; theirby including first.

The syntax first...second takes all commits from both branches, except those from the common branch point.

