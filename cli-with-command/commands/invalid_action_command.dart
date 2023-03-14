import 'base_command.dart';

class InvalidActionCommand extends Command {
  InvalidActionCommand(super.params);

  @override
  Future<void> execute() async {
    assert(params.length == 2);

    print("'${params[1]}' is not a ${params[0]} action\n");
  }

  @override
  void undo() {}
}
