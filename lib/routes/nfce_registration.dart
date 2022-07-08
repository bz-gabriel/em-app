import 'package:emapp/core/constans.dart';
import 'package:emapp/main.dart';
import 'package:emapp/model/nfces_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../services/users_auth_api.dart';

class NfceRegistration extends StatefulWidget {
  const NfceRegistration({Key? key}) : super(key: key);

  @override
  State<NfceRegistration> createState() => _NfceRegistrationState();
}

class _NfceRegistrationState extends State<NfceRegistration> {
  String ticket = '';
  @override
  void initState() {
    // TODO: implement initState
    readQrCode();
    super.initState();
  }

  readQrCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      '#FFFFFF',
      "Cancelar",
      true,
      ScanMode.QR,
    );
    setState(() => ticket = code != '-1' ? code : 'Não validado');
  }

  @override
  Widget build(BuildContext context) {
    final userAuth = Provider.of<UsersAuthApi>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: mainColor,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (ticket != '')
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    NfcesRequestModel model =
                        NfcesRequestModel(accessToken: userAuth.accessToken);
                    bool deuCerto =
                        await userAuth.nfceRegistration(model, ticket);
                    if (deuCerto) {
                      print('deu Certo');
                    } else {
                      print(ticket);
                      print('n');
                    }
                  },
                  child: Text('enviar'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
