import 'package:flutter/material.dart';

class EmptyServiceHistoryState extends StatelessWidget {
  const EmptyServiceHistoryState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 26),
      child: Column(
        children: const [
          _EmptyIllustration(),
          SizedBox(height: 18),
          Text(
            'Нет результата',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Попробуйте использовать другое ключевое слово',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyIllustration extends StatelessWidget {
  const _EmptyIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 112,
      height: 112,
      child: CustomPaint(painter: _EmptyIllustrationPainter()),
    );
  }
}

class _EmptyIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cyan = Paint()
      ..color = const Color(0xFF00D1FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final fill = Paint()
      ..color = const Color(0x1400D1FF)
      ..style = PaintingStyle.fill;

    final body = Path()
      ..moveTo(size.width * 0.28, size.height * 0.22)
      ..lineTo(size.width * 0.68, size.height * 0.34)
      ..lineTo(size.width * 0.78, size.height * 0.75)
      ..lineTo(size.width * 0.22, size.height * 0.65)
      ..close();
    canvas.drawPath(body, fill);
    canvas.drawPath(body, cyan);

    final circleCenter = Offset(size.width * 0.48, size.height * 0.55);
    canvas.drawCircle(circleCenter, size.width * 0.15, cyan);
    canvas.drawLine(
      Offset(circleCenter.dx - 8, circleCenter.dy - 8),
      Offset(circleCenter.dx + 8, circleCenter.dy + 8),
      cyan,
    );
    canvas.drawLine(
      Offset(circleCenter.dx + 8, circleCenter.dy - 8),
      Offset(circleCenter.dx - 8, circleCenter.dy + 8),
      cyan,
    );
    canvas.drawLine(
      Offset(size.width * 0.6, size.height * 0.66),
      Offset(size.width * 0.82, size.height * 0.88),
      cyan,
    );
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.68),
      Offset(size.width * 0.72, size.height * 0.82),
      Paint()
        ..color = const Color(0xFF00D1FF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
