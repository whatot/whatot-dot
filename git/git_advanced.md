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

## 
