import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import 'main.dart';

enum animationState {walk,melle,idle,jump,runShoot}

class Enemy extends BodyComponent<MyGame> with CollisionCallbacks {

  late Vector2 position;
  late double restitution;
  late SpriteAnimationGroupComponent enemy = SpriteAnimationGroupComponent();
  late BodyDef bodyDef;
  late final List<SpriteAnimation>listSprite;


  Enemy(this.position, this.restitution, this.listSprite);

  @override
  Body createBody() {
    final shape = CircleShape()
      ..radius = 40;
    final fixture = FixtureDef(
        shape, friction: 0.2, restitution: 0.2, density: 0.5);
    bodyDef =
        BodyDef(userData: this, position: position, type: BodyType.dynamic,fixedRotation: true);
    return world.createBody(bodyDef)
      ..createFixture(fixture);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);

    print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
  }


  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    super.onLoad();

    //add(CircleHitbox());

  }


  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    //add(CircleHitbox());

    enemy.
    animations = {
      animationState.walk: listSprite[0],
      animationState.melle: listSprite[1],
      animationState.idle: listSprite[2],
      animationState.jump: listSprite[3],
      animationState.runShoot: listSprite[4]
    };
    enemy.size = Vector2(100, 100);
    enemy.anchor = Anchor.center;
    enemy.current = animationState.idle;

    add(
        enemy
          /*..add(
              MoveEffect.to(
                Vector2(10, 0),
                EffectController(
                  duration: 10,
                  infinite: true,
                  alternate: true,
                ),
              )
          )*/
    );
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    //gameRef.enemy.body.position.x-= 1;
    //enemy.position.x-= 1;
    gameRef.enemy.center.x-= 1;

    /*print("BoDYEnemYYY${gameRef.enemy.body.position.x}");
    print("BoDYRobot${gameRef.robot.body.position.x}");
*/
    double positionEnemy=gameRef.enemy.body.position.x;
    double positionRobot=gameRef.robot.body.position.x;

    if(enemy.scale.x>0&&positionRobot<positionEnemy){
      enemy.flipHorizontally();
      enemy.current = animationState.runShoot;
    }
    /*
    if(enemy.scale.x<0&&positionRobot>positionEnemy){
     //  enemy.flipHorizontally();
    }
    if(enemy.position.x >4.8 && enemy.position.x<=5 ){
    }
    if (enemy.position.x >= 5) {
      //gameRef.enemy.body.position.x += 0.7;

      enemy.current = animationState.runShoot;
    } else if (enemy.position.x < 5) {
     // gameRef.enemy.body.position.x -= 0.7;
    }*/


  }
}