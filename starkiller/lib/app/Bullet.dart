import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import 'package:starkiller/app/Starkiller.dart';
import 'package:starkiller/app/Starship.dart';
import 'package:starkiller/app/types/MovePatterns.dart';

class Bullet extends SpriteComponent {
    
    final Starkiller game;
    final Starship player;
    bool reverse;
    Rect hitbox;
    Paint visual;

    Bullet(this.game, this.player, {this.reverse = false}) {
        this.hitbox = Rect.fromLTWH(this.player.hitbox.topCenter.dx, this.player.hitbox.topCenter.dy, 4, 12);
        this.visual = Paint();
        this.visual.color = Colors.red;
    }

    bool isOffScreen() => this.hitbox.topCenter.dy <= 0.0;

    @override
    void update(double t) {
        if (this.reverse) {
            this.hitbox = this.hitbox.translate(0, 10);
        } else {
            this.hitbox = this.hitbox.translate(0, -10);
        }
    }

    @override
    void render(Canvas canvas) {
        canvas.drawRect(this.hitbox, this.visual);
    }

    @override
    bool destroy() {
        return true;
    }
}