# Changelog

All notable changes to this project will be documented in this file, per [the Keep a Changelog standard](http://keepachangelog.com/).

## [Unreleased] - TBD

## [1.4.1] - 2020-03-12
### Fixed
- Ensure previously committed files that are later added to `.distignore` get deleted. Props [@pascalknecht](https://github.com/pascalknecht) via [#26](https://github.com/10up/action-wordpress-plugin-deploy/pull/26).
- Escape filenames to avoid errors with filenames containing an `@` symbol. Props [@Gaya](https://github.com/Gaya) via [#22](https://github.com/10up/action-wordpress-plugin-deploy/pull/22).
- Use parameter expansion instead of `sed` to remove `v` from version numbers. Props [@szepeviktor](https://github.com/szepeviktor) via [#24](https://github.com/10up/action-wordpress-plugin-deploy/pull/24).
- Use `https` for WordPress.org URLs. Props [@dinhtungdu](https://github.com/dinhtungdu) via [#28](https://github.com/10up/action-wordpress-plugin-deploy/pull/28).
- Correct encrypted secrets documentation link. Props [@felipeelia](https://github.com/felipeelia) via [#20](https://github.com/10up/action-wordpress-plugin-deploy/pull/20).

## [1.4.0] - 2019-10-21
### Added
- Strip leading `v` off of tag name if present, as it is remains common practice with Git tags.

### Fixed
- Avoid failure if no assets directory exists.

## [1.3.0] - 2019-08-30
### Added
- Added the ability to use `.distignore` to exclude files from deployment instead of `.gitattributes`, which works better when a build step is included. Props [@LeoColomb](https://github.com/LeoColomb) via [#3](https://github.com/10up/action-wordpress-plugin-deploy/pull/3), with additional thanks to [@markjaquith](https://github.com/markjaquith) for consultation.

### Changed
- Removed unnecessary `GITHUB_TOKEN` check/requirement.

## [1.2.1] - 2019-08-22
### Fixed
- Use more robust method of copying files (`-c` flag for `rsync`).

[Unreleased]: https://github.com/10up/action-wordpress-plugin-deploy/compare/master...develop
[1.4.1]: https://github.com/10up/action-wordpress-plugin-deploy/compare/1.4.0...1.4.1
[1.4.0]: https://github.com/10up/action-wordpress-plugin-deploy/compare/1.3.0...1.4.0
[1.3.0]: https://github.com/10up/action-wordpress-plugin-deploy/compare/1.2.1...1.3.0
[1.2.1]: https://github.com/10up/action-wordpress-plugin-deploy/compare/03e175e...d2b6608
