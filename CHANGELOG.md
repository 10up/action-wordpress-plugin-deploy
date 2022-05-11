# Changelog

All notable changes to this project will be documented in this file, per [the Keep a Changelog standard](http://keepachangelog.com/).

## [Unreleased] - TBD


## [2.1.0] - 2022-04-12
### Added
- Mime type change to `image/gif` for `.gif` files (props [@doekenorg](https://github.com/doekenorg) via [#76](https://github.com/10up/action-wordpress-plugin-deploy/pull/76)).
- Environment variable (`BUILD_DIR`) to deploy plugin files built into a custom directory (props [@dinhtungdu](https://github.com/dinhtungdu) via [#83](https://github.com/10up/action-wordpress-plugin-deploy/pull/83) and [#86](https://github.com/10up/action-wordpress-plugin-deploy/pull/86)).

### Fixed
- Set correct mime type for for `.svg` files (props [@andrewheberle](https://github.com/andrewheberle) via [#78](https://github.com/10up/action-wordpress-plugin-deploy/pull/78)).
- SVN error when plugin doesn't have an image (props [@Lewiscowles1986](https://github.com/Lewiscowles1986) via [#82](https://github.com/10up/action-wordpress-plugin-deploy/pull/82)).

## [2.0.0] - 2021-08-16
This is now a composite Action, meaning that it runs directly on the GitHub Actions runner rather than spinning up its own container and is significantly faster.

### Added
- Add `zip-path` output, as the `SLUG` may not match the repository name (props [@ocean90](https://github.com/ocean90) via [#74](https://github.com/10up/action-wordpress-plugin-deploy/pull/74)).

### Fixed
- Avoid a Debian image issue where the container could not be built (props [@helen](https://github.com/helen) via [#74](https://github.com/10up/action-wordpress-plugin-deploy/pull/74)).

## [1.5.0] - 2020-05-27
### Added
- Add optional ZIP file generation from SVN trunk to match content on WordPress.org (props [@shivapoudel](https://github.com/shivapoudel) via [#37](https://github.com/10up/action-wordpress-plugin-deploy/pull/37)).
- Add example workflow file to attach the ZIP file to a GitHub release (props [@helen](https://github.com/helen) via [#42](https://github.com/10up/action-wordpress-plugin-deploy/pull/42)).
- Set mime types on images in the SVN `assets` directory to prevent forced downloads on WordPress.org (props [@nextgenthemes](https://github.com/nextgenthemes) via [#40](https://github.com/10up/action-wordpress-plugin-deploy/pull/40)).

## [1.4.1] - 2020-03-12
### Fixed
- Ensure previously committed files that are later added to `.distignore` get deleted (props [@pascalknecht](https://github.com/pascalknecht) via [#26](https://github.com/10up/action-wordpress-plugin-deploy/pull/26)).
- Escape filenames to avoid errors with filenames containing an `@` symbol (props [@Gaya](https://github.com/Gaya) via [#22](https://github.com/10up/action-wordpress-plugin-deploy/pull/22)).
- Use parameter expansion instead of `sed` to remove `v` from version numbers (props [@szepeviktor](https://github.com/szepeviktor) via [#24](https://github.com/10up/action-wordpress-plugin-deploy/pull/24)).
- Use `https` for WordPress.org URLs (props [@dinhtungdu](https://github.com/dinhtungdu) via [#28](https://github.com/10up/action-wordpress-plugin-deploy/pull/28)).
- Correct encrypted secrets documentation link (props [@felipeelia](https://github.com/felipeelia) via [#20](https://github.com/10up/action-wordpress-plugin-deploy/pull/20)).

## [1.4.0] - 2019-10-21
### Added
- Strip leading `v` off of tag name if present, as it is remains common practice with Git tags.

### Fixed
- Avoid failure if no assets directory exists.

## [1.3.0] - 2019-08-30
### Added
- Added the ability to use `.distignore` to exclude files from deployment instead of `.gitattributes`, which works better when a build step is included (props [@LeoColomb](https://github.com/LeoColomb) via [#3](https://github.com/10up/action-wordpress-plugin-deploy/pull/3), with additional thanks to [@markjaquith](https://github.com/markjaquith) for consultation).

### Changed
- Removed unnecessary `GITHUB_TOKEN` check/requirement.

## [1.2.1] - 2019-08-22
### Fixed
- Use more robust method of copying files (`-c` flag for `rsync`).

[Unreleased]: https://github.com/10up/action-wordpress-plugin-deploy/compare/stable...develop
[2.1.0]: https://github.com/10up/action-wordpress-plugin-deploy/compare/2.0.0...2.1.0
[2.0.0]: https://github.com/10up/action-wordpress-plugin-deploy/compare/1.5.0...2.0.0
[1.5.0]: https://github.com/10up/action-wordpress-plugin-deploy/compare/1.4.1...1.5.0
[1.4.1]: https://github.com/10up/action-wordpress-plugin-deploy/compare/1.4.0...1.4.1
[1.4.0]: https://github.com/10up/action-wordpress-plugin-deploy/compare/1.3.0...1.4.0
[1.3.0]: https://github.com/10up/action-wordpress-plugin-deploy/compare/1.2.1...1.3.0
[1.2.1]: https://github.com/10up/action-wordpress-plugin-deploy/compare/03e175e...d2b6608
