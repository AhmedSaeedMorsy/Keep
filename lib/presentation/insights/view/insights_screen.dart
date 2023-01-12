import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/constants_manager.dart';
import 'package:keep/app/resources/font_manager.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
          colors: [
            ColorManager.primaryColor,
            ColorManager.primaryColor,
            ColorManager.primaryColor,
            ColorManager.white,
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: FadeInDown(
              duration: const Duration(
                seconds: AppIntDuration.s1,
              ),
              child: SharedWidget.header(
                context,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: FadeInUp(
              duration: const Duration(
                seconds: AppIntDuration.s1,
              ),
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
                    left: MediaQuery.of(context).size.width / AppPadding.p12,
                    right: MediaQuery.of(context).size.width / AppPadding.p12,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return insightsItem(context: context);
                    },
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
          ),
        ],
      ),
    );
  }

  Widget insightsItem({
    required BuildContext context,
  }) {
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
                showPopup(context);
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
  }

  void showPopup(context) {
    showGeneralDialog(
        barrierLabel: "showGeneralDialog",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.6),
        transitionDuration: const Duration(
          seconds: AppIntDuration.s1,
        ),
        context: context,
        pageBuilder: (context, _, __) {
          return Column(
            children: [
              Container(
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
            ],
          );
        },
        transitionBuilder: (_, animation1, __, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, 1),
              end: const Offset(0, .5),
            ).animate(animation1),
            child: child,
          );
        });
  }
}
