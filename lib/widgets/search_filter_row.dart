import 'package:flutter/material.dart';

import 'glass_container.dart';

class SearchFilterRow extends StatelessWidget {
  const SearchFilterRow({super.key});

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
        GlassContainer(
          width: 56,
          height: 56,
          borderRadius: BorderRadius.circular(100),
          child: const Center(
            child: Icon(Icons.tune, color: Colors.white, size: 24),
          ),
        ),
      ],
    );
  }
}
