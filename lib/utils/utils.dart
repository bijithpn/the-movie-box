import 'dart:convert';

import 'package:share_plus/share_plus.dart';

class Utils {
  static String base64Encode(String input) {
    final bytes = utf8.encode(input);
    return base64.encode(bytes);
  }

  static String base64Decode(String encodedInput) {
    final decodedBytes = base64.decode(encodedInput);
    return utf8.decode(decodedBytes);
  }

  static void deeplinkCreater({required int showId, required String route}) {
    final routeEncode = base64Encode(route);
    final showIdEncode = base64Encode(showId.toString());
    Share.share(
      'Look what i found on the moviebox app!\n themoviebox.dev/$routeEncode/$showIdEncode',
    );
  }
}
