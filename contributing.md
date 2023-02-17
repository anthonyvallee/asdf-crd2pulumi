# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test crd2pulumi https://github.com/anthonyvallee/asdf-crd2pulumi.git "crd2pulumi version"
```

Tests are automatically run in GitHub Actions on push and PR.
