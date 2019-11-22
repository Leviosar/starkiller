import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/util.dart';
import 'package:starkiller/app/GameWrapper.dart';
import 'package:starkiller/app/Starkiller.dart';

void main() async {
    Flame.images.loadAll(['background.png', 'xwingsprite.png', 'tiefighter.png', 'animated_background.gif']);
    Starkiller game = Starkiller();
    
    runApp(
        GameWrapper(game)
    );
}