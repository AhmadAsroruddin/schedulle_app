import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedulle_app/presentation/bloc/Auth_bloc.dart';
import 'package:schedulle_app/presentation/shared/theme.dart';

import '../../shared/customTextForm.dart';
import '../../shared/roundedImage.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  static const routeName = '/registerPage';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: screenWidth * 0.51,
            height: screenHeight * 0.23,
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/register_image.png'),
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
                    "Create Account",
                    style:
                        blackTextStyle.copyWith(fontSize: 26, fontWeight: bold),
                  ),
                ),
                CustomTextForm(
                  controller: _emailController,
                  title: "Email",
                  screenWidth: screenWidth,
                ),
                CustomTextForm(
                  controller: _usernameController,
                  title: "Username",
                  screenWidth: screenWidth,
                ),
                CustomTextForm(
                  controller: _passwordController,
                  title: "Password",
                  screenWidth: screenWidth,
                  isObsecure: true,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.only(top: 5, bottom: 20),
                    child: const Text("Sudah Punya akun?"),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: blueColor),
                  child: TextButton(
                    onPressed: () async {
                      await context.read<AuthCubit>().create(_emailController.text,
                          _passwordController.text, _usernameController.text);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0x000b6efe),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is AuthError) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                              ),
                            );
                          });
                        } else if (state is AuthHasData) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.result),
                              ),
                            );
                          });
                        } else {
                          return Text(
                            "Create Account",
                            style: whiteTextStyle.copyWith(fontSize: 18),
                          );
                        }
                        return Text(
                          "Create Account",
                          style: whiteTextStyle.copyWith(fontSize: 18),
                        );
                      },
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
                      child: const Text("Dengan cara lain"),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RoundedImage(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      imageUrl: "assets/Google_logo.png",
                    ),
                    RoundedImage(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      imageUrl: "assets/facebook_logo.png",
                    ),
                    RoundedImage(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      imageUrl: "assets/apple_logo.png",
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
