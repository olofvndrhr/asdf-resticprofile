<div align="center">

# asdf-resticprofile [![Build](https://github.com/olofvndrhr/asdf-resticprofile/actions/workflows/build.yml/badge.svg)](https://github.com/olofvndrhr/asdf-resticprofile/actions/workflows/build.yml) [![Lint](https://github.com/olofvndrhr/asdf-resticprofile/actions/workflows/lint.yml/badge.svg)](https://github.com/olofvndrhr/asdf-resticprofile/actions/workflows/lint.yml)

[resticprofile](https://creativeprojects.github.io/resticprofile/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, `gzip` and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

Plugin:

```shell
asdf plugin add resticprofile
# or
asdf plugin add resticprofile https://github.com/olofvndrhr/asdf-resticprofile.git
```

resticprofile:

```shell
# Show all installable versions
asdf list-all resticprofile

# Install specific version
asdf install resticprofile latest

# Set a version globally (on your ~/.tool-versions file)
asdf global resticprofile latest

# Now resticprofile commands are available
resticprofile --verbose version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/olofvndrhr/asdf-resticprofile/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Ivan Schaller](https://github.com/olofvndrhr/)
