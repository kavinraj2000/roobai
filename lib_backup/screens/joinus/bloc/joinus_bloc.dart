// 1. Events (join_us_event.dart)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class JoinUsEvent {}

class LaunchUrlEvent extends JoinUsEvent {
  final String url;
  final String platform;
  
  LaunchUrlEvent({required this.url, required this.platform});
}

// 2. States (join_us_state.dart)
abstract class JoinUsState {}

class JoinUsInitial extends JoinUsState {}

class JoinUsLoading extends JoinUsState {}

class JoinUsUrlLaunched extends JoinUsState {
  final String platform;
  
  JoinUsUrlLaunched({required this.platform});
}

class JoinUsError extends JoinUsState {
  final String message;
  final String platform;
  
  JoinUsError({required this.message, required this.platform});
}



class JoinUsBloc extends Bloc<JoinUsEvent, JoinUsState> {
  JoinUsBloc() : super(JoinUsInitial()) {
    on<LaunchUrlEvent>(_onLaunchUrl);
  }

  Future<void> _onLaunchUrl(LaunchUrlEvent event, Emitter<JoinUsState> emit) async {
    try {
      emit(JoinUsLoading());
      
      final uri = Uri.parse(event.url);
      final canLaunch = await canLaunchUrl(uri);
      
      if (canLaunch) {
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        
        if (launched) {
          emit(JoinUsUrlLaunched(platform: event.platform));
        } else {
          emit(JoinUsError(
            message: 'Could not launch ${event.platform}',
            platform: event.platform,
          ));
        }
      } else {
        emit(JoinUsError(
          message: '${event.platform} app is not installed',
          platform: event.platform,
        ));
      }
    } catch (e) {
      emit(JoinUsError(
        message: 'Failed to launch ${event.platform}: ${e.toString()}',
        platform: event.platform,
      ));
    }
  }
}

// 4. Models (social_platform.dart)
class SocialPlatform {
  final String name;
  final String url;
  final String iconPath;
  final IconData? iconData;
  final bool useAssetIcon;

  const SocialPlatform({
    required this.name,
    required this.url,
    this.iconPath = '',
    this.iconData,
    this.useAssetIcon = false,
  });
}

class SocialPlatforms {
  static const whatsapp = SocialPlatform(
    name: 'WhatsApp Group',
    url: 'https://roobai.com/s/whatsapp',
    iconPath: 'assets/icons/whatsapp-2.png',
    useAssetIcon: true,
  );

  static const telegram = SocialPlatform(
    name: 'Telegram',
    url: 'https://t.me/roobaiofficial',
    iconData: Icons.telegram_sharp,
  );

  static const facebookGroup = SocialPlatform(
    name: 'Facebook Group',
    url: 'https://roobai.com/s/facebook',
    iconData: Icons.facebook_sharp,
  );

  static const twitter = SocialPlatform(
    name: 'Twitter Page',
    url: 'https://roobai.com/s/twitter1',
    iconPath: 'assets/icons/x.png',
    useAssetIcon: true,
  );

  static const facebookPage = SocialPlatform(
    name: 'FB Official Page',
    url: 'https://roobai.com/s/atfbpage',
    iconData: Icons.facebook_outlined,
  );

  static List<SocialPlatform> get all => [
    whatsapp,
    telegram,
    facebookGroup,
    twitter,
    facebookPage,
  ];
}


