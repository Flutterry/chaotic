part of widgets;

class CustomText extends StatelessWidget {
  final String? tag;
  final String? text;
  final TextStyle? style;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final int maxLines;
  final TextAlign align;

  const CustomText({
    this.tag,
    this.text,
    this.style,
    this.fontSize = 15,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.maxLines = 1,
    this.align = TextAlign.start,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deliStyle = style ??
        TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        );
    return Text(
      text ?? tr(tag ?? 'text and tag = null'),
      style: deliStyle,
      overflow: TextOverflow.ellipsis,
      textAlign: align,
      locale: context.locale,
      maxLines: maxLines,
    );
  }
}
