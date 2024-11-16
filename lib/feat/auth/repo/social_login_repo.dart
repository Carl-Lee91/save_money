import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:save_money/public_method/public_method.dart';

class SocialLoginRepo {
  Future<void> signInKakao() async {
    try {
      final dio = Dio();
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token;
      if (isInstalled) {
        try {
          token = await UserApi.instance.loginWithKakaoTalk();
        } catch (e) {
          token = await UserApi.instance.loginWithKakaoAccount();
        }
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      final response = await dio.post(
        'https://kapi.kakao.com/v2/user/me',
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}',
          },
        ),
      );
      final Map<String, dynamic> profileInfo = response.data;

      print(profileInfo);

      final int? userID = profileInfo['id'];

      await secureStorage.write(
        key: 'kakaoAccessToken',
        value: token.accessToken,
      );
      await secureStorage.write(
        key: 'kakaoRefreshToken',
        value: token.refreshToken,
      );
    } catch (error) {}
  }
}
