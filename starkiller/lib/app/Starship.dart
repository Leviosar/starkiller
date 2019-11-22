import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:starkiller/app/Bullet.dart';
import 'package:starkiller/app/Starkiller.dart';

class Starship extends SpriteComponent {

    final Starkiller game;
    bool fired = false;
    Rect hitbox;
    Paint visual;
    List<Bullet> bullets = [];

    Starship(this.game) {
        this.hitbox = Rect.fromLTWH((this.game.screenSize.width / 2) - 25, this.game.screenSize.height - 200, 50, 50);
        this.visual = Paint();
        this.visual.color = Colors.white;
    }

    @override
    void render(Canvas c) {
        c.drawRect(this.hitbox, this.visual);
    }

    @override 
    void update(double time) {
        this.fire();
    }

    void onPanUpdate(DragUpdateDetails details) {
        double currentX = details.globalPosition.dx - 25;
        double currentY = details.globalPosition.dy - 25;
        this.hitbox = Rect.fromLTWH(currentX, currentY, 50, 50);
    }

    void onPanDown(DragDownDetails details) {
        double currentX = details.globalPosition.dx - 25;
        double currentY = details.globalPosition.dy - 25;
        this.hitbox = Rect.fromLTWH(currentX, currentY, 50, 50);
    }

    @override
    bool destroy() {
        bool remove;
        return remove;
    }

    @override
    void resize(Size size) {}

    void fire() {
        if (bullets.isEmpty) this.bullets.add(Bullet(this.game, this));
    }
}