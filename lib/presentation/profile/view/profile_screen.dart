// ignore_for_file: must_be_immutable, library_prefixes

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/common/widget.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/presentation/profile/controller/profile_states.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import 'dart:ui' as UI;
import '../../../app/services/calender_helper/calender_helper.dart';
import '../../calendar_monthly/controller/calendar_monthly_bloc.dart';
import '../../calendar_monthly/controller/calendar_monthly_states.dart';
import '../../home/controller/home_bloc.dart';
import '../../home/controller/home_states.dart';
import '../controller/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  UI.TextDirection direction = UI.TextDirection.ltr;
  var calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()
        ..getProfile(
          id: CacheHelper.getData(key: SharedKey.id),
        ),
      child: BlocBuilder<ProfileBloc, ProfileStates>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.white,
            body: SingleChildScrollView(
              child: ConditionalBuilderRec(
                condition: state is ProfileSuccessState,
                builder: (context) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / AppSize.s3,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.topStart,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height /
                                        AppSize.s4_3,
                                    color: ColorManager.primaryColor,
                                    child: Image(
                                      image: NetworkImage(
                                        ProfileBloc.get(context)
                                                .profileModel
                                                .user
                                                .cover ??
                                            "",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          AppPadding.p12,
                                      left: MediaQuery.of(context).size.width /
                                          AppPadding.p12,
                                    ),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Routes.layoutRoute);
                                        },
                                        child: Directionality(
                                          textDirection: direction,
                                          child: const Icon(
                                            Icons.arrow_back_ios,
                                            color: ColorManager.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s9_4,
                                      backgroundColor: ColorManager.white,
                                    ),
                                    CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height /
                                              AppSize.s10,
                                      backgroundColor: ColorManager.grey,
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            ProfileBloc.get(context)
                                                    .profileModel
                                                    .user
                                                    .profile ??
                                                ""),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s80,
                      ),
                      Text(
                        ProfileBloc.get(context).profileModel.user.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        ProfileBloc.get(context).profileModel.user.title!,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s22,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s8,
                        ),
                        child: SharedWidget.defaultButton(
                          backgroundColor: ColorManager.white,
                          function: () {},
                          text: AppStrings.saveContact.tr(),
                          context: context,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: ColorManager.primaryColor,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s18,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: AppSize.s1.w,
                          color: ColorManager.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s12,
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s50,
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return socialItem(
                              name: ProfileBloc.get(context)
                                  .profileModel
                                  .social[index]
                                  .name,
                              link: ProfileBloc.get(context)
                                  .profileModel
                                  .social[index]
                                  .link,
                              context: context,
                            );
                          },
                          itemCount: ProfileBloc.get(context)
                              .profileModel
                              .social
                              .length,
                          semanticChildCount: 2,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: AppSize.s20.w,
                            crossAxisSpacing: AppSize.s60.h,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:
                              MediaQuery.of(context).size.height / AppSize.s50,
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s10,
                        ),
                        child: BlocProvider(
                            create: (context) => CalendarMonthlyBloc(),
                            child: BlocBuilder<CalendarMonthlyBloc,
                                CalendarMonthlyStates>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        CalendarMonthlyBloc.get(context)
                                            .decressDate();
                                        calendarController.backward!();
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: AppSize.s18.w,
                                      ),
                                    ),
                                    Text(
                                      DateFormat.yMMMM().format(
                                        DateTime(
                                          DateTime.now().year,
                                          CalendarMonthlyBloc.get(context)
                                              .dateTimeMonth,
                                        ),
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        CalendarMonthlyBloc.get(context)
                                            .incressDate();
                                        calendarController.forward!();
                                      },
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: AppSize.s18.w,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / AppSize.s50,
                      ),
                      BlocProvider(
                        create: (context) => HomeBloc()..getTask(),
                        child: BlocBuilder<HomeBloc, HomeStates>(
                          builder: (context, state) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                                horizontal: MediaQuery.of(context).size.width /
                                    AppSize.s30,
                              ),
                              child: SizedBox(
                                height: AppSize.s700.h,
                                child: SfCalendar(
                                  controller: calendarController,
                                  view: CalendarView.month,
                                  firstDayOfWeek: 7,
                                  viewNavigationMode: ViewNavigationMode.none,
                                  dataSource: MeetingDataSource(
                                      HomeBloc.get(context).meetings),
                                  monthViewSettings: const MonthViewSettings(
                                    numberOfWeeksInView: 6,
                                    appointmentDisplayMode:
                                        MonthAppointmentDisplayMode.appointment,
                                  ),
                                  headerHeight: AppSize.s1,
                                  headerStyle: const CalendarHeaderStyle(
                                    textStyle: TextStyle(
                                      color: ColorManager.white,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget socialItem({
    required String name,
    required String link,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        ProfileBloc.get(context).openLink(link: link);
      },
      child: name == "Gmail"
          ? Image.asset(
              AssetsManager.gmail,
            )
          : name == "Website"
              ? Image.asset(
                  AssetsManager.web,
                )
              : name == "Address"
                  ? Image.asset(
                      AssetsManager.googleMaps,
                    )
                  : name == "Youtube"
                      ? Image.asset(
                          AssetsManager.youtube,
                        )
                      : name == "Snapchat"
                          ? Image.asset(
                              AssetsManager.snapchat,
                            )
                          : name == "Instagram"
                              ? Image.asset(
                                  AssetsManager.instagram,
                                )
                              : name == "Facebook"
                                  ? Image.asset(
                                      AssetsManager.facebookIcon,
                                    )
                                  : name == "Linkedin"
                                      ? Image.asset(
                                          AssetsManager.linkedinIcon,
                                        )
                                      : name == "Tiktok"
                                          ? Image.asset(
                                              AssetsManager.tiktok,
                                            )
                                          : name == "Twitter"
                                              ? Image.asset(
                                                  AssetsManager.twitter,
                                                )
                                              : name == "Youtube"
                                                  ? Image.asset(
                                                      AssetsManager.youtube,
                                                    )
                                                  : name == "Quora"
                                                      ? Image.asset(
                                                          AssetsManager.quora,
                                                        )
                                                      : name == "Reddit"
                                                          ? Image.asset(
                                                              AssetsManager
                                                                  .reddit,
                                                            )
                                                          : name == "Telegram"
                                                              ? Image.asset(
                                                                  AssetsManager
                                                                      .telegram,
                                                                )
                                                              : name ==
                                                                      "Pinterest"
                                                                  ? Image.asset(
                                                                      AssetsManager
                                                                          .pinterest,
                                                                    )
                                                                  : name ==
                                                                          "Paypal"
                                                                      ? Image
                                                                          .asset(
                                                                          AssetsManager
                                                                              .paypal,
                                                                        )
                                                                      : name ==
                                                                              "App Link"
                                                                          ? Image
                                                                              .asset(
                                                                              AssetsManager.appStore,
                                                                            )
                                                                          : name == "Link"
                                                                              ? Image.asset(
                                                                                  AssetsManager.link,
                                                                                )
                                                                              : name == "Message"
                                                                                  ? Image.asset(
                                                                                      AssetsManager.messages,
                                                                                    )
                                                                                  : name == "Phone"
                                                                                      ? Image.asset(
                                                                                          AssetsManager.phone,
                                                                                        )
                                                                                      : name == "Whatsapp"
                                                                                          ? Image.asset(
                                                                                              AssetsManager.whatsapp,
                                                                                            )
                                                                                          : name == "Whatsapp Bussniss"
                                                                                              ? Image.asset(
                                                                                                  AssetsManager.whatsappBuisness,
                                                                                                )
                                                                                              : null,
    );
  }
}
