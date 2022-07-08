import 'package:emapp/core/constans.dart';
import 'package:emapp/model/nfce_model.dart';
import 'package:emapp/model/nfces_request_model.dart';
import 'package:emapp/routes/login_page.dart';
import 'package:emapp/services/users_auth_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NfcesResponseModel>? list;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadNfces();
  }

  String getCurrency(double value) {
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return formatter.format(value);
  }

  String fmtDate(DateTime value) {
    initializeDateFormatting('pt_BR', null);
    DateFormat formatter = DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_BR');
    return formatter.format(value);
  }

  Future<void> loadNfces() async {
    final userAuth = Provider.of<UsersAuthApi>(context, listen: false);
    final accessToken = userAuth.accessToken;
    NfcesRequestModel model = NfcesRequestModel(accessToken: accessToken);
    list = await UsersAuthApi().getNfces(model);
    isLoading = false;
    setState(() {
      isLoading = false;
    });
    return Future.value();
  }

  String ticket = '';
  readQrCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      '#FFFFFF',
      "Cancelar",
      true,
      ScanMode.QR,
    );
    setState(() => ticket = code != '-1' ? code : 'Não validado');
  }

  SnackBar snackBar = const SnackBar(
    content: Text('Não foi possível conectar link'),
    backgroundColor: Colors.redAccent,
  );

  Future<void> _launchLink(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.platformDefault);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final userAuth = Provider.of<UsersAuthApi>(context, listen: true);
    final accToken = userAuth.accessToken;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('User'),
              accountEmail: const Text('email@email'),
              decoration: BoxDecoration(
                color: mainColor,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.chrome_reader_mode_rounded),
              title: const Text(
                'Listas',
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () async {
                bool logout = await UsersAuthApi().logout();
                if (logout) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ListBody(
                          children: [
                            const Text(
                              'Funcão não implementada, cadastre suas notinhas diretamente em:',
                            ),
                            TextButton(
                              onPressed: () {
                                _launchLink(
                                  'https://app-easymarket.herokuapp.com/',
                                );
                              },
                              child: const Text(
                                'https://app-easymarket.herokuapp.com/',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.qr_code),
            ),
          ],
        ),
        backgroundColor: mainColor,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : list == null
              ? const Text('Nenhuma nota encontrada')
              : ListView.builder(
                  itemCount: list?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(list![index].issuer!.name!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //exibindo o mesmo valor par ambas notinhas
                          Text(fmtDate(list![index].emissionDate!)),
                          Text(getCurrency(double.parse(list![index].amount!))),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
