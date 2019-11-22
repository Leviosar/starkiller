import 'package:flutter/material.dart';
import 'package:starkiller/app/Starkiller.dart';

class GameWrapper extends StatelessWidget {
    final Starkiller game;
    
    GameWrapper(this.game);
    
    @override
    Widget build(BuildContext context) {
        return game.widget;
    }
}