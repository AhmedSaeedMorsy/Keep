// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/presentation/insights/controller/insights_states.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../controller/insights_bloc.dart';

class InsightsScreen extends StatelessWidget {
  InsightsScreen({super.key});
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: ColorManager.white,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SharedWidget.header(
                context,
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        AppSize.s40.w,
                      ),
                      topRight: Radius.circular(
                        AppSize.s40.w,
                      ),
                    )),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / AppPadding.p30,
                    left: MediaQuery.of(context).size.width / AppPadding.p20,
                    right: MediaQuery.of(context).size.width / AppPadding.p20,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return insightsItem(context: context);
                    },
                    semanticChildCount: 2,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppSize.s20.w,
                      crossAxisSpacing: AppSize.s20.h,
                      childAspectRatio: 1 / 1.1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget insightsItem({
    required BuildContext context,
  }) {
    return BlocProvider(
        create: (context) => InsightsBloc(),
        child: BlocBuilder<InsightsBloc, InsightsStates>(
          builder: (context, state) {
            return Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / AppSize.s42,
                horizontal: MediaQuery.of(context).size.width / AppSize.s40,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppSize.s18.w,
                ),
                color: ColorManager.grey,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        bottomSheetItem(context);
                      },
                      child: const Icon(
                        Icons.info_outline,
                      ),
                    ),
                  ),
                  Text(
                    "0",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: FontSizeManager.s32.sp,
                        ),
                  ),
                  Text(
                    "Pops",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            );
          },
        ));
  }

  void bottomSheetItem(
    context,
  ) {
    scaffoldKey.currentState!
        .showBottomSheet(
          (context) => Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Container(
              height: MediaQuery.of(context).size.height / AppSize.s3,
              width: double.infinity,
              padding: const EdgeInsetsDirectional.all(
                AppPadding.p20,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / AppSize.s50,
                  horizontal: MediaQuery.of(context).size.width / AppSize.s30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppSize.s18.w,
                  ),
                  color: ColorManager.lightGrey,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    """Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book It has survived not only five centuries but also the leap into electronic """,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: FontSizeManager.s18.sp,
                        ),
                  ),
                ),
              ),
            ),
          ),
        )
        .closed
        .then((value) {
      InsightsBloc.get(context).changeBottomSheet(
        isShow: false,
      );
    });
    InsightsBloc.get(context).changeBottomSheet(
      isShow: true,
    );
  }
}
