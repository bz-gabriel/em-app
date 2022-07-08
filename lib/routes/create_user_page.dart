import 'package:emapp/core/constans.dart';
import 'package:emapp/model/create_user_request_model.dart';
import 'package:emapp/routes/home_page.dart';
import 'package:emapp/routes/login_page.dart';
import 'package:emapp/services/users_auth_api.dart';
import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    SizedBox criarSizedBox() {
      return SizedBox(height: _size.height * 0.02);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        backgroundColor: mainColor,
      ),
      body: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: _size.height * 0.05),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: decorationTextFormFieldLogin,
                  enabledBorder: decorationTextFormFieldLogin,
                  prefixIcon: const Icon(Icons.account_box),
                ),
                controller: _nameController,
                keyboardType: TextInputType.text,
              ),
              criarSizedBox(),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'e-mail',
                  border: decorationTextFormFieldLogin,
                  enabledBorder: decorationTextFormFieldLogin,
                  prefixIcon: const Icon(Icons.mail),
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              criarSizedBox(),
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
              ),
              SizedBox(
                height: _size.height * 0.02,
              ),
              SizedBox(
                width: _size.width * 0.30,
                child: OutlinedButton(
                  onPressed: () async {
                    CreateUserRequestModel creteUserModel =
                        CreateUserRequestModel(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      passwordConfirm: _passwordController.text,
                    );
                    bool deuCerto = await UsersAuthApi().SignUp(creteUserModel);
                    if (deuCerto) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                      print('Deu certo');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text('CADASTRAR'),
                  style: defaultStyleButton,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SnackBar snackBar = const SnackBar(
    content: Text('Por favor, preencha os dados corretamente'),
    backgroundColor: Colors.redAccent,
  );
}
