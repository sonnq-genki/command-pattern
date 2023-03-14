import 'command_history.dart';
import 'commands/base_command.dart';

class CommandInvoker {
  late Command _command;
  CommandHistory _commandHistory;

  CommandInvoker(this._commandHistory);

  void setCommand(Command command) {
    this._command = command;
  }

  Future<void> executeCommand() async {
    _commandHistory.push(_command);
    await this._command.execute();
  }

  void undo() {
    final lastCommand = _commandHistory.pop();
    if (lastCommand == null) {
      print('Nothing to undo\n');
      return;
    }

    lastCommand.undo();
  }
}
