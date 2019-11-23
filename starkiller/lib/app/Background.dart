import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:starkiller/app/Starkiller.dart';

class Background {
    final Starkiller game;

    Sprite backgroundSprite;
    Rect bgRect;
    bool color;
    Paint bgColor;

    Background(this.game, {this.color = false}) {
        this.bgRect = Rect.fromLTWH(0, 0, this.game.screenSize.width, this.game.screenSize.height);
        if (this.color) {
            this.bgColor = Paint();
            this.bgColor.color = Color(0xff3d3d3d);
        } else {
            this.backgroundSprite = Sprite('animated_background.gif');
        }
    }

    void render(Canvas c) {
        if (this.color) {
            c.drawRect(this.bgRect, this.bgColor);
        } else {
            this.backgroundSprite.renderRect(c, this.bgRect);
        }
    }

    void update(double t) {}
}