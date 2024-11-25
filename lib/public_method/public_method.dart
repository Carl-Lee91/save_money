import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
late FlutterSecureStorage secureStorage;

class PublicMethod {
  static Future<void> preferenceinit() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
  }

  static void secureStorageInit() {
    WidgetsFlutterBinding.ensureInitialized();
    secureStorage = const FlutterSecureStorage();
  }

  static void infoDialogue(BuildContext context, String description) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Column(
          children: [
            AlertDialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              content: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  children: [
                    const Text('소비 TIP'),
                    const Gap(16),
                    Image.asset(
                      'assets/images/big_dollar.png',
                      width: 151,
                      height: 107,
                    ),
                    const Gap(16),
                    Text(description),
                  ],
                ),
              ),
            ),
            const Gap(12),
            const SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                child: Text(
                  '확인했어요',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
