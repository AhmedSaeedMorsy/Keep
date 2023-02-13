import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/font_manager.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / AppPadding.p30,
                  left: MediaQuery.of(context).size.width / AppPadding.p20,
                  right: MediaQuery.of(context).size.width / AppPadding.p20,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        AppStrings.notification.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    SizedBox(
                      height:
                          MediaQuery.of(context).size.height / AppSize.s22,
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            notificationItem(context: context),
                        separatorBuilder: (context, index) => SizedBox(
                          height: MediaQuery.of(context).size.height /
                              AppSize.s22,
                        ),
                        itemCount: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget notificationItem({
    required BuildContext context,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / AppSize.s100,
        horizontal: MediaQuery.of(context).size.width / AppSize.s30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSize.s18.w,
        ),
        color: ColorManager.grey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Notification Title",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              IconButton(
                onPressed: () {
                  showPopupNotification(context);
                },
                icon: const Icon(
                  Icons.more_horiz,
                ),
              ),
            ],
          ),
          Text(
            """Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s""",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: ColorManager.primaryColor,
                fontSize: FontSizeManager.s16.sp),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          Text(
            "2 min.",
            style: Theme.of(context).textTheme.displayMedium,
          )
        ],
      ),
    );
  }

  static void showPopupNotification(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FadeInDown(
          duration: const Duration(milliseconds: AppIntDuration.duration500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: AppSize.s120.h,
                color: ColorManager.grey,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s18,
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              const Icon(
                                Icons.delete,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    AppSize.s50,
                              ),
                              Text(
                                AppStrings.deleteNotification.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontSize: FontSizeManager.s22.sp,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: ColorManager.darkGrey,
                      width: double.infinity,
                      height: AppSize.s1.h,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s18,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.visibility_off,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  AppSize.s50,
                            ),
                            Text(
                              AppStrings.hideNotififcation.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: FontSizeManager.s22.sp,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
