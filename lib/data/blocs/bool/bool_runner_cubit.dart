

import 'package:flutter_bloc/flutter_bloc.dart';

class BoolCubit extends Cubit<bool> {
  BoolCubit({required bool initBool}) : super(initBool);
  updateBool(bool updateBool) => emit(updateBool);
  toggleBool() => emit(state ? false : true);
}
