import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(index: 1));

  void changeTab(int index) {
    emit(HomeState(index: index));
  }
}
