import 'dart:html';
import 'dart:ui';

import 'package:untitled/board.dart';
import 'package:untitled/values.dart';

class Piece {


  Tetromino type;

  Piece({required this.type});

  List<int> position = [];

  Color get color {
    return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  }

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++){
          position[i] += rowLenght;
        } break;
      case Direction.left:
        for (int i = 0; i < position.length; i++){
          position[i] -= 1;
        } break;
      case Direction.right:
        for (int i = 0; i < position.length; i++){
          position[i] += 1;
        } break;
      default:
    }
  }

  int rotationState = 1;
  void rotatePiece() {

    List<int> newPosition = [];

    switch (type) {
      case Tetromino.L:
        switch (rotationState)  {
          case 0:
            newPosition = [
              position[1] - rowLenght,
              position[1],
              position[1] + rowLenght,
              position[1] + rowLenght + 1,
              ];
              if (piecePositionIsValid(newPosition)) {
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
              }
              break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenght - 1,
              ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
              break;
          case 2:
            newPosition = [
              position[1] + rowLenght,
              position[1],
              position[1] - rowLenght,
              position[1] - rowLenght - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] - rowLenght,
              position[1],
              position[1] + 1,
              position[1]  - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          default:
          }
        break;
      case Tetromino.J:
        switch (rotationState)  {
          case 0:
            newPosition = [
              position[1] - rowLenght,
              position[1],
              position[1] + rowLenght,
              position[1] + rowLenght - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowLenght - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + rowLenght,
              position[1],
              position[1] - rowLenght,
              position[1] - rowLenght + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          default:
        }
        break;
      case Tetromino.I:
        switch (rotationState)  {
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowLenght,
              position[1],
              position[1] + rowLenght,
              position[1] + 2 * rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + rowLenght,
              position[1],
              position[1] - rowLenght,
              position[1]  - 2 * rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          default:
        }
        break;
      case Tetromino.O:
        break;
      case Tetromino.S:
        switch (rotationState)  {
          case 0:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLenght - 1,
              position[1] + rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLenght,
              position[0],
              position[0] + 1,
              position[0] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLenght - 1,
              position[1] + rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowLenght,
              position[0],
              position[0] + 1,
              position[0] + rowLenght + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          default:
        }
        break;
      case Tetromino.Z:
        switch (rotationState)  {
          case 0:
            newPosition = [
              position[0] + rowLenght - 2,
              position[1],
              position[2] + rowLenght - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[0] - rowLenght + 2,
              position[1],
              position[2] - rowLenght + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[0] + rowLenght - 2,
              position[1],
              position[2] + rowLenght - 1,
              position[3] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[0] - rowLenght + 2,
              position[1],
              position[2] - rowLenght + 1,
              position[3] - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          default:
        }
        break;
      case Tetromino.T:
        switch (rotationState)  {
          case 0:
            newPosition = [
              position[2] - rowLenght,
              position[2],
              position[2] + 1,
              position[2] + rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] - rowLenght,
              position[1] - 1,
              position[1],
              position[1] + rowLenght,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[2] - rowLenght,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          default:
        }
        break;
      default:
        }

    }
    bool positionIsvalid(int position) {
      int row = (position / rowLenght).floor();
      int col = position % rowLenght;

      if(row < 0 || col < 0 || gameBoard[row][col] != null) {
        return false;
      } else {
        return true;
      }
    }

    bool piecePositionIsValid(List<int> piecePosition) {
      bool firstColOccupied = false;
      bool lastColOccupied = false;

      for (int pos in piecePosition) {
        if (!positionIsvalid(pos)) {
          return false;
        }

        int col = pos % rowLenght;

        if (col == 0) {
          firstColOccupied = true;
        }
        if (col == rowLenght - 1) {
          lastColOccupied = true;
        }
      }

      return !(firstColOccupied && lastColOccupied);
    }
  }
