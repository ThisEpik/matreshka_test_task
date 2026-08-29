base class IBattlePassTask {
  final int id;
  final int exp;
  final String description;
  final bool isComplete;

  IBattlePassTask({
    required this.id,
    required this.exp,
    required this.description,
    required this.isComplete,
  });
}
