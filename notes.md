## Resources

- https://www.richardlord.net/ash/
- https://package.elm-lang.org/packages/seurimas/slime/latest/Slime
- https://github.com/kutuluk/js13k-ecs
- https://github.com/xarvh/elm-game-state
- https://github.com/w0rm/elm-mogee/blob/master/src/Components/Components.elm
- https://github.com/w0rm/elm-mogee/blob/master/src/Systems/Systems.elm

## Ideas/Issues

- getComponents2/3/4 -> Maybe.map2/3/4 or similar

### entity references

store entities (ids) in components (target of a hunter, parent entity in a tree)

challenges

- entity components can be reused/changed
- entities can be destroyed and entity ids reused

solutions

- create entity UID, get by UID, destroyEntity removes UID/Entity reference?
- two-way binding of entities (by the user)
  - user has to check for components anyway...

related

- Slime uses `uidToId` and `idToUid` dicts
- TODO check ash

## ~~Elm AST~~

never mind!

- https://github.com/avh4/elm-format/issues/194
- https://github.com/avh4/elm-format/tree/master/parser/src/AST
- https://github.com/elm/compiler/tree/master/compiler/src/AST
- https://github.com/Bogdanp/elm-ast
- https://github.com/simonh1000/json-interpreter/blob/master/src/AST.elm
