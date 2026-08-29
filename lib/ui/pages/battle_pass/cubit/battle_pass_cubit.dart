import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/domain/models/battle_pass_experience.dart';
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
          pickedReward: null,
          battlePassExperience: null,
          isRewardsAtStart: true,
          isRewardsAtEnd: false,
        ),
      );

  void init() {
    final tasks = repo.getTasks();
    final rewards = repo.getRewards();
    final battlePassExperience = repo.getBattlePassExperience();

    emit(
      state.copyWith(
        tasks: tasks,
        rewards: rewards,
        battlePassExperience: battlePassExperience,
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

  void pickReward(IBattlePassReward newReward) {
    emit(state.copyWith(pickedReward: newReward));
  }

  void updateRewardsScrollState({
    required bool isAtStart,
    required bool isAtEnd,
  }) {
    if (state.isRewardsAtStart == isAtStart && state.isRewardsAtEnd == isAtEnd) {
      return;
    }

    emit(
      state.copyWith(
        isRewardsAtStart: isAtStart,
        isRewardsAtEnd: isAtEnd,
      ),
    );
  }
}
