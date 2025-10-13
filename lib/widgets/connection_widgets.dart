import 'package:flutter/material.dart';

class ConnectionLostWidget extends StatelessWidget {
  final bool isVisible;
  final VoidCallback? onRetry;

  const ConnectionLostWidget({
    super.key,
    required this.isVisible,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              const Icon(
                Icons.wifi_off,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'No internet connection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (onRetry != null)
                TextButton(
                  onPressed: onRetry,
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConnectionStatusOverlay extends StatelessWidget {
  final Widget child;
  final bool showConnectionLost;
  final VoidCallback? onRetry;

  const ConnectionStatusOverlay({
    super.key,
    required this.child,
    required this.showConnectionLost,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        ConnectionLostWidget(
          isVisible: showConnectionLost,
          onRetry: onRetry,
        ),
      ],
    );
  }
}

class ConnectionAwareWidget extends StatefulWidget {
  final Widget child;
  final bool showConnectionBanner;
  final VoidCallback? onRetry;

  const ConnectionAwareWidget({
    super.key,
    required this.child,
    this.showConnectionBanner = true,
    this.onRetry,
  });

  @override
  State<ConnectionAwareWidget> createState() => _ConnectionAwareWidgetState();
}

class _ConnectionAwareWidgetState extends State<ConnectionAwareWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

// Utility method to show connection snackbar
void showConnectionSnackbar(BuildContext context, bool hasConnection) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            hasConnection ? Icons.wifi : Icons.wifi_off,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            hasConnection 
              ? 'Connection restored' 
              : 'Connection lost',
          ),
        ],
      ),
      backgroundColor: hasConnection ? Colors.green : Colors.red,
      duration: Duration(seconds: hasConnection ? 2 : 5),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
