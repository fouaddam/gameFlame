import 'package:actividad/Ground.dart';
import 'package:actividad/Player.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import 'package:flame_texturepacker/flame_texturepacker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  final game = MyGame();
  runApp(GameWidget(game: game));

}


class MyGame extends FlameGame with HasDraggables {
  MyGame();

  final knobPaint = BasicPalette.yellow.withAlpha(200).paint();
  final backgroundPaint = BasicPalette.white.withAlpha(100).paint();
  late JoystickComponent joystickComponent;
  late ParallaxComponent parallaxComponent;

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

     Player player=Player(listSprite, position: Vector2(200,100), size: Vector2(100,100));
     //Ground ground=Ground(Vector2(100,100), Vector2(100,100));
     //add(ground);

     add(player);

     Ground ground=Ground( position: Vector2(-170,size.y-80), size:Vector2(size.x+350,150));
     ground
    .sprite = await loadSprite("street.png");

    add(ground);


  }


}
