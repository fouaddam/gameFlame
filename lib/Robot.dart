
import 'package:actividad/Player.dart';
import 'package:actividad/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

import 'Ground.dart';

enum animationState {walk,melle,idle,jump,runShoot}


class Robot extends BodyComponent<MyGame> {

  late Vector2 position;
  late double restitution;
  late SpriteAnimationGroupComponent robot=SpriteAnimationGroupComponent();
  late BodyDef bodyDef;
  final List<SpriteAnimation>listSprite;


  Robot(
      this.position, this.restitution, this.listSprite);

  @override
  Body createBody() {
    final shape=CircleShape()..radius=42;
    final fixture=FixtureDef(shape,friction: 0.2,restitution: 0.2,density: 0.5);
    bodyDef=BodyDef(userData:this,position: position,type:BodyType.dynamic);
    return world.createBody(bodyDef)..createFixture(fixture);
  }



    @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
     super.onLoad();
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

     add(robot);
     //add(CircleHitbox());

  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    //add(CircleHitbox());
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    bool stateX=gameRef.joystickComponent.relativeDelta.x.isNegative;
    bool stateY=gameRef.joystickComponent.relativeDelta.y.isNegative;
    if(!stateX){
      robot.current=animationState.runShoot;
      gameRef.parallaxComponent.parallax?.baseVelocity.x=100;
    }

    if(stateX && gameRef.joystickComponent.relativeDelta.x<0){
      robot.current=animationState.melle;
      gameRef.parallaxComponent.parallax?.baseVelocity.x=0;

    }
    if(gameRef.joystickComponent.relativeDelta.x==0){
      robot.current=animationState.idle;
      gameRef.parallaxComponent.parallax?.baseVelocity.x=0;
    }

    double playerVectory = (gameRef.joystickComponent.delta * 10 * dt).y;

    if(stateY && gameRef.robot.body.position.y>gameRef.size.y/2){
      robot.current=animationState.jump;
      gameRef.robot.body.position.add(Vector2(0, playerVectory));

      if(gameRef.robot.body.position.y<=gameRef.size.y/2){
        robot.current=animationState.idle;
      }

    }

    /*if(position.y<gameRef.size.y-size.y && current!=animationState.jump){
      velocity.y-=(gravity/20);
      position.y-=velocity.y*dt;

    }*/
  }








}