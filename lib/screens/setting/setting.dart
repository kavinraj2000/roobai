import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:roobai/core/theme/constants.dart';
import 'package:roobai/features/product/shared/widget/appbarwidget.dart';
import 'package:roobai/features/product/shared/widget/navbarwidget.dart';
import 'package:roobai/screens/joinus/view/mobile/joinus_mobile_view.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  _StateSetting createState() => _StateSetting();
}

class _StateSetting extends State<Setting> with TickerProviderStateMixin {
  String userId = "";
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    setName();
    _animationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: Appbarwidget(),
      bottomNavigationBar: BottomNavBarWidget(currentRoute: '/settings',),
      body: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   // colors: [primaryColor, primaryColor.withOpacity(0.8), Colors.grey.shade50],
          // ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Modern Header Section
                  _buildModernHeader(),
                  const SizedBox(height: 30),
                  // Settings Items
                  _buildSettingsSection(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernHeader() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white.withOpacity(0.2), Colors.white.withOpacity(0.1)],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: InkWell(
            onTap: () => show_dialog(),
            borderRadius: BorderRadius.circular(24),
            child: Row(
              children: [
                Hero(
                  tag: 'user_avatar',
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white.withOpacity(0.9), Colors.white.withOpacity(0.7)],
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 5)),
                      ],
                    ),
                    child: Center(child: Icon(Icons.person, size: 35, color: primaryColor)),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.isEmpty ? 'Welcome User' : name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                        ),
                        child: Text(
                          userTokenID,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: userTokenID == 'roobai.com' ? 12 : 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.edit_rounded, color: Colors.white.withOpacity(0.8), size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    final settingsItems = [
      SettingsItem(
        icon: Icons.handshake_rounded,
        title: 'Join Us',
        subtitle: 'Become part of our community',
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const JoinUsView())),
        gradient: [Colors.blue.shade400, Colors.blue.shade600],
      ),
      SettingsItem(
        icon: Icons.notifications_rounded,
        title: 'Notification Settings',
        subtitle: 'Manage your preferences',
        onTap: () => AppSettings.openAppSettings(),
        gradient: [Colors.orange.shade400, Colors.orange.shade600],
      ),
      SettingsItem(
        icon: Icons.share_rounded,
        title: 'Share App',
        subtitle: 'Tell your friends about us',
        onTap: _shareApp,
        gradient: [Colors.green.shade400, Colors.green.shade600],
      ),
      SettingsItem(
        icon: Icons.mail_rounded,
        title: 'Write Us',
        subtitle: 'Send us your feedback',
        onTap: launchEmailSubmission,
        gradient: [Colors.purple.shade400, Colors.purple.shade600],
      ),
      SettingsItem(
        icon: Icons.star_rounded,
        title: 'Rate Us',
        subtitle: 'Rate us on app store',
        onTap: () => _launchURL(context, 'https://play.google.com/store/apps/details?id=com.roobai'),
        gradient: [Colors.amber.shade400, Colors.amber.shade600],
      ),
      SettingsItem(
        icon: Icons.info_rounded,
        title: 'About Us',
        subtitle: 'Learn more about Roobai',
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUs()));
        },
        gradient: [Colors.teal.shade400, Colors.teal.shade600],
      ),
      SettingsItem(
        icon: Icons.verified_rounded,
        title: 'Affiliate Disclosure',
        subtitle: 'Transparency information',
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => const affilate()));
        },
        gradient: [Colors.indigo.shade400, Colors.indigo.shade600],
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: settingsItems.asMap().entries.map((entry) {
          int index = entry.key;
          SettingsItem item = entry.value;
          return AnimatedContainer(
            duration: Duration(milliseconds: 200 + (index * 100)),
            curve: Curves.easeOutBack,
            child: _buildModernSettingItem(item, index),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildModernSettingItem(SettingsItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 8), spreadRadius: 0),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: item.onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.white, item.gradient[0].withOpacity(0.05)],
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: item.gradient,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: item.gradient[1].withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Icon(item.icon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                  child: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _shareApp() {
    var shareLink1 =
        'With Roobai application you can get best offers & deals from top online shopping sites. https://apps.apple.com/in/app/roobai-instant-loot-deals/id1329408096';

    var shareLink =
        'With Roobai application you can get best offers & deals from top online shopping sites. https://play.google.com/store/apps/details?id=com.roobai';

    // if (Platform.isAndroid) {
    //   FlutterShare.share(title: 'Roobai App', linkUrl: shareLink.toString(), chooserTitle: "Roobai");
    // } else if (Platform.isIOS) {
    //   FlutterShare.share(title: 'Roobai App', linkUrl: shareLink1.toString(), chooserTitle: "Roobai");
    // }
  }

  void launchEmailSubmission() async {
    final Email email = Email(body: '', subject: 'Roobai feedback ', recipients: ['admin@roobai.com'], isHTML: false);

    await FlutterEmailSender.send(email);
    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }
  }

  void show_dialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: const Offset(0, 15))],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [primaryColor, primaryColor.withOpacity(0.8)]),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.edit_rounded, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            'Update Your Name',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close_rounded, color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey.shade50,
                        border: Border.all(color: Colors.grey.shade200, width: 1),
                      ),
                      child: TextField(
                        controller: nameControler,
                        onChanged: (value) => name = value,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText: 'Enter your name',
                          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(20),
                          prefixIcon: Icon(Icons.person_outline_rounded, color: Colors.grey.shade500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (name.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Please enter your name'),
                                    backgroundColor: Colors.red.shade400,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                );
                              } else {
                                const storage = FlutterSecureStorage();
                                await storage.write(
                                  key: 'name',
                                  value: name,
                                  iOptions: _getIOSOptions(),
                                  aOptions: _getAndroidOptions(),
                                );
                                setState(() {});
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Name updated successfully!'),
                                    backgroundColor: Colors.green.shade400,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                            child: const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String cmt_val = "";
  var cmtControler = TextEditingController();
  var commentsControler = TextEditingController();
  var nameControler = TextEditingController();
  String name = '';
  String comments = '';

  IOSOptions _getIOSOptions() => const IOSOptions(accountName: 'roobai');

  AndroidOptions _getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true);

  String userTokenID = "roobai.com";

  Future<void> setName() async {
    const storage = FlutterSecureStorage();
    await storage.read(key: 'name', iOptions: _getIOSOptions(), aOptions: _getAndroidOptions()).then((value) {
      if (value != null && value.toString().isNotEmpty) {
        name = value.toString();
        nameControler.text = value.toString();
        setState(() {});
      }
    });
  }

  void _launchURL(BuildContext context, String url) async {
    try {
      if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
    }
  }
}

class SettingsItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final List<Color> gradient;

  SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.gradient,
  });
}
