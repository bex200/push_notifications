import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_push_jeleapps/api/firebase_api.dart';
import 'package:test_push_jeleapps/bloc/notification_bloc/notification_bloc.dart';
import 'package:test_push_jeleapps/data/model/notification_model.dart';
import 'package:test_push_jeleapps/presentation/style/colors.dart';
import 'package:test_push_jeleapps/presentation/widgets/common_appbar.dart';
import 'package:test_push_jeleapps/presentation/widgets/notification_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  bool isDeviceTokenVisible = false;
  bool isError = false;
  String errorMessage = '';
  List<NotificationModel>? notificationList = [];
  String? deviceToken;
  Future<void> getDeviceToken() async {
    String? token = await FirebaseMessagingApi().getDeviceToken();
    setState(() {
      deviceToken = token;
    });
  }

  @override
  void initState() {
    getDeviceToken();
    context.read<NotificationBloc>().add(GetNotificationListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: CommonAppBar(
            title: 'Notifications',
            deviceToken: deviceToken,
          )),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.globalAccentBlue,
              ),
            );
          } else if (state is NotificationsLoaded &&
              state.notificationList.isNotEmpty) {
            print(state.toString());
            state.notificationList
                .sort((a, b) => b.receivedTime.compareTo(a.receivedTime));
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...state.notificationList
                      .map((notification) => NotificationCard(
                            notificationModel: notification,
                          )),
                ],
              ),
            );
          } else if (state is NotificationLoadingError) {
            return SnackBar(content: Text(state.errorMessage));
          }

          return const Center(
            child: Text('You don\'t have notifications yet:)'),
          );
        },
      ),
    );
  }
}
