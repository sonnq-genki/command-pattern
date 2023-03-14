import 'dart:io';

class CliWithoutCommand {
  final acceptedCommands = ['git'];
  final acceptedActions = ['pull', 'checkout'];

  void run() async {
    print('Welcome!\n');

    while (true) {
      String? line = stdin.readLineSync();
      if (line == null) continue;

      await this.execute(line);
    }
  }

  /// Code -3: Empty
  /// Code -2: Invalid action
  /// Code -1: Invalid command
  /// Code 0: Good
  /// Code 1: Show help
  int validate(List<String> tokens) {
    if (tokens.isEmpty) return -3;

    final command = tokens[0];

    if (tokens.length == 1) {
      if (acceptedCommands.contains(command)) {
        return 1;
      } else if (command.isEmpty) {
        return -3;
      } else {
        return -1;
      }
    }

    final action = tokens[1];
    if (!acceptedActions.contains(action)) {
      if (acceptedCommands.contains(command)) {
        return -2;
      } else {
        return -1;
      }
    }

    return 0;
  }

  Future<void> execute(String line) async {
    final tokens = line.split(' ');

    final code = this.validate(tokens);

    switch (code) {
      case -3:
        // Empty
        break;
      case -2:
        this.showInvalidAction(tokens);
        break;
      case -1:
        this.showInvalidCommand(tokens);
        break;
      case 0:
        final action = tokens[1];

        if (action == 'pull') {
          await this.handlePull(tokens);
        } else if (action == 'checkout') {
          await this.handleCheckout(tokens);
        }
        break;
      case 1:
        this.showHelp(tokens);
        break;
      default:
        this.showInvalidCommand(tokens);
    }
  }

  Future<void> handlePull(List<String> tokens) async {
    if (tokens.length == 2) {
      print('Pulling from origin...');
      await Future.delayed(Duration(seconds: 2), () {
        print('Pull from origin successfully\n');
      });
      return;
    }

    print('Pulling from "${tokens[2]}"...');
    await Future.delayed(Duration(seconds: 2), () {
      print('Pull from "${tokens[2]}" successfully\n');
    });
  }

  Future<void> handleCheckout(List<String> tokens) async {
    if (tokens.length == 2) {
      print('Invalid branch name\n');
      return;
    }

    print('Checkouting to "${tokens[2]}"...');
    await Future.delayed(Duration(seconds: 2), () {
      print('Checkout to "${tokens[2]}" successfully\n');
    });
  }

  void showInvalidCommand(List<String> tokens) {
    print('"${tokens[0]}" command not found\n');
  }

  void showHelp(List<String> tokens) {
    for (final action in acceptedActions) {
      print('\t$action');
    }
    print('\n');
  }

  void showInvalidAction(List<String> tokens) {
    print("'${tokens[1]}' is not a ${tokens[0]} action\n");
  }
}
