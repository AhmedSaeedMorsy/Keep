// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/model/profile_model.dart';
import 'package:keep/presentation/profile/controller/profile_states.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/services/calender_helper/calender_helper.dart';
import '../../../model/is_assign_lead_model.dart';
import '../../../model/task_model.dart';

class ProfileBloc extends Cubit<ProfileStates> {
  ProfileBloc() : super(ProfileInitState());
  static ProfileBloc get(context) => BlocProvider.of(context);
  ProfileModel profileModel = ProfileModel();
  List form = [];
  void getProfile({
    required int id,
    required BuildContext context,
  }) {
    emit(ProfileLoadingState());
    DioHelper.getData(path: ApiConstant.getProfilePath(id: id)).then(
      (value) {
        profileModel = ProfileModel.fromJson(value.data);
        form = jsonDecode(profileModel.form[0].inputs);
        socialMedia();
        emit(ProfileSuccessState());
      },
    ).catchError(
      (error) {
        if (error is DioError) {
          if (error.response!.statusCode == 401) {
            SharedWidget.toast(
              message: AppStrings.logInAgain.tr(),
              backgroundColor: ColorManager.error,
            );
            CacheHelper.removeData(key: SharedKey.token);
            CacheHelper.removeData(key: SharedKey.qr);
            CacheHelper.removeData(key: SharedKey.id);
            CacheHelper.removeData(key: SharedKey.loginDate);
            CacheHelper.removeData(key: SharedKey.bio);
            CacheHelper.removeData(key: SharedKey.email);
            CacheHelper.removeData(key: SharedKey.name);
            CacheHelper.removeData(key: SharedKey.title);
            CacheHelper.removeData(key: SharedKey.phone);
            Navigator.pushReplacementNamed(
              context,
              Routes.loginRoute,
            );
          }
        }
        emit(ProfileErrorState());
      },
    );
  }

  Future<void> openLink({
    required String link,
  }) async {
    String googleUrl = link;
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  void saveContact({
    required String name,
    required String email,
    required String title,
    required String phone,
  }) async {
    if (await FlutterContacts.requestPermission()) {
      // Insert new contact
      final newContact = Contact()
        ..name.first = name
        ..emails = [
          Email(
            email,
          ),
        ]
        ..displayName = title
        ..phones = [Phone(phone)]
        ..socialMedias = socialMediaList;
      await newContact.insert().then((value) {
        SharedWidget.toast(
          message: AppStrings.saved.tr(),
          backgroundColor: ColorManager.agree,
        );

        emit(AddContactSuccessState());
      });
    }
  }

  TaskModel taskModel = TaskModel();
  List<TaskData> taskList = [];
  List<Meeting> meetings = <Meeting>[];
  List<TaskData> notApproveTask = [];

  void getTask({required BuildContext context}) {
    emit(GetTaskLoadingState());
    DioHelper.getData(
      path: ApiConstant.getTaskInProfilePath(
        id: CacheHelper.getData(
          key: SharedKey.id,
        ),
      ),
    ).then(
      (value) {
        taskModel = TaskModel.fromJson(
          value.data,
        );
        DateTime dateTime = DateTime.now();

        taskList = [];
        meetings = [];
        notApproveTask = [];
        for (var element in taskModel.data) {
          if (element.user[0].pivot.status == "approved") {
            if (DateFormat("yyyy-MM-dd")
                    .format(DateTime.parse(element.startDate)) ==
                DateFormat("yyyy-MM-dd").format(dateTime)) {
              taskList.add(element);
            } else if (DateTime.parse(DateFormat("yyyy-MM-dd")
                        .format(DateTime.parse(element.endDate)))
                    .isAfter(DateTime.parse(
                        DateFormat("yyyy-MM-dd").format(dateTime))) &&
                DateTime.parse(DateFormat("yyyy-MM-dd")
                        .format(DateTime.parse(element.startDate)))
                    .isBefore(DateTime.parse(
                        DateFormat("yyyy-MM-dd").format(dateTime)))) {
              taskList = [];
              taskList.add(element);
            }
            meetings.add(Meeting(
                element.title!,
                DateTime.parse(element.startDate),
                DateTime.parse(element.endDate),
                ColorManager.darkGrey,
                false));
          } else if (element.user[0].pivot.status == "not approved") {
            notApproveTask.add(element);
          }
        }
        emit(GetTaskSuccessState());
      },
    ).catchError(
      (error) {
        if (error is DioError) {
          if (error.response!.statusCode == 401) {
            SharedWidget.toast(
              message: AppStrings.logInAgain.tr(),
              backgroundColor: ColorManager.error,
            );
            CacheHelper.removeData(key: SharedKey.token);
            CacheHelper.removeData(key: SharedKey.qr);
            CacheHelper.removeData(key: SharedKey.id);
            CacheHelper.removeData(key: SharedKey.loginDate);
            CacheHelper.removeData(key: SharedKey.bio);
            CacheHelper.removeData(key: SharedKey.email);
            CacheHelper.removeData(key: SharedKey.name);
            CacheHelper.removeData(key: SharedKey.title);
            CacheHelper.removeData(key: SharedKey.phone);
            Navigator.pushReplacementNamed(
              context,
              Routes.loginRoute,
            );
          }
        }
        emit(
          GetTaskErrorState(error.toString()),
        );
      },
    );
  }

  List<SocialMedia> socialMediaList = [];
  void socialMedia() {
    for (var element in profileModel.social) {
      if (element.name == "Facebook") {
        socialMediaList
            .add((SocialMedia(element.link, label: SocialMediaLabel.facebook)));
      } else if (element.name == "Instagram") {
        socialMediaList.add(
            (SocialMedia(element.name, label: SocialMediaLabel.instagram)));
      } else if (element.name == "Linkedin") {
        socialMediaList
            .add((SocialMedia(element.name, label: SocialMediaLabel.linkedIn)));
      } else if (element.name == "Snapchat") {
        socialMediaList
            .add((SocialMedia(element.name, label: SocialMediaLabel.snapchat)));
      } else if (element.name == "Tiktok") {
        socialMediaList
            .add((SocialMedia(element.name, label: SocialMediaLabel.tikTok)));
      } else if (element.name == "Twitter") {
        socialMediaList
            .add((SocialMedia(element.name, label: SocialMediaLabel.twitter)));
      } else if (element.name == "Whatsapp") {
        socialMediaList
            .add((SocialMedia(element.name, label: SocialMediaLabel.whatsapp)));
      } else if (element.name == "Whatsapp Bussniss") {
        socialMediaList
            .add((SocialMedia(element.name, label: SocialMediaLabel.whatsapp)));
      } else if (element.name == "Youtube") {
        socialMediaList
            .add((SocialMedia(element.name, label: SocialMediaLabel.youtube)));
      } else if (element.name == "Telegram") {
        socialMediaList
            .add((SocialMedia(element.name, label: SocialMediaLabel.telegram)));
      } else if (element.name == "Reddit") {
        socialMediaList
            .add((SocialMedia(element.name, label: SocialMediaLabel.reddit)));
      } else if (element.name == "Pinterest") {
        socialMediaList.add(
            (SocialMedia(element.name, label: SocialMediaLabel.pinterest)));
      }
    }
  }

  void createAssignedLead({
    required int id,
    required BuildContext context,
    required String name,
    required String email,
    required String gender,
    required String phone,
    required String companyName,
    required String position,
    required String industry,
    required String note,
    required List custom,
  }) {
    emit(CreateAssignedLeadLoadingState());
    DioHelper.postData(
      path: ApiConstant.createAssignedLead(
        id: id,
      ),
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "gender": gender,
        "company_name": companyName,
        "position": position,
        "industry": industry,
        "note": note,
        "custom": custom,
        "type": "app"
      },
    ).then((value) {
      emit(CreateAssignedLeadSuccessState());
      isAssignLead(id: id);
    }).catchError((error) {
      if (error is DioError) {
        if (error.response!.statusCode == 401) {
          SharedWidget.toast(
            message: AppStrings.logInAgain.tr(),
            backgroundColor: ColorManager.error,
          );
          CacheHelper.removeData(key: SharedKey.token);
          CacheHelper.removeData(key: SharedKey.qr);
          CacheHelper.removeData(key: SharedKey.id);
          CacheHelper.removeData(key: SharedKey.loginDate);
          CacheHelper.removeData(key: SharedKey.bio);
          CacheHelper.removeData(key: SharedKey.email);
          CacheHelper.removeData(key: SharedKey.name);
          CacheHelper.removeData(key: SharedKey.title);
          CacheHelper.removeData(key: SharedKey.phone);
          Navigator.pushReplacementNamed(
            context,
            Routes.loginRoute,
          );
        }
      }
      emit(CreateAssignedLeadErrorState());
    });
  }

