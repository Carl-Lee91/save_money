import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SocialLoginViewModel extends AsyncNotifier {
  @override
  FutureOr build() {
    throw UnimplementedError();
  }
}

final socialLoginProvider = AsyncNotifierProvider<SocialLoginViewModel, void>(
  SocialLoginViewModel.new,
);
