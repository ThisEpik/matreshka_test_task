base class IBattlePassExperience {
  final int level;
  final int currentXP;
  final int nextLevelXP;

  IBattlePassExperience({
    required this.level,
    required this.currentXP,
    required this.nextLevelXP,
  });
}
