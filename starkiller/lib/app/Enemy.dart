import 'dart:math';

import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import 'package:starkiller/app/Bullet.dart';
import 'package:starkiller/app/Starkiller.dart';
import 'package:starkiller/app/Starship.dart';

class Enemy extends SpriteComponent implements Starship{

    final Starkiller game;
    bool fired = false;
    Rect hitbox;
    Paint visual;
    List<Bullet> bullets = [];
    
    Enemy(this.game) {
        Random rng = Random();
        int px = rng.nextInt((this.game.screenSize.width - 30).round());
        int py = rng.nextInt((this.game.screenSize.height * 0.5).round());
        this.hitbox = Rect.fromLTWH(px.toDouble(), py.toDouble(), 30, 30);
        this.visual = Paint();
        this.visual.color = Colors.green;
    }

    @override
    void render(Canvas c) {
        c.drawRect(this.hitbox, this.visual);
    }

    @override 
    void update(double time) {}

    void fire() {
        if (bullets.isEmpty) this.bullets.add(Bullet(this.game, this));
    }

    @override
    void onPanDown(DragDownDetails details) {}

    @override
    void onPanUpdate(DragUpdateDetails details) {}
}