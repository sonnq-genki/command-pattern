import 'commands/base_command.dart';

class CommandHistory {
  List<Command> _histories = [];

  void push(Command command) {
    _histories.add(command);
  }

  Command? pop() {
    if (_histories.isEmpty) return null;

    final last = _histories.last;
    _histories.removeAt(_histories.length - 1);
    return last;
  }
}
