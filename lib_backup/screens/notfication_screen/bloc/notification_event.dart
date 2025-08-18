// part of'notification_bloc.dart';


// abstract class MainScreenEvent extends Equatable {
//   const MainScreenEvent();

//   @override
//   List<Object?> get props => [];
// }

// class InitializeApp extends MainScreenEvent {
//   const InitializeApp();
// }

// class ChangeTab extends MainScreenEvent {
//   final int tabIndex;
  
//   const ChangeTab(this.tabIndex);
  
//   @override
//   List<Object> get props => [tabIndex];
// }

// class RefreshNotifications extends MainScreenEvent {
//   const RefreshNotifications();
// }

// class ClearError extends MainScreenEvent {
//   const ClearError();
// }
// //==-----------------------------------------------------------------//

// abstract class NotificationEvent extends Equatable {
//   const NotificationEvent();

//   @override
//   List<Object?> get props => [];
// }

// class LoadNotifications extends NotificationEvent {
//   const LoadNotifications();
// }

// class HandleForegroundMessage extends NotificationEvent {
//   final RemoteMessage message;
  
//   const HandleForegroundMessage(this.message);
  
//   @override
//   List<Object> get props => [message];
// }

// class HandleNotificationTap extends NotificationEvent {
//   final String? payload;
  
//   const HandleNotificationTap(this.payload);
  
//   @override
//   List<Object?> get props => [payload];
// }

// class MarkNotificationAsRead extends NotificationEvent {
//   final int notificationId;
  
//   const MarkNotificationAsRead(this.notificationId);
  
//   @override
//   List<Object> get props => [notificationId];
// }

// class ClearAllNotifications extends NotificationEvent {
//   const ClearAllNotifications();
// }