import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/domain/models/battle_pass_reward.dart';
import 'package:matreshka_test_task/domain/models/battle_pass_task.dart';
import 'package:matreshka_test_task/domain/repos/battle_pass_repo.dart';
import 'package:matreshka_test_task/ui/pages/battle_pass/models/battle_pass_progression_state.dart';

part 'battle_pass_state.dart';

class BattlePassCubit extends Cubit<BattlePassState> {
  final IBattlePassRepository repo;

  BattlePassCubit({required this.repo})
    : super(
        BattlePassState(
          battlePassProgressionState: BattlePassProgressionState.free,
          tasksPickedIndex: 0,
          tasks: [],
          rewards: [],
        ),
      );

  void init() {
    final tasks = repo.getTasks();
    final rewards = repo.getRewards();
    emit(
      state.copyWith(
        tasks: tasks,
        rewards: rewards,
      ),
    );
  }

  void changeBattlePassProgression(BattlePassProgressionState newState) {
    emit(
      state.copyWith(battlePassProgressionState: newState),
    );
  }

  void changeTasksIndex(int index) {
    emit(state.copyWith(tasksPickedIndex: index));
  }
}
