import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaf_scan/core/common/widgets/custom_elevated_button.dart';
import 'package:leaf_scan/core/common/widgets/custom_snack_bar.dart';
import 'package:leaf_scan/core/common/widgets/custom_text_field.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';
import 'package:leaf_scan/features/authentication/cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // At least one uppercase, one lowercase, one number, one special char, min 8 characters
    final regex =
        RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');

    if (!regex.hasMatch(value)) {
      return 'Password must be at least 8 characters and include uppercase, lowercase, number, and special character';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: BlocListener<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    Navigator.pushNamed(context, "/home");
                  }
                  if (state is LoginFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar(
                        message: state.message,
                      ).build(context),
                    );
                  }
                },
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset("assets/login_hero.png"),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Login",
                          style: GoogleFonts.workSans(
                            color: AppColors.blackColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: "Email",
                        validator: (email) => validateEmail(email),
                        icon: Icon(
                          Icons.alternate_email,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: "Password",
                        validator: (password) => validatePassword(password),
                        isObscure: true,
                        icon: Icon(
                          Icons.lock,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.workSans(
                              color: AppColors.greenColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return CustomElevatedButton(
                            isLoading: state is LoginLoadingState,
                            buttonText: "Login",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context).login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New to this?",
                              style: GoogleFonts.workSans(
                                  color: AppColors.darkGreyColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/register");
                              },
                              child: Text(
                                "Register",
                                style: GoogleFonts.workSans(
                                  color: AppColors.greenColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
