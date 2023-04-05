import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:keep/app/services/dio_helper/dio_helper.dart';
import 'package:keep/app/services/shared_prefrences/cache_helper.dart';
import 'package:keep/presentation/lead_layout/controller/states.dart';
import '../../../model/leads_model.dart';

class LeadsBloc extends Cubit<LeadsStates> {
  LeadsBloc() : super(LeadsInitState());
  static LeadsBloc get(context) => BlocProvider.of(context);
  LeadsModel leadsModel = LeadsModel();
  List<DataLeadMedel> allAsignedLeads = [];
  List<DataLeadMedel> todayLeads = [];
  List<DataLeadMedel> notAsignedLeads = [];
  List<DataLeadMedel> yasterdayLeads = [];
  List<DataLeadMedel> thisWeekLeads = [];
  List<DataLeadMedel> thisMonthLeads = [];

  void getLeads() {
    emit(LeadsLoadingState());
    DioHelper.getData(
      path: ApiConstant.getLeads,
      token: CacheHelper.getData(
        key: SharedKey.token,
      ),
    ).then((value) {
      leadsModel = LeadsModel.fromJson(value.data);
      for (var element in leadsModel.data) {
        if (element.name == null) {
          notAsignedLeads.add(element);
        } else {
          allAsignedLeads.add(element);
          if (DateTime.parse(element.createdAt)
                  .difference(DateTime.now())
                  .inDays ==
              0) {
            todayLeads.add(element);
          }

          if (DateTime.parse(element.createdAt)
                  .difference(DateTime.now())
                  .inDays ==
              1) {
            yasterdayLeads.add(element);
          }
          if (DateTime.parse(element.createdAt)
                  .difference(DateTime.now())
                  .inDays <
              7) {
            thisWeekLeads.add(element);
          }
          if (DateTime.parse(element.createdAt)
                  .difference(DateTime.now())
                  .inDays <
              30) {
            thisMonthLeads.add(element);
          }
        }
      }
      emit(LeadsSuccessState());
    }).catchError((error) {
      emit(LeadsErrorState());
    });
  }
}
