base class IBattlePassTask {
  final int exp;
  final String description;
  final bool isComplete;

  IBattlePassTask({
    required this.exp,
    required this.description,
    required this.isComplete,
  });
}
