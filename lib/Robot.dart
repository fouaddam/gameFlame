
import 'package:actividad/Player.dart';
import 'package:actividad/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/animation.dart';
import 'package:forge2d/src/dynamics/body.dart';

import 'Enemy.dart';
import 'Ground.dart';

enum animationState {walk,melle,idle,jump,runShoot}


class Robot extends BodyComponent<MyGame> with ContactCallbacks{

  late Vector2 position;
  late double restitution;
  late SpriteAnimationGroupComponent robot=SpriteAnimationGroupComponent();
  late BodyDef bodyDef;
  final List<SpriteAnimation>listSprite;


  Robot(this.position, this.restitution, this.listSprite);

  @override
  Body createBody() {
    final shape=CircleShape()..radius=40;
    final fixture=FixtureDef(shape,friction: 0.2,restitution: 0.2,density: 0.5);
    bodyDef=BodyDef(userData:this,position: position,type:BodyType.dynamic,fixedRotation: true);
    return world.createBody(bodyDef)..createFixture(fixture);
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

    robot.
    animations={
      animationState.walk:listSprite[0],
      animationState.melle:listSprite[1],
      animationState.idle:listSprite[2],
      animationState.jump:listSprite[3],
      animationState.runShoot:listSprite[4]
    };
    robot.size=Vector2(100, 100);
    robot.anchor=Anchor.center;
    robot.current=animationState.idle;

    add(
        robot
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

    if(robot.position.x>=5){
      //gameRef.robot.body.position.x+=0.7;
    }else if(robot.position.x<5){
     // gameRef.robot.body.position.x-=0.7;
    }
    //print(robot.position.x.toString());
    //center.x+=robot.position.x;
    //print();
    //print("*****${body.position.x}");
    bool stateX=gameRef.joystickComponent.relativeDelta.x.isNegative;
    bool stateY=gameRef.joystickComponent.relativeDelta.y.isNegative;
    if(!stateX&& gameRef.joystickComponent.relativeDelta.x!=0){
      robot.current=animationState.runShoot;
      gameRef.parallaxComponent.parallax?.baseVelocity.x=100;
     // gameRef.robot.center.x+=1;
    }

    if(stateX){
      robot.current=animationState.melle;
      gameRef.parallaxComponent.parallax?.baseVelocity.x=0;

    }
    if(gameRef.joystickComponent.relativeDelta.x==0){
      robot.current=animationState.idle;
      gameRef.parallaxComponent.parallax?.baseVelocity.x=0;
    }

    double playerVectory = (gameRef.joystickComponent.delta * 10 * dt).y;

    if(stateY && gameRef.robot.center.y>100){
      robot.current=animationState.jump;
      gameRef.robot.center.add(Vector2(0, playerVectory));

      if(gameRef.robot.body.position.y==100){
        robot.current=animationState.idle;
      }
    }
   // print(gameRef.ground.body.position.y);


    /*if(position.y<gameRef.size.y-size.y && current!=animationState.jump){
      velocity.y-=(gravity/20);
      position.y-=velocity.y*dt;

    }*/
  }

  @override
  void beginContact(Object other, Contact contact) {
    // TODO: implement beginContact
    super.beginContact(other, contact);
    if (other is Enemy) {
      print("ha chocado");
    }
  }
}