# WordPress.org Plugin Deploy

This Action commits the contents of your Git tag to the WordPress.org plugin repository using the same tag name. It excludes Git-specific items or files and directories as optionally defined in your `.gitattributes` file, and moves anything from a `.wordpress-org` subdirectory to the top-level `assets` directory in Subversion (plugin banners, icons, and screenshots).

## Configuration

### Required secrets
* `SVN_USERNAME`
* `SVN_PASSWORD`
* `GITHUB_TOKEN` - you do not need to generate one but you do have to explicitly make it available to the Action

Secrets can be set while editing your workflow or in the repository settings. They cannot be viewed once stored. [GitHub secrets documentation](https://developer.github.com/actions/creating-workflows/storing-secrets/)

### Optional environment variables
* `SLUG` - defaults to the respository name, customizable in case your WordPress repository has a different slug. This should be a very rare case as WordPress assumes that the directory and initial plugin file have the same slug.
* `VERSION` - defaults to the tag name; do not recommend setting this except for testing purposes
* `ASSETS_DIR` - defaults to `.wordpress-org`, customizable for other locations of WordPress.org plugin repository-specific assets that belong in the top-level `assets` directory (the one on the same level as `trunk`)

### Excluding files from deployment
If there are files or directories to be excluded from deployment, such as tests or editor config files, they can be specified in your `.gitattributes` file using the `export-ignore` directive. If you use this method, please be sure to include the following items:

```gitattributes
# Directories
/.wordpress-org export-ignore
/.github export-ignore

# Files
/.gitattributes export-ignore
/.gitignore export-ignore
```


## Example Workflow File
```yml
name: Deploy to WordPress.org
on:
  push:
    branches:
    - refs/tags/*
jobs:
  tag:
    name: New tag
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: WordPress Plugin Deploy
      uses: 10up/action-wordpress-plugin-deploy@master
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        SVN_PASSWORD: ${{ secrets.SVN_PASSWORD }}
        SVN_USERNAME: ${{ secrets.SVN_USERNAME }}
        SLUG: my-super-cool-plugin
```

### Known issues
* Currently the `tags` filter on the `push` action does not work as expected, so we target the `refs/tags/*` naming of a branch instead. Ideally for readability and correctness this would use something like `tags: - *`.

## Contributing
Want to help? Check out our [contributing guidelines](CONTRIBUTING.md) to get started.

<p align="center">
<a href="http://10up.com/contact/"><img src="https://10updotcom-wpengine.s3.amazonaws.com/uploads/2016/10/10up-Github-Banner.png" width="850"></a>
</p>

## License

Our GitHub Actions are available for use and remix under the MIT license.

