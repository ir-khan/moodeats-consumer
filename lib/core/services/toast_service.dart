import 'package:consumer/config/routes/app_router.dart';
import 'package:consumer/core/enums/enums.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';

class ToastService {
  void show({
    required String message,
    ToastType toastType = ToastType.info,
    Duration duration = const Duration(seconds: 5),
  }) {
    DelightToastBar(
      snackbarDuration: duration,
      position: DelightSnackbarPosition.top,
      builder: (context) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        Color backgroundColor;
        Color textColor;
        IconData toastIcon;

        switch (toastType) {
          case ToastType.success:
            backgroundColor = colorScheme.primary;
            textColor = colorScheme.onPrimary;
            toastIcon = Icons.check_circle_outline;
            break;
          case ToastType.error:
            backgroundColor = colorScheme.error;
            textColor = colorScheme.onError;
            toastIcon = Icons.error_outline;
            break;
          case ToastType.info:
            backgroundColor = colorScheme.secondary;
            textColor = colorScheme.onSecondary;
            toastIcon = Icons.info_outline;
            break;
        }

        return ToastCard(
          leading: Icon(toastIcon, color: textColor),
          title: Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          color: backgroundColor,
        );
      },
      autoDismiss: true,
    ).show(AppRouter.rootNavigatorKey.currentContext!);
  }
}
