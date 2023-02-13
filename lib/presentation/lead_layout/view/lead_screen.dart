import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/common/widget.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../edit_lead/view/edit_lead_screen.dart';
import '../../profile/view/profile_screen.dart';

class LeedScreen extends StatelessWidget {
  const LeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / AppSize.s30,
        left: MediaQuery.of(context).size.width / AppSize.s100,
        right: MediaQuery.of(context).size.width / AppSize.s100,
      ),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => leadItem(context: context),
        separatorBuilder: (context, index) => SizedBox(
          height: MediaQuery.of(context).size.height / AppSize.s32,
        ),
        itemCount: 10,
      ),
    );
  }

  Widget leadItem({
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(),
            ));
      },
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: AppSize.s30.w,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / AppSize.s50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.leadName,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      "${AppStrings.ip} : 123452212633512",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: FontSizeManager.s12.sp,
                          ),
                    ),
                    Text(
                      "${AppStrings.location.tr()} : 123452212633512",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: FontSizeManager.s12.sp,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / AppSize.s50,
              ),
              child: Container(
                width: double.infinity,
                height: AppSize.s1.h,
                color: ColorManager.darkGrey,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditLeadScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: AppSize.s18.w,
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s100,
                        ),
                        Text(
                          AppStrings.edit.tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s200),
                  color: ColorManager.darkGrey,
                  width: 1,
                  height: AppSize.s24.h,
                ),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsManager.download,
                          width: AppSize.s12.w,
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s100,
                        ),
                        Text(
                          AppStrings.download.tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / AppSize.s200),
                  color: ColorManager.darkGrey,
                  width: 1,
                  height: AppSize.s24.h,
                ),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () {
                      showPopupScanner(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsManager.scanner,
                          width: AppSize.s18.w,
                          color: ColorManager.primaryColor,
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s100,
                        ),
                        Text(
                          AppStrings.qrcode.tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.width / AppSize.s200,
                  ),
                  color: ColorManager.darkGrey,
                  width: 1,
                  height: AppSize.s24.h,
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      SharedWidget.showPopupShare(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.share,
                          size: AppSize.s18.w,
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / AppSize.s100,
                        ),
                        Text(
                          AppStrings.share.tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showPopupScanner(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FadeInDown(
          duration: const Duration(milliseconds: AppIntDuration.duration500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: AppSize.s220.h,
                color: ColorManager.grey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / AppSize.s22,
                  ),
                  child: const Image(
                    image: AssetImage(
                      AssetsManager.qrCode,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
