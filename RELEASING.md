# Releasing War1gus

War1gus is released in lockstep with the Stratagus engine: a release of version
`X.Y.Z` is tagged `vX.Y.Z` here and in
[`Wargus/stratagus`](https://github.com/Wargus/stratagus), and the workflows
here build against the engine tag with the matching name, falling back to the
engine `master` branch when there is no such tag. Tag the engine first, so that
the artifacts built here are built against the engine that is being released.
See `RELEASING.md` in the engine repository for the engine part of the release,
including its documentation and changelog.

## Release artifacts

| artifact | workflow |
| --- | --- |
| Windows installer | [`windows.yml`](.github/workflows/windows.yml) |
| macOS `dmg` | [`macos.yml`](.github/workflows/macos.yml) |
| Linux AppImage | [`ubuntu.yml`](.github/workflows/ubuntu.yml) |

A push to `master`, a tag, or a manual "Run workflow" makes all three build,
and so does [`engine.yml`](.github/workflows/engine.yml), which runs daily and
starts them when the engine has moved since the artifacts went up. A pull
request is built so that it can be reviewed, but publishes nothing, and it is
the only build a branch gets: `master` and version tags are the refs that
publish, so a branch with a pull request is not built twice. The Launchpad
recipes and the `HowToRelease` list they came with are gone. Each of the three
workflows uploads its artifact to the release for the tag it ran for, creating
that release if none of them has yet, and pushes to `master` upload to the
[master-builds
release](https://github.com/Wargus/war1gus/releases/tag/master-builds) instead.

The Linux workflow runs `tools/ci-build.sh`, which takes one argument, the
platform being built for, and does that platform's whole artifact. The AppImage
can therefore be built locally the same way, which is what the workflow does:

```sh
git clone --recursive https://github.com/Wargus/stratagus ../stratagus
tools/ci-build.sh linux   # and macos or windows, where the tools are
```

It writes the artifact to `release-assets/`, and takes the engine from
`../stratagus` unless `ENGINE_SRC` says otherwise.

## Tagging a release

`X.Y.Z` below is the version being released, and `vX.Y.Z` the tag.

1. Increase the version in:

   | file | |
   | --- | --- |
   | `scripts/stratagus.lua` | `war1gus.Version`, which the game shows in the UI |
   | `war1gus.nsi` | `VERSION` of the installer, and its `COPYRIGHT` years |
   | `war1gus.rc` | `VERSION`, and `VIVERSION` of the same version with commas |
   | `war1tool.cpp` | `VERSION` of the extractor tool, and its `COPYRIGHT` years |
   | `mac/Info.plist` | `CFBundleShortVersionString` of the app bundle |

2. Add the changelog entry for the new version with `dch -v X.Y.Z-1` (or
   `gbp dch` to generate it from the commits since the last release) and close
   it with `dch -r`; move the years in `debian/copyright` if needed.

3. Commit and merge to `master`: `git commit -a -m "Release version X.Y.Z"`.

4. Once the engine has been tagged `vX.Y.Z`, tag and push here. The three
   workflows then build the artifacts and put them on the release.

   ```sh
   git tag vX.Y.Z
   git push origin master --tags
   ```

   The release notes are the ones for the release as a whole, so write them
   once the artifacts are up, e.g. with
   `gh release edit vX.Y.Z --verify-tag --notes-file notes.md`.

5. Update the download links for the stable versions in the website repository.
