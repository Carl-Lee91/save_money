import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:save_money/public_method/public_method.dart';

class SocialLoginViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> signInKakao() async {
    state = const AsyncValue.loading();
    try {
      final dio = Dio();

      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token;

      if (isInstalled) {
        try {
          token = await UserApi.instance.loginWithKakaoTalk();
        } catch (_) {
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
      final String userID = profileInfo['id'].toString();

      prefs.setString('userID', userID);
      prefs.setString('platform', 'kakao');
      await secureStorage.write(
        key: 'kakaoAccessToken',
        value: token.accessToken,
      );
      await secureStorage.write(
        key: 'kakaoRefreshToken',
        value: token.refreshToken,
      );

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(
        error,
        stackTrace,
      );
    }
  }

  Future<void> signInGoogle() async {
    state = const AsyncValue.loading();
    try {
      final GoogleSignIn googleSignIn =
          GoogleSignIn(scopes: ['profile', 'email']);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      String userID = googleUser!.id;

      prefs.setString('userID', userID);
      prefs.setString('platform', 'google');
      await secureStorage.write(
        key: 'googleAccessToken',
        value: googleAuth!.idToken,
      );

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(
        error,
        stackTrace,
      );
    }
  }
}

final socialLoginProvider =
    AsyncNotifierProvider<SocialLoginViewModel, void>(SocialLoginViewModel.new);
