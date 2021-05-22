import 'package:zhaoxiaowu_app/global/global.dart';

Future getAccountingHistory(String date) async {
  return await Global.getInstance().dio.get(
    "/zxw/AccountingHistory",
    queryParameters: {
      "date": date,
    },
  );
}
