import 'dart:math' show Random;

import 'package:matreshka_test_task/data/models/battle_pass_task.dart';
import 'package:matreshka_test_task/domain/models/battle_pass_task.dart';
import 'package:matreshka_test_task/domain/repos/battle_pass_repo.dart';

final class MockBattlePassRepo implements IBattlePassRepository {
  @override
  List<IBattlePassTask> getTasks() {
    return [
      BattlePassTaskDTO(
        exp: Random().nextInt(300 - 5) + 5,
        description: 'Используйте определенный предмет (Энергетик) 10 раз.',
        isComplete: true,
      ),
      BattlePassTaskDTO(
        exp: Random().nextInt(300) + 5,
        description: 'Используйте определенный предмет (Бургер) 10 раз.',
        isComplete: false,
      ),
      BattlePassTaskDTO(
        exp: Random().nextInt(300) + 5,
        description: 'Используйте определенный предмет (Краска) 10 раз.',
        isComplete: true,
      ),
      BattlePassTaskDTO(
        exp: Random().nextInt(300) + 5,
        description: 'Используйте определенный предмет (Лопата) 10 раз.',
        isComplete: false,
      ),
      BattlePassTaskDTO(
        exp: Random().nextInt(300) + 5,
        description: 'Используйте определенный предмет (Кола) 10 раз.',
        isComplete: true,
      ),
    ];
  }
}
