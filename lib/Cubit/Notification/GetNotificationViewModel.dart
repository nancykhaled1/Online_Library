import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/Responses/GetNotificationResponse.dart';
import '../../Repositories/GetNotificationRepository.dart';
import '../States/States.dart';

class NotificationScreenViewModel extends Cubit<States> {
 final GetNotificationRepository getNotificationRepository;
  NotificationScreenViewModel( this.getNotificationRepository)
      : super(InitialState());

 List<Notifications> notifications = [];



 void getNotification() async {
    emit(LoadingState(loadingMessage: 'Loading...'));
    var either = await getNotificationRepository.getNotification();
    either.fold(
          (l) {
        emit(ErrorState(errorMessage: l.error?.message));
      },

                (response) {
                  notifications = response.data?.notifications ?? [];
                  emit(GetNotificationSuccessState(notifications: notifications));
                },

    );
  }


}
