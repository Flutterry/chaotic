part of widgets;

abstract class CustomTextFormField extends StatelessWidget {
  factory CustomTextFormField({
    TextInputType? textInputType = TextInputType.name,
    TextEditingController? controller,
    bool Function(String?)? validation,
    String? hint = '',
    String? errorMsg = '',
    FocusNode? nextFocus,
    FocusNode? myFocus,
    bool? enable = true,
    int? maxLines = 1,
  }) {
    return _CustomTextFormField(
      controller: controller,
      textInputType: textInputType,
      validation: validation ?? (value) => true,
      hint: hint,
      errorMsg: errorMsg,
      nextFocus: nextFocus,
      myFocus: myFocus,
      enable: enable,
      maxLines: maxLines,
    );
  }

  factory CustomTextFormField.withLabel({
    TextInputType? textInputType = TextInputType.name,
    TextEditingController? controller,
    bool Function(String?)? validation,
    String? hint = '',
    String? errorMsg = '',
    FocusNode? nextFocus,
    FocusNode? myFocus,
    bool? enable = true,
    int? maxLines = 1,
    IconData? icon,
    String? label = '',
  }) {
    return _CustomTextFormFieldLabel(
      controller: controller,
      textInputType: textInputType,
      validation: validation ?? (value) => true,
      hint: hint,
      errorMsg: errorMsg,
      nextFocus: nextFocus,
      myFocus: myFocus,
      enable: enable,
      maxLines: maxLines,
      icon: icon,
      label: label,
    );
  }

  factory CustomTextFormField.withLabelAndCode({
    TextInputType? textInputType = TextInputType.name,
    TextEditingController? controller,
    bool Function(String?)? validation,
    String? hint = '',
    String? errorMsg = '',
    FocusNode? nextFocus,
    FocusNode? myFocus,
    bool? enable = true,
    int? maxLines = 1,
    IconData? icon,
    String? label = '',
    Code? code,
  }) {
    return _CustomTextFormFieldLabelCode(
      controller: controller,
      textInputType: textInputType,
      validation: validation ?? (value) => true,
      hint: hint,
      errorMsg: errorMsg,
      nextFocus: nextFocus,
      myFocus: myFocus,
      enable: enable,
      maxLines: maxLines,
      icon: icon,
      label: label,
      code: code,
    );
  }

  const CustomTextFormField._();
}

class _CustomTextFormField extends CustomTextFormField {
  final TextEditingController? controller;
  final String? hint;
  final String? errorMsg;
  final bool Function(String?)? validation;
  final TextInputType? textInputType;
  final FocusNode? nextFocus;
  final FocusNode? myFocus;
  final bool? enable;
  final int? maxLines;

  const _CustomTextFormField({
    this.textInputType,
    this.controller,
    this.validation,
    this.hint,
    this.errorMsg,
    this.nextFocus,
    this.myFocus,
    this.enable,
    this.maxLines,
  }) : super._();

  OutlineInputBorder border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: color.withOpacity(0.7)),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      enabled: enable,
      controller: controller,
      validator: (value) {
        final result = validation?.call(value) ?? true;
        return result ? null : errorMsg;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        enabledBorder: border(Colors.grey.withOpacity(0.05)),
        border: border(Colors.grey),
        focusedBorder: border(Colors.green),
        errorBorder: border(Colors.red),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14),
      ),
      obscureText: textInputType == TextInputType.visiblePassword,
      keyboardType: textInputType,
      focusNode: myFocus,
      onEditingComplete: () {
        if (nextFocus == null) {
          FocusScope.of(context).nextFocus();
        } else {
          nextFocus?.requestFocus();
        }
      },
    );
  }
}

class _CustomTextFormFieldLabel extends CustomTextFormField {
  final TextEditingController? controller;
  final String? hint;
  final String? errorMsg;
  final String? label;
  final IconData? icon;
  final bool Function(String?)? validation;
  final TextInputType? textInputType;
  final FocusNode? nextFocus;
  final FocusNode? myFocus;
  final bool? enable;
  final int? maxLines;

  const _CustomTextFormFieldLabel({
    this.controller,
    this.icon,
    this.label,
    this.hint,
    this.errorMsg,
    this.validation,
    this.textInputType,
    this.nextFocus,
    this.myFocus,
    this.enable,
    this.maxLines,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            if (icon != null)
              Icon(
                icon,
                color: Colors.grey,
              ),
            const SizedBox(width: 5),
            CustomText(
              text: label,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        const SizedBox(height: 8),
        _CustomTextFormField(
          maxLines: maxLines,
          enable: enable,
          controller: controller,
          hint: hint,
          errorMsg: errorMsg,
          validation: validation,
          textInputType: textInputType,
          nextFocus: nextFocus,
          myFocus: myFocus,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _CustomTextFormFieldLabelCode extends CustomTextFormField {
  final TextEditingController? controller;
  final String? hint;
  final String? errorMsg;
  final String? label;
  final IconData? icon;
  final bool Function(String?)? validation;
  final TextInputType? textInputType;
  final Code? code;
  final FocusNode? nextFocus;
  final FocusNode? myFocus;
  final bool? enable;
  final int? maxLines;

  const _CustomTextFormFieldLabelCode({
    this.icon,
    this.label,
    this.controller,
    this.hint,
    this.errorMsg,
    this.validation,
    this.textInputType,
    this.code,
    this.nextFocus,
    this.myFocus,
    this.enable,
    this.maxLines,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            const SizedBox(width: 5),
            CustomText(
              text: label,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _CustomTextFormField(
                controller: controller,
                hint: hint,
                errorMsg: errorMsg,
                validation: validation,
                textInputType: textInputType,
                myFocus: myFocus,
                nextFocus: nextFocus,
                enable: enable,
                maxLines: maxLines,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CountryCodePicker(
                onInit: (countryCode) {
                  code?.dialCode = countryCode?.dialCode ?? '+nullCode';
                },
                onChanged: (countryCode) {
                  code?.dialCode = countryCode.dialCode ?? '+nullCode';
                },
                searchDecoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 8,
                  ),
                ),
                dialogSize: Size(95.w, 50.h),
                showFlagMain: false,
                padding: EdgeInsets.zero,
                countryFilter: const ['+966'],
                textStyle: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class Code {
  String dialCode = '';
}
