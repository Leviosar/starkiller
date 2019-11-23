import 'package:flutter/material.dart';
import 'package:flame/gestures.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:starkiller/app/Background.dart';
import 'package:starkiller/app/Bullet.dart';
import 'package:starkiller/app/Enemy.dart';
import 'package:starkiller/app/Starship.dart';
import 'package:starkiller/app/Wave.dart';

class Starkiller extends BaseGame with PanDetector {
    
    Size screenSize;
    Background background;
    List<Starship> players = [];
    List<Enemy> enemies = [];
    Wave currentWave;
    int difficulty = 3;

    Starkiller({this.screenSize}) {
        this.setup();
    }

    void setup() async {
        resize(await Flame.util.initialDimensions());
        this.background = Background(this);
        this.spawnPlayer();
        this.spawnWave();
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
        
        if (currentWave != null) this.currentWave.render(canvas);
    }

    @override
    void update(double time) {
        this.players.forEach((Starship player) => player.update(time));
        this.players.removeWhere((Starship player) => player.healthPoints <= 0);
        if (currentWave != null) this.currentWave.update(time);
        if (currentWave.boogies.isEmpty) this.spawnWave();
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

    void spawnWave() {
        this.currentWave = Wave(this, boogieNumber: this.difficulty);
        this.difficulty++;
    }
}