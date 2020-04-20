#!/bin/bash

# Note that this does not use pipefail
# because if the grep later doesn't match any deleted files,
# which is likely the majority case,
# it does not exit with a 0, and I only care about the final exit.
set -eo

# Ensure SVN username and password are set
# IMPORTANT: while secrets are encrypted and not viewable in the GitHub UI,
# they are by necessity provided as plaintext in the context of the Action,
# so do not echo or use debug mode unless you want your secrets exposed!
if [[ -z "$SVN_USERNAME" ]]; then
	echo "Set the SVN_USERNAME secret"
	exit 1
fi

if [[ -z "$SVN_PASSWORD" ]]; then
	echo "Set the SVN_PASSWORD secret"
	exit 1
fi

# Allow some ENV variables to be customized
if [[ -z "$SLUG" ]]; then
	SLUG=${GITHUB_REPOSITORY#*/}
fi
echo "ℹ︎ SLUG is $SLUG"

if [[ -z "$ASSETS_DIR" ]]; then
	ASSETS_DIR=".wordpress-org"
fi
echo "ℹ︎ ASSETS_DIR is $ASSETS_DIR"

	WORKSPACE_DIR="./wp-staging-svn/trunk/"

echo "ℹ︎ WORKSPACE_DIR is $WORKSPACE_DIR"

echo "ℹ︎ GITHUB_WORKSPACE is $GITHUB_WORKSPACE"

echo "List content of workspace:"
ls /github/workspace

echo "List content of current dir:"
ls ./

echo "List content of WORKSPACE_DIR:"
ls $WORKSPACE_DIR

echo "cd WORKSPACE_DIR:"
cd $WORKSPACE_DIR

SVN_URL="https://plugins.svn.wordpress.org/${SLUG}/"
SVN_DIR="/github/svn-${SLUG}"

# Checkout just trunk and assets for efficiency
# Tagging will be handled on the SVN level
echo "➤ Checking out .org repository..."
svn checkout --depth immediates "$SVN_URL" "$SVN_DIR"
cd "$SVN_DIR"
svn update --set-depth infinity assets
svn update --set-depth infinity trunk

echo "➤ Copying files..."
if [[ -e "$WORKSPACE_DIR/.distignore" ]]; then
	echo "ℹ︎ Using .distignore"
	# Copy from current branch to /trunk, excluding dotorg assets
	# The --delete flag will delete anything in destination that no longer exists in source
	rsync -rc --exclude-from="$WORKSPACE_DIR/.distignore" "$WORKSPACE_DIR/" trunk/ --delete --delete-excluded 
	echo "ls trunk:"
	ls trunk
else
	echo "ℹ︎ Using .gitattributes"

	cd "$WORKSPACE_DIR"

	# "Export" a cleaned copy to a temp directory
	TMP_DIR="/github/archivetmp"
	mkdir "$TMP_DIR"

	git config --global user.email "10upbot+github@10up.com"
	git config --global user.name "10upbot on GitHub"

	# If there's no .gitattributes file, write a default one into place
	if [[ ! -e "$10up.com/.gitattributes" ]]; then
		cat > "$10up.com/.gitattributes" <<-EOL
		/$ASSETS_DIR export-ignore
		/.gitattributes export-ignore
		/.gitignore export-ignore
		/.github export-ignore
		EOL

		# Ensure we are in the $10up.com directory, just in case
		# The .gitattributes file has to be committed to be used
		# Just don't push it to the origin repo :)
		git add .gitattributes && git commit -m "Add .gitattributes file"
	fi

	# This will exclude everything in the .gitattributes file with the export-ignore flag
	git archive HEAD | tar x --directory="$TMP_DIR"

	cd "$SVN_DIR"

	# Copy from clean copy to /trunk, excluding dotorg assets
	# The --delete flag will delete anything in destination that no longer exists in source
	rsync -rc "$TMP_DIR/" trunk/ --delete --delete-excluded
	echo "ls trunk 2:"
	ls trunk
fi

# Copy dotorg assets to /assets
if [[ -d "$GITHUB_WORKSPACE/$ASSETS_DIR/" ]]; then
	rsync -rc "$GITHUB_WORKSPACE/$ASSETS_DIR/" assets/ --delete
else
	echo "ℹ︎ No assets directory found; skipping asset copy"
fi

# Add everything and commit to SVN
# The force flag ensures we recurse into subdirectories even if they are already added
# Suppress stdout in favor of svn status later for readability
echo "➤ Preparing files..."
#svn add . --force > /dev/null

# SVN delete all deleted files
# Also suppress stdout here
#svn status | grep '^\!' | sed 's/! *//' | xargs -I% svn rm %@ > /dev/null

# Copy tag locally to make this a single commit
echo "➤ Copying tag..."
svn cp "trunk" "tags/$VERSION"

echo "List folder tags/$VERSION"
ls ./tags/$VERSION

svn status

echo "➤ Committing files..."
#svn commit -m "Update to version $VERSION from GitHub" --no-auth-cache --non-interactive  --username "$SVN_USERNAME" --password "$SVN_PASSWORD"

echo "✓ Plugin deployed!"
