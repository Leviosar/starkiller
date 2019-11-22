import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:starkiller/app/Starkiller.dart';

class Background {
    final Starkiller game;

    Sprite backgroundSprite;
    Rect bgRect;

    Background(this.game) {
        this.backgroundSprite = Sprite('animated_background.gif');
        this.bgRect = Rect.fromLTWH(0, 0, this.game.screenSize.width, this.game.screenSize.height);
    }

    void render(Canvas c) {
        this.backgroundSprite.renderRect(c, this.bgRect);
    }

    void update(double t) {}
}