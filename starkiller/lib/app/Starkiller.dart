import 'package:flutter/material.dart';
import 'package:flame/gestures.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:starkiller/app/Background.dart';
import 'package:starkiller/app/Bullet.dart';
import 'package:starkiller/app/Enemy.dart';
import 'package:starkiller/app/Scoreboard.dart';
import 'package:starkiller/app/Starship.dart';
import 'package:starkiller/app/StartButton.dart';
import 'package:starkiller/app/View.dart';
import 'package:starkiller/app/Wave.dart';
import 'package:starkiller/app/views/HomeView.dart';

class Starkiller extends BaseGame with PanDetector {
    
    Size screenSize;
    Background background;
    Background homeBackground;
    List<Starship> players = [];
    List<Enemy> enemies = [];
    Wave currentWave;
    int difficulty = 3;

    View activeView = View.home;
    HomeView homeView;
    StartButton startButton;
    Scoreboard scoreboard;

    Starkiller({this.screenSize}) {
        this.setup();
    }

    void setup() async {
        resize(await Flame.util.initialDimensions());
        this.background = Background(this);
        this.homeBackground = Background(this, color: true);
        this.homeView = HomeView(this);
        this.startButton = StartButton(this);
        this.scoreboard = Scoreboard(this);
    }

    @override 
    void render(Canvas canvas) {
        switch (this.activeView) {
            case View.home:
                this.homeBackground.render(canvas);
                this.homeView.render(canvas);
                this.startButton.render(canvas);
            break;
            case View.playing:
                this.background.render(canvas);
                this.players.forEach(
                    (Starship player) {
                        player.render(canvas);
                        player.bullets.forEach((Bullet bullet) => bullet.render(canvas));
                    }
                );
                if (currentWave != null) this.currentWave.render(canvas);
                // this.scoreboard.render(canvas);
            break;
            case View.lost:
                this.homeBackground.render(canvas);
                this.startButton.render(canvas);
                // this.scoreboard.render(canvas);
            break;
            default:
        }
    }

    @override
    void update(double time) {
        if (this.players != null) this.players.forEach((Starship player) => player.update(time));
        if (this.players != null) this.players.removeWhere((Starship player) => player.healthPoints <= 0);
        if (currentWave != null) this.currentWave.update(time);
        if (currentWave != null && currentWave.boogies.isEmpty) this.spawnWave();
        if (this.activeView == View.playing && this.players.isEmpty) this.activeView = View.lost;
    }

    @override
    void resize(Size size) {
        this.screenSize = size;
        super.resize(size);
    }

    void onTapDown(TapDownDetails details) {
        if (this.startButton != null && (this.activeView == View.home || this.activeView == View.lost)) {
            if (this.startButton.rect.contains(details.globalPosition)) {
                this.startButton.onTapDown();
            }
        }
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