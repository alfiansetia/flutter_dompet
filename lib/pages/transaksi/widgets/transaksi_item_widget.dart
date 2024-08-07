import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/transaksi/transaksi_bloc.dart';
import 'package:flutter_dompet/data/models/transaksi.dart';
import 'package:flutter_dompet/pages/transaksi/transaksi_detail_page.dart';
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
        Navigator.of(context).push(
          MaterialPageRoute<TransaksiDetailPage>(
            builder: (context) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => TransaksiBloc(),
                  ),
                ],
                child: TransaksiDetailPage(
                  id: transaksi.id!,
                  title: '${transaksi.number}',
                ),
              );
            },
          ),
        );
      },
      child: Row(
        children: [
          // Container(
          //   width: 60,
          //   height: 60,
          //   decoration: BoxDecoration(
          //     color: transaksi.status == 'success' ? Colors.green : Colors.red,
          //     shape: BoxShape.circle,
          //     image: DecorationImage(
          //       image: NetworkImage(
          //         transaksi.user?.avatar ?? '',
          //       ),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          const SizedBox(width: Dimensions.paddingSizeExtraLarge),
          // Informasi Transaksi
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  '${transaksi.from?.name ?? '-'} TO ${transaksi.to?.name ?? '-'} ${transaksi.number}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titilliumRegular.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: ColorResources.getTextTitle(context),
                  ),
                ),
                Text(
                  transaksi.date ?? '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titilliumRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: ColorResources.getTextTitle(context),
                  ),
                ),
                Text(transaksi.desc ?? ''),
                SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeExtraLarge),
          // Tanggal
          Text(
            '${(transaksi.amount ?? '-')}'.formatPrice(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: titilliumRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: ColorResources.getTextTitle(context),
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}
