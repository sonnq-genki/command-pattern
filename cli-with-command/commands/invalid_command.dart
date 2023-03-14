import 'base_command.dart';

class InvalidCommand extends Command {
  InvalidCommand(super.params);

  @override
  Future<void> execute() async {
    assert(params.isNotEmpty);

    print('"${params[0]}" command not found\n');
  }

  @override
  void undo() {}
}
