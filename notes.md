## Resources

- https://www.richardlord.net/ash/
- https://github.com/richardlord/Asteroids
- https://package.elm-lang.org/packages/seurimas/slime/latest/Slime
- https://github.com/kutuluk/js13k-ecs
- https://github.com/xarvh/elm-game-state
- https://github.com/w0rm/elm-mogee/blob/master/src/Components/Components.elm
- https://github.com/w0rm/elm-mogee/blob/master/src/Systems/Systems.elm

- https://gpfault.net/posts/webgl2-particles.txt.html

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

Entities can have states, for instance an entity can be controlled by a human or an ai but not both. Currently this is hard to enforce.

Might be nice to have a selected (processEntities) that also checks the value of a component next to the type. So we could have a component `type Player = Human | Ai`, and the `processEntities` with type `Player` and value `Human` (or `Ai`).

Just checking the value may be slow. Maybe we should treat them as separate components? But then you can add them twice again.

We could also have a list of excluded components, so the when you insert one type of components, another type is automatically removed. This shoud be easy to configure, ensures consistancy and should be relatively fast.

But real state management manages multiple components...

## ~~Elm AST~~

never mind!

- https://github.com/avh4/elm-format/issues/194
- https://github.com/avh4/elm-format/tree/master/parser/src/AST
- https://github.com/elm/compiler/tree/master/compiler/src/AST
- https://github.com/Bogdanp/elm-ast
- https://github.com/simonh1000/json-interpreter/blob/master/src/AST.elm
