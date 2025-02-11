import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaf_scan/core/common/widgets/custom_elevated_button.dart';
import 'package:leaf_scan/core/common/widgets/custom_text_field.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                  isObscure: true,
                  icon: Icon(
                    Icons.lock,
                  ),
                ),
                SizedBox(
                  height: 30,
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
                  height: 30,
                ),
                CustomElevatedButton(
                  buttonText: "Login",
                  onPressed: () {},
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
                        onTap: (){
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
    );
  }
}
