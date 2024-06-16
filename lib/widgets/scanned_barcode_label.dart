import 'package:dictionary/screens/web_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kode4u/configs/k_config.dart';
import 'package:kode4u/utils/k_utils.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannedBarcodeLabel extends StatelessWidget {
  const ScannedBarcodeLabel({
    super.key,
    required this.barcodes,
  });

  final Stream<BarcodeCapture> barcodes;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: barcodes,
      builder: (context, snapshot) {
        final scannedBarcodes = snapshot.data?.barcodes ?? [];

        if (scannedBarcodes.isEmpty) {
          return const Text(
            '',
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(KConfig.margin),
              padding: EdgeInsets.all(KConfig.margin),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(KConfig.radius + 300),
                  color: Colors.white),
              child: Text(
                scannedBarcodes.first.displayValue ?? 'No display value.',
                overflow: TextOverflow.fade,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(KConfig.radius),
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: scannedBarcodes.first.displayValue!),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Copied Success'),
                        duration:
                            const Duration(seconds: 2), // Optional duration
                        action: SnackBarAction(
                          label: 'Close',
                          onPressed: () {
                            // Code to execute when Snackbar action is pressed
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(KConfig.margin),
                    padding: EdgeInsets.all(KConfig.margin),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(KConfig.radius),
                        color: Theme.of(context).unselectedWidgetColor),
                    child: const Icon(CupertinoIcons.rectangle_on_rectangle,
                        color: Colors.white),
                  ),
                ),
                scannedBarcodes.first.displayValue!.contains('http')
                    ? InkWell(
                        borderRadius: BorderRadius.circular(KConfig.radius),
                        onTap: () {
                          Get.to(() =>
                              WebScreen(scannedBarcodes.first.displayValue!));
                        },
                        child: Container(
                          margin: EdgeInsets.all(KConfig.margin),
                          padding: EdgeInsets.all(KConfig.margin),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(KConfig.radius),
                              color: Theme.of(context).unselectedWidgetColor),
                          child: const Icon(CupertinoIcons.link,
                              color: Colors.white),
                        ),
                      )
                    : Container(),
              ],
            )
          ],
        );
      },
    );
  }
}
