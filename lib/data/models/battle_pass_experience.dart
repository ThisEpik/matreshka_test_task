import 'package:matreshka_test_task/domain/models/battle_pass_experience.dart';

final class BattlePassExperienceDTO extends IBattlePassExperience {
  BattlePassExperienceDTO({
    required super.level,
    required super.currentXP,
    required super.nextLevelXP,
  });
}
