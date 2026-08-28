part of 'battle_pass_cubit.dart';

final class BattlePassState {
  final BattlePassProgressionState battlePassProgressionState;
  final int tasksPickedIndex;
  final List<IBattlePassTask> tasks;

  BattlePassState({
    required this.battlePassProgressionState,
    required this.tasksPickedIndex,
    required this.tasks,
  });

  BattlePassState copyWith({
    BattlePassProgressionState? battlePassProgressionState,
    int? tasksPickedIndex,
    List<IBattlePassTask>? tasks,
  }) {
    return BattlePassState(
      battlePassProgressionState: battlePassProgressionState ?? this.battlePassProgressionState,
      tasksPickedIndex: tasksPickedIndex ?? this.tasksPickedIndex,
      tasks: tasks ?? this.tasks,
    );
  }
}
