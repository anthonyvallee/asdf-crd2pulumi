<div align="center">

# asdf-crd2pulumi [![Build](https://github.com/anthonyvallee/asdf-crd2pulumi/actions/workflows/build.yml/badge.svg)](https://github.com/anthonyvallee/asdf-crd2pulumi/actions/workflows/build.yml) [![Lint](https://github.com/anthonyvallee/asdf-crd2pulumi/actions/workflows/lint.yml/badge.svg)](https://github.com/anthonyvallee/asdf-crd2pulumi/actions/workflows/lint.yml)


[crd2pulumi](https://github.com/pulumi/crd2pulumi) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add crd2pulumi
# or
asdf plugin add crd2pulumi https://github.com/anthonyvallee/asdf-crd2pulumi.git
```

crd2pulumi:

```shell
# Show all installable versions
asdf list-all crd2pulumi

# Install specific version
asdf install crd2pulumi latest

# Set a version globally (on your ~/.tool-versions file)
asdf global crd2pulumi latest

# Now crd2pulumi commands are available
crd2pulumi version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/anthonyvallee/asdf-crd2pulumi/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Anthony Vallee](https://github.com/anthonyvallee/)
