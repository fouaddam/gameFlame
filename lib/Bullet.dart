
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'main.dart';

class Bullet extends SpriteComponent with CollisionCallbacks,HasGameRef<MyGame> {
  // Speed of the bullet.
  final double _speed = 450;

  // Controls the direction in which bullet travels.
  Vector2 direction = Vector2(1, 0);

  // Level of this bullet. Essentially represents the
  // level of spaceship that fired this bullet.


  Bullet({
    required Sprite? sprite,
    required Vector2? position,
    required Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  @override
  void onMount() {
    super.onMount();

    // Adding a circular hitbox with radius as 0.4 times
    //  the smallest dimension of this components size.
    final shape = CircleHitbox.relative(
      0.4,
      parentSize: size,
      position: size / 4,
    );
    shape.renderShape = false;
    add(shape);
  }


  @override
  void update(double dt) {
    super.update(dt);


    // Moves the bullet to a new position with _speed and direction.
    position += direction * _speed * dt;

    // If bullet crosses the upper boundary of screen
    // mark it to be removed it from the game world.
    if (position.y < 0) {
      // removeFromParent();
    }
  }
}