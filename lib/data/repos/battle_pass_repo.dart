import 'dart:math' show Random;

import 'package:matreshka_test_task/data/models/battle_pass_reward.dart';
import 'package:matreshka_test_task/data/models/battle_pass_task.dart';
import 'package:matreshka_test_task/domain/enums/battle_pass_reward_rarity.dart';
import 'package:matreshka_test_task/domain/enums/battle_pass_reward_status.dart';
import 'package:matreshka_test_task/domain/models/battle_pass_reward.dart';
import 'package:matreshka_test_task/domain/models/battle_pass_task.dart';
import 'package:matreshka_test_task/domain/repos/battle_pass_repo.dart';
import 'package:matreshka_test_task/ui/kit/images.dart';

final class MockBattlePassRepo implements IBattlePassRepository {
  @override
  List<IBattlePassTask> getTasks() {
    final random = Random();

    return [
      BattlePassTaskDTO(
        id: random.nextInt(10000 - 1) + 1,
        exp: random.nextInt(300 - 5) + 5,
        description: 'Используйте определенный предмет (Энергетик) 10 раз.',
        isComplete: true,
      ),
      BattlePassTaskDTO(
        id: random.nextInt(10000 - 1) + 1,
        exp: random.nextInt(300) + 5,
        description: 'Используйте определенный предмет (Бургер) 10 раз.',
        isComplete: false,
      ),
      BattlePassTaskDTO(
        id: random.nextInt(10000 - 1) + 1,
        exp: random.nextInt(300) + 5,
        description: 'Используйте определенный предмет (Краска) 10 раз.',
        isComplete: true,
      ),
      BattlePassTaskDTO(
        id: random.nextInt(10000 - 1) + 1,
        exp: random.nextInt(300) + 5,
        description: 'Используйте определенный предмет (Лопата) 10 раз.',
        isComplete: false,
      ),
      BattlePassTaskDTO(
        id: random.nextInt(10000 - 1) + 1,
        exp: random.nextInt(300) + 5,
        description: 'Используйте определенный предмет (Кола) 10 раз.',
        isComplete: true,
      ),
    ];
  }

  @override
  List<IBattlePassReward> getRewards() {
    final random = Random();

    const images = [
      ImagesAssets.bracelet,
      ImagesAssets.bodyArmour,
    ];

    const rarities = BattlePassRewardRarity.values;
    const statuses = BattlePassRewardStatus.values;

    return List.generate(100, (index) {
      final position = index + 1;

      return BattlePassRewardDTO(
        id: position,
        name: 'Награда $position',
        image: images[index % images.length],
        count: random.nextInt(20) + 1,
        rarity: rarities[random.nextInt(rarities.length)],
        status: index < 5 ? BattlePassRewardStatus.reached : statuses[random.nextInt(statuses.length)],
        isPremium: position % 2 == 0,
      );
    });
  }
}
