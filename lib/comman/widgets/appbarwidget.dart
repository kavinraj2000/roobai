import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/comman/constants/app_constansts.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final String? profileImage;
  final bool isLoggedIn;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;
  final Function(String)? onSearch;

  const CustomAppBar({
    super.key,
    this.title,
    this.profileImage,
    this.isLoggedIn = false,
    this.onNotificationPressed,
    this.onProfilePressed,
    this.onSearch,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF5E17EB),
      elevation: 2,
      titleSpacing: 0,
       iconTheme: const IconThemeData(
      color: Colors.white, // <-- change drawer icon color here
      size: 28,
    ),
      // Logo on the start
      // leading: Text(widget.title),
      // Static title
      title: Row(
        children: [
           Image.asset(
                      'assets/icons/New Roobai.png',
                      fit: BoxFit.contain,
                      height: 32,
                    ),
                    SizedBox(width: 8,),
                    // Text('Roobai',style: AppConstants.headerwhite,)
        ],
      ),
      actions: [
        // Search icon
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: _toggleSearch,
        ),

        // Optional search field overlay
        if (isSearching)
          Container(
            width: 200,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.white70),
              ),
              onChanged: widget.onSearch,
            ),
          ),

      

      
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: (){
            context.goNamed(RouteName.setting);
          },
        ),

        if (widget.isLoggedIn)
          GestureDetector(
            onTap: widget.onProfilePressed,
            child: Padding(
              padding: const EdgeInsets.only(right: 14),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                backgroundImage: widget.profileImage != null
                    ? NetworkImage(widget.profileImage!)
                    : null,
                child: widget.profileImage == null
                    ? const Icon(Icons.person, color: Color(0xFF5E17EB))
                    : null,
              ),
            ),
          ),

        if (!widget.isLoggedIn)
          TextButton(
            onPressed: () => context.goNamed(RouteName.joinUs),
            child: const Text(
              'Join Us',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
          ),
            Builder(
          builder: (context) {
            if (Scaffold.of(context).hasEndDrawer) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
