part of commons;

extension ExtensionOnNumbers on num {
  double get w {
    return MediaQuery.of(ContextService.context).size.width * _getPercent(this);
  }

  double get h {
    return MediaQuery.of(ContextService.context).size.height *
        _getPercent(this);
  }
}

extension ExtensionOnStrings on String {
  String get image {
    return 'assets/images/${this}';
  }
}

double responsiveSize(num mobile, {num? tablet, num? desktop}) {
  if (shortestSide < phoneBreakpoint) return mobile * 1.0;
  if (shortestSide < tabletBreakPoint) return (tablet ?? mobile) * 1.0;
  if (shortestSide >= desktopBreakPoint) return (desktop ?? mobile) * 1.0;

  return mobile * 1.0;
}

double _getPercent(num percent) {
  num p = percent < 0 ? 0 : percent;
  p = percent > 100 ? 100 : percent;

  return p / 100;
}

double phoneBreakpoint = 800;
double tabletBreakPoint = 1000;
double desktopBreakPoint = 100;

double get shortestSide {
  return MediaQuery.of(ContextService.context).size.shortestSide * 1.0;
}
