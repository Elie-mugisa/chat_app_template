import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:testapp/controllers/auth_controller.dart';
import 'package:testapp/screens/chat_page.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthController auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    // final AuthController auth = Get.put(AuthController());
    // auth.gettingUsers();

    final heightPage = MediaQuery.of(context).size.height;
    final widthPage = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GetBuilder<AuthController>(
              init: AuthController(),
              builder: (controller) {
                return IconButton(
                    onPressed: () => controller.logout(),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 32,
                    ));
              })
        ],
      ),
      body: Center(
          child: GetBuilder<AuthController>(
              init: AuthController(),
              builder: (controller) {
                // print(controller.selectedImg);
                // controller.selectedImg = controller.userList[0]['imagePath'];
                // print(sele)
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SizedBox(
                          width: double.infinity,
                          child: Text(
                            'contact',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.userList.length,
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.grey.shade200,
                              ),
                          itemBuilder: (context, index) {
                            return contactTile(
                                widthPage : widthPage, heightPage: heightPage, controller: controller, index: index, contactId: controller.userList[index]['uid'], contactName: controller.userList[index]['name'], contactEmail: controller.userList[index]['email']);
                          }),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                );
              })),
    );
  }

  GestureDetector contactTile({required double widthPage, required double heightPage,
      required AuthController controller, required int index, required String contactName, required String contactId, required String  contactEmail}) {
    return GestureDetector(
      onTap: () => Get.to(()=> ChatPage(), arguments: {
        'id': contactId,
        'name': contactName,
        'email' : contactEmail
      }),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              height: widthPage * 0.15,
              width: widthPage * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(heightPage),
                  color: Colors.grey),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${controller.userList[index]['name']}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text('start part of the message to be...'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
