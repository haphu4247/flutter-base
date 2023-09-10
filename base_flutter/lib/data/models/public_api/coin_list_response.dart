import 'package:base_flutter/base/models/base_model.dart';
import 'package:base_flutter/base/models/base_response.dart';
import 'package:base_flutter/shared/utils/date_time_utils.dart';
import 'package:base_flutter/shared/utils/utils_int.dart';
import 'package:base_flutter/shared/utils/utils_string.dart';

class CoinListResponse extends BaseResponse<CoinListResponse> {
  const CoinListResponse(dynamic data) : super(isOK: 'true', data: data);

  factory CoinListResponse.fromJson(dynamic json) {
    return CoinListResponse(json);
  }
}

class CoinModel extends BaseModel {
/*
{
  "symbol": "ETHBTC",
  "priceChange": "0.00061000",
  "priceChangePercent": "0.972",
  "weightedAvgPrice": "0.06333457",
  "prevClosePrice": "0.06277000",
  "lastPrice": "0.06338000",
  "lastQty": "0.00320000",
  "bidPrice": "0.06337000",
  "bidQty": "10.03400000",
  "askPrice": "0.06338000",
  "askQty": "136.52870000",
  "openPrice": "0.06277000",
  "highPrice": "0.06385000",
  "lowPrice": "0.06276000",
  "volume": "30534.48990000",
  "quoteVolume": "1933.88882480",
  "openTime": 1692762469842,
  "closeTime": 1692848869842,
  "firstId": 422321469,
  "lastId": 422369305,
  "count": 47837
} 
*/

  final String? symbol;
  final String? priceChange;
  final String? priceChangePercent;
  final String? weightedAvgPrice;
  final String? prevClosePrice;
  final String? lastPrice;
  final String? lastQty;
  final String? bidPrice;
  final String? bidQty;
  final String? askPrice;
  final String? askQty;
  final String? openPrice;
  final String? highPrice;
  final String? lowPrice;
  final String? volume;
  final String? quoteVolume;
  final int? openTime;
  final int? closeTime;
  final int? firstId;
  final int? lastId;
  final int? count;

  const CoinModel({
    this.symbol,
    this.priceChange,
    this.priceChangePercent,
    this.weightedAvgPrice,
    this.prevClosePrice,
    this.lastPrice,
    this.lastQty,
    this.bidPrice,
    this.bidQty,
    this.askPrice,
    this.askQty,
    this.openPrice,
    this.highPrice,
    this.lowPrice,
    this.volume,
    this.quoteVolume,
    this.openTime,
    this.closeTime,
    this.firstId,
    this.lastId,
    this.count,
    dynamic data,
  }) : super(data: data);

  factory CoinModel.fromJson(dynamic json) {
    if (json == null) {
      return const CoinModel();
    }
    final symbol = UtilsString.parse(json['symbol']);
    final priceChange = UtilsString.parse(json['priceChange']);
    final priceChangePercent = UtilsString.parse(json['priceChangePercent']);
    final weightedAvgPrice = UtilsString.parse(json['weightedAvgPrice']);
    final prevClosePrice = UtilsString.parse(json['prevClosePrice']);
    final lastPrice = UtilsString.parse(json['lastPrice']);
    final lastQty = UtilsString.parse(json['lastQty']);
    final bidPrice = UtilsString.parse(json['bidPrice']);
    final bidQty = UtilsString.parse(json['bidQty']);
    final askPrice = UtilsString.parse(json['askPrice']);
    final askQty = UtilsString.parse(json['askQty']);
    final openPrice = UtilsString.parse(json['openPrice']);
    final highPrice = UtilsString.parse(json['highPrice']);
    final lowPrice = UtilsString.parse(json['lowPrice']);
    final volume = UtilsString.parse(json['volume']);
    final quoteVolume = UtilsString.parse(json['quoteVolume']);
    final openTime = UtilsInt.parse(json['openTime']);
    final closeTime = UtilsInt.parse(json['closeTime']);
    final firstId = UtilsInt.parse(json['firstId']);
    final lastId = UtilsInt.parse(json['lastId']);
    final count = UtilsInt.parse(json['count']);
    return CoinModel(
      symbol: symbol,
      priceChange: priceChange,
      priceChangePercent: priceChangePercent,
      weightedAvgPrice: weightedAvgPrice,
      prevClosePrice: prevClosePrice,
      lastPrice: lastPrice,
      lastQty: lastQty,
      bidPrice: bidPrice,
      bidQty: bidQty,
      askPrice: askPrice,
      askQty: askQty,
      openPrice: openPrice,
      highPrice: highPrice,
      lowPrice: lowPrice,
      volume: volume,
      quoteVolume: quoteVolume,
      openTime: openTime,
      closeTime: closeTime,
      firstId: firstId,
      lastId: lastId,
      count: count,
    );
  }
  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['priceChange'] = priceChange;
    data['priceChangePercent'] = priceChangePercent;
    data['weightedAvgPrice'] = weightedAvgPrice;
    data['prevClosePrice'] = prevClosePrice;
    data['lastPrice'] = lastPrice;
    data['lastQty'] = lastQty;
    data['bidPrice'] = bidPrice;
    data['bidQty'] = bidQty;
    data['askPrice'] = askPrice;
    data['askQty'] = askQty;
    data['openPrice'] = openPrice;
    data['highPrice'] = highPrice;
    data['lowPrice'] = lowPrice;
    data['volume'] = volume;
    data['quoteVolume'] = quoteVolume;
    data['openTime'] = DateTimeUtils.formatDateFromMilliSeconds(openTime);
    data['closeTime'] = DateTimeUtils.formatDateFromMilliSeconds(closeTime);
    data['firstId'] = UtilsString.formatNumber(firstId);
    data['lastId'] = UtilsString.formatNumber(lastId);
    data['count'] = UtilsString.formatNumber(count);
    return data;
  }
}
