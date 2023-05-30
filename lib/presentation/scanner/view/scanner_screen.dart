// ignore_for_file: library_prefixes, deprecated_member_use

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep/app/constant/api_constant.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/values_manager.dart';
import 'dart:ui' as UI;

import '../../profile/view/profile_screen.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  UI.TextDirection direction = UI.TextDirection.ltr;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < AppSize.s400.w ||
            MediaQuery.of(context).size.height < AppSize.s400.h)
        ? AppSize.s200.w
        : AppSize.s400.w;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: ColorManager.primaryColor,
                    borderRadius:
                        MediaQuery.of(context).size.width / AppSize.s80,
                    borderLength:
                        MediaQuery.of(context).size.width / AppSize.s120,
                    borderWidth:
                        MediaQuery.of(context).size.width / AppSize.s120,
                    cutOutSize: scanArea,
                  ),
                  onPermissionSet: (ctrl, p) =>
                      _onPermissionSet(context, ctrl, p),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / AppPadding.p20,
                    left: MediaQuery.of(context).size.width / AppPadding.p20,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: AppSize.s10,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Directionality(
                          textDirection: direction,
                          child: const CircleAvatar(
                            radius: AppSize.s16,
                            backgroundColor: ColorManager.white,
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: AppSize.s8,
                              ),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: ColorManager.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        setState(
          () async {
            result = scanData;

            if (result!.code!.contains("dash.keepbi.com")) {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    id: int.parse(result!.code!.split("=").last),
                  ),
                ),
              );
            } else if (result!.code!.contains(ApiConstant.url) == false) {
              openLink(link: result!.code!);
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> openLink({
    required String link,
  }) async {
    String googleUrl = link;
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }
}
