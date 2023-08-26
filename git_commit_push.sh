#!/bin/bash

# Check for inputs, $# gives the number of arguments provided.
if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <branch name> <commit message>"
	exit 1
fi

branch_name="$1"
commit_message="$2"

# Check if cwd is a git repo.
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
	echo "Error: Not a git repository."
	exit 1
else
	git checkout "$branch_name"
fi

# Helper function to check the status of the git repo.
check_changes() {
	# Check if there are any changes to commit.
	if [ -z "$(git status --porcelain)" ]; then
		echo "No changes to commit."
		exit 1
	else
		echo "Found changes to commit."
	fi
}

# Helper function to commit and push changes.
commit_and_push() {
	# Add all changes to the commit.
	git add .
	# Commit the changes.
	git commit -m "$commit_message"
	# Push the changes to the remote repo.
	git push origin "$branch_name"
}

# Check for changes and commit and push.
check_changes
commit_and_push



