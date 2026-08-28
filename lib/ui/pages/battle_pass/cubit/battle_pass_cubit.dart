import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/ui/pages/battle_pass/models/battle_pass_progression_state.dart';

part 'battle_pass_state.dart';

class BattlePassCubit extends Cubit<BattlePassState> {
  BattlePassCubit()
    : super(
        BattlePassState(
          battlePassProgressionState: BattlePassProgressionState.free,
          tasksPickedIndex: 0,
        ),
      );

  void changeBattlePassProgression(BattlePassProgressionState newState) {
    emit(
      state.copyWith(battlePassProgressionState: newState),
    );
  }

  void changeTasksIndex(int index) {
    emit(state.copyWith(tasksPickedIndex: index));
  }
}
