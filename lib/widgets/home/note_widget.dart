import 'package:flutter/material.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    super.key,
    required this.title,
    required this.content,
  });
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final isTaplet = MediaQuery.of(context).size.width > 800;
    final dataFontSize = MediaQuery.of(context).size.width *
        (isTaplet ? 0.03 : 0.07); 
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizeH.s2),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTaplet ? dataFontSize : AppSizeSp.s16,
              color: AppVar.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            child: Text(
              content,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isTaplet ? dataFontSize : AppSizeSp.s16,
                color: AppVar.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
