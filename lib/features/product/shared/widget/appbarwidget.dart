import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? profileImage;
  final String? userName;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;

  const CustomAppBar({
    super.key,
    this.title,
    this.profileImage,
    this.userName,
    this.onNotificationPressed,
    this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF5E17EB),
      elevation: 0,
      leading: Image.asset(
        'assets/icons/logo.png',
        fit: BoxFit.fitHeight,
        
      ),
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
           automaticallyImplyLeading: true,
      actions: [
        TextButton(
          onPressed: () {
            context.goNamed(RouteName.joinUs);
          },
          child: const Text(
            'Join us',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          onPressed: onNotificationPressed,
        ),
        GestureDetector(
          onTap: onProfilePressed,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                //   backgroundImage: (profileImage != null &&
                //           profileImage!.isNotEmpty)
                //       ? NetworkImage(profileImage!)
                //       : const AssetImage("")
                //           as ImageProvider,
                //   backgroundColor: Colors.grey[300],
                // ),
                ),
                const SizedBox(width: 6),
                Text(
                  userName ?? "Guest",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
