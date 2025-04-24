import 'package:flutter/material.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HistoryLoadingWidget extends StatelessWidget {
  const HistoryLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              Icons.history_rounded,
              size: 30,
              color: AppColors.greenColor,
            ),
            title: Text("LeafNameForFurtherChat",
                style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(
              "Chat ID: LeafIdToUniqulyIdentifyLeaf",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.darkGreyColor,
                  ),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
