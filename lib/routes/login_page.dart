import 'package:emapp/core/constans.dart';
import 'package:emapp/model/login_request_model.dart';
import 'package:emapp/routes/create_user_page.dart';
import 'package:emapp/routes/home_page.dart';
import 'package:emapp/services/users_auth_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    final accessToken = Provider.of<UsersAuthApi>(context);
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: mainColor,
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: _size.height * 0.05,
              ),
              const Text(
                'Easy Market',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Bem Vindo',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 40.0,
                ),
              ),
              SizedBox(
                height: _size.height * 0.10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'e-mail',
                  border: decorationTextFormFieldLogin,
                  enabledBorder: decorationTextFormFieldLogin,
                  prefixIcon: const Icon(Icons.mail),
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Por favor, digite seu e-mail';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(_emailController.text)) {
                    return 'Por favor, digite um e-mail correto';
                  }
                },
              ),
              SizedBox(
                height: _size.height * 0.02,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'senha',
                  border: decorationTextFormFieldLogin,
                  enabledBorder: decorationTextFormFieldLogin,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    child: Icon(
                      _showPassword == false
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: _showPassword == false ? true : false,
                validator: (senha) {
                  if (senha == null || senha.isEmpty) {
                    return 'Por favor, digite sua senha';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Esqueceu a sua senha?',
                      style: TextStyle(
                        fontSize: _size.width * 0.030,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: _size.width * 0.30,
                child: OutlinedButton(
                  onPressed: () async {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    //if (_formkey.currentState!.validate()) {
                    LoginRequestModel loginModel = LoginRequestModel(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    final authUser =
                        Provider.of<UsersAuthApi>(context, listen: false);

                    bool deuCerto = await authUser.login(loginModel);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    if (deuCerto) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                      print('Deu certo');
                    } else {
                      _passwordController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  //},
                  child: const Text('LOGIN'),
                  style: defaultStyleButton,
                ),
              ),
              SizedBox(
                height: _size.height * 0.001,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Não tem uma conta?',
                    style: TextStyle(
                      fontSize: _size.width * 0.030,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.5),
                    child: TextButton(
                      onPressed: () {
                        _emailController.clear();
                        _passwordController.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateUserPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Cadastre-se',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: _size.width * 0.030,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SnackBar snackBar = const SnackBar(
    content: Text('E-mail ou senha são invalidos'),
    backgroundColor: Colors.redAccent,
  );
}
