// ignore_for_file: file_names, must_be_immutable

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/common/widget.dart';
import 'package:keep/app/constant/enums_extentions.dart';
import 'package:keep/app/resources/assets_manager.dart';
import 'package:keep/model/kits_model.dart';
import 'package:keep/presentation/knowledge/controller/bloc.dart';
import 'package:keep/presentation/knowledge/controller/states.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';

class KnowledgeScreen extends StatelessWidget {
  const KnowledgeScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KitsBloc()..getKits(),
      child: BlocBuilder<KitsBloc, KitsStates>(builder: (context, state) {
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
                            AppStrings.businessKit.tr(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / AppSize.s22,
                        ),
                        Expanded(
                          child: ConditionalBuilderRec(
                            condition:
                                KitsBloc.get(context).kitsModel.data.isNotEmpty,
                            builder: (context) {
                              return ListView.separated(
                                padding: EdgeInsets.zero,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    businessKitItem(
                                  context: context,
                                  model: KitsBloc.get(context)
                                      .kitsModel
                                      .data[index],
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                      AppSize.s22,
                                ),
                                itemCount:
                                    KitsBloc.get(context).kitsModel.data.length,
                              );
                            },
                            fallback: (context) => Center(
                              child: Text(
                                AppStrings.notKitsYet.tr(),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
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
      }),
    );
  }

  Widget businessKitItem({
    required BuildContext context,
    required KitData model,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.name.toTitleCase(),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(
            model.desc.toTitleCase(),
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: FontSizeManager.s12.sp,
                ),
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
                    KitsBloc.get(context).openFile(
                      url: model.path,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.visibility,
                        size: AppSize.s18.w,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / AppSize.s100,
                      ),
                      Text(
                        AppStrings.view.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / AppSize.s200,
                ),
                color: ColorManager.darkGrey,
                width: 1,
                height: AppSize.s24.h,
              ),
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () {
                    KitsBloc.get(context).openFile(
                      url: model.path,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetsManager.download,
                        width: AppSize.s12.w,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / AppSize.s100,
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
                        MediaQuery.of(context).size.width / AppSize.s120),
                color: ColorManager.darkGrey,
                width: 1,
                height: AppSize.s24.h,
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    SharedWidget.showPopupShare(context, model.id, "kit");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                        size: AppSize.s18.w,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / AppSize.s100,
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
    );
  }
}
