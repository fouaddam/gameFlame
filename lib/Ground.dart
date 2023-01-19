import 'dart:html';

import 'package:actividad/Robot.dart';
import 'package:actividad/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';




class Ground extends BodyComponent<MyGame> {

  final Vector2 gameSize;
  final int x;
  final int y;

  Ground(this.gameSize, this.x, this.y);

  @override
  Body createBody() {
    final shape=EdgeShape()..set(Vector2(0,gameSize.y-x), Vector2(gameSize.x,gameSize.y-y));

    final fixture=FixtureDef(shape,friction: 0.5,density: 1.2);

    final bodyDef=BodyDef(userData:this,position: Vector2.zero(),type:BodyType.static);
    return world.createBody(bodyDef)..createFixture(fixture);
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
    if(world.contactManager.contacts.isNotEmpty){
      //print(world.contactManager.contacts.first.bodyB.userData.toString());
    }
  }


  }










