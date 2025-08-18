import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/core/theme/theme.dart';

class Appbarwidget extends StatelessWidget implements PreferredSizeWidget {
  const Appbarwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(

      backgroundColor: Colors.transparent, // Customize as needed
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/icons/logo.png',color: Colors.black,),
      ),
      title: Text(
        'Roobai.com',
        style: GoogleFonts.aBeeZee (
          color: Colors.black,
          
          fontSize: 28,
        ),
      ),
      centerTitle: false,
      actions: [
        
        TextButton(onPressed: (){
          context.goNamed(RouteName.joinUs);
        }, child: Text('Join',style: GoogleFonts.aBeeZee(),)),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
