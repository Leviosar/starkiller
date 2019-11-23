import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:starkiller/app/Starkiller.dart';

class HomeView {
    final Starkiller game;
    Rect titleRect;
    Sprite titleSprite;

    HomeView(this.game) {
        titleRect = Rect.fromLTWH(
            game.screenSize.width * 0.1,
            100,
            game.screenSize.width * 0.8,
            game.screenSize.width * 0.8
        );
        titleSprite = Sprite('blackhole.png');
    }

    void render(Canvas c) {
        this.titleSprite.renderRect(c, this.titleRect);
    }

    void update(double t) {}
}