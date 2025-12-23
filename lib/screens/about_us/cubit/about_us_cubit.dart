import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:euro/utils/hive/hive_utils.dart';
import 'package:flutter/services.dart';

part 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit() : super(AboutUsInitial());
  Future<void> getString() async {
    try {
      emit(AboutUsLoading());
      String string = await rootBundle
          .loadString("assets/text/about_us_${HiveUtils.getLanguage}.txt");
      emit(AboutUsLoaded(data: string));
    } catch (e) {
      log("$e");
      emit(AboutUsError());
    }
  }
}
