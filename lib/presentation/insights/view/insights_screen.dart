import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/font_manager.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.primaryColor,
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
            flex: 3,
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
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.width / AppPadding.p12,
                    vertical:
                        MediaQuery.of(context).size.height / AppPadding.p30,
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSize.s18.h,
                    crossAxisSpacing: AppSize.s50.w,
                    childAspectRatio: 1 / 1.15,
                    children: List.generate(
                      10,
                      (index) => insightsItem(
                        context: context,
                      ),
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
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / AppSize.s50,
        horizontal: MediaQuery.of(context).size.width / AppSize.s30,
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
          SizedBox(
            height: MediaQuery.of(context).size.height / AppSize.s30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / AppSize.s18,
            ),
            child: Container(
              color: ColorManager.darkGrey,
              width: double.infinity,
              height: AppSize.s1.h,
            ),
          ),
        ],
      ),
    );
  }

  void showPopup(context) {
    showDialog(
      context: context,
      builder: (_) => FadeInUp(
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
          margin: EdgeInsets.only(
            top: AppSize.s220.h,
            bottom: AppSize.s220.h,
            left: AppSize.s18.w,
            right: AppSize.s18.w,
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
    );
  }
}
