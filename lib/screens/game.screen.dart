import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/board.model.dart';
import 'package:tic_tac_toe/theme/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "x";
  Board game = Board();
  bool gameOver = false;
  int turn = 0;
  Map<String, String> checkpoints = {
    "0": "",
    "1": "",
    "2": "",
    "3": "",
    "4": "",
    "5": "",
    "6": "",
    "7": "",
    "8": ""
  };

  List<String> userA = [];
  List<String> userB = [];

  void resetGame() {
    game.board = Board.initGameBoard();
    lastValue = "x";
    checkpoints = {
      "0": "",
      "1": "",
      "2": "",
      "3": "",
      "4": "",
      "5": "",
      "6": "",
      "7": "",
      "8": ""
    };
    userA = [];
    userB = [];
    turn = 0;
    gameOver = false;
    indexToDrawLine =  [];
  }
  List<String> indexToDrawLine = [];

  void check(List<String> user, String index) {
    user.add(index);
    user == userA ? checkpoints[index] = "x" : checkpoints[index] = "o";

    var res = Board.checkWinner(user);
    print(res);
    if (res[0] == true) {
      var snackBar = SnackBar(
        content: Text("User ${user == userA ? 'o' : 'x'} won! Let's restart the game!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      gameOver = true;
      indexToDrawLine = res[1] as List<String>;
      // print("indexToDrawLine $indexToDrawLine");

    } else if (turn == 8) {
      var snackBar = const SnackBar(
        content: Text("DRAW! Let's restart the game!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      gameOver = true;
    }
  }

  @override
  void initState() {
    super.initState();
    game.board = Board.initGameBoard();
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "It's ${lastValue.toUpperCase()} turn!",
            style: const TextStyle(
              fontSize: 58.0,
              color: Colors.white
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
                crossAxisCount: Board.boardLength ~/ 3,
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(
                  Board.boardLength,
                  (index) => InkWell(
                    onTap: gameOver ? null : () {
                      print('index $index');
                      setState(() {
                        if (game.board![index] == "") {
                          game.board![index] = lastValue;
                          if (lastValue == "x") {
                            lastValue = "o";
                          } else {
                            lastValue = "x";
                          }
                        }
                        check(lastValue == "x" ? userA : userB, index.toString());
                        turn++;
                      });
                    },
                    child: Container(
                      width: Board.blockSize,
                      height: Board.blockSize,
                      decoration: BoxDecoration(
                        color: indexToDrawLine.contains((index).toString()) ? Colors.red : CustomColor.secondaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                            game.board![index].toUpperCase(),
                          style: TextStyle(
                            color: indexToDrawLine.contains((index).toString()) ? Colors.white : game.board![index] == "x"
                                ? Colors.pinkAccent
                                : Colors.blueAccent,
                            fontSize: 64.0
                          ),
                        ),
                      ),
                    ),
                  )
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.replay
            ),
            onPressed: () {
              setState(() {
                resetGame();
              });
            },
            label: const Text("Repeat the game!"),
          )
        ],
      ),
    );
  }
}
