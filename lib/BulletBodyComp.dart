

import 'package:actividad/EnemyP.dart';
import 'package:actividad/main.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

import 'Enemy.dart';

class BulletBodyComp extends BodyComponent<MyGame> with ContactCallbacks{

  late SpriteComponent bullet;
  final Vector2 position;
  final Sprite sprite;
  final Vector2 size;


  BulletBodyComp(this.sprite,this.position, this.size);

  @override
  Body createBody() {
    final shape=CircleShape()..radius=20;
    final fixture=FixtureDef(shape,friction: 0,restitution: 0,density: 0);
    final bodyDef=BodyDef(userData:this,position: position,type:BodyType.dynamic,fixedRotation: true,bullet: true,gravityOverride: Vector2(1,0));
    return world.createBody(bodyDef)..createFixture(fixture);
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    bullet=SpriteComponent();
    bullet..sprite=sprite
          ..size=size
          ..anchor=Anchor.center;
    add(bullet);
  }

  @override
  void beginContact(Object other, Contact contact) {
    // TODO: implement beginContact
    super.beginContact(other, contact);
    if(other is Enemy){
      removeFromParent();

    }
    if(other is BulletBodyComp){
      removeFromParent();
    }
  }
  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
     super.onLoad();

  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    gameRef.bulletBodyComp.center.x+=1;
  }






}