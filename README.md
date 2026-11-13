# About War1gus

<img src="./war1gus.png" width="100" align="right" />

War1gus is a re-implementation of **Warcraft: Orcs & Humans** that that can be played on modern platforms with the [Stratagus engine](https://github.com/Wargus/stratagus). The game uses graphics and sounds from the original Warcraft, but improves the gameplay mechanisms with many modern conveniences that the Stratagus engine allows, such as modern mouse controls, named groups, larger group selection, more player factions in multiplayer games, a map editor, and multiple towns. 

You can find more details at [stratagus.com](https://stratagus.com/war1gus.html) 

### Downloads

Every release of War1gus comes with a Windows installer, a macOS `dmg` and a
Linux AppImage:

- [Latest stable release](https://github.com/Wargus/war1gus/releases/latest)
- [Latest unstable build](https://github.com/Wargus/war1gus/releases/tag/master-builds) — rebuilt for every push to `master`, so it is the newest development build rather than a tested release

Older releases are in the [release list](https://github.com/Wargus/war1gus/releases), and [stratagus.com](https://stratagus.com/war1gus.html) explains how to install and where to get the game data from.

### Extracting data for macOS

In order to play War1gus you first need to extract the game data from your Warcraft installer. The built-in extractor tool is currently not working correctly on macOS, but
[this third-party script](https://github.com/shinra-electric/Stratagus-Data-Extractor-Script) can be used while fixes are being worked on. <br>

Run the script in the same folder as your game data and the War1gus app. **It only needs to be run once**. 

It will not be needed in the future when the built-in extractor is fixed. 

### Build status

Windows: ![Build Status](https://github.com/Wargus/war1gus/actions/workflows/windows.yml/badge.svg)

Linux: ![Build Status](https://github.com/Wargus/war1gus/actions/workflows/ubuntu.yml/badge.svg)

macOS: ![Build Status](https://github.com/Wargus/war1gus/actions/workflows/macos.yml/badge.svg)

The Windows workflow builds the installer, the Linux workflow the AppImage and
the macOS workflow the `dmg`; pushing a version tag creates the release with
those artifacts, and pushes to `master` update the `master-builds` release.
`RELEASING.md` describes how a release is made.


### Join the community
[![Join the chat at https://gitter.im/Wargus](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Wargus?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Discord](https://img.shields.io/discord/780082494447288340?style=flat-square&logo=discord&label=discord)](https://discord.gg/dQGxaw3QfB)


### Gallery
<img width="800" src="https://user-images.githubusercontent.com/93911529/157967177-0eab04af-a704-415d-8f6f-294d0e5aaed0.png">
