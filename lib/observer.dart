import 'dart:developer';

import 'package:bloc/bloc.dart';

//Class ini digunakan untuk memantau perpindahan state
class MyObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // print('${bloc.runtimeType} $change');
    log('BLOC : $bloc, CHANGE : $change');
  }
}
