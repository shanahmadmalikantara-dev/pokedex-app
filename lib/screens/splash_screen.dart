import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _pokeballScale;
  late Animation<double> _pokeballRotate;
  late Animation<double> _logoFade;
  late Animation<Offset> _logoSlide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _pokeballScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _pokeballRotate = Tween<double>(begin: -0.3, end: 0.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    _ctrl.forward();

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HomeScreen(),
            transitionDuration: const Duration(milliseconds: 700),
            transitionsBuilder: (_, anim, __, child) => FadeTransition(
              opacity: anim,
              child: child,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Top half — merah
          Container(
            height: size.height * 0.5,
            width: double.infinity,
            color: const Color(0xFFCC0000),
          ),
          // Bottom half — navy dark
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.5,
              width: double.infinity,
              color: const Color(0xFF1A1D2E),
            ),
          ),

          // Pokeball di tengah
          Center(
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, __) => Transform.rotate(
                angle: _pokeballRotate.value,
                child: Transform.scale(
                  scale: _pokeballScale.value,
                  child: SizedBox(
                    width: size.width * 0.72,
                    height: size.width * 0.72,
                    child: CustomPaint(
                      painter: _PokeballPainter(),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Logo di bawah
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, child) => FadeTransition(
                opacity: _logoFade,
                child: SlideTransition(
                  position: _logoSlide,
                  child: child,
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 180,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Text(
                    'Pokémon',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PokeballPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Shadow
    paint
      ..color = Colors.black.withOpacity(0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    canvas.drawCircle(center + const Offset(0, 8), radius, paint);
    paint.maskFilter = null;

    // Top — red
    paint.color = const Color(0xFFCC0000);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159, 3.14159, true, paint,
    );

    // Bottom — white
    paint.color = Colors.white;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0, 3.14159, true, paint,
    );

    // Outer black border
    paint
      ..color = const Color(0xFF111111)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.045;
    canvas.drawCircle(center, radius - paint.strokeWidth / 2, paint);

    // Middle black band
    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.09
      ..color = const Color(0xFF111111);
    canvas.drawLine(
      Offset(0 + paint.strokeWidth / 2, size.height / 2),
      Offset(size.width - paint.strokeWidth / 2, size.height / 2),
      paint,
    );

    // Center white circle
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawCircle(center, size.width * 0.14, paint);

    // Center border
    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.045
      ..color = const Color(0xFF111111);
    canvas.drawCircle(center, size.width * 0.14, paint);

    // Center inner highlight
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawCircle(center, size.width * 0.075, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}