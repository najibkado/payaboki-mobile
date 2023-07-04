import 'package:payaboki/models/depositVacct.dart';

class DepositArgs {
  DepositVacct depositVacct;
  var escrowData;
  bool is_escrow;

  DepositArgs({
    required this.depositVacct,
    required this.escrowData,
    required this.is_escrow,
  });
}
