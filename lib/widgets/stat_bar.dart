import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatBar extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const StatBar({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 68,
            child: Text(label,
              style: GoogleFonts.nunito(
                fontSize: 12,
                color: Colors.black38,
                fontWeight: FontWeight.w700,
              )),
          ),
          SizedBox(
            width: 38,
            child: Text(
              value.toString(),
              style: GoogleFonts.nunito(
                fontSize: 14,
                color: const Color(0xFF1A1D2E),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 7,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: value / 200.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                  builder: (_, val, __) => FractionallySizedBox(
                    widthFactor: val.clamp(0.0, 1.0),
                    child: Container(
                      height: 7,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}