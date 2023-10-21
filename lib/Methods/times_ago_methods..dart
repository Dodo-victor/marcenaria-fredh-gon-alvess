
import 'package:timeago/timeago.dart'as timeago;

class TimesAgo {

static setDate(date){

   timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());
  final timeAgoString = timeago.format(date, locale: 'pt_BR'); 
  return timeAgoString;
}

}