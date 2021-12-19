import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:volo_consumer/utils/constants/app_themes.dart';

class ThemeService {
  AppTheme getInitialTheme() {
    return AppTheme.lightTheme;
  }
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
            themeData: AppThemes.appThemeData[
                GetIt.instance.get<ThemeService>().getInitialTheme()
                // AppTheme.lightTheme
                ]!));

  //Create func to change themes
}

class ThemeState {
  final ThemeData themeData;
  const ThemeState({required this.themeData});
}
