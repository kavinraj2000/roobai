import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roobai/app/route_names.dart';
import 'package:roobai/core/theme/constants.dart';
import 'package:roobai/screens/joinus/bloc/joinus_bloc.dart';


class JoinUsScreen extends StatelessWidget {
  const JoinUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JoinUsBloc(),
      child: const JoinUsView(),
    );
  }
}

class JoinUsView extends StatelessWidget {
  const JoinUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lay_bg,
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Join Us',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.goNamed(RouteName.mainScreen)
        ),
        backgroundColor: primaryColor,
      ),
      body: const SafeArea(
        child: JoinUsBody(),
      ),
    );
  }
}
class JoinUsBody extends StatelessWidget {
  const JoinUsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<JoinUsBloc, JoinUsState>(
      listener: (context, state) {
        if (state is JoinUsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is JoinUsUrlLaunched) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening ${state.platform}...'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Connect With Us...",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            ...SocialPlatforms.all
                .map((platform) => _buildPlatformItem(context, platform))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformItem(BuildContext context, SocialPlatform platform) {
    return BlocBuilder<JoinUsBloc, JoinUsState>(
      builder: (context, state) {
        final isLoading = state is JoinUsLoading;

        return GestureDetector(
          onTap: isLoading
              ? null
              : () {
                  context.read<JoinUsBloc>().add(
                        LaunchUrlEvent(
                          url: platform.url,
                          platform: platform.name,
                        ),
                      );
                },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildPlatformIcon(platform),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    platform.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (isLoading)
                  const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlatformIcon(SocialPlatform platform) {
    const double size = 32;

    if (platform.useAssetIcon) {
      return ClipOval(
        child: Container(
          height: size,
          width: size,
          color: platform.name == 'Twitter Page'
              ? Colors.transparent
              : primaryColor.withOpacity(0.1),
          padding: const EdgeInsets.all(6),
          child: Image.asset(
            platform.iconPath,
            fit: BoxFit.contain,
            color: platform.name == 'Twitter Page' ? null : primaryColor,
          ),
        ),
      );
    } else {
      return CircleAvatar(
        radius: size / 2,
        backgroundColor: primaryColor.withOpacity(0.1),
        child: Icon(platform.iconData, color: primaryColor),
      );
    }
  }
}
