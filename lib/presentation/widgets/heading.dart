import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle(
      {super.key, required this.title, this.textButton = "", this.onClick});

  final String title;
  final String textButton;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: onClick,
            child: Text(
              textButton,
              style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue,
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
