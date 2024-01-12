import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/features/dashboard/controller/widget_controller/search_controller.dart';

class CustomSearchBox extends StatefulWidget {
  final String page;
  const CustomSearchBox({Key? key, required this.page}) : super(key: key);

  @override
  State<CustomSearchBox> createState() => _CustomSearchBoxState();
}

class _CustomSearchBoxState extends State<CustomSearchBox> {
  // final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.055,
        child: Consumer(
          builder: (context, ref, child) {
            return TextField(
              controller: widget.page == 'home'
                  ? ref.read(homeControllerProvider.notifier).state
                  : widget.page == 'upcoming'
                      ? ref.read(upcomingControllerProvider.notifier).state
                      : ref.read(pastControllerProvider.notifier).state,
              cursorColor: const Color(0xffffE8D48A),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white38, width: 1),
                    borderRadius: BorderRadius.circular(30.0)),
                filled: true,
                fillColor: const Color(0xff646464),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Color(0xffE8D48A),
                ),
                //isDense: true,
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white38, width: 1),
                    borderRadius: BorderRadius.circular(30.0)),
                hintText: 'Search guest name, id...',
                hintStyle: const TextStyle(
                  fontSize: 12,
                  color: Color(0xffFFFFFF),
                  fontStyle: FontStyle.italic,
                ),
              ),
              onChanged: (value) {
                if (widget.page == 'home') {
                  ref.read(nameSearchProvider.notifier).state = value;
                } else if (widget.page == 'upcoming') {
                  ref.read(newNameSearchProvider.notifier).state = value;
                } else {
                  ref.read(pastNameSearchProvider.notifier).state = value;
                }
              },
            );
          },
        ));
  }
}
