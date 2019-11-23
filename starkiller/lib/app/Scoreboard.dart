import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:starkiller/app/Starkiller.dart';
import 'package:starkiller/app/View.dart';

class Scoreboard{
    
    final Starkiller game;
    TextSpan text;
    TextPainter painter;
    int score;

    Scoreboard(this.game, {this.score = 0}) {
        this.text = TextSpan(text: score.toString(), style: TextStyle(color: Colors.white));
        this.painter = TextPainter(text: this.text, textDirection: TextDirection.ltr, textAlign: TextAlign.start);
    }

    void render(Canvas c) {
        this.painter.paint(c, Offset(this.game.screenSize.width * 0.1, this.game.screenSize.height * 0.1));
    }

    void update(double t) {}

    void onTapDown() {
        this.game.activeView = View.playing;
        this.game.spawnWave();
        this.game.spawnPlayer();
    }
}