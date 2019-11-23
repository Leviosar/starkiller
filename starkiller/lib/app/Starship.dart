import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/components/component.dart';
import 'package:starkiller/app/Bullet.dart';
import 'package:starkiller/app/Enemy.dart';
import 'package:starkiller/app/Starkiller.dart';

class Starship extends SpriteComponent {

    final Starkiller game;
    bool fired = false;
    int healthPoints = 3;
    Rect hitbox;
    Sprite sprite;
    List<Bullet> bullets = [];

    Starship(this.game) {
        this.hitbox = Rect.fromLTWH((this.game.screenSize.width / 2) - 25, this.game.screenSize.height - 200, 50, 50);
        this.sprite = Sprite('xwingsprite.png');
    }

    @override
    void render(Canvas c) {
        this.sprite.renderRect(c, this.hitbox);
    }

    @override 
    void update(double time) {
        this.fire();
        this.bullets.forEach((Bullet bullet) => bullet.update(time));
        this.bullets.removeWhere((Bullet bullet) => bullet.isOffScreen());
        this.checkDeath();
    }

    void checkDeath() {
        this.game.currentWave.boogies.forEach(
            (Enemy boogie) {
                List<Bullet> forRemoval = [];
                boogie.bullets.forEach(
                    (Bullet bullet) {
                        if (this.hitbox.contains(bullet.hitbox.bottomCenter)) {
                            forRemoval.add(bullet);
                            this.healthPoints--;
                        }
                    }
                );
                forRemoval.forEach((Bullet bullet) => boogie.bullets.remove(bullet));
            }
        );
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