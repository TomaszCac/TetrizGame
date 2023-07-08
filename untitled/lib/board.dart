import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:untitled/piece.dart';
import 'package:untitled/pixel.dart';
import 'package:untitled/values.dart';


List<List<Tetromino?>> gameBoard = List.generate(
    colLenght,
        (i) => List.generate (
          rowLenght,
            (j) =>  null,
        ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {



  Piece currentPiece = Piece(type: Tetromino.T);

  int currentScore = 0;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(
        frameRate,
        (timer)
        {  setState(() {
          clearLines();
          checkLanding();
          if (gameOver == true) {
            timer.cancel();
            showGameOverDialog();
          }

          currentPiece.movePiece(Direction.down);
        });
        });
  }

  void showGameOverDialog() {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Przegrales!'),
      content: Text("Twoje punkty: $currentScore"),
      actions: [
        TextButton(onPressed: (){
          resetGame();
          Navigator.pop(context);
        }, child: Text('Zagraj Ponownie'))
      ],
    ),);
  }
  void resetGame() {
    gameBoard = List.generate(
      colLenght,
          (i) => List.generate (
        rowLenght,
            (j) =>  null,
      ),
    );
    gameOver = false;
    currentScore = 0;
    createNewPiece();
    startGame();

  }

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
       int row = (currentPiece.position[i]/ rowLenght).floor();
       int col = currentPiece.position[i] % rowLenght;

       if  (direction == Direction.left) {
         col -= 1;
       } else if (direction == Direction.right) {
         col += 1;
       } else if (direction == Direction.down) {
         row += 1;
       }

       if ( row >= colLenght || col < 0 || col >= rowLenght) {
         return true;
       } else if (col > 0 && row > 0 && gameBoard[row][col] != null) {
         return true;
       }
    }

    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i=0; i< currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLenght).floor();
        int col = currentPiece.position[i] % rowLenght;
        if (row>=0 && col>=0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();

    }
  }

  void createNewPiece() {
    Random rand = Random();

    Tetromino randomType =
    Tetromino.values[rand.nextInt(Tetromino.values.length)];

    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();
    if (isGameOver()) {
      gameOver = true;
    }
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void clearLines() {
    for (int row = colLenght - 1; row >= 0; row--) {
      bool rowIsFull = true;
      for (int col = 0; col < rowLenght; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      if (rowIsFull) {
        for(int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(row, (index) => null);
        currentScore++;
      }
    }
  }

  bool isGameOver() {
    for (int col = 0; col<rowLenght; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: GridView.builder(
                  itemCount: rowLenght * colLenght,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowLenght),
                  itemBuilder: (context, index) {

                    int row = (index / rowLenght).floor();
                    int col = index % rowLenght;

                    if (currentPiece.position.contains(index)) {
                      return Pixel(
                        color: currentPiece.color,
                      );
                    } else if (gameBoard[row][col] != null) {
                      final Tetromino? tetrominoType = gameBoard[row][col];
                      return Pixel(color: tetrominoColors[tetrominoType]);
                    }else {
                      return Pixel(
                          color: Colors.grey,);
                    }

                  } ),

          ),

          Text('Punkty: $currentScore', style: TextStyle(color: Colors.white),
          ),
          
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: moveLeft, color: Colors.white, icon: Icon(Icons.arrow_back_ios),),

                IconButton(onPressed: rotatePiece, color: Colors.white, icon: Icon(Icons.rotate_right),),

                IconButton(onPressed: moveRight, color: Colors.white, icon: Icon(Icons.arrow_forward_ios),),
              ],
            ),
          )

        ],
      )
      );

  }
}
