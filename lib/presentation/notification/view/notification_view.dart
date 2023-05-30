import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/constant/enums_extentions.dart';
import 'package:keep/app/resources/font_manager.dart';
import 'package:keep/presentation/notification/controller/bloc.dart';
import 'package:keep/presentation/notification/controller/states.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../model/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc()..getNotification(context: context),
      child: BlocBuilder<NotificationBloc, NotificationStates>(
        builder: (context, state) {
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
                        top:
                            MediaQuery.of(context).size.height / AppPadding.p30,
                        left:
                            MediaQuery.of(context).size.width / AppPadding.p20,
                        right:
                            MediaQuery.of(context).size.width / AppPadding.p20,
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
                            height: MediaQuery.of(context).size.height /
                                AppSize.s22,
                          ),
                          Expanded(
                            child: ConditionalBuilderRec(
                              condition: NotificationBloc.get(context)
                                  .notificationModel
                                  .data
                                  .isNotEmpty,
                              builder: (context) {
                                return ListView.separated(
                                  padding: EdgeInsets.zero,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      notificationItem(
                                          context: context,
                                          model: NotificationBloc.get(context)
                                              .notificationModel
                                              .data[index]),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        AppSize.s22,
                                  ),
                                  itemCount: NotificationBloc.get(context)
                                      .notificationModel
                                      .data
                                      .length,
                                );
                              },
                              fallback: (context) {
                                return Center(
                                  child: Text(
                                    AppStrings.notFoundNotificationYet.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                );
                              },
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
    );
  }

  Widget notificationItem({
    required BuildContext context,
    required NotificationData model,
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
                model.title.toTitleCase(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          Text(
            model.body.toCapitalized(),
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: ColorManager.primaryColor,
                  fontSize: FontSizeManager.s14.sp,
                ),
          ),
        ],
      ),
    );
  }
}
