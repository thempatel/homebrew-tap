# thempatel/homebrew-tap

Homebrew tap for tools by [@thempatel](https://github.com/thempatel).

## Install

```sh
brew tap thempatel/tap
brew install mdlr
```

## Formulas

- **mdlr** — polyglot code-analysis tool that builds a graph of source-level units and computes structural metrics. Source: [thempatel/mdlr](https://github.com/thempatel/mdlr).

## Releasing a new version of mdlr

1. In `thempatel/mdlr`, bump `version` in `Cargo.toml`, commit, then tag and push:

   ```sh
   git tag v<X.Y.Z>
   git push --tags
   ```

   Optionally create a GitHub release for the tag.

2. Compute the tarball sha256:

   ```sh
   curl -sL https://github.com/thempatel/mdlr/archive/refs/tags/v<X.Y.Z>.tar.gz \
     | shasum -a 256
   ```

3. In `Formula/mdlr.rb`, update `url` and `sha256` to the new version.

4. Commit and push this tap repo. Users get the new version on next `brew upgrade`.

## Notes on the formula

- Build uses `rustup-init` rather than Homebrew's `rust` so cargo honors the
  `rust-toolchain.toml` channel pin in the upstream repo.
- `mdlr-extract-go` is built from `tools/mdlr-extract-go` and installed alongside
  `mdlr`. It is invoked by `mdlr` only when a `go.mod` is present in the analyzed
  workspace; analysis of non-Go projects is unaffected if it is missing.
