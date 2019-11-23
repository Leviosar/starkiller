import 'package:flutter/material.dart';
import 'package:starkiller/app/Enemy.dart';
import 'package:starkiller/app/Starkiller.dart';
import 'package:starkiller/app/types/MovePatterns.dart';
import 'package:starkiller/app/types/Movement.dart';

class Wave {

    double boogieSize;
    int boogieNumber;
    List<Enemy> boogies = [];
    Starkiller game;

    Wave(this.game, {this.boogieNumber = 3}) {
        this.boogieSize = this.calculateBoogieSize();
        this.spawn();
        this.addMovement(
            Movement(
                status: true,
                pattern: MovePatterns.forwards,
                yLimit: 200,
                speed: 6
            )
        );
    }

    void spawn() {
        double spacing = 100 / (this.boogieNumber + 1);
        this.boogies.addAll(
            List.generate(this.boogieNumber, (int index) {
                double x = (index * this.boogieSize) + ((index + 1) * spacing);
                double y = 0;
                return Enemy(this.game, size: this.boogieSize, initialX: x, initialY: y);
            })
        );
    }

    double calculateBoogieSize() {
        double screenWidth = this.game.screenSize.width;
        return (screenWidth - 100) / this.boogieNumber;
    }

    void addMovement(Movement mov) {
        this.boogies.forEach(
            (Enemy boogie) {
                boogie.addMovement(mov);
            }
        );
    }

    void update(double time) {
        this.boogies.forEach((Enemy boogie) => boogie.update(time));
        this.boogies.removeWhere((Enemy boogie) => boogie.healthPoints <= 0);
    }

    void render(Canvas canvas) {
        this.boogies.forEach(
            (Enemy boogie) {
                boogie.render(canvas);
            }
        );
    }
}