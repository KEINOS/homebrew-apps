# Homebrew Smoke Tests

This directory contains smoke tests for apps installed from the `KEINOS/apps` tap. Tests run with [ShellSpec] on macOS and Linux.

The shared runner installs the selected Formula or Cask and verifies that Homebrew lists it. Each spec only needs to check app-specific behavior.

## Add an app

Add `spec/<app-name>_spec.sh`, matching the filename in `Formula/` or `Casks/`. No workflow or runner configuration is required.

For example, `Casks/go-pallet.rb` uses `spec/go-pallet_spec.sh`.

The workflow:

- tests only changed apps on pushes;
- tests every spec during the monthly schedule;
- accepts `all` or one app name when run manually.

## Run locally

With Homebrew and ShellSpec installed:

```console
bash Tests/run-smoke-test.sh go-pallet
```

## References

- [Examples to write tests]
- [Syntax references]

[Examples to write tests]: https://github.com/shellspec/shellspec/tree/master/examples/spec
[ShellSpec]: https://github.com/shellspec/shellspec
[Syntax references]: https://github.com/shellspec/shellspec/blob/master/docs/references.md
