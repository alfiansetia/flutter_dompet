import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/dompet/dompet_bloc.dart';
import 'package:flutter_dompet/data/models/dompet.dart';
import 'package:flutter_dompet/pages/dompet/dompet_detail_page.dart';
import 'package:flutter_dompet/utils/price_ext.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/custom_themes.dart';
import '../../../utils/dimensions.dart';

class DompetItemWidget extends StatelessWidget {
  final Dompet dompet;
  const DompetItemWidget({
    Key? key,
    required this.dompet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<DompetDetailPage>(
            builder: (context) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => DompetBloc(),
                  ),
                ],
                child: DompetDetailPage(
                  id: dompet.id!,
                  title: 'Detail Dompet ${dompet.accName}',
                ),
              );
            },
          ),
        );
      },
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              // color: dompet.status == 'success' ? Colors.green : Colors.red,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  'https://picsum.photos/200${dompet.id}',
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
                  dompet.name ?? '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titilliumRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: ColorResources.getTextTitle(context),
                  ),
                ),
                Text(
                  dompet.accName ?? '',
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
            '${(dompet.saldo ?? '0')}'.formatPrice(),
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
