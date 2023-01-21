import 'dart:math';

import 'package:actividad/Ground.dart';
import 'package:actividad/Player.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'Bullet.dart';
import 'Colision.dart';
import 'Enemy.dart';
import 'EnemyP.dart';
import 'Robot.dart';
import 'dart:async';
import 'package:flame/timer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  final game = MyGame();
  runApp(GameWidget(game: game));

}


class MyGame extends Forge2DGame with HasDraggables,HasCollisionDetection,TapDetector{

  MyGame():super(gravity: Vector2(0, 15),zoom: 1);

  final knobPaint = BasicPalette.yellow.withAlpha(200).paint();
  final backgroundPaint = BasicPalette.white.withAlpha(100).paint();
  late JoystickComponent joystickComponent;
  late ParallaxComponent parallaxComponent;
  late Robot robot;
  late Enemy enemy;
  late Ground ground;
  late Player player;
  late Timer timer;
  late EnemyP enemyP;
    int remaninTime=10;



  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
     super.onLoad();
   // add(Player(position: Vector2(200,200), size: Vector2(200,200)));


     parallaxComponent = await ParallaxComponent.load(
       [
         //ParallaxImageData("bg5.png"),
         //ParallaxImageData("bg6.png"),
         ParallaxImageData("city.jpg"),
         // ParallaxImageData("bg3.png"),
         // ParallaxImageData("bg4.png"),
       ],
       baseVelocity: Vector2(0,0),
       repeat: ImageRepeat.repeatX,
     );

     add(parallaxComponent);
     //addContactCallback(BallWallCallback());


     joystickComponent =JoystickComponent(
         knob: CircleComponent(radius: 20, paint: knobPaint),
         background: CircleComponent(radius: 40, paint: backgroundPaint),
         margin: const EdgeInsets.only(left: 40, bottom: 40),
         size:20.5);
     add(joystickComponent);


     var spriteSheetWalk = await fromJSONAtlas("Walk.png","Walk.json");
     SpriteAnimation Walk = SpriteAnimation.spriteList(
         spriteSheetWalk, stepTime: .1);

     var spriteSheetMelee = await fromJSONAtlas("Melee.png","Melee.json");
     SpriteAnimation Melee = SpriteAnimation.spriteList(
         spriteSheetMelee, stepTime: .1);

     var spriteSheetIdle = await fromJSONAtlas("Idle.png","Idle.json");
     SpriteAnimation Idle = SpriteAnimation.spriteList(
         spriteSheetIdle, stepTime: .1);

     var spriteSheetJump = await fromJSONAtlas("Jump.png","Jump.json");
     SpriteAnimation Jump = SpriteAnimation.spriteList(
         spriteSheetJump, stepTime: .1);

     var spriteSheetRunShoot = await fromJSONAtlas("RunShoot.png","RunShoot.json");
     SpriteAnimation RunShoot = SpriteAnimation.spriteList(
         spriteSheetRunShoot, stepTime: .1);

     List<SpriteAnimation>listSprite=[];
       listSprite.add(Walk);
       listSprite.add(Melee);
       listSprite.add(Idle);
       listSprite.add(Jump);
       listSprite.add(RunShoot);

      player=Player(listSprite, position: Vector2(200,100), size: Vector2(100,100));

     add(player);
     //Ground ground=Ground(Vector2(100,100), Vector2(100,100));
     //add(ground);

    // add(player);
       robot=Robot(Vector2(200,400), 0.5, listSprite);
      //add(robot);


      ground=Ground(Vector2(600,600),50,50);

    //add(ground);

     timer = Timer(7, onTick: () async {
       if (remaninTime >= 1) {
         remaninTime -= 2;
         //Random r = Random();
        // int high = size.x as int;

         enemy=Enemy(Vector2(700,400), 0.5, listSprite);

         enemyP=EnemyP(listSprite, position: Vector2(400,500), size: Vector2(100,100));
         add(enemyP);

         /*BulletEnemy bulletEnemy = BulletEnemy(
             sprite: spriteSheet.getSprite(5, 6)
             ,
             position: Vector2((r.nextInt(high - 40) + 40) - 30, 0),
             size: Vector2(80, 80));
         add(bulletEnemy);

         BulletEnemy bulletEnemy2 = BulletEnemy(
             sprite: spriteSheet.getSprite(5, 7)
             ,
             position: Vector2((r.nextInt(high - 40) + 40) - 30, 0),
             size: Vector2(80, 80));
         add(bulletEnemy2);

         _hpText.text = player2.intGetScore().toString();

         if (r.nextInt(8) == 6 || r.nextInt(8) == 2) {
           Heart heart = Heart(
               position: Vector2((r.nextInt(high - 40) + 40) - 60, 0),
               size: Vector2(30, 30), sprite: await loadSprite("heart.png"));
           add(heart);

         }*/
       }
     }, repeat: true);


    // addContactCallback(BallWallCallback());



  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if (remaninTime > 0) {
      timer.update(dt);
    }


  }

  void Contacts(){
    if(world.contactManager.contacts.isNotEmpty){
      world.contactManager.contacts.forEach((element) {
        print("Cuerpo A ${element.bodyA.userData}");
        print("Cuerpo B ${element.bodyB.userData.toString()}");

      });
     // print(world.contactManager.contacts.first);
    }
  }

  @override
  Future<void> onTapDown(TapDownInfo info) async {
    // TODO: implement onTapDown
    super.onTapDown(info);

    Bullet bullet=Bullet(sprite:await loadSprite("missil.png")
        ,position:player.position.clone()+Vector2(40,-15),size:Vector2(20,30),level: 1);
    add(bullet);

  }




}
