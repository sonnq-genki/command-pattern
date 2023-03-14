import 'base_command.dart';

class HelpCommand extends Command {
  final List<Map<String, List<String>>> acceptedCommands;
  HelpCommand(super.params, {required this.acceptedCommands});

  @override
  Future<void> execute() async {
    for (final command in acceptedCommands) {
      command.forEach((cmd, actions) {
        print('\t$cmd');

        actions.forEach((action) {
          print('\t\t$action');
        });
      });
      print('\n');
    }
    print('\n');
  }

  @override
  void undo() {}
}
