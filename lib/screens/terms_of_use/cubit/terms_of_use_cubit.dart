import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:euro/utils/hive/hive_utils.dart';
import 'package:flutter/services.dart';

part 'terms_of_use_state.dart';

class TermsOfUseCubit extends Cubit<TermsOfUseState> {
  TermsOfUseCubit() : super(TermsOfUseInitial());

  Future<void> getString() async {
    try {
      emit(TermsOfUseLoading());
      String string = await rootBundle
          .loadString("assets/text/terms_of_use_${HiveUtils.getLanguage}.txt");
      emit(TermsOfUseLoaded(data: string));
    } catch (e) {
      log("$e");
      emit(TermsOfUseError());
    }
  }
}
