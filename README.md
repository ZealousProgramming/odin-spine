# odin-spine

Experimental spine runtime for Odin. Currently comes with a `raylib` implementation.

## License

While you're free to use these bindings as you'd like, there is an associated license
via the [Spine License](http://esotericsoftware.com/spine-editor-license#s2) that users should be aware of. The license sits at the top of the `odin_spine.odin` file, but it can also be found [here](https://github.com/EsotericSoftware/spine-runtimes/blob/4.1/LICENSE). Users looking to integrate this with their project will need a valid Spine License at the time of integration.

## Features

A basic implementation is provided for raylib via `odin_spine:core/raylib`, but you can create your own implementation as you'd like API found in `odin_spine:core`.

- [x] Frameworks
  - [ ] Raylib
    - [ ] Platforms
      - [x] Windows
      - [ ] Linux (Do not have access to a Linux machine)
      - [ ] MacOS (Do not have access to a MacOS machine)
    - [x] Base Implementation (Spineboy, Windmill)
    - [ ] Clipping (Coin)
    - [ ] Batched Meshes

## Examples

Examples can be found at `/examples/raylib`. A few examples to show off Spine's features:

- `spineboy`
  - The Spineboy project demonstrates a variety of Spine features, such as meshes, IK, transform constraints, and clipping.
- `coin`
  - The coin project demonstrates how to make a shiny coin using Spine's clipping and tint black features.
- `windmill`
  - The windmill projects show how to model isometric perspective with both Spine Essential and Spine Professional. The project illustrates how to perform isometric rotations, create a simple smoke effect, and how to add variation by duplicating elements and their animations.
- `dragon`
  - The dragon project is a simple example of basic Spine animation and traditional frame-by-frame animation in Spine.

## Reading Materials

- [Spine API Reference](https://esotericsoftware.com/spine-api-reference)
- [Spine Runtime Guide](https://esotericsoftware.com/spine-runtimes-guide)
- [spine-c Source](https://github.com/EsotericSoftware/spine-runtimes/tree/4.1/spine-c)
- [Spine License](http://esotericsoftware.com/spine-editor-license#s2)
- [Spine Runtime License](https://github.com/EsotericSoftware/spine-runtimes/blob/4.1/LICENSE)
