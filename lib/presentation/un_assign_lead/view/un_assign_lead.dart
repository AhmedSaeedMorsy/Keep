// ignore_for_file: file_names, must_be_immutable, library_prefixes, deprecated_member_use

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/presentation/profile/controller/profile_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import 'dart:ui' as UI;
import '../../../model/leads_model.dart';
import '../../lead_layout/controller/bloc.dart';
import '../../lead_layout/controller/states.dart';
import 'create_lead_screen.dart';

class UnAssignLead extends StatelessWidget {
  UnAssignLead({super.key});
  UI.TextDirection direction = UI.TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => LeadsBloc()
                      ..getLeads(
                        context: context,
                      ),
                  ),
                  BlocProvider(
                    create: (context) => ProfileBloc()
                      ..getProfile(
                        context: context,
                        id: CacheHelper.getData(
                          key: SharedKey.id,
                        ),
                      ),
                  ),
                ],
                child: BlocBuilder<LeadsBloc, LeadsStates>(
                  builder: (context, state) {
                    return ConditionalBuilderRec(
                      condition:
                          ProfileBloc.get(context).profileModel.user != null,
                      builder: (context) {
                        return Expanded(
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
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width /
                                    AppSize.s20,
                              ),
                              child: LeadsBloc.get(context)
                                      .notAsignedLeads
                                      .isNotEmpty
                                  ? ListView.separated(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              AppSize.s50),
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) => leadItem(
                                          context: context,
                                          name: ProfileBloc.get(context)
                                              .profileModel
                                              .user!
                                              .name,
                                          form: ProfileBloc.get(context).form,
                                          model: LeadsBloc.get(context)
                                              .notAsignedLeads[index]),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                AppSize.s32,
                                      ),
                                      itemCount: LeadsBloc.get(context)
                                          .notAsignedLeads
                                          .length,
                                    )
                                  : Center(
                                      child: Text(
                                        AppStrings.notLeadsYet.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget leadItem({
    required BuildContext context,
    required DataLeadMedel model,
    required name,
    required form,
  }) {
    return InkWell(
      onTap: () async {
        String googleUrl =
            "https://www.google.com/maps/search/?api=1&query=${model.latitude},${model.longitude}";
        if (await canLaunch(googleUrl)) {
          await launch(googleUrl);
        }
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
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppStrings.ip} : ${model.ip}",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontSize: FontSizeManager.s12.sp,
                                ),
                      ),
                      Text(
                        "${AppStrings.location.tr()} : ${model.latitude},${model.longitude}",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontSize: FontSizeManager.s12.sp,
                                ),
                      ),
                      Text(
                        "${AppStrings.country.tr()} : ${model.country}",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontSize: FontSizeManager.s12.sp,
                                ),
                      ),
                      Text(
                        "${AppStrings.city.tr()} : ${model.city}",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontSize: FontSizeManager.s12.sp,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SharedWidget.defaultButton(
                context: context,
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateLeadScreen(
                        name: name,
                        form: form,
                        id: model.id,
                      ),
                    ),
                  );
                },
                text: AppStrings.createLead.tr(),
                backgroundColor: ColorManager.white,
                style: Theme.of(context).textTheme.displaySmall!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
