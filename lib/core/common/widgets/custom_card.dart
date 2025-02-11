import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon leading;
  final VoidCallback onTap;
  const CustomCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 6,
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(4, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                leading,
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.workSans(
                          color: AppColors.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.workSans(
                          color: AppColors.darkGreyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.play_arrow_rounded, color: AppColors.blackColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
