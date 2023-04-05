// ignore_for_file: must_be_immutable, library_prefixes

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/constant/enums_extentions.dart';
import 'package:keep/app/resources/assets_manager.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/presentation/share/controller/share_bloc.dart';
import 'package:keep/presentation/share/controller/share_states.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/language_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import 'dart:ui' as UI;

class ShareScreen extends StatelessWidget {
  ShareScreen({
    super.key,
    required this.id,
    required this.shareType,
  });
  UI.TextDirection direction = UI.TextDirection.ltr;
  final int id;
  final String shareType;
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ShareBloc()..getTeams(),
        child: BlocConsumer<ShareBloc, ShareStates>(
          listener: (context, state) {
            if (state is ShareLeadsSuccessState ||
                state is ShareKitsSuccessState ||
                state is ShareMeetingSuccessState) {
              Navigator.pop(context);
            }
          },
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
                                    AppSize.s50,
                              ),
                              child: ShareBloc.get(context)
                                      .teamsNameList
                                      .isNotEmpty
                                  ? dropDownItem(
                                      context: context,
                                    )
                                  : null,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width /
                                          AppSize.s8,
                                ),
                                child: ConditionalBuilderRec(
                                  condition: ShareBloc.get(context)
                                      .usersModel
                                      .users
                                      .isNotEmpty,
                                  builder: (context) => ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        checkboxItem(
                                            context: context,
                                            name: ShareBloc.get(context)
                                                .usersModel
                                                .users[index]
                                                .name,
                                            index: ShareBloc.get(context)
                                                .usersModel
                                                .users[index]
                                                .id),
                                    itemCount: ShareBloc.get(context)
                                        .usersModel
                                        .users
                                        .length,
                                  ),
                                  fallback: (context) => Center(
                                    child: Text(
                                      AppStrings.notUsersYet.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width /
                                    AppSize.s30,
                                vertical: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                              ),
                              child: SharedWidget.defaultButton(
                                context: context,
                                function: () {
                                  print(shareType);
                                  print(id);
                                  if (shareType == "lead") {
                                    ShareBloc.get(context).shareLead(id: id);
                                  } else if (shareType == "kit") {
                                    ShareBloc.get(context).shareKit(id: id);
                                  } else if (shareType == "meeting") {
                                    ShareBloc.get(context).shareMeeting(id: id);
                                  }
                                },
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
                                function: () {
                                  Navigator.pop(context);
                                },
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
                      fontSize: FontSizeManager.s16.sp,
                    ),
              ),
            ),
          ],
        ),
        items: ShareBloc.get(context)
            .teamsNameList
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
        value: ShareBloc.get(context).selectedValue,
        onChanged: (value) {
          ShareBloc.get(context).changeDropDownItem(value: value!);
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

  Widget checkboxItem(
      {required BuildContext context,
      required String name,
      required int index}) {
    return Row(
      children: [
        Checkbox(
          value: ShareBloc.get(context).selectedUsers.contains(index)
              ? true
              : false,
          onChanged: (value) {
            ShareBloc.get(context).changeCheckBoxState(
              value: value!,
              index: index,
            );
          },
        ),
        Text(
          name.toTitleCase(),
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: FontSizeManager.s16.sp,
              ),
        ),
      ],
    );
  }
}
