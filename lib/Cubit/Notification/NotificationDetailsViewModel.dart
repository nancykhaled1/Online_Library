import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Repositories/CounterRepository.dart';
import '../../Repositories/NotificationDetailsRepository.dart';
import '../States/States.dart';

class NotificationDetailsViewModel extends Cubit<States> {
  final NotificationDetailsRepository notificationDetailsRepository;
  final CounterRepository counterRepository;

  NotificationDetailsViewModel( this.notificationDetailsRepository, this.counterRepository)
      : super(InitialState());






  void getNotificationDetails(String notificationId) async {
    emit(LoadingState(loadingMessage: 'جارى التحميل')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await notificationDetailsRepository.getNotification(notificationId);
    either.fold(
          (l) {
        emit(ErrorState(errorMessage: l.error?.message));
      },
          (success) {
        emit(NotificationDetailsSuccessState(notificationDetails: success.data!));
        }

    );
  }


  void getCounter() async {
    emit(LoadingState(loadingMessage: 'جارى التحميل')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await counterRepository.getCounter();
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
          emit(CounterSuccessState(counterData: success.data!));
        }

    );
  }



}
