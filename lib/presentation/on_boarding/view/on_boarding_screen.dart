import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/common/widget.dart';
import 'package:keep/app/resources/assets_manager.dart';
import 'package:keep/app/resources/color_manager.dart';
import 'package:keep/app/resources/strings_manager.dart';
import 'package:keep/app/resources/values_manager.dart';

import '../../../app/resources/routes_manager.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              AssetsManager.onBoarding,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width / AppSize.s18,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  SharedWidget.changeLanguage(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / AppSize.s30,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      color: ColorManager.white,
                      child: Padding(
                        padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / AppSize.s80,
                        ),
                        child: Text(
                          AppStrings.en.tr(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Image(
                  width: AppSize.s180.w,
                  image: const AssetImage(
                    AssetsManager.logo,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / AppSize.s16,
                ),
                child: SharedWidget.defaultButton(
                  context: context,
                  backgroundColor: ColorManager.lightGrey,
                  function: () {
                    Navigator.pushNamed(
                      context,
                      Routes.loginRoute,
                    );
                  },
                  style: Theme.of(context).textTheme.displayLarge!,
                  text: AppStrings.signIn.tr(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
