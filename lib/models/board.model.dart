import 'dart:ffi';

import 'package:tic_tac_toe/models/player.model.dart';

class Board {
  static const boardLength = 9;
  static const blockSize = 300.0;

  List<String>? board;
  static List<String>? initGameBoard() {
    return List.generate(boardLength, (index) => Player.empty);
  }

  static List<Object> checkWinner(List<String> checkList) {
    if (checkList.length < 3) {
      return [false, ''];
    }
    List<String> list = ['012', '036', '048', '147', '258', '345', '678', '246'];
    int correctChar = 0;
    int returnListIndex = 0;

    for (var i = 0; i < list.length; i++) {
      var splitArray  = list[i].split('');
      // print('checkList is = $checkList');
      // print('list string to compare is = $splitArray');
      for (var j = 0; j < checkList.length; j++) {
        for (var number in splitArray) {
          if (checkList[j].contains(number)) {
            correctChar++;
          }
        }
        returnListIndex = j;
      }
      if (correctChar != 3) {
        correctChar = 0;
        returnListIndex = 0;
      } else {
        return [true, splitArray];
      }
    }
    return [false, ''];
  }
}