// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/constants/validation_input.dart';
import 'package:testapp/controllers/app_controller.dart';
import 'package:testapp/controllers/auth_controller.dart';
import 'package:testapp/screens/auth/sign_up.dart';
import 'package:testapp/screens/auth/widgets/input_field.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final emailController = TextEditingController();
  final passController = TextEditingController();

  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final heightPage = MediaQuery.of(context).size.height;
    final widthPage = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: heightPage * 0.4,
              width: widthPage,
              decoration: const BoxDecoration(color: Colors.black),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Center(
                child: Text(
                  'Dev Chat',
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GetBuilder<AppController>(
                init: AppController(),
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          MyInput(
                            icon:
                                Icon(Icons.email, color: Colors.grey.shade700),
                            hintText: 'exemple@gmail.com',
                            controller: emailController,
                            validing: EMAIL_VALIDATION_REGEX,
                            label: 'Email',
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value != null
                                  //  && PASSWORD_VALIDATION_REGEX.hasMatch(value)
                                  ) {
                                return null;
                              }
                              return "Le mot de pass doit aumoins avoir 6 caracteres";
                            },
                            obscureText: controller.isObscure.value,
                            controller: passController,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () => controller.viewInput(),
                                    icon: controller.isObscure.value
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)),
                                prefixIcon: const Icon(Icons.lock),
                                hintText: 'Mot secret',
                                labelText: 'Mot secret'),
                          )
                        ],
                      ),
                    ),
                  );
                }),
            SizedBox(
              height: heightPage * 0.18,
            ),
            GetBuilder<AuthController>(
                init: AuthController(),
                builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (_loginFormKey.currentState?.validate() ?? false) {
                        _loginFormKey.currentState?.save();
                        // print(emailController.text);
                        // print(passController.text);
                        controller.login(emailController.text.trim(),
                            passController.text.trim());
                      }
                    },
                    child: Container(
                        height: 45,
                        width: double.maxFinite,
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child:  Center(
                          child: controller.isLoading.value? const  SizedBox(
                             height: 20,
                             width: 20,
                          child:  CircularProgressIndicator(color: Colors.red,)): const Text(
                            'Se Connecter',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        )),
                  );
                }),
                const SizedBox(height: 15,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('N\'avez pas encore un compte?'),
                 
                    TextButton(onPressed: () => Get.to(()=> SignUp()), child: const Text('S\'inscrire', style: TextStyle(color: Colors.red),))
                  ],
                ),
              
          ],
        ),
      ),
    );
  }
}
