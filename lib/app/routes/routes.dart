import 'package:flutter/widgets.dart';
import 'package:auction/app/app.dart';
import 'package:auction/home/home.dart';
import 'package:auction/login/login.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
