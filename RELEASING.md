# Releasing War1gus

War1gus is released in lockstep with the Stratagus engine: a release of version
`X.Y.Z` is tagged `vX.Y.Z` here and in
[`Wargus/stratagus`](https://github.com/Wargus/stratagus), and the workflows
here build against the engine tag with the matching name, falling back to the
engine `master` branch when there is no such tag. Tag the engine first, so that
the artifacts built here are built against the engine that is being released.

1. Increase the version in:

   |file| |
   |---|---|
   |`scripts/stratagus.lua`|`war1gus.Version`, which the game shows in the UI          |
   |`war1gus.nsi`           |`VERSION` of the installer, and its `COPYRIGHT` years     |
   |`war1gus.rc`            |`VERSION`, and `VIVERSION` of the same version with commas|
   |`war1tool.cpp`          |`VERSION` of the extractor tool, and its `COPYRIGHT` years|
   |`mac/Info.plist`        |`CFBundleShortVersionString` of the app bundle            |

2. Add the changelog entry for the new version with `dch -v X.Y.Z-1` (or
   `gbp dch` to generate it from the commits since the last release) and close
   it with `dch -r`; move the years in `debian/copyright` if needed.

3. Commit and merge to `master`: `git commit -a -m "Release version X.Y.Z"`.

4. Once the engine has been tagged `vX.Y.Z`, tag and push here. The CI builds
   the artifacts and puts them on the release.

   ```sh
   git tag vX.Y.Z
   git push origin master --tags
   ```

   The release notes are the ones for the release as a whole, so write them
   once the artifacts are up, e.g. with
   `gh release edit vX.Y.Z --verify-tag --notes-file notes.md`.

5. Update the download links for the stable versions in the website repository.
