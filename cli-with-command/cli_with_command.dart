import 'dart:io';

import 'command_history.dart';
import 'command_invoker.dart';
import 'commands/checkout_command.dart';
import 'commands/help_command.dart';
import 'commands/invalid_action_command.dart';
import 'commands/invalid_command.dart';
import 'commands/pull_command.dart';

class CliWithCommand {
  final acceptedCommands = ['git', 'undo'];
  final acceptedActions = ['pull', 'checkout'];

  late final CommandInvoker _commandInvoker;

  CliWithCommand() : _commandInvoker = CommandInvoker(CommandHistory());

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
  /// Code 2: Undo
  int validate(List<String> tokens) {
    if (tokens.isEmpty) return -3;

    final command = tokens[0];

    if (tokens.length == 1) {
      if (acceptedCommands.contains(command)) {
        if (command == 'undo') return 2;
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
        _commandInvoker.setCommand(InvalidActionCommand(tokens.sublist(0, 2)));
        _commandInvoker.executeCommand();
        break;
      case -1:
        _commandInvoker.setCommand(InvalidCommand([tokens[0]]));
        _commandInvoker.executeCommand();
        break;
      case 0:
        final action = tokens[1];
        final params = tokens.sublist(2);

        if (action == 'pull') {
          _commandInvoker.setCommand(PullCommand(params));
          await _commandInvoker.executeCommand();
        } else if (action == 'checkout') {
          _commandInvoker.setCommand(CheckoutCommand(params));
          await _commandInvoker.executeCommand();
        }
        break;
      case 1:
        _commandInvoker.setCommand(
          HelpCommand(
            [],
            acceptedCommands: [
              {
                'git': ['pull', 'checkout']
              },
              {'undo': []}
            ],
          ),
        );
        _commandInvoker.executeCommand();
        break;
      case 2:
        _commandInvoker.undo();
        break;
      default:
        _commandInvoker.setCommand(InvalidCommand([tokens[0]]));
        _commandInvoker.executeCommand();
    }
  }
}
