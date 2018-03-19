// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:stagexl/stagexl.dart';

import '../game.dart';
import 'game_element.dart';

class GameBackgroundElement extends Sprite {
  num get _backgroundScale => (parent as GameElement).boardScale;
  int get _boardSize => (parent as GameElement).boardSize;
  Game get _game => (parent as GameElement).game;

  GameBackgroundElement(GameElement gameElement, TextureAtlas op) {
    addTo(gameElement);

    //the lengths we go to reduce bytes down the wire...
    var ttl = new Bitmap(op.getBitmapData('background_top_left'));
    var stl = new Bitmap(op.getBitmapData('background_side_left'))..y = 96;

    var bbl = new Bitmap(op.getBitmapData('background_top_left'))
      ..scaleY = -1
      ..y = 1534;
    var sbl = new Bitmap(op.getBitmapData('background_side_left'))
      ..scaleY = -1
      ..y = 1438;

    var ttr = new Bitmap(op.getBitmapData('background_top_left'))
      ..scaleX = -1
      ..x = 2048;
    var str = new Bitmap(op.getBitmapData('background_side_left'))
      ..scaleX = -1
      ..x = 2048
      ..y = 96;

    var bbr = new Bitmap(op.getBitmapData('background_top_left'))
      ..scaleX = -1
      ..x = 2048
      ..scaleY = -1
      ..y = 1534;
    var sbr = new Bitmap(op.getBitmapData('background_side_left'))
      ..scaleX = -1
      ..x = 2048
      ..scaleY = -1
      ..y = 1438;

    addChild(ttl);
    addChild(stl);
    addChild(bbl);
    addChild(sbl);
    addChild(ttr);
    addChild(str);
    addChild(bbr);
    addChild(sbr);

    //draw the board
    var boardData = new BitmapData(_boardSize, _boardSize, 0x000000);
    var cr = new Rectangle<int>(0, 0, 112, 122);
    boardData
      ..drawPixels(op.getBitmapData('game_board_corner_top_left'), cr,
          new Point<int>(0, 0))
      ..drawPixels(op.getBitmapData('game_board_corner_top_right'), cr,
          new Point<int>(_boardSize - 112, 0))
      ..drawPixels(op.getBitmapData('game_board_corner_bottom_left'), cr,
          new Point<int>(0, _boardSize - 112))
      ..drawPixels(op.getBitmapData('game_board_corner_bottom_right'), cr,
          new Point<int>(_boardSize - 112, _boardSize - 112));
    var tbr = new Rectangle<int>(0, 0, 80, 112);
    var lrr = new Rectangle<int>(0, 0, 112, 80);
    for (var i = 0; i < _game.field.width - 2; i++) {
      boardData
        ..drawPixels(op.getBitmapData('game_board_side_top'), tbr,
            new Point<int>(112 + i * 80, 0))
        ..drawPixels(op.getBitmapData('game_board_side_bottom'), tbr,
            new Point<int>(112 + i * 80, _boardSize - 112))
        ..drawPixels(op.getBitmapData('game_board_side_left'), lrr,
            new Point<int>(0, 112 + i * 80))
        ..drawPixels(op.getBitmapData('game_board_side_right'), lrr,
            new Point<int>(_boardSize - 112, 112 + i * 80));
    }

    var board = new Bitmap(boardData)
      ..x = GameElement.boardOffset.x
      ..y = GameElement.boardOffset.y
      ..scaleX = _backgroundScale
      ..scaleY = _backgroundScale;

    addChild(board);
  }
}
