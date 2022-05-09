part of widgets;

class CustomForm extends StatelessWidget {
  final Widget form;
  final String? image;
  final String? text;
  final String? tag;
  final double marginTopPercent;
  final double imageRadius;
  final void Function()? onPress;
  final Color shadowColor;
  final bool enable;
  final double blurRadius;
  final double? buttonWidth;
  final double? fontSize;
  final ButtonStyle? buttonStyle;

  const CustomForm({
    required this.form,
    this.onPress,
    this.image,
    this.shadowColor = Colors.black,
    this.imageRadius = 20,
    this.marginTopPercent = 15,
    this.enable = true,
    this.text,
    this.tag,
    this.blurRadius = 100,
    this.buttonStyle,
    this.fontSize,
    this.buttonWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: marginTopPercent.h,
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: image == null ? 10 : imageRadius,
              bottom: onPress == null ? 0 : 25,
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.3),
                  offset: const Offset(2, 4),
                  blurRadius: blurRadius,
                )
              ],
            ),
            child: form,
          ),
          if (image != null)
            Positioned(
              top: -imageRadius,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: shadowColor,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: image!.startsWith('http')
                    ? CircleAvatar(
                        backgroundColor: shadowColor,
                        radius: imageRadius,
                        backgroundImage: NetworkImage(image!),
                      )
                    : CircleAvatar(
                        backgroundColor: shadowColor,
                        radius: imageRadius,
                        child: Image.asset(
                          image!,
                          width: imageRadius,
                          height: imageRadius,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          if (text != null || tag != null)
            Positioned(
              bottom: -25,
              child: SizedBox(
                height: 50,
                width: buttonWidth,
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: enable
                      ? () {
                          FocusScope.of(ContextService.context)
                              .requestFocus(FocusNode());
                          onPress?.call();
                        }
                      : null,
                  child: CustomText(
                    text: text ?? tr(tag!),
                    color: Colors.white,
                    fontSize: fontSize ?? 10,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
