import 'package:matreshka_test_task/domain/models/battle_pass_experience.dart';
import 'package:matreshka_test_task/domain/models/battle_pass_reward.dart';
import 'package:matreshka_test_task/domain/models/battle_pass_task.dart';

abstract interface class IBattlePassRepository {
  List<IBattlePassTask> getTasks();
  List<IBattlePassReward> getRewards();
  IBattlePassExperience getBattlePassExperience();
}
