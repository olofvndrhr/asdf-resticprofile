# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

asdf plugin test resticprofile https://github.com/olofvndrhr/asdf-resticprofile.git "resticprofile --verbose version"
```

Tests are automatically run in GitHub Actions on push and PR.
