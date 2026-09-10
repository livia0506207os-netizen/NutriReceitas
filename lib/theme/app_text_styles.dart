import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static final title = GoogleFonts.jost(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static final section = GoogleFonts.jost(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static final body = GoogleFonts.jost(
    fontSize: 14,
    color: Colors.black,
  );

  static final muted = GoogleFonts.jost(
    fontSize: 13,
    color: AppColors.muted,
  );

  static final primarySmall = GoogleFonts.jost(
    fontSize: 12,
    color: AppColors.primary,
  );
}
