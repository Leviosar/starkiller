import 'package:flutter/material.dart';

class Movement {
    double speed;
    bool status;
    List<int> pattern; 
    double xLimit, yLimit;

    Movement({
        this.status = false, 
        this.speed = 1, 
        this.pattern = const [0,0],
        this.xLimit = 1000,
        this.yLimit = 1000
    });

    void checkLimits(double x, double y) {
        if (x >= this.xLimit || y >= this.yLimit) this.status = false;
    }
}