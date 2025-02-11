import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaf_scan/core/common/widgets/custom_elevated_button.dart';
import 'package:leaf_scan/core/common/widgets/custom_text_field.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _userNameController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
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
                Image.asset("assets/register_hero.png"),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign Up",
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
                  controller: _userNameController,
                  hintText: "Username",
                  icon: Icon(
                    Icons.person,
                  ),
                ),
                SizedBox(
                  height: 30,
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
                CustomElevatedButton(
                  buttonText: "Register",
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
                        "Joined us before?",
                        style: GoogleFonts.workSans(
                            color: AppColors.darkGreyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Text(
                          "Login",
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
