import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/constant/enums_extentions.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/styles_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../home/controller/home_bloc.dart';
import '../../home/controller/home_states.dart';
import '../../home/view/home_screen.dart';
import '../../layout/controller/layout_bloc.dart';
import '../../layout/view/layout_screen.dart';

class SelectMemberInTeamsScreen extends StatelessWidget {
  const SelectMemberInTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc(),
        child: BlocBuilder<HomeBloc, HomeStates>(builder: (context, state) {
          return Container(
            color: ColorManager.white,
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / AppSize.s20,
              right: MediaQuery.of(context).size.width / AppSize.s20,
              top: MediaQuery.of(context).size.height / AppSize.s26,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.selectMember.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  SharedWidget.addTaskFormField(
                    textInputType: TextInputType.name,
                    controller: TextEditingController(),
                    hint: AppStrings.search.tr(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s100,
                  ),
                  ListView.separated(padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => taskItem(context, index),
                    separatorBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s50,
                    ),
                    itemCount: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s20,
                  ),
                  SharedWidget.defaultButton(
                    context: context,
                    function: () {
                      screen = HomeScreen();
                      LayoutBloc.get(context).changeBottomNavBar(0);
                    },
                    text: AppStrings.submit.tr(),
                    backgroundColor: ColorManager.white,
                    style: getExtraBoldStyle(
                      fontSize: FontSizeManager.s20.sp,
                      color: ColorManager.primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  SharedWidget.defaultButton(
                    context: context,
                    function: () {
                      screen = HomeScreen();
                      LayoutBloc.get(context).changeBottomNavBar(0);
                    },
                    text: AppStrings.cancel.tr(),
                    backgroundColor: ColorManager.white,
                    style: getExtraBoldStyle(
                      fontSize: FontSizeManager.s20.sp,
                      color: ColorManager.primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s18,
                  ),
                ],
              ),
            ),
          );
        }));
  }

  Widget taskItem(
    BuildContext context,
    int index,
  ) =>
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s22,
          vertical: MediaQuery.of(context).size.height / AppSize.s30,
        ),
        decoration: BoxDecoration(
          color: HomeBloc.get(context).taskState[index] == "agree"
              ? ColorManager.agree
              : ColorManager.grey,
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width / AppSize.s30,
          ),
        ),
        child: Row(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Member Name".toTitleCase(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: HomeBloc.get(context).taskState[index] == "agree"
                      ? Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: ColorManager.white)
                      : Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "Department".toTitleCase(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: HomeBloc.get(context).taskState[index] == "agree"
                      ? Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: ColorManager.white,)
                      : Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const Spacer(),
            if (HomeBloc.get(context).taskState[index] == "agree")
              InkWell(
                onTap: () {
                  HomeBloc.get(context).addToDecline(index);
                },
                child: const Image(
                  image: AssetImage(
                    AssetsManager.delete,
                  ),
                ),
              ),
            if (HomeBloc.get(context).taskState[index] == "decline")
              InkWell(
                onTap: () {
                  HomeBloc.get(context).addToAgree(index);
                },
                child: const Image(
                  image: AssetImage(
                    AssetsManager.agree,
                  ),
                ),
              ),
            if (HomeBloc.get(context).taskState[index] == null)
              InkWell(
                onTap: () {
                  HomeBloc.get(context).addToAgree(index);
                },
                child: const Image(
                  image: AssetImage(
                    AssetsManager.agree,
                  ),
                ),
              ),
          ],
        ),
      );
}
