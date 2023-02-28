import 'package:flutter/material.dart';


class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const String PLAYER_X = "X";
  static const String PLAYER_O = "O";

  late String currentPlayer;
  late bool gameEnd;
  late List<String> occupied;

  @override
  void initState() {
    initializeGame();
    super.initState();
  }

  void initializeGame() {
    currentPlayer = PLAYER_X;
    gameEnd = false;
    occupied = List.filled(9, "");
  }

  void updateGame(int index) {
    if (gameEnd || occupied[index].isNotEmpty) {
      return;
    }

    setState(() {
      occupied[index] = currentPlayer;
      checkForWinner();
      if (!gameEnd) {
        changeTurn();
      }
    });
  }

  void changeTurn() {
    if (currentPlayer == PLAYER_X) {
      currentPlayer = PLAYER_O;
    } else {
      currentPlayer = PLAYER_X;
    }
  }

  void checkForWinner() {
    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var winningPos in winningList) {
      String playerPosition0 = occupied[winningPos[0]];
      String playerPosition1 = occupied[winningPos[1]];
      String playerPosition2 = occupied[winningPos[2]];

      if (playerPosition0.isNotEmpty &&
          playerPosition0 == playerPosition1 &&
          playerPosition1 == playerPosition2) {
        showGameOverMessage("Player $playerPosition0 won!");
        gameEnd = true;
        return;
      }
    }

    if (!occupied.contains("")) {
      showGameOverMessage("It's a draw!");
      gameEnd = true;
      return;
    }
  }

  void showGameOverMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
    duration: const Duration(seconds: 3),
    action: SnackBarAction(
    label: "New Game",
    onPressed: () {
    initializeGame();
    },
    );