  bool isOpen = false;

  void changeDropDownIcon() {
    isOpen = !isOpen;
    emit(ChangeDropDownIconState());
  }

  String selectedValue = "Male";
  void changeDropDownItem({required String value}) {
    selectedValue = value;

    emit(ChangeDropDownValueState());
  }

  void createUnAssignedLead({
    required int id,
    required BuildContext context,
  }) {
    emit(CreateUnAssignedLeadLoadingState());
    DioHelper.postData(path: ApiConstant.createUnAssignedLead(id: id), data: {
      "type": "app",
    }).then((value) {
      emit(CreateUnAssignedLeadSuccessState());
    }).catchError(
      (error) {
        if (error is DioError) {
          if (error.response!.statusCode == 401) {
            SharedWidget.toast(
              message: AppStrings.logInAgain.tr(),
              backgroundColor: ColorManager.error,
            );
            CacheHelper.removeData(key: SharedKey.token);
            CacheHelper.removeData(key: SharedKey.qr);
            CacheHelper.removeData(key: SharedKey.id);
            CacheHelper.removeData(key: SharedKey.loginDate);
            CacheHelper.removeData(key: SharedKey.bio);
            CacheHelper.removeData(key: SharedKey.email);
            CacheHelper.removeData(key: SharedKey.name);
            CacheHelper.removeData(key: SharedKey.title);
            CacheHelper.removeData(key: SharedKey.phone);
            Navigator.pushReplacementNamed(
              context,
              Routes.loginRoute,
            );
          }
        }
        emit(CreateUnAssignedLeadErrorState());
      },
    );
  }

  IsAssignedModel isAssignedModel = IsAssignedModel();
  void isAssignLead({required int id}) {
    emit(IsAssignedLeadLoadingState());
    DioHelper.getData(path: ApiConstant.isAssignedLeadPath(id)).then((value) {
      isAssignedModel = IsAssignedModel.fromJson(value.data);
      emit(IsAssignedLeadSuccessState());
    }).catchError(
      (error) {
        
        emit(IsAssignedLeadErrorState());
      },
    );
  }
}
