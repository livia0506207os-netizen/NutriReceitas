import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CategoryCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color background;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.label,
    required this.icon,
    required this.background,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(19),
      onTap: onTap,
      child: Container(
        height: 86,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(19),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white.withValues(alpha: 0.45),
              child: Icon(icon, color: Colors.black87, size: 29),
            ),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
