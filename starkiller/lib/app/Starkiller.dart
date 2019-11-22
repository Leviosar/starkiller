import 'package:flutter/material.dart';
import 'package:flame/gestures.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:starkiller/app/Background.dart';
import 'package:starkiller/app/Bullet.dart';
import 'package:starkiller/app/Enemy.dart';
import 'package:starkiller/app/Starship.dart';

class Starkiller extends BaseGame with PanDetector {
    
    Size screenSize;
    Background background;
    List<Starship> players = [];
    List<Enemy> enemies = [];

    Starkiller() {
        this.setup();
    }

    void setup() async {
        resize(await Flame.util.initialDimensions());
        this.background = Background(this);
        this.spawnPlayer();
        this.spawnEnemy();
    }

    @override 
    void render(Canvas canvas) {
        this.background.render(canvas);
        this.players.forEach(
            (Starship player) {
                player.render(canvas);
                player.bullets.forEach((Bullet bullet) => bullet.render(canvas));
            }
        );

        this.enemies.forEach(
            (Enemy enemy) {
                enemy.render(canvas);
            }
        );
    }

    @override
    void update(double time) {
        if (this.enemies.isEmpty) {
            this.spawnEnemy();
        }
        this.players.forEach(
            (Starship player) {
                player.update(time);
                player.bullets.forEach(
                    (Bullet bullet) { 
                        bullet.update(time);
                        this.enemies.removeWhere(
                            (Enemy enemy) {
                                return enemy.hitbox.contains(bullet.hitbox.topCenter);
                            }
                        );
                    }
                );
                player.bullets.removeWhere((Bullet bullet) => bullet.isOffScreen());
            }
        );
    }

    @override
    void resize(Size size) {
        this.screenSize = size;
        super.resize(size);
    }

    void onPanDown(DragDownDetails details) {
        this.players.forEach(
            (Starship player) {
                if (player.hitbox.contains(details.globalPosition)) {
                    player.onPanDown(details);
                }
            }
        );
    }

    void onPanUpdate(DragUpdateDetails details) {
        this.players.forEach(
            (Starship player) {
                if (player.hitbox.contains(details.globalPosition)) {
                    player.onPanUpdate(details);
                }
            }
        );
    }

    void spawnPlayer() {
        this.players.add(
            Starship(this)
        );
    }

    void spawnEnemy() {
        this.enemies.add(
            Enemy(this)
        );
    }
}