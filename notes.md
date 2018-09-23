## Resources

ecs

- https://www.richardlord.net/ash/
- https://github.com/richardlord/Asteroids
- https://package.elm-lang.org/packages/seurimas/slime/latest/Slime
- https://github.com/kutuluk/js13k-ecs
- https://github.com/xarvh/elm-game-state
- https://github.com/w0rm/elm-mogee/blob/master/src/Components/Components.elm
- https://github.com/w0rm/elm-mogee/blob/master/src/Systems/Systems.elm
- https://github.com/xarvh/herzog-drei

webgl

- https://package.elm-lang.org/packages/elm-explorations/webgl/latest/
- http://www.lighthouse3d.com/tutorials/glsl-tutorial/spaces-and-matrices/
- http://www.lighthouse3d.com/tutorials/glsl-tutorial/texture-coordinates/
- https://webglfundamentals.org/webgl/lessons/webgl-shaders-and-glsl.html
- https://gpfault.net/posts/webgl2-particles.txt.html

more ecs

- https://gist.github.com/TheSeamau5/4fc43cb00253f4e5d7b4
- https://gist.github.com/TheSeamau5/ec9695232ae919185f4d
- https://discourse.elm-lang.org/t/entity-component-system-for-elm-game-development/1499
- https://groups.google.com/forum/#!topic/elm-discuss/NJCZFIYxshE
- https://www.reddit.com/r/elm/comments/68qiig/slime_ecs_for_elm/
- http://www.html5gamedevs.com/topic/26508-entity-component-system-and-functional-programming/
- https://hackernoon.com/when-not-to-use-ecs-48362c71cf47

misc

- https://gamedev.stackexchange.com/questions/46963/how-to-avoid-texture-bleeding-in-a-texture-atlas

## Ideas/Issues

- getComponents2/3/4 -> Maybe.map2/3/4 or similar

### entity references

store entities (ids) in components (target of a hunter, parent entity in a tree)

challenges

- entity components can be reused/changed (Dict implementation does not need reuse)
- entities can be destroyed and entity ids reused

solutions

- create entity UID, get by UID, destroyEntity removes UID/Entity reference?
- two-way binding of entities (by the user)
  - user has to check for components anyway...

related

- Slime uses `uidToId` and `idToUid` dicts
- TODO check ash

### manage states

Manage multiple entity components based on entity state...

## ~~Elm AST~~

never mind!

- https://github.com/avh4/elm-format/issues/194
- https://github.com/avh4/elm-format/tree/master/parser/src/AST
- https://github.com/elm/compiler/tree/master/compiler/src/AST
- https://github.com/Bogdanp/elm-ast
- https://github.com/simonh1000/json-interpreter/blob/master/src/AST.elm
