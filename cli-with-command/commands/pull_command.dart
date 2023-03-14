import 'base_command.dart';

class PullCommand extends Command {
  PullCommand(super.params);

  @override
  Future<void> execute() async {
    if (params.length == 0) {
      print('Pulling from origin...');
      await Future.delayed(Duration(seconds: 2), () {
        print('Pull from origin successfully\n');
      });
      return;
    }

    print('Pulling from "${params[0]}"...');
    await Future.delayed(Duration(seconds: 2), () {
      print('Pull from "${params[2]}" successfully\n');
    });
  }

  @override
  void undo() {
    print('Backed to before pulling\n');
  }
}
