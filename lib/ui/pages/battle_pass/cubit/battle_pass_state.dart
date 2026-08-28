part of 'battle_pass_cubit.dart';

final class BattlePassState {
  final BattlePassProgressionState battlePassProgressionState;
  final int tasksPickedIndex;

  BattlePassState({required this.battlePassProgressionState, required this.tasksPickedIndex});

  BattlePassState copyWith({
    BattlePassProgressionState? battlePassProgressionState,
    int? tasksPickedIndex,
  }) {
    return BattlePassState(
      battlePassProgressionState: battlePassProgressionState ?? this.battlePassProgressionState,
      tasksPickedIndex: tasksPickedIndex ?? this.tasksPickedIndex,
    );
  }
}
