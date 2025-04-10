import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:viaja_segura_movil/presentation/widgets/atoms/go_back_button.dart';

class QrCodeScanningScreen extends StatefulWidget {
  const QrCodeScanningScreen({super.key});

  @override
  State<QrCodeScanningScreen> createState() => _QrCodeScanningScreenState();
}

class _QrCodeScanningScreenState extends State<QrCodeScanningScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
    });
  }

  void _toggleFlash() async {
    if (controller != null) await controller!.toggleFlash();
  }

  void _flipCamera() async {
    if (controller != null) await controller!.flipCamera();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),
              ),
            ],
          ),
          Container(
            color: theme.primaryColor.withOpacity(0.7),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 48.0,
                horizontal: 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      GoBackButton(color: theme.canvasColor),
                      const Spacer(),
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert,
                          color: theme.canvasColor,
                        ),
                        onSelected: (String value) {
                          if (value == 'flash') {
                            _toggleFlash();
                          } else if (value == 'flip') {
                            _flipCamera();
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              value: 'flash',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.flash_on,
                                    color: theme.primaryColor,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Flash'),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'flip',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.flip_camera_android,
                                    color: theme.primaryColor,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Flip Camera'),
                                ],
                              ),
                            ),
                          ];
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    "Escanea aquí el código QR",
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.canvasColor,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
