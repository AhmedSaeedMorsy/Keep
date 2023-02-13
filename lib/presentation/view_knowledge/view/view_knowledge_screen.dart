import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/assets_manager.dart';
import '../../../app/common/widget.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';

class ViewKnowledgeScreen extends StatelessWidget {
  const ViewKnowledgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / AppPadding.p30,
                    left: MediaQuery.of(context).size.width / AppPadding.p20,
                    right: MediaQuery.of(context).size.width / AppPadding.p20,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: AppSize.s350.h,
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height /
                              AppSize.s50,
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s30,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppSize.s18.w,
                          ),
                          color: ColorManager.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width / AppSize.s5,
                          vertical: MediaQuery.of(context).size.height /
                              AppSize.s40,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image(
                              image: const AssetImage(
                                AssetsManager.arrowRight,
                              ),
                              width: AppSize.s22.w,
                            ),
                            Image(
                              image: const AssetImage(
                                AssetsManager.arrowLeft,
                              ),
                              width: AppSize.s22.w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
