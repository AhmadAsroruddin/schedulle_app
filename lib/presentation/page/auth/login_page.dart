import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedulle_app/presentation/bloc/Auth_bloc.dart';
import 'package:schedulle_app/presentation/page/auth/register_page.dart';
import 'package:schedulle_app/presentation/routes/router_delegate.dart';
import 'package:schedulle_app/presentation/shared/theme.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static const routeName = '/loginPage';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: 400,
              height: screenHeight * 0.2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/Vector.png'),
                ),
              ),
            ),
          ),
          ListView(
            children: [
              Container(
                width: screenWidth * 0.51,
                height: screenHeight * 0.23,
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/login_image.png'),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Login",
                        style: blackTextStyle.copyWith(
                            fontSize: 26, fontWeight: bold),
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        hintText: "Masukan email atau username",
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        hintText: "Password",
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      child: const Text("Forgot Password"),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: blueColor),
                      child: TextButton(
                        onPressed: () async {
                          await context.read<AuthCubit>().login(
                              _emailController.text, _passwordController.text);

                          // ignore: use_build_context_synchronously
                          (Router.of(context).routerDelegate
                                  as MyRouterDelegate)
                              .login();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0x000b6efe),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: whiteTextStyle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: screenWidth * 0.2,
                          height: 5,
                          decoration: const BoxDecoration(color: Colors.blue),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: const Text("Belum punya akun?"),
                        ),
                        Container(
                          width: screenWidth * 0.2,
                          height: 5,
                          decoration: const BoxDecoration(color: Colors.blue),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(RegisterPage.routeName);
                      },
                      child: Text(
                        "Buat Akun",
                        style: blackTextStyle,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
