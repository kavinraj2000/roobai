// part of'notification_bloc.dart';
// abstract class MainScreenState extends Equatable {
//   const MainScreenState();

//   @override
//   List<Object?> get props => [];
// }

// class MainScreenInitial extends MainScreenState {
//   const MainScreenInitial();
// }

// class MainScreenLoading extends MainScreenState {
//   const MainScreenLoading();
// }

// class MainScreenLoaded extends MainScreenState {
//   final int selectedTabIndex;
//   final bool hasUnreadNotifications;
//   final List<NotiModel> notifications;

//   const MainScreenLoaded({
//     required this.selectedTabIndex,
//     required this.hasUnreadNotifications,
//     required this.notifications,
//   });

//   @override
//   List<Object> get props => [selectedTabIndex, hasUnreadNotifications, notifications];

//   MainScreenLoaded copyWith({
//     int? selectedTabIndex,
//     bool? hasUnreadNotifications,
//     List<NotiModel>? notifications,
//   }) {
//     return MainScreenLoaded(
//       selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
//       hasUnreadNotifications: hasUnreadNotifications ?? this.hasUnreadNotifications,
//       notifications: notifications ?? this.notifications,
//     );
//   }
// }

// class MainScreenError extends MainScreenState {
//   final String message;
//   final int selectedTabIndex;

//   const MainScreenError({
//     required this.message,
//     this.selectedTabIndex = 0,
//   });

//   @override
//   List<Object> get props => [message, selectedTabIndex];
// }

// //==--------------------------------------------------------------------==//

// abstract class NotificationState extends Equatable {
//   const NotificationState();

//   @override
//   List<Object?> get props => [];
// }

// class NotificationInitial extends NotificationState {
//   const NotificationInitial();
// }

// class NotificationLoading extends NotificationState {
//   const NotificationLoading();
// }

// class NotificationLoaded extends NotificationState {
//   final List<NotiModel> notifications;
//   final int unreadCount;

//   const NotificationLoaded({
//     required this.notifications,
//     required this.unreadCount,
//   });

//   @override
//   List<Object> get props => [notifications, unreadCount];

//   NotificationLoaded copyWith({
//     List<NotiModel>? notifications,
//     int? unreadCount,
//   }) {
//     return NotificationLoaded(
//       notifications: notifications ?? this.notifications,
//       unreadCount: unreadCount ?? this.unreadCount,
//     );
//   }
// }

// class NotificationError extends NotificationState {
//   final String message;

//   const NotificationError(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class NotificationProcessing extends NotificationState {
//   final List<NotiModel> notifications;
//   final int unreadCount;

//   const NotificationProcessing({
//     required this.notifications,
//     required this.unreadCount,
//   });

//   @override
//   List<Object> get props => [notifications, unreadCount];
// }