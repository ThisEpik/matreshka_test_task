part of 'battle_pass_cubit.dart';

final class BattlePassState {
  final BattlePassProgressionState battlePassProgressionState;
  final int tasksPickedIndex;
  final List<IBattlePassTask> tasks;
  final List<IBattlePassReward> rewards;
  final IBattlePassReward? pickedReward;
  final IBattlePassExperience? battlePassExperience;
  final bool isRewardsAtStart;
  final bool isRewardsAtEnd;

  BattlePassState({
    required this.battlePassProgressionState,
    required this.tasksPickedIndex,
    required this.tasks,
    required this.rewards,
    required this.battlePassExperience,
    required this.pickedReward,
    required this.isRewardsAtStart,
    required this.isRewardsAtEnd,
  });

  BattlePassState copyWith({
    BattlePassProgressionState? battlePassProgressionState,
    int? tasksPickedIndex,
    List<IBattlePassTask>? tasks,
    List<IBattlePassReward>? rewards,
    IBattlePassReward? pickedReward,
    IBattlePassExperience? battlePassExperience,
    bool? isRewardsAtStart,
    bool? isRewardsAtEnd,
  }) {
    return BattlePassState(
      battlePassProgressionState: battlePassProgressionState ?? this.battlePassProgressionState,
      tasksPickedIndex: tasksPickedIndex ?? this.tasksPickedIndex,
      tasks: tasks ?? this.tasks,
      rewards: rewards ?? this.rewards,
      pickedReward: pickedReward ?? this.pickedReward,
      battlePassExperience: battlePassExperience ?? this.battlePassExperience,
      isRewardsAtStart: isRewardsAtStart ?? this.isRewardsAtStart,
      isRewardsAtEnd: isRewardsAtEnd ?? this.isRewardsAtEnd,
    );
  }
}
