import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_push_jeleapps/bloc/theme_cubit/theme_cubit.dart';
import 'package:test_push_jeleapps/presentation/style/colors.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final String? deviceToken;
  const CommonAppBar(
      {required this.title, super.key, required this.deviceToken});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;
    print(context.read<ThemeCubit>().state);
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      actions: [
        PopupMenuButton(
          color:
              isDarkMode ? AppColors.lightBodyMedium : AppColors.darkCardBg,
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () => {
                Clipboard.setData(ClipboardData(text: deviceToken!)),
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Device-Token copied to clipboard')))
              },
              child: Text(deviceToken!,
                  style: const TextStyle(
                      fontSize: 8, color: AppColors.globalAccentBlue)),
            )
          ],
        ),
        Switch.adaptive(
          thumbColor: WidgetStateProperty.all(AppColors.globalAccentBlue),
          trackOutlineWidth: const WidgetStatePropertyAll(0),
          activeColor: AppColors.lightBg,
          thumbIcon:
              WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
            if (isDarkMode) {
              return const Icon(
                Icons.light_mode_outlined,
                color: AppColors.darkBg,
              );
            } else {
              return const Icon(
                Icons.dark_mode_outlined,
              );
            }
          }),
          value: isDarkMode,
          onChanged: (value) {
            context.read<ThemeCubit>().toggleTheme(value);
          },
        ),
      ],
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
