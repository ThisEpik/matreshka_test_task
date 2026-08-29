part of 'battle_pass_cubit.dart';

final class BattlePassState {
  final BattlePassProgressionState battlePassProgressionState;
  final int tasksPickedIndex;
  final List<IBattlePassTask> tasks;
  final List<IBattlePassReward> rewards;

  BattlePassState({
    required this.battlePassProgressionState,
    required this.tasksPickedIndex,
    required this.tasks,
    required this.rewards,
  });

  BattlePassState copyWith({
    BattlePassProgressionState? battlePassProgressionState,
    int? tasksPickedIndex,
    List<IBattlePassTask>? tasks,
    List<IBattlePassReward>? rewards,
  }) {
    return BattlePassState(
      battlePassProgressionState: battlePassProgressionState ?? this.battlePassProgressionState,
      tasksPickedIndex: tasksPickedIndex ?? this.tasksPickedIndex,
      tasks: tasks ?? this.tasks,
      rewards: rewards ?? this.rewards,
    );
  }
}
