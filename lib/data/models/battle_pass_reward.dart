import 'package:matreshka_test_task/domain/models/battle_pass_reward.dart';

final class BattlePassRewardDTO extends IBattlePassReward {
  BattlePassRewardDTO({
    required super.id,
    required super.name,
    required super.image,
    required super.count,
    required super.rarity,
    required super.status,
    required super.isPremium,
  });
}
