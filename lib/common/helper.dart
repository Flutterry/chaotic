part of commons;

bool phoneValidation(String? value) {
  if (value == null) return false;
  const phoneRegex = r'^\d{11,15}$';
  return RegExp(phoneRegex).hasMatch(value);
}

bool passwordValidation(String? value) {
  return value != null && value.length >= 8;
}

bool textValidation(String? value, {int min = 0, int max = 500}) {
  return value != null &&
      value.trim().length >= min &&
      value.trim().length <= max;
}

bool emailValidation(String? value) {
  if (value == null || value.isEmpty) return false;
  const emailRegex =
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  return RegExp(emailRegex).hasMatch(value);
}

bool nationalIdValidation(String? value) {
  return value != null && value.trim().length >= 14;
}

bool sameValidation(String? value, String? secondValue) {
  return value == secondValue;
}

void hideStatusBar() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

void hideKeyboard() {
  FocusScope.of(ContextService.context).requestFocus(FocusNode());
}

void preventLandScapeMode() {
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
}

String enumToString<T>(T value) {
  return value.toString().split('.').last;
}

Future<String> getDeviceName() async {
  String brand = '';
  String id = '';
  if (Platform.isAndroid) {
    final deviceInfo = await PlatformDeviceId.deviceInfoPlugin.androidInfo;
    brand = deviceInfo.device;
    id = deviceInfo.androidId;
  } else {
    final deviceInfo = await PlatformDeviceId.deviceInfoPlugin.iosInfo;
    brand = deviceInfo.model;
    id = deviceInfo.identifierForVendor;
  }

  return '$brand|$id';
}

Future<String?> getDeviceToken(dynamic firebaseMessaging) async {
  if (Platform.isIOS) {
    firebaseMessaging.requestPermission();
    await firebaseMessaging.getNotificationSettings();
  }
  final token = await firebaseMessaging.getToken();
  return token.toString();
}

/// keys => code, number
Future<Map<String, String>> getApplicationVersion() async {
  final packageInfo = await PackageInfo.fromPlatform();
  final code = packageInfo.version;
  final number = packageInfo.buildNumber;
  return {
    'code': code,
    'number': number,
  };
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}');
  for (final match in pattern.allMatches(text)) {
    debugPrint(match.group(0));
  }
}

String replaceFarsiNumber(String input) {
  final english = '0123456789'.split('').map((e) => e.trim()).toList();
  final farsi = '٠١٢٣٤٥٦٧٨٩'.split('').map((e) => e.trim()).toList();
  var result = input;

  for (int i = 0; i < english.length; i++) {
    result = result.replaceAll(farsi[i], english[i]);
  }

  return result;
}

///return result in meter
double distanceBetween(
  double startLatitude,
  double startLongitude,
  double endLatitude,
  double endLongitude,
) {
  const earthRadius = 6378137.0;
  final dLat = _toRadians(endLatitude - startLatitude);
  final dLon = _toRadians(endLongitude - startLongitude);

  final a = pow(sin(dLat / 2), 2) +
      pow(sin(dLon / 2), 2) *
          cos(_toRadians(startLatitude)) *
          cos(_toRadians(endLatitude));
  final c = 2 * asin(sqrt(a));

  return earthRadius * c;
}

double _toRadians(double degree) {
  return degree * pi / 180;
}

/// converter to asset files BitmapDescriptor.fromAssetImage,
Future getMarkerIcon(Function converter, String imagePath) async {
  final icon = await converter(
    ImageConfiguration.empty,
    imagePath,
  );
  return icon;
}

/// if it return true it's mean this position inside area
/// it's take [currentPosition] from type LatLng, and [vertices] List<LatLng>
bool isInsideArea(dynamic currentPosition, List<dynamic> vertices) {
  int intersectCount = 0;
  for (int j = 0; j < vertices.length - 1; j++) {
    if (_rayCastIntersect(currentPosition, vertices[j], vertices[j + 1])) {
      intersectCount++;
    }
  }

  return intersectCount.isOdd; // odd = inside, even = outside;
}

bool _rayCastIntersect(dynamic tap, dynamic vertA, dynamic vertB) {
  double aY = vertA.latitude;
  double bY = vertB.latitude;
  double aX = vertA.longitude;
  double bX = vertB.longitude;
  double pY = tap.latitude;
  double pX = tap.longitude;

  if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
    return false; // a and b can't both be above or below pt.y, and a or
    // b must be east of pt.x
  }

  double m = (aY - bY) / (aX - bX); // Rise over run
  double bee = (-aX) * m + aY; // y = mx + b
  double x = (pY - bee) / m; // algebra is neat!

  return x > pX;
}

Map<String, dynamic> deleteSame(
  Map<String, dynamic> firstMap,
  Map<String, dynamic> secondMap, {
  List<String> ignoreKeys = const [],
}) {
  try {
    final keys = firstMap.keys.toList();
    for (var i = 0; i < keys.length; i++) {
      final key = keys[i];
      if (ignoreKeys.contains(key)) continue;
      if (firstMap[key] is Map && secondMap[key] is Map) {
        final result =
            deleteSame(firstMap[key], secondMap[key], ignoreKeys: ignoreKeys);
        if (result.isEmpty) firstMap.remove(key);
      } else if (firstMap[key] is List &&
          secondMap[key] is List &&
          (firstMap[key] as List).every((e) => e is Map) &&
          (secondMap[key] as List).every((e) => e is Map)) {
        for (var j = 0; j < firstMap[key].length; j++) {
          deleteSame(firstMap[key][j], secondMap[key][j],
              ignoreKeys: ignoreKeys);
        }
        (firstMap[key] as List).removeWhere((e) => e.isEmpty);
        if (firstMap[key].isEmpty) firstMap.remove(key);
      } else if (firstMap[key] is List && secondMap[key] is List) {
        if (listEquals(firstMap[key], secondMap[key])) firstMap.remove(key);
      } else if (firstMap[key] == secondMap[key]) {
        firstMap.remove(key);
      }
    }
  } catch (_) {}

  return firstMap;
}
