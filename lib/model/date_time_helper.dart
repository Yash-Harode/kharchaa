//convert the DateTime to a string yyyymmdd
String converDateTimeToString(DateTime dateTime) {
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  //if month is single num like 2 >>> 02
  if (month.length == 1) month = '0' + month;
  //if day is single num like 2 >>> 02
  String day = dateTime.day.toString();
  if (day.length == 1) month = '0' + day;

  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
// DateTime.now()-> 2023/2/11 -> 20230211