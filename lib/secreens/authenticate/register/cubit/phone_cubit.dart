
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'phone_state.dart';

class PhoneCubit extends Cubit<PhoneState> {
  PhoneCubit() : super(PhoneInitial());
  static PhoneCubit get(context)=>BlocProvider.of(context);
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
  bool loading = false;
  bool resend =true;
  Duration? timerTastoPremuto=Duration(seconds: 60);
  void changeLoadingState(state){
    loading=state;
    emit(ChangeLoadingState());
  }
  void changeTimeState(context,endTim){
      endTime=endTim;
      emit(ChangeTimeState());
   }
   void changeStateOfTimeState(context,re){
      resend=re;
      emit(ChangeStateOfTimeState());
   }
}
