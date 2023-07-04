import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:payaboki/arguments/wallet_scan_pay_args.dart';
import 'package:payaboki/screens/wallet_scan_pay.dart';

class WalletScan extends StatefulWidget {
  static const String id = "wallet_scan";
  final walletInfo;
  const WalletScan({Key? key, this.walletInfo}) : super(key: key);

  @override
  State<WalletScan> createState() => _WalletScanState();
}

class _WalletScanState extends State<WalletScan> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    var walletData = widget.walletInfo;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          'Scan to pay',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.all(15.0),
            color: Colors.grey,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off,
                        size: 25.0, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on,
                        size: 25.0, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            padding: EdgeInsets.fromLTRB(0.0, 15.0, 30.0, 15.0),
            color: Colors.grey,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(
                      Icons.cameraswitch,
                      size: 15.0,
                    );
                  case CameraFacing.back:
                    return const Icon(
                      Icons.cameraswitch,
                      size: 25.0,
                    );
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: cameraController,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            // print(barcode.rawValue);
            // debugPrint('Barcode found! ${barcode.rawValue}');
            Navigator.pushNamed(context, WalletScanPay.id,
                arguments: ScanPayArgs(
                    rcv: barcode.rawValue.toString(), user_data: walletData));
          }
        },
      ),
    );
  }
}
