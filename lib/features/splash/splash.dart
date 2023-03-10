import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_sys/sizes.dart';
import 'splash_controller.dart';
import '../../shared/widgets/animated_logo.dart';
import 'widgets/app_progress.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Image _logo = Image.asset('assets/logo_white.png');
  final controller = SplashController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              height: Sizes.logoSize,
              child: AnimatedLogo(logo: _logo),
            ),
            BlocListener<SplashController, SplashState>(
              bloc: controller,
              listener: (context, state) {
                final cnxt = Navigator.of(context);
                if (state == SplashState.unlogged) {
                  cnxt.pushReplacementNamed('/register');
                } else if (state == SplashState.logged) {
                  cnxt.pushReplacementNamed('/home');
                } else if (state == SplashState.manualLog) {
                  cnxt.pushNamedAndRemoveUntil('/login', (route) => false);
                }
              },
              child: const AppProgress(),
            ),
          ],
        ),
      ),
    );
  }
}
