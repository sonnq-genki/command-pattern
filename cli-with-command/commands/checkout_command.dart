import 'base_command.dart';

class CheckoutCommand extends Command {
  CheckoutCommand(super.params);

  @override
  Future<void> execute() async {
    if (params.length == 0) {
      print('Invalid branch name\n');
      return;
    }

    print('Checkouting to "${params[0]}"...');
    await Future.delayed(Duration(seconds: 2), () {
      print('Checkout to "${params[0]}" successfully\n');
    });
  }

  @override
  void undo() {
    print('Backed to before checkouting\n');
  }
}
