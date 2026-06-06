import 'package:flutter/material.dart';

import 'glass_container.dart';

class SearchFilterRow extends StatelessWidget {
  const SearchFilterRow({
    super.key,
    this.onFilterTap,
    this.activeFilterCount = 0,
  });

  final VoidCallback? onFilterTap;
  final int activeFilterCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: GlassContainer(
            height: 56,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Поиск сервисов',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          child: InkWell(
            onTap: onFilterTap,
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              width: 56,
              height: 56,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  GlassContainer(
                    width: 56,
                    height: 56,
                    borderRadius: BorderRadius.circular(100),
                    child: Center(
                      child: Icon(
                        Icons.tune,
                        color: activeFilterCount > 0
                            ? const Color(0xFF040811)
                            : Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  if (activeFilterCount > 0) ...[
                    Positioned.fill(
                      child: IgnorePointer(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: const Color(0xFF00D1FF),
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x9900D1FF),
                                blurRadius: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.tune,
                        color: const Color(0xFF040811),
                        size: 24,
                      ),
                    ),
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 18,
                        height: 18,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF4B45),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$activeFilterCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
