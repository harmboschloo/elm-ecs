# ECS Generator

Generates elm code for an entity-component-system (ECS) given a list of components.

Experimental / work in progress.

- [live](https://harmboschloo.github.io/elm-ecs-generator/)
- [example](https://harmboschloo.github.io/elm-ecs-generator/#%7B%22ecs%22%3A%5B%22Ecs%22%2C%22Ecs%22%5D%2C%22components%22%3A%5B%5B%22Components%22%2C%22Ai%22%5D%2C%5B%22Components%22%2C%22Collectable%22%5D%2C%5B%22Components%22%2C%22Collector%22%5D%2C%5B%22Components.Controls%22%2C%22Controls%22%5D%2C%5B%22Components%22%2C%22KeyControlsMap%22%5D%2C%5B%22Components%22%2C%22Motion%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Scale%22%5D%2C%5B%22Components%22%2C%22ScaleAnimation%22%5D%2C%5B%22Components%22%2C%22Sprite%22%5D%2C%5B%22Components.Transforms%22%2C%22Transforms%22%5D%2C%5B%22Components%22%2C%22Velocity%22%5D%5D%2C%22nodes%22%3A%5B%7B%22name%22%3A%22collectable%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Collectable%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%5D%7D%2C%7B%22name%22%3A%22collector%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Collector%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%5D%7D%2C%7B%22name%22%3A%22keyControls%22%2C%22components%22%3A%5B%5B%22Components.Controls%22%2C%22Controls%22%5D%2C%5B%22Components%22%2C%22KeyControlsMap%22%5D%5D%7D%2C%7B%22name%22%3A%22motionControl%22%2C%22components%22%3A%5B%5B%22Components.Controls%22%2C%22Controls%22%5D%2C%5B%22Components%22%2C%22Motion%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Velocity%22%5D%5D%7D%2C%7B%22name%22%3A%22movement%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Velocity%22%5D%5D%7D%2C%7B%22name%22%3A%22render%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Sprite%22%5D%5D%7D%2C%7B%22name%22%3A%22scaleAnimation%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22ScaleAnimation%22%5D%5D%7D%2C%7B%22name%22%3A%22transform%22%2C%22components%22%3A%5B%5B%22Components.Transforms%22%2C%22Transforms%22%5D%5D%7D%5D%7D)
- [example demo](https://harmboschloo.github.io/elm-ecs-generator/example/build/) - controls: arrow keys, esc to pause
- [example code](https://github.com/harmboschloo/elm-ecs-generator/tree/master/example)

## Resources

ecs

- https://www.richardlord.net/ash/
- https://github.com/richardlord/Asteroids
- https://package.elm-lang.org/packages/seurimas/slime/latest/Slime
- https://github.com/kutuluk/js13k-ecs
- https://github.com/w0rm/elm-mogee/blob/master/src/Components/Components.elm
- https://github.com/w0rm/elm-mogee/blob/master/src/Systems/Systems.elm
- https://github.com/xarvh/elm-game-state
- https://github.com/xarvh/herzog-drei

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
