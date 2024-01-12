import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  // Function onValidate;
  final String? Function(String?)? onValidate;
  FocusNode? focusNode;
  // Function onchanged;
  void Function(String)? onChanged;
  CustomTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    required this.onValidate,
    this.focusNode,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
        maxLines: 1,
        enableInteractiveSelection: true,
        onChanged: widget.onChanged,
        validator: widget.onValidate,
        controller: widget.controller,
        obscureText:
            widget.obscureText == false ? widget.obscureText : _obscureText,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
            // hintStyle: TextStyle(color: Colors.white
            // ),
            //filled: true,
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
                              height: 15,
                              width: 15,
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
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xffC6C6C6))),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white),
            )),
      ),
    );
  }
}
