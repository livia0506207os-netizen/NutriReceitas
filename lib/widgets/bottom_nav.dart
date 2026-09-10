import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NutriBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NutriBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.home_outlined, 'Início'),
      (Icons.search, 'Buscar'),
      (Icons.favorite_border, 'Favoritos'),
      (Icons.person_outline, 'Perfil'),
    ];

    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE3E3E3))),
        ),
        padding: const EdgeInsets.only(top: 7, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final selected = currentIndex == index;
            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      items[index].$1,
                      size: 28,
                      color: selected ? AppColors.primary : Colors.black,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      items[index].$2,
                      style: TextStyle(
                        fontSize: 12,
                        color: selected ? AppColors.primary : Colors.black,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
