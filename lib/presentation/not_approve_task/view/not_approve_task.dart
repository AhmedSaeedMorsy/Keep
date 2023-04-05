import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep/app/constant/enums_extentions.dart';
import 'package:keep/presentation/layout/view/layout_screen.dart';
import 'package:keep/presentation/not_approve_task/controller/bloc.dart';
import 'package:keep/presentation/not_approve_task/controller/states.dart';
import '../../../app/resources/assets_manager.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../model/task_model.dart';
import '../../edit_task/view/edit_task_screen.dart';
import '../../home/controller/home_bloc.dart';
import '../../home/controller/home_states.dart';

class NotApproveTask extends StatelessWidget {
  const NotApproveTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotApproveTaskBloc(),
      child: BlocConsumer<NotApproveTaskBloc, NotApproveTaskStates>(
        listener: (context, state) {
          if (state is RejectTaskSuccessstate ||
              state is ApproveTaskSuccessstate) {
            screen = const LayoutScreen();
          }
        },
        builder: (context, state) {
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
                    AppStrings.notApproveTask.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / AppSize.s50,
                  ),
                  BlocProvider(
                    create: (context) => HomeBloc()..getTask(),
                    child: BlocBuilder<HomeBloc, HomeStates>(
                      builder: (context, state) {
                        return ConditionalBuilderRec(
                          condition:
                              HomeBloc.get(context).notApproveTask.isNotEmpty,
                          builder: (context) {
                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => taskItem(
                                context,
                                index,
                                HomeBloc.get(context).notApproveTask[index],
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                              ),
                              itemCount:
                                  HomeBloc.get(context).notApproveTask.length,
                            );
                          },
                          fallback: (context) => Center(
                            child: Text(
                              AppStrings.notTaskesYet.tr(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget taskItem(
    BuildContext context,
    int index,
    TaskData model,
  ) =>
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTaskScreen(
                task: model,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / AppSize.s22,
            vertical: MediaQuery.of(context).size.height / AppSize.s30,
          ),
          decoration: BoxDecoration(
            color: HomeBloc.get(context).taskState[index] == "agree"
                ? ColorManager.agree
                : HomeBloc.get(context).taskState[index] == "decline"
                    ? ColorManager.error
                    : ColorManager.grey,
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width / AppSize.s30,
            ),
          ),
          child: Row(
            children: [
              Text(
                model.title!.toTitleCase(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: HomeBloc.get(context).taskState[index] == "agree"
                    ? Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: ColorManager.white,
                        )
                    : HomeBloc.get(context).taskState[index] == "decline"
                        ? Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: ColorManager.white,
                            )
                        : Theme.of(context).textTheme.headlineSmall,
              ),
              const Spacer(),
              if (HomeBloc.get(context).taskState[index] == "agree")
                InkWell(
                  onTap: () {
                    HomeBloc.get(context).addToDecline(index);
                    NotApproveTaskBloc.get(context).rejectTask(id: model.id);
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
                    NotApproveTaskBloc.get(context).approveTask(id: model.id);
                  },
                  child: const Image(
                    image: AssetImage(
                      AssetsManager.agree,
                    ),
                  ),
                ),
              if (HomeBloc.get(context).taskState[index] == null)
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        HomeBloc.get(context).addToDecline(index);
                        NotApproveTaskBloc.get(context)
                            .rejectTask(id: model.id);
                      },
                      child: const Image(
                        image: AssetImage(
                          AssetsManager.delete,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / AppSize.s30,
                    ),
                    InkWell(
                      onTap: () {
                        HomeBloc.get(context).addToAgree(index);
                        NotApproveTaskBloc.get(context)
                            .approveTask(id: model.id);
                      },
                      child: const Image(
                        image: AssetImage(
                          AssetsManager.agree,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
}
