import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:htp_concierge/dashboard.dart';
import 'package:htp_concierge/features/dashboard/presentation/screens/guest_details.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot debugPrintreload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    await controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // readQr();
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xffFFFFFF),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(flex: 4, child: _buildQrView(context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    if (controller != null && mounted) {
      setState(() {
        controller!.resumeCamera();
      });
    }
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    try {
      setState(() {
        this.controller = controller;
      });
      controller.resumeCamera();

      controller.scannedDataStream.listen((scanData) async {
        setState(() {
          result = scanData;
        });

        if (result != null) {
          String bookingType = "";
          List<String>? splitedCode = result?.code?.split("/");
          final splitlen = splitedCode?.length;

          if (splitlen == 2) {
            if (splitedCode?[0] == "E") {
              bookingType = "event_entry_booking";
            } else if (splitedCode?[0] == "C") {
              bookingType = "club_entry_booking";
            } else {
              bookingType = "table_entry_booking";
            }

            if (splitedCode![1].toString().isNotEmpty) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GuestDetails(
                            docId: splitedCode[1],
                            bookingType: bookingType,
                          )));
            } else {
              await invalidQR(context);
            }
          } else {
            await invalidQR(context);
          }
        }
      });
      this.controller!.pauseCamera();
      this.controller!.resumeCamera();
    } on RangeError catch (e) {
      if (e.message == "Invalid value") {
        invalidQR(context);

        throw ("Invalid value");
      } else {
        throw e.message;
      }
    } catch (e) {
      debugPrint("invalid");
      rethrow;
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  invalidQR(
    BuildContext context,
  ) {
    return showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
                border: Border.all(
                    color: Colors.yellow.withOpacity(0.4), width: 0.7)),
            height: 180,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 50),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: ClipRRect(
                        child: Image.asset("assets/images/denied.png"),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Navigator.pushNamed(context, RequestPlan.route);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard()));
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  // "Request Sent",
                  "Entry access denied",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 12,
                ),
                // Container(
                //   width: 160,
                Text(
                  // "Our support team will get back to you shortly",
                  "Invalid QR code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 192, 192, 192)
                          .withOpacity(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  // ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        );
      },
      context: context,
    );
  }
}
