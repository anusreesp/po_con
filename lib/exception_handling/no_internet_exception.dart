import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:htp_concierge/exception_handling/controllers/connectivity_controller.dart';

class NoInternetPage extends ConsumerWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SvgPicture.asset(
                'assets/svg/images/exception/no_connection.svg',
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: const Text(
                  'Oops, No Internet Connection',
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: -1.7,
                    wordSpacing: -2.6,
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: 24,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 52),
                child: const Text(
                  'No internet connection was found. Check your connection or try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xffC0C8D3),
                  ),
                )),
            const SizedBox(
              height: 32,
            ),
            if (connectivity is ConnectivityLoading)
              const CircularProgressIndicator(),
            if (connectivity is ConnectivityNone)
              BlackBorderButton(
                  onTap: () {
                    ref.read(connectivityProvider.notifier).init();
                  },
                  text: 'Try again')
          ],
        ),
      ),
    );
  }
}

class BlackBorderButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? height;
  const BlackBorderButton(
      {super.key, required this.onTap, this.height, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.92,
        height: height ?? 50,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffD3BB8A)),
          color: Color(0xff090F17).withOpacity(0.75),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
                child: Text(text,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white)))),
      ),
    );
  }
}
