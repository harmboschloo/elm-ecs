# To do

- getEntity
- canvas renderer for demo https://package.elm-lang.org/packages/joakin/elm-canvas/latest/
- fromList [components]
- toList [components]
- Node set/remove
- EntityId id index
- Can we get rit of Components type defined by user?

# Resources

ecs

- https://package.elm-lang.org/packages/seurimas/slime/latest/Slime
- https://github.com/w0rm/elm-mogee/blob/master/src/Components/Components.elm
- https://github.com/w0rm/elm-mogee/blob/master/src/Systems/Systems.elm
- https://github.com/xarvh/elm-game-state
- https://github.com/xarvh/herzog-drei
- https://github.com/kutuluk/js13k-ecs
- https://www.richardlord.net/ash/
- https://github.com/richardlord/Asteroids
- http://robbinmarcus.blogspot.com/2016/07/the-next-step-in-entity-component.html
- https://github.com/slide-rs/specs
- https://stackoverflow.com/questions/1901251/component-based-game-engine-design
- https://www.sebaslab.com/ecs-design-to-achieve-true-inversion-of-flow-control/

webgl

- https://package.elm-lang.org/packages/elm-explorations/webgl/latest/
- https://package.elm-lang.org/packages/Zinggi/elm-2d-game/latest/
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

# Benchmarks

## Demo System Operations (outdated)

- Animation: iterate (A)B -> insert A
- Collection: iterate AB + iterate AC -> sometimes remove C, insert DE, update F
- KeyControls: iterate (A)B -> insert A
- MotionControl: iterate ABCD -> insert A
- Movement: iterate AB -> insert A
- Render: iterate AB
- Spawn: create with ABCDEF...
- Transform: iterate A -> insert A & sometimes destroy & sometimes insert B
