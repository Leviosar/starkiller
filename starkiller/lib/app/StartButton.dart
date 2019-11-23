import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:starkiller/app/Starkiller.dart';
import 'package:starkiller/app/View.dart';

class StartButton extends SpriteComponent{
    
    final Starkiller game;
    Rect rect;
    Sprite sprite;

    StartButton(this.game) {
        this.rect = Rect.fromLTWH(
            game.screenSize.width * 0.1,
            game.screenSize.height - (game.screenSize.width * 0.6),
            game.screenSize.width * 0.8,
            game.screenSize.width * 0.4
        );
        this.sprite = Sprite('startbutton.png');
    }

    void render(Canvas c) {
        sprite.renderRect(c, this.rect);
    }

    void update(double t) {}

    void onTapDown() {
        this.game.activeView = View.playing;
        this.game.spawnWave();
        this.game.spawnPlayer();
    }
}