// import 'dart:async';

// import 'package:equatable/equatable.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:roobai_app/features/product/data/model/noti_model.dart';
// import 'package:roobai_app/screens/notfication_screen/repo/notification_repo.dart';

// part 'notfication_state.dart';
// part 'notification_event.dart';

// class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
//   final NotificationUseCase _notificationUseCase;
//   final FirebaseMessagingRepository _firebaseRepo;
//   StreamSubscription? _messageSubscription;
//   StreamSubscription? _notificationTapSubscription;

//   MainScreenBloc(
//     this._notificationUseCase,
//     this._firebaseRepo,
//   ) : super(const MainScreenInitial()) {
//     on<InitializeApp>(_onInitializeApp);
//     on<ChangeTab>(_onChangeTab);
//     on<RefreshNotifications>(_onRefreshNotifications);
//     on<ClearError>(_onClearError);
//   }

//   Future<void> _onInitializeApp(
//     InitializeApp event,
//     Emitter<MainScreenState> emit,
//   ) async {
//     emit(const MainScreenLoading());
    
//     try {
//       // Initialize notifications
//       await _notificationUseCase.initializeNotifications();
      
//       // Setup Firebase messaging
//       await _setupFirebaseMessaging();
      
//       // Setup notification tap handling
//       await _setupNotificationTapHandling();
      
//       // Load existing notifications
//       final notifications = await _notificationUseCase.getStoredNotifications();
      
//       emit(MainScreenLoaded(
//         selectedTabIndex: 0,
//         hasUnreadNotifications: notifications.isNotEmpty,
//         notifications: notifications,
//       ));
//     } catch (e) {
//       emit(MainScreenError(message: 'Failed to initialize app: ${e.toString()}'));
//     }
//   }

//   void _onChangeTab(
//     ChangeTab event,
//     Emitter<MainScreenState> emit,
//   ) {
//     final currentState = state;
//     if (currentState is MainScreenLoaded) {
//       emit(currentState.copyWith(selectedTabIndex: event.tabIndex));
//     } else if (currentState is MainScreenError) {
//       emit(MainScreenError(
//         message: currentState.message,
//         selectedTabIndex: event.tabIndex,
//       ));
//     }
//   }

//   Future<void> _onRefreshNotifications(
//     RefreshNotifications event,
//     Emitter<MainScreenState> emit,
//   ) async {
//     final currentState = state;
//     if (currentState is MainScreenLoaded) {
//       try {
//         final notifications = await _notificationUseCase.getStoredNotifications();
//         emit(currentState.copyWith(
//           notifications: notifications,
//           hasUnreadNotifications: notifications.isNotEmpty,
//         ));
//       } catch (e) {
//         emit(MainScreenError(
//           message: 'Failed to refresh notifications: ${e.toString()}',
//           selectedTabIndex: currentState.selectedTabIndex,
//         ));
//       }
//     }
//   }

//   void _onClearError(
//     ClearError event,
//     Emitter<MainScreenState> emit,
//   ) {
//     final currentState = state;
//     if (currentState is MainScreenError) {
//       emit(MainScreenLoaded(
//         selectedTabIndex: currentState.selectedTabIndex,
//         hasUnreadNotifications: false,
//         notifications: const [],
//       ));
//     }
//   }

//   Future<void> _setupFirebaseMessaging() async {
//     _messageSubscription = _firebaseRepo.onMessage.listen((message) async {
//       await _notificationUseCase.handleForegroundMessage(message);
//       add(const RefreshNotifications());
//     });
//   }

//   Future<void> _setupNotificationTapHandling() async {
//     _notificationTapSubscription = _notificationUseCase
//         .notificationTapStream
//         .listen((payload) async {
//       await _notificationUseCase.handleNotificationTap(payload);
//     });
//   }

//   @override
//   Future<void> close() {
//     _messageSubscription?.cancel();
//     _notificationTapSubscription?.cancel();
//     return super.close();
//   }
// }
// //=================================================================================================//
