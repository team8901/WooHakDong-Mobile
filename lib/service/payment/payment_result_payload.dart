typedef PaymentResultPayload = Map<String, String>;

extension SuccessResult on PaymentResultPayload {
  bool get isSuccess {
    bool? getBoolean(String? value) {
      switch (value) {
        case "true":
          return true;
        case "false":
          return false;
      }
      return null;
    }

    return getBoolean(this["imp_success"]) ??
        getBoolean(this['success']) ??
        this['error_code'] == null && this['code'] == null;
  }

  String get transactionId {
    return this['imp_uid'] ?? this['txId'] ?? '-';
  }

  String get paymentId {
    return this['merchant_uid'] ?? this['paymentId'] ?? '-';
  }

  String get errorCode {
    return this['error_code'] ?? this['code'] ?? '-';
  }

  String get errorMessage {
    return this['error_msg'] ?? this['message'] ?? '-';
  }
}
