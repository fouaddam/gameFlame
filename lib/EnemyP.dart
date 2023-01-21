import 'package:actividad/Player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'main.dart';

enum animationState {walk,melle,idle,jump,runShoot}

class EnemyP extends SpriteAnimationGroupComponent with CollisionCallbacks,HasGameRef<MyGame>{


  late ShapeHitbox hitbox;
  final List<SpriteAnimation>listSprite;
  double gravity=9.8;
  Vector2 velocity=Vector2(0, 0);



  EnemyP(this.listSprite, {
    required Vector2 position,
    required Vector2 size,
  }) :super(position: position, size: size);

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();
    hitbox = CircleHitbox();
    hitbox.renderShape = false;
    anchor=Anchor.center;
    add(hitbox);



    animations={
      animationState.walk:listSprite[0],
      animationState.melle:listSprite[1],
      animationState.idle:listSprite[2],
      animationState.jump:listSprite[3],
      animationState.runShoot:listSprite[4]
    };

    current=animationState.runShoot;
    flipHorizontally();

  }


  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();

  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    position.x-=1;

   /* bool stateX=gameRef.joystickComponent.relativeDelta.x.isNegative;
    bool stateY=gameRef.joystickComponent.relativeDelta.y.isNegative;
    if(!stateX){
      current=animationState.runShoot;
      gameRef.parallaxComponent.parallax?.baseVelocity.x=100;
    }

    if(stateX && gameRef.joystickComponent.relativeDelta.x<0){
      current=animationState.melle;
      gameRef.parallaxComponent.parallax?.baseVelocity.x=0;

    }
    if(gameRef.joystickComponent.relativeDelta.x==0){
      current=animationState.idle;
      gameRef.parallaxComponent.parallax?.baseVelocity.x=0;
    }

    double playerVectory = (gameRef.joystickComponent.delta * 10 * dt).y;

    if(stateY && position.y>gameRef.size.y/4){
      current=animationState.jump;
      position.add(Vector2(0, playerVectory));

    }*/

    if(position.y<gameRef.size.y-size.y && current!=animationState.jump){
      velocity.y-=(gravity/20);
      position.y-=velocity.y*dt;

    }
  }
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
      if(other is Player){
        print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
      }

  }



}