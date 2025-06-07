import 'package:flutter/material.dart';

class CustomDrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomDrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: 18,
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          height: 1.25,
        ),
      ),
      leading: Icon(
        icon,
        size: 28,
        color:
            isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
      ),
      dense: isSelected,
      visualDensity: VisualDensity.comfortable,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      minTileHeight: 30,
      selected: isSelected,
      onTap: onTap,
    );
  }
}
