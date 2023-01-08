import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/assets_manager.dart';
import 'package:keep/app/resources/color_manager.dart';
import 'package:keep/app/resources/values_manager.dart';
import 'package:keep/presentation/layout/controller/layout_bloc.dart';

import '../controller/layout_states.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutBloc(),
      child: BlocBuilder<LayoutBloc, LayoutStates>(
        builder: (
          context,
          state,
        ) {
          return LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Scaffold(
              body: SafeArea(
                child: LayoutBloc.get(context)
                    .currentScreen[LayoutBloc.get(context).currentIndex],
              ),
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                color: ColorManager.primaryColor,
                notchMargin: constraints.minWidth.toInt() <= 550
                    ? AppSize.s8.w
                    : AppSize.s5.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.height / AppSize.s120,
                    vertical: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(
                            right:
                                MediaQuery.of(context).size.width / AppSize.s22,
                          ),
                          child: InkWell(
                            onTap: () {
                              LayoutBloc.get(context).changeBottomNavBar(1);
                            },
                            child: Image.asset(
                              AssetsManager.Knowledge,
                              color: LayoutBloc.get(context).currentIndex == 1
                                  ? ColorManager.white
                                  : ColorManager.whiteWithOpacity,
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
                          padding: EdgeInsets.only(
                            right:
                                MediaQuery.of(context).size.width / AppSize.s12,
                          ),
                          child: InkWell(
                            onTap: () {
                              LayoutBloc.get(context).changeBottomNavBar(2);
                            },
                            child: Image.asset(
                              AssetsManager.insight,
                              color: LayoutBloc.get(context).currentIndex == 2
                                  ? ColorManager.white
                                  : ColorManager.whiteWithOpacity,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.only(
                            left:
                                MediaQuery.of(context).size.width / AppSize.s12,
                          ),
                          child: InkWell(
                            onTap: () {
                              LayoutBloc.get(context).changeBottomNavBar(3);
                            },
                            child: Image.asset(
                              AssetsManager.customer,
                              color: LayoutBloc.get(context).currentIndex == 3
                                  ? ColorManager.white
                                  : ColorManager.whiteWithOpacity,
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
                          padding: EdgeInsets.only(
                            left:
                                MediaQuery.of(context).size.width / AppSize.s22,
                          ),
                          child: InkWell(
                            onTap: () {
                              LayoutBloc.get(context).changeBottomNavBar(4);
                            },
                            child: Image.asset(
                              AssetsManager.scanner,
                              color: LayoutBloc.get(context).currentIndex == 4
                                  ? ColorManager.white
                                  : ColorManager.whiteWithOpacity,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: constraints.minWidth.toInt() <= 550
                  ? FloatingActionButton(
                      backgroundColor: ColorManager.primaryColor,
                      onPressed: () {
                        LayoutBloc.get(context).changeBottomNavBar(0);
                      },
                      child: Image(
                        image: const AssetImage(
                          AssetsManager.home,
                        ),
                        width: AppSize.s30.w,
                        color: LayoutBloc.get(context).currentIndex == 0
                            ? ColorManager.white
                            : ColorManager.whiteWithOpacity,
                      ),
                    )
                  : FloatingActionButton.large(
                      backgroundColor: ColorManager.primaryColor,
                      onPressed: () {
                        LayoutBloc.get(context).changeBottomNavBar(0);
                      },
                      child: Image(
                        image: const AssetImage(
                          AssetsManager.home,
                        ),
                        width: AppSize.s22.w,
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
