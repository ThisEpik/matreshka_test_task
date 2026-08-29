import 'package:matreshka_test_task/domain/models/battle_pass_task.dart';

final class BattlePassTaskDTO extends IBattlePassTask {
  BattlePassTaskDTO({
    required super.id,
    required super.exp,
    required super.description,
    required super.isComplete,
  });
}
