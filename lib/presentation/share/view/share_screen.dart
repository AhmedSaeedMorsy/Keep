// ignore_for_file: must_be_immutable, library_prefixes

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/constant/enums_extentions.dart';
import 'package:keep/app/resources/assets_manager.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/presentation/share/controller/share_controller.dart';
import 'package:keep/presentation/share/controller/share_states.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/language_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import 'dart:ui' as UI;

class ShareScreen extends StatelessWidget {
  ShareScreen({super.key});
  UI.TextDirection direction = UI.TextDirection.ltr;

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ShareBloc(),
        child: BlocBuilder<ShareBloc, ShareStates>(
          builder: (context, state) {
            return Container(
              color: ColorManager.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / AppPadding.p12,
                      left: MediaQuery.of(context).size.width / AppPadding.p20,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Directionality(
                          textDirection: direction,
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: ColorManager.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
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
                          top: MediaQuery.of(context).size.height /
                              AppPadding.p30,
                          left: MediaQuery.of(context).size.width /
                              AppPadding.p12,
                          right: MediaQuery.of(context).size.width /
                              AppPadding.p12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                AppStrings.share.tr().toTitleCase(),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width /
                                    AppSize.s30,
                                right: MediaQuery.of(context).size.width /
                                    AppSize.s30,
                                bottom: MediaQuery.of(context).size.height /
                                    AppSize.s20,
                              ),
                              child: dropDownItem(
                                context: context,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width /
                                            AppSize.s8),
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      checkboxItem(context: context),
                                  itemCount: 10,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width /
                                    AppSize.s30,
                                right: MediaQuery.of(context).size.width /
                                    AppSize.s30,
                                top: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                                bottom: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                              ),
                              child: SharedWidget.defaultButton(
                                context: context,
                                function: () {},
                                text: AppStrings.share.tr().toTitleCase(),
                                backgroundColor: ColorManager.white,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: ColorManager.primaryColor,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width /
                                    AppSize.s30,
                                right: MediaQuery.of(context).size.width /
                                    AppSize.s30,
                                bottom: MediaQuery.of(context).size.height /
                                    AppSize.s12,
                              ),
                              child: SharedWidget.defaultButton(
                                context: context,
                                function: () {},
                                text: AppStrings.cancel.tr().toTitleCase(),
                                backgroundColor: ColorManager.white,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: ColorManager.primaryColor),
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
          },
        ),
      ),
    );
  }

  Future<String> currentLanguage = getAppLanguage();
  Widget dropDownItem({required BuildContext context}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        iconOnClick: Image(
          image: const AssetImage(
            AssetsManager.arrowUp,
          ),
          width: AppSize.s16.w,
          height: AppSize.s16.h,
        ),
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.department.tr(),
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: ColorManager.darkGrey,
                      fontSize: FontSizeManager.s18.sp,
                    ),
              ),
            ),
          ],
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.headlineSmall!,
                ),
              ),
            )
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          // setState(() {
          //   selectedValue = value as String;
          // });
        },
        icon: Image(
          image: const AssetImage(
            AssetsManager.arrowDown,
          ),
          width: AppSize.s16.w,
          height: AppSize.s16.h,
        ),
        buttonHeight: AppSize.s40.h,
        buttonWidth: AppSize.s220.w,
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.s55.w,
          ),
          color: ColorManager.grey,
        ),
        buttonPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s22,
        ),
        itemHeight: AppSize.s30.h,
        dropdownMaxHeight: AppSize.s150.h,
        dropdownWidth: AppSize.s180.w,
        scrollbarRadius: Radius.circular(
          AppSize.s10.w,
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              AppSize.s20.w,
            ),
            bottomRight: Radius.circular(
              AppSize.s20.w,
            ),
          ),
          color: ColorManager.white,
        ),
        scrollbarThickness: AppSize.s8.w,
        offset: CacheHelper.getData(key: SharedKey.Language) ==
                    LanguageType.ENGLISH.getValue() ||
                CacheHelper.getData(key: SharedKey.Language) == null
            ? Offset(AppSize.s20.w, 0)
            : Offset(-AppSize.s20.w, 0),
      ),
    );
  }

  Widget checkboxItem({
    required BuildContext context,
  }) {
    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: (value) {},
        ),
        Text(
          "name".toTitleCase(),
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: FontSizeManager.s18.sp,
              ),
        )
      ],
    );
  }
}
