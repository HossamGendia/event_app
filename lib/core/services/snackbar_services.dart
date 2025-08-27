// import 'package:bot_toast/bot_toast.dart';
//
// abstract class SnackBarService{
//   static void showSuccessMessage(String msg){
//     BotToast.showCustomNotification(toastBuilder: )
//   }
//
//   static void showWarningMessage(String msg, {bool isLoading = false}){
//     BotToast.showCustomNotification(toastBuilder: )
//   }
//
//   static void showErrorMessage(String msg){
//     BotToast.showCustomNotification(toastBuilder: )
//   }
// }

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

abstract class SnackBarService {
  static void showSuccessMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (cancel) => _buildNotification(
        msg: msg,
        color: Colors.green,
        icon: Icons.check_circle,
        cancel: cancel,
      ),
      duration: Duration(seconds: 3),
    );
  }

  static void showWarningMessage(String msg, {bool isLoading = false}) {
    BotToast.showCustomNotification(
      toastBuilder: (cancel) => _buildNotification(
        msg: msg,
        color: Colors.orange,
        icon: Icons.warning,
        cancel: cancel,
      ),
      duration: Duration(seconds: isLoading ? 0 : 3), // لو isLoading = true يفضل مفتوح
    );
  }

  static void showErrorMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (cancel) => _buildNotification(
        msg: msg,
        color: Colors.red,
        icon: Icons.error,
        cancel: cancel,
      ),
      duration: Duration(seconds: 3),
    );
  }

  /// 🔹 Widget reusable للرسائل
  static Widget _buildNotification({
    required String msg,
    required Color color,
    required IconData icon,
    required VoidCallback cancel,
  }) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) => cancel(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                msg,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: cancel,
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
