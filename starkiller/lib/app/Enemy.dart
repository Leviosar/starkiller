import 'dart:math';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:starkiller/app/Bullet.dart';
import 'package:starkiller/app/Starkiller.dart';
import 'package:starkiller/app/Starship.dart';
import 'package:starkiller/app/types/Movement.dart';

class Enemy extends SpriteComponent implements Starship{

    final Starkiller game;
    
    bool fired = false;
    int fireCounter = 0;
    Rect hitbox;
    Sprite sprite;
    List<Bullet> bullets = [];
    List<Movement> movements = [];
    double size;
    double initialX, initialY;
    int healthPoints = 1;
    
    Enemy(this.game, {this.size, this.initialX, this.initialY}) {
        this.hitbox = Rect.fromLTWH(this.initialX, this.initialY, this.size, this.size);
        this.sprite = Sprite('tiefightersprite.png');
    }

    @override
    void render(Canvas canvas) {
        this.sprite.renderRect(canvas, this.hitbox);
        
        this.bullets.forEach(
            (Bullet bullet) {
                bullet.render(canvas);
            }
        );
    }

    @override 
    void update(double time) {
        
        this.checkDeath();
        this.bullets.removeWhere((Bullet bullet) => bullet.isOffScreen());
        this.bullets.forEach((Bullet bullet) => bullet.update(time));

        this.fireCounter++;
        if (this.fireCounter == 60) {
            this.fire();
            this.fireCounter = 0;
        }

        this.movements.forEach(
            (Movement move) {
                move.checkLimits(this.hitbox.center.dx, this.hitbox.center.dy);
                if (move.status) {
                    this.move(move);
                }
            } 
        );
    }

    void move(Movement move) {
        this.hitbox = this.hitbox.translate(
            move.pattern[0] * move.speed,
            move.pattern[1] * move.speed,
        ); 
    }

    void addMovement(Movement mov) {
        this.movements.add(mov);
    }

    void fire() {
        this.bullets.add(Bullet(this.game, this, reverse: true));
    }

    void checkDeath() {
        this.game.players.forEach(
            (Starship player) {
                List<Bullet> forRemoval = [];
                player.bullets.forEach(
                    (Bullet bullet) {
                        if (this.hitbox.contains(bullet.hitbox.bottomCenter)) {
                            forRemoval.add(bullet);
                            this.healthPoints--;
                            if (this.healthPoints == 0) this.game.scoreboard.score++;
                        }
                    }
                );
                forRemoval.forEach((Bullet bullet) => player.bullets.remove(bullet));
            }
        );
    }

    @override
    void onPanDown(DragDownDetails details) {}

    @override
    void onPanUpdate(DragUpdateDetails details) {}
}