import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/presentation/Knowledge/view/Knowledge_screen.dart';
import 'package:keep/presentation/home/view/home_screen.dart';
import 'package:keep/presentation/insights/view/insights_screen.dart';
import 'package:keep/presentation/layout/controller/layout_states.dart';
import 'package:keep/presentation/leads/view/leads_screen.dart';
import 'package:keep/presentation/scanner/view/scanner_screen.dart';

class LayoutBloc extends Cubit<LayoutStates> {
  LayoutBloc() : super(LayoutInitState());
  static LayoutBloc get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> currentScreen = const [
    HomeScreen(),
    KnowledgeScreen(),
    InsightsScreen(),
    LeadsScreen(),
    ScannerScreen(),
  ];
  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }
}
