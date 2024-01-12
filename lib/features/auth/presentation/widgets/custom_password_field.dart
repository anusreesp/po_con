import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CustomPasswordField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  // Function onValidate;
  final String? Function(String?)? onValidate;
  void Function(String)? onChanged;
  // Function onchanged;
  CustomPasswordField({
    Key? key,
    required this.hintText,
    this.obscureText = true,
    this.controller,
    required this.onValidate,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: TextFormField(
        enableInteractiveSelection: true,
        onChanged: widget.onChanged,
        validator: widget.onValidate,
        controller: widget.controller,
        obscureText:
            widget.obscureText == false ? widget.obscureText : _obscureText,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
            hintText: widget.hintText,
            suffixIcon: widget.obscureText == true
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: GestureDetector(
                      onTap: () => _togglePassword(),
                      // child: Icon(!_obscureText
                      //     ? Icons.visibility
                      //     : Icons.visibility_off),
                      child: !_obscureText
                          ? SizedBox(
                              height: 17,
                              width: 17,
                              child: Center(
                                child: SvgPicture.asset(
                                    'assets/images/icons/visibility_on.svg'),
                              ),
                            )
                          : SizedBox(
                              height: 12,
                              width: 12,
                              child: Center(
                                child: Image.asset(
                                  "assets/images/icons/visibility_off.png",
                                  scale: 3.5,
                                ),
                              ),
                            ),
                    ),
                  )
                : null,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 112, 112, 112))),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 105, 105, 105)),
            )),
      ),
    );
  }
}
