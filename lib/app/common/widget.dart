import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/resources/font_manager.dart';
import '../resources/color_manager.dart';
import '../resources/language_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class SharedWidget {
  static Widget defaultTextFormField({
    final TextEditingController? controller,
    required TextInputType textInputType,
    bool obscure = false,
    void Function(String?)? onChange,
    void Function()? onTap,
    String? hint,
    bool? enabled,
    String? Function(String?)? validator,
    IconButton? suffixIcon,
    void Function(String)? onFieldSubmitted,
    int maxLines = 1,
    int minLines = 1,
  }) =>
      SizedBox(
        height: AppSize.s50.h,
        child: TextFormField(
          controller: controller,
          cursorColor: ColorManager.primaryColor,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: ColorManager.lightGrey, filled: true,
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s50.h),
              borderSide: const BorderSide(
                color: ColorManager.primaryColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s50.h),
              borderSide: const BorderSide(
                color: ColorManager.primaryColor,
              ),
            ),
            contentPadding:
                EdgeInsets.only(top: AppPadding.p1.h, left: AppPadding.p16.w),
            // hint style
            hintStyle: getBoldStyle(
              color: ColorManager.grey,
              fontSize: FontSizeManager.s22,
            ),
          ),
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChange,
          onTap: onTap,
          enabled: enabled,
          minLines: minLines,
          validator: validator,
          keyboardType: textInputType,
          maxLines: maxLines,
        ),
      );

  static Widget header(context) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppPadding.p20,
          vertical: MediaQuery.of(context).size.height / AppPadding.p40,
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / AppSize.s50,
                    horizontal: MediaQuery.of(context).size.width / AppSize.s50,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: AppSize.s30.w,
                        backgroundColor: ColorManager.white,
                      ),
                      SizedBox(
                        width:
                            MediaQuery.of(context).size.width / AppSize.s30.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.userName.tr(),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s350,
                          ),
                          Text(
                            AppStrings.jobDescription.tr(),
                            style: Theme.of(context).textTheme.displaySmall,
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            Align(
              alignment: Alignment.topRight,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / AppSize.s30,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.notifications,
                        size: AppSize.s18.w,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / AppSize.s30,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.settings,
                        size: AppSize.s18.w,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  // static Widget noItemWidget(context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       SvgPicture.asset(AssetsManager.empty,),
  //       const SizedBox(
  //         height: AppSize.s30,
  //       ),
  //       Text(
  //         AppStrings.cartEmpty,
  //         style: Theme.of(context).textTheme.bodyLarge,
  //       ),
  //       const SizedBox(
  //         height: AppSize.s20,
  //       ),
  //       Text(
  //         AppStrings.emptyBio,
  //         style: Theme.of(context).textTheme.displayLarge,
  //       ),
  //     ],
  //   );
  // }

  // static toast({required String message,required Color backgroundColor}) {
  //   return Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     backgroundColor: backgroundColor,
  //     textColor: ColorManager.white,
  //     fontSize: FontSizeManager.s16.sp,
  //   );
  // }

  static void changeLanguage(context) {
    changeAppLanguage();
    Phoenix.rebirth(context);
  }

  static Widget defaultButton({
    required BuildContext context,
    required Function() function,
    required String text,
    required Color backgroundColor,
    required TextStyle style,
  }) {
    return Container(
      height: AppSize.s42.h,
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.primaryColor,
        ),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          AppSize.s50.h,
        ),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }

  // static Widget dropDown({
  //   required String hintText,
  //   required List<String> list,
  //   void Function(String?)? onChanged,
  //   final FormFieldSetter? onSaved,
  //   final String? validateText,
  //   String? Function(String?)? validator,
  // }) =>
  //     DropdownButtonFormField2(
  //       isExpanded: true,
  //       decoration: InputDecoration(
  //         contentPadding: EdgeInsets.symmetric(
  //           vertical: AppSize.s10.h,
  //           horizontal: AppSize.s10.w,
  //         ),
  //         fillColor: ColorManager.white,
  //         filled: true,
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(
  //               AppSize.s100.h,
  //             ),
  //           ),
  //         ),
  //       ),
  //       hint: Text(
  //         hintText,
  //         style: TextStyle(
  //           fontSize: FontSizeManager.s16.sp,
  //           color: ColorManager.grey,
  //         ),
  //       ),
  //       icon: const Icon(
  //         Icons.arrow_drop_down,
  //         color: ColorManager.black,
  //       ),
  //       iconSize: AppSize.s20.w,
  //       buttonHeight: AppSize.s30.w,
  //       items: list
  //           .map(
  //             (item) => DropdownMenuItem<String>(
  //               value: item,
  //               child: Text(
  //                 item,
  //                 style: TextStyle(
  //                   fontSize: FontSizeManager.s12.sp,
  //                   color: ColorManager.black,
  //                 ),
  //               ),
  //             ),
  //           )
  //           .toList(),
  //       onChanged: onChanged,
  //       onSaved: onSaved,
  //       validator: validator,
  //     );

//   static Widget searchItem({
//     required TextEditingController controller,
//     required BuildContext context,
//     required TextInputType textInputType,
//     bool obscure = false,
//     void Function(String?)? onChange,
//     void Function()? onTap,
//     String? hint,
//     bool? enabled,
//     Icon? suffixIcon,
//     void Function(String)? onFieldSubmitted,
//     int maxLines = 1,
//     int minLines = 1,
//   }) =>
//       Padding(
//           padding: EdgeInsets.symmetric(
//             vertical: MediaQuery.of(context).size.height / AppSize.s180,
//             horizontal: MediaQuery.of(context).size.width / AppSize.s50,
//           ),
//           child: Container(
//             clipBehavior: Clip.antiAlias,
//             decoration: BoxDecoration(
//               color: ColorManager.white,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(
//                   AppSize.s100.h,
//                 ),
//               ),
//               border: Border.all(
//                 color: ColorManager.grey,
//               ),
//             ),
//             width: double.infinity,
//             height: AppSize.s40.h,
//             child: TextFormField(
//               cursorColor: ColorManager.primaryColor,
//               obscureText: obscure,
//               decoration: InputDecoration(
//                 hintText: hint,
//                 suffixIcon: suffixIcon,
//                 border: InputBorder.none,

//                 contentPadding: EdgeInsets.symmetric(
//                     vertical: AppSize.s10.h, horizontal: AppSize.s10.w),
//                 // hint style
//                 hintStyle: getRegularStyle(
//                   color: ColorManager.grey,
//                 ),
//               ),
//               onFieldSubmitted: onFieldSubmitted,
//               onChanged: onChange,
//               onTap: onTap,
//               enabled: enabled,
//               minLines: minLines,
//               controller: controller,
//               keyboardType: textInputType,
//               maxLines: maxLines,
//             ),
//           ));
// }

  // number of notification
  // Container(
  //   padding: EdgeInsets.all(
  //     MediaQuery.of(context).size.width /
  //         AppSize.s100,
  //   ),
  //   clipBehavior: Clip.antiAliasWithSaveLayer,
  //   decoration: BoxDecoration(
  //     color: ColorManager.error,
  //     shape: BoxShape.circle,
  //   ),
  //   child: Text(
  //     AppStrings.three,
  //     style: Theme.of(context)
  //         .textTheme
  //         .bodySmall!
  //         .copyWith(
  //           fontSize: FontSizeManager.s16.sp,
  //         ),
  //   ),
  // ),
}
