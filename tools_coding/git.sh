#! /bin/sh

# 1. Base Configuration
# --system : all user(local machine)
# --golbal : current user
# --local  : current path
# --list   : show current cfg
git config --list
git config --global user.name "Dramalife"
git config --global user.email dramalife@live.com

# 2. Create an empty Git repository or reinitialize an existing one
#git init

# 3. Clone a respository
git clone https://github.com/Dramalife/note.git

# 4. Status
# Untracked files		git add <file>..."	  to include in what will be committed
#				git reset HEAD <file>..." to unstage
# Changes to be committed	git commit -m"xx" <file>  to commit
#				git commit -a 		  --all
# Changes not staged for commit:
#  	(use "git add <file>..." to update what will be committed)
#   	(use "git checkout -- <file>..." to discard changes in working directory)
#    	modified:   test2/test2.txt
# Your branch is ahead of 'origin/master' by 1 commit.(use "git push" to publish your local commits)

git status