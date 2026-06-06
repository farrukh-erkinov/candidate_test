import 'package:flutter/material.dart';

class LicensePlate extends StatelessWidget {
  const LicensePlate({
    super.key,
    this.region = '01',
    this.series = 'A',
    this.number = '777',
    this.suffix = 'AA',
  });

  final String region;
  final String series;
  final String number;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 197,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF040811)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFF040811), width: 2),
            ),
            child: Stack(
              children: [
                const Positioned(
                  left: 39,
                  top: 0,
                  bottom: 0,
                  child: VerticalDivider(
                    color: Color(0xFF040811),
                    thickness: 2,
                    width: 2,
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 11,
                  width: 30,
                  child: _PlateText(region, fontSize: 17),
                ),
                Positioned(
                  left: 47,
                  top: 7,
                  width: 20,
                  child: _PlateText(series, fontSize: 23),
                ),
                for (var index = 0; index < number.length; index++)
                  Positioned(
                    left: 73 + (18.0 * index),
                    top: 7,
                    width: 18,
                    child: _PlateText(
                      number.substring(index, index + 1),
                      fontSize: 23,
                    ),
                  ),
                for (var index = 0; index < suffix.length; index++)
                  Positioned(
                    left: 133 + (18.0 * index),
                    top: 7,
                    width: 18,
                    child: _PlateText(
                      suffix.substring(index, index + 1),
                      fontSize: 23,
                    ),
                  ),
                const Positioned(right: 3, top: 8, child: _UzFlag()),
                const Positioned(
                  right: 3,
                  bottom: 7,
                  width: 18,
                  child: Text(
                    'UZ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0099B5),
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                ),
                const Positioned(left: 3, top: 17, child: _PlateDot()),
                const Positioned(right: 3, top: 17, child: _PlateDot()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlateText extends StatelessWidget {
  const _PlateText(this.text, {required this.fontSize});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 1,
      style: TextStyle(
        color: const Color(0xFF040811),
        fontFamily: 'monospace',
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        height: 1,
      ),
    );
  }
}

class _PlateDot extends StatelessWidget {
  const _PlateDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        color: Color(0xFF040811),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _UzFlag extends StatelessWidget {
  const _UzFlag();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 13,
      height: 8,
      child: Column(
        children: const [
          Expanded(child: ColoredBox(color: Color(0xFF0099B5))),
          SizedBox(height: 0.4, child: ColoredBox(color: Color(0xFFE60026))),
          Expanded(child: ColoredBox(color: Colors.white)),
          SizedBox(height: 0.4, child: ColoredBox(color: Color(0xFFE60026))),
          Expanded(child: ColoredBox(color: Color(0xFF1EB53A))),
        ],
      ),
    );
  }
}
