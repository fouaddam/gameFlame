

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Ground extends SpriteComponent{


  late RectangleHitbox hitbox;

  Ground({
    required Vector2 position,
    required Vector2 size,
  }) :super(position: position, size: size);

  @override
  Future<void>? onLoad() async {
    hitbox = RectangleHitbox();
    hitbox.renderShape = false;

    add(hitbox);
  }
  }





