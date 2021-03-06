# Tests To Download via Homebrew on Linux

This directory contains healthchecks of the formula using [ShellSpec](https://github.com/shellspec/shellspec).

Most of the tests simply downloads the app via `brew` and runs a smoke test.
See [go-pallet_spec.sh](./spec/go-pallet_spec.sh) for example.

## Note

- Steps to add tests
  1. Create Test Files
    - Place them under `./spec/` dir.
    - File name format: `<app_name>_spec.sh`
      - Ex.) `go-pallet_spec.sh`
  2. Add test runner to [docker-compose.yml](../docker-compose.yml)
  3. Add the workflow to [workflows](../.github/workflows)
    - Add the status workflow status badge to [README.md](../README.md) as well.

## Reference

- [Examples to write tests](https://github.com/shellspec/shellspec/tree/master/examples/spec) @ github.com/shellspec/shellspec
- [Syntax References](https://github.com/shellspec/shellspec/blob/master/docs/references.md) @ github.com/shellspec/shellspec
