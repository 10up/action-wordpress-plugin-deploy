# Contributing and Maintaining

First, thank you for taking the time to contribute!

The following is a set of guidelines for contributors as well as information and instructions around our maintenance process. The two are closely tied together in terms of how we all work together and set expectations, so while you may not need to know everything in here to submit an issue or pull request, it's best to keep them in the same document.

## Ways to contribute

Contributing isn't just writing code - it's anything that improves the project. All contributions for our GitHub Actions for WordPress are managed right here on GitHub. Here are some ways you can help:

### Reporting bugs

If you're running into an issue with the action, please take a look through [existing issues](https://github.com/10up/action-wordpress-plugin-deploy/issues) and [open a new one](https://github.com/10up/action-wordpress-plugin-deploy/issues/new) if needed. If you're able, include a link to the log output from the failed run.

### Suggesting enhancements

New features and enhancements are also managed via [issues](https://github.com/10up/action-wordpress-plugin-deploy/issues).

### Pull requests

Pull requests represent a proposed solution to a specified problem. They should always reference an issue that describes the problem and contains discussion about the problem itself. Discussion on pull requests should be limited to the pull request itself, i.e. code review.

For more on how 10up writes and manages code, check out our [10up Engineering Best Practices](https://10up.github.io/Engineering-Best-Practices/).

## Workflow

This repository currently uses the `develop` branch to reflect active work and `stable` to represent the latest tagged release. Both should typically be usable and frequently the same, but we request that pull requests be opened against `develop` and usage of the action be against `stable` or a specific tag. New releases will be tagged as updates are made.

## Release instructions

1. Branch: Starting from `develop`, cut a release branch named `release/X.Y.Z` for your changes.
1. Changelog: Add/update the changelog in `CHANGELOG.md`. 
1. Props: update `CREDITS.md` file with any new contributors, confirm maintainers are accurate.
1. Readme updates: Make any other readme changes as necessary in `README.md`.
1. Merge: Make a non-fast-forward merge from your release branch to `develop` (or merge the pull request), then merge `develop` into `stable` (`git checkout stable && git merge --no-ff develop`).
1. Push: Push your stable branch to GitHub (e.g. `git push origin stable`).
1. Release: Create a [new release](https://github.com/10up/action-wordpress-plugin-deploy/releases/new), naming the tag and the release with the new version number, and targeting the `stable` branch. Paste the changelog from `CHANGELOG.md` into the body of the release and include a link to the closed issues on the [milestone](https://github.com/10up/action-wordpress-plugin-deploy/milestones/#?closed=1).  The release should now appear under [releases](https://github.com/10up/action-wordpress-plugin-deploy/releases).
1. Ensure it appears in the GitHub Marketplace correctly.
1. Close milestone: Edit the [milestone](https://github.com/10up/action-wordpress-plugin-deploy/milestones/) with release date (in the `Due date (optional)` field) and link to GitHub release (in the `Description field`), then close the milestone.
1. Punt incomplete items: If any open issues or PRs which were milestoned for `X.Y.Z` do not make it into the release, update their milestone to `X.Y.Z+1`, `X.Y+1.0`, `X+1.0.0` or `Future Release`.
1. Celebrate shipping!