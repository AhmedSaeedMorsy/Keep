import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/common/widget.dart';
import 'package:keep/presentation/lead_layout/controller/states.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../controller/bloc.dart';

class LeedTodayScreen extends StatelessWidget {
  const LeedTodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeadsBloc()..getLeads(context: context),
      child: BlocBuilder<LeadsBloc, LeadsStates>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / AppSize.s30,
              horizontal: MediaQuery.of(context).size.width / AppSize.s100,
            ),
            child: LeadsBloc.get(context).todayLeads.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => SharedWidget. leadItem(
                        context: context,
                        model: LeadsBloc.get(context).todayLeads[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      height: MediaQuery.of(context).size.height / AppSize.s32,
                    ),
                    itemCount: LeadsBloc.get(context).todayLeads.length,
                  )
                : Center(
                    child: Text(
                      AppStrings.notLeadsYet.tr(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
          );
        },
      ),
    );
  }

  }
