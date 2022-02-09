void main() {
  List<String> numbersList = [
    "6789998212",
    "+91-6789998213",
    "+91-6789998212",
    "+96789998212",
    "916789992120",
    "67899-98214",
    "6789998214",
  ];

  Set numbers = {};
  for (var number in numbersList) {
    String regex =
        r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';

    String regexStr = number.replaceAll(RegExp(regex, unicode: true), '');

    String revNum = regexStr.split('').reversed.join();

    String num = revNum.substring(0, 10);

    String numb = num.split('').reversed.join();

    numbers.add(numb);
  }
  ;
  print(numbers);
}
