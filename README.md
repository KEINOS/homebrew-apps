# Homebrew Taps of [KEINOS][keinos]

[![Smoke tests][smoke-badge]][smoke-workflow]

This repo is an archive of Homebrew taps for released apps under [KEINOS repositories][repositories].

You may need to trust this tap before installation:

```console
brew trust keinos/apps
```

| Repo | Install |
| :--: | :------ |
| [genrawid] | `brew install KEINOS/apps/genrawid` |
| [whereami] | `brew install KEINOS/apps/whereami` |
| [go-pallet] | `brew install KEINOS/apps/go-pallet` |
| [dev-go] | `brew install KEINOS/apps/dev-go-sample` |
| [multihash] | `brew install KEINOS/apps/multihash` |
| [gostars] | `brew install KEINOS/apps/gostars` |

---

Smoke tests install each app with a scenario through this tap and run its ShellSpec checks on macOS and Linux. Changed apps are tested on every push, and all scenarios run monthly at 16:30 UTC on day 2.

[dev-go]: https://github.com/KEINOS/dev-go/
[genrawid]: https://github.com/KEINOS/go-genrawid
[go-pallet]: https://github.com/KEINOS/go-pallet/
[gostars]: https://github.com/KEINOS/gostars
[keinos]: https://github.com/KEINOS/
[multihash]: https://github.com/KEINOS/brew-multihash
[repositories]: https://github.com/KEINOS?tab=repositories
[smoke-badge]: https://github.com/KEINOS/homebrew-apps/actions/workflows/smoke-test.yml/badge.svg
[smoke-workflow]: https://github.com/KEINOS/homebrew-apps/actions/workflows/smoke-test.yml
[whereami]: https://github.com/KEINOS/whereami
