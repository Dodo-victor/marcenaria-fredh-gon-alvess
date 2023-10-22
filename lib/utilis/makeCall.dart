import 'package:fredh_lda/utilis/show_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

makeCall({required String phoneNumber, required context}) async {
  final uri = Uri(
    scheme: "tel",
    path: phoneNumber,
  );



  if (await launchUrl(uri)) {
    await launchUrl(uri);
  } else {
    showSnackBar(
        context: context, content: "Ocorreu um erro ao fazer á chamada");
  }
}
