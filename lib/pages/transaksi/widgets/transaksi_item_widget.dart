import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/transaksi/transaksi_bloc.dart';
import 'package:flutter_dompet/data/models/transaksi.dart';
import 'package:flutter_dompet/utils/price_ext.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/custom_themes.dart';
import '../../../utils/dimensions.dart';

class TransaksiItemWidget extends StatelessWidget {
  final Transaksi transaksi;
  const TransaksiItemWidget({
    Key? key,
    required this.transaksi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<TransaksiBloc>()
            .add(FetchShowTransaksiEvent(id: transaksi.id.toString()));
      },
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: transaksi.status == 'success' ? Colors.green : Colors.red,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  transaksi.user?.avatar ?? '',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          // Informasi Transaksi
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaksi.date ?? '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titilliumRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: ColorResources.getTextTitle(context),
                  ),
                ),
                Text(
                  '${transaksi.from?.name ?? '-'} TO ${transaksi.to?.name ?? '-'}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titilliumRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: ColorResources.getTextTitle(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          // Tanggal
          Text(
            (transaksi.amount ?? '-').formatPrice(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: titilliumRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: ColorResources.getTextTitle(context),
            ),
          ),
        ],
      ),
    );
  }
}
