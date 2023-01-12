import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/assets_manager.dart';
import 'package:keep/app/resources/color_manager.dart';
import 'package:keep/app/resources/values_manager.dart';
import 'package:keep/presentation/home/view/home_screen.dart';
import 'package:keep/presentation/layout/controller/layout_bloc.dart';

import '../../Knowledge/view/Knowledge_screen.dart';
import '../../insights/view/insights_screen.dart';
import '../../leads/view/leads_screen.dart';
import '../../scanner/view/scanner_screen.dart';
import '../controller/layout_states.dart';

Widget screen = HomeScreen();

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return BlocProvider(
      create: (context) => LayoutBloc(),
      child: BlocBuilder<LayoutBloc, LayoutStates>(
        builder: (
          context,
          state,
        ) {
          return LayoutBuilder(builder: (
            context,
            BoxConstraints constraints,
          ) {
            return Scaffold(
              backgroundColor: ColorManager.white,
              body: SafeArea(child: screen),
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                clipBehavior: Clip.antiAlias,
                color: ColorManager.primaryColor,
                notchMargin: constraints.minWidth.toInt() <= 550
                    ? AppSize.s8.w
                    : AppSize.s5.w,
                child: Container(
                  padding: EdgeInsetsDirectional.all(
                    MediaQuery.of(context).size.width / AppSize.s25,
                  ),
                  height: AppSize.s55.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsetsDirectional.only(
                            end:
                                MediaQuery.of(context).size.width / AppSize.s22,
                          ),
                          child: InkWell(
                            onTap: () {
                              LayoutBloc.get(context).changeBottomNavBar(1);
                              screen = const KnowledgeScreen();
                            },
                            child: Image.asset(
                              AssetsManager.Knowledge,
                              color: LayoutBloc.get(context).currentIndex == 1
                                  ? ColorManager.white
                                  : ColorManager.whiteWithOpacity,
                              width: AppSize.s24.w,
                              height: AppSize.s24.w,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: ColorManager.white,
                        width: 1,
                        height: double.infinity,
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsetsDirectional.only(
                            end:
                                MediaQuery.of(context).size.width / AppSize.s12,
                          ),
                          child: InkWell(
                            onTap: () {
                              LayoutBloc.get(context).changeBottomNavBar(2);
                              screen = const InsightsScreen();
                            },
                            child: Image.asset(
                              AssetsManager.insight,
                              color: LayoutBloc.get(context).currentIndex == 2
                                  ? ColorManager.white
                                  : ColorManager.whiteWithOpacity,
                              width: AppSize.s24.w,
                              height: AppSize.s24.h,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsetsDirectional.only(
                            start:
                                MediaQuery.of(context).size.width / AppSize.s22,
                          ),
                          child: InkWell(
                            onTap: () {
                              LayoutBloc.get(context).changeBottomNavBar(3);
                              screen = const LeadsScreen();
                            },
                            child: Image.asset(
                              AssetsManager.customer,
                              color: LayoutBloc.get(context).currentIndex == 3
                                  ? ColorManager.white
                                  : ColorManager.whiteWithOpacity,
                              width: AppSize.s24.w,
                              height: AppSize.s24.h,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: ColorManager.white,
                        width: 1,
                        height: double.infinity,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsetsDirectional.only(
                            start:
                                MediaQuery.of(context).size.width / AppSize.s22,
                          ),
                          child: InkWell(
                            onTap: () {
                              LayoutBloc.get(context).changeBottomNavBar(4);
                              screen = const ScannerScreen();
                            },
                            child: Image.asset(
                              AssetsManager.scanner,
                              color: LayoutBloc.get(context).currentIndex == 4
                                  ? ColorManager.white
                                  : ColorManager.whiteWithOpacity,
                              width: AppSize.s24.w,
                              height: AppSize.s24.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: keyboardIsOpened
                  ? null
                  : constraints.minWidth.toInt() <= 550
                      ? FloatingActionButton(
                          backgroundColor: ColorManager.primaryColor,
                          onPressed: () {
                            LayoutBloc.get(context).changeBottomNavBar(0);
                            screen = HomeScreen();
                          },
                          child: Image(
                            image: const AssetImage(
                              AssetsManager.home,
                            ),
                            width: AppSize.s24.w,
                            color: LayoutBloc.get(context).currentIndex == 0
                                ? ColorManager.white
                                : ColorManager.whiteWithOpacity,
                          ),
                        )
                      : FloatingActionButton.large(
                          backgroundColor: ColorManager.primaryColor,
                          onPressed: () {
                            screen = HomeScreen();
                            LayoutBloc.get(context).changeBottomNavBar(0);
                          },
                          child: Image(
                            image: const AssetImage(
                              AssetsManager.home,
                            ),
                            width: AppSize.s14.w,
                            color: LayoutBloc.get(context).currentIndex == 0
                                ? ColorManager.white
                                : ColorManager.whiteWithOpacity,
                          ),
                        ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            );
          });
        },
      ),
    );
  }
}
