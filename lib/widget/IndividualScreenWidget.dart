import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myapp/widget/StockchartWidget.dart';
import 'package:myapp/domain/News.dart';
import 'package:myapp/domain/StockData.dart';
import 'package:myapp/domain/Fullstock.dart';
/*


class IndividualScreenWidget extends StatelessWidget {
  final FullStockData? stock;

  IndividualScreenWidget({this.stock});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        IndividualAppBarWidget(stock: stock),
        Expanded(child: IndividualNewsScreen(stock: stock)),
        Expanded(child: StockChart(stock: stock))
      ],
    );
  }
}


class IndividualAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final StockData? stock;

  IndividualAppBarWidget({this.stock});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 40,
            height: 40,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              stock!.imageUrl,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          ),
          Text(
            stock!.ticker,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
            child: Text(stock!.name),
          ),
        ],
      ),
    );
  }
}
*/
