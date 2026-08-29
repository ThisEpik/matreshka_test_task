import 'package:matreshka_test_task/domain/enums/battle_pass_reward_rarity.dart';
import 'package:matreshka_test_task/domain/enums/battle_pass_reward_status.dart';

base class IBattlePassReward {
  final int id;
  final String name;
  final String image;
  final int count;
  final BattlePassRewardRarity rarity;
  final BattlePassRewardStatus status;
  final bool isPremium;

  IBattlePassReward({
    required this.id,
    required this.name,
    required this.image,
    required this.count,
    required this.rarity,
    required this.status,
    required this.isPremium,
  });
}
