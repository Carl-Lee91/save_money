import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:save_money/public_method/public_method.dart';

class SettingViewModel extends AsyncNotifier<void> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? get platform => prefs.getString('platform');

  @override
  FutureOr<void> build() {}

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      if (platform == 'kakao') {
        await UserApi.instance.logout();
      } else if (platform == 'google') {
        await googleSignIn.signOut();
      }
      await _clearData();
      state = const AsyncValue.data(null);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> withdrawal() async {
    state = const AsyncValue.loading();
    try {
      if (platform == 'kakao') {
        await _unLinkKakao();
      } else if (platform == 'google') {
        await googleSignIn.signOut();
      }
      await _clearData();
      state = const AsyncValue.data(null);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> _unLinkKakao() async {
    try {
      OAuthToken? kakaoAccessToken =
          await TokenManagerProvider.instance.manager.getToken();
      if (kakaoAccessToken != null) {
        await AuthApi.instance.refreshToken(oldToken: kakaoAccessToken);
        await UserApi.instance.unlink();
      }
    } catch (e) {
      throw Exception('Kakao unlink failed: $e');
    }
  }

  Future<void> _clearData() async {
    prefs.clear();
    await secureStorage.deleteAll();
  }
}

final settingViewModelProvider =
    AsyncNotifierProvider<SettingViewModel, void>(SettingViewModel.new);
