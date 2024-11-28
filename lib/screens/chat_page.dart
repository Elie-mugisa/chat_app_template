import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapp/constants/app_string.dart';
import 'package:testapp/constants/helpers.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contactInfo = Get.arguments;

    final heithPage = MediaQuery.of(context).size.height;
    final widthPage = MediaQuery.of(context).size.width;
    final isDark = HelperFns.isDarkMode(context);
    // print(contactInfo);

    return Scaffold(
      appBar: navChatBar(contactInfo),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: heithPage,
                width: widthPage,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppString.wal), fit: BoxFit.cover)),
              ),
              Container(
                height: heithPage,
                width: widthPage,
                color: Colors.black.withOpacity(0.5),
              ),
              Container(
                // height: heithPage,
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      
                      width: double.maxFinite,
                      color: Colors.purple,
                    ),
                    SizedBox(
                      // height: heithPage * 0.07,
                      height: 45,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              constraints: BoxConstraints(
                                maxWidth: widthPage * 0.82,
                              ),
                              filled: true,
                              fillColor: isDark? Colors.black : Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: const BorderSide(
                               color: Colors.red
                                ))
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(7)),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.send_sharp,
                                    color: Colors.white,
                                  )))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar navChatBar(contactInfo) {
    return AppBar(
      leadingWidth: 30,
      leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),
      title: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${contactInfo['name']}',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                '${contactInfo['email']}',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ],
          )
        ],
      ),
    );
  }
}
