abstract class Command {
  final List<String> params;

  Command(this.params);

  Future<void> execute() async {}

  void undo() {}
}
