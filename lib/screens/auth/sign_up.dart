// ignore_for_file: unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:testapp/constants/app_string.dart';
import 'package:testapp/constants/validation_input.dart';
import 'package:testapp/controllers/app_controller.dart';
import 'package:testapp/controllers/auth_controller.dart';
import 'package:testapp/screens/auth/sign_in.dart';
import 'package:testapp/screens/auth/widgets/input_field.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final GlobalKey<FormState> _registerFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final heightPage = MediaQuery.of(context).size.height;
    final widthPage = MediaQuery.of(context).size.width;
    final AuthController auth = Get.put(AuthController());

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Hey, Bienvenu', style: TextStyle(
                        fontSize: 32
                      ),),
                      Text('Creer un compte et profiter d\'interagire avec les amis!', style: TextStyle(
                        color: Colors.grey.shade500
                      ),)
                    ],
                  ),
                ),
                GetBuilder<AuthController>(
                    init: AuthController(),
                    builder: (controller) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(left: 10, top: 4),
                  height: heightPage * 0.15,
                  width: double.maxFinite,
                
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => controller.getImageFromGallery(),
                        child: Container(
                          height: widthPage * 0.25,
                          width: widthPage * 0.25,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(500)),
                          child: controller.selectedImg !=null? CircleAvatar(

                                backgroundImage: FileImage(controller.selectedImg!,))
                        
                           : Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: SvgPicture.asset(
                              AppString.avatar,
                              color: Colors.grey.shade500,
                              height: 10,
                                                       ),
                           ),
                        )
                        ),
                      
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          height: 45,
                          width: widthPage * 0.62,
                          child: TextFormField(
                            controller: nameController,
                              decoration: const InputDecoration(
                                  hintText: "Nom complet",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Colors.grey, // Set the border color
                                      width: 2.0, // Set the border width
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .blue, // Set the color when focused
                                      width:
                                          2.0, // Set the border width when focused
                                    ),
                                  )))),
                    ],
                  ),
                );
                    }),
                     SizedBox(height: heightPage * 0.05,),
                Container(
                  padding: const EdgeInsets.only(top: 30, left: 24, bottom: 10),
                  child: const Text(
                    textAlign: TextAlign.left,
                    'Les information supplementaires',
                    style: TextStyle(fontSize: 18),
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
                          key: _registerFormKey,
                          child: Column(
                            children: [
                              MyInput(
                                icon: Icon(Icons.email,
                                    color: Colors.grey.shade700),
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
                  height: heightPage * 0.1,
                ),
                GetBuilder<AuthController>(
                    init: AuthController(),
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          if (_registerFormKey.currentState?.validate() ?? false) {
                            _registerFormKey.currentState?.save();
                            // print(nameController.text);
                            // print(emailController.text);
                            // print(passController.text);
                            // print(controller.selectedImg!.path);
                            controller.register(
                                email: emailController.text.trim(),
                                imagePath: controller.selectedImg?.path ?? " ",
                                name: nameController.text.trim(),
                                password: passController.text.trim()
                                );
                          }
                        },
                        child: Container(
                            height: 45,
                            width: double.maxFinite,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ))
                                  : const Text(
                                      'S\'inscrire',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                            )),
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Avez vous deja un compte?'),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () => Get.to(() => SignIn()),
                        child: const Text(
                          'Se connecter',
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
