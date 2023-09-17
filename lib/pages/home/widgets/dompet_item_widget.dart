import 'package:flutter/material.dart';
import 'package:flutter_dompet/data/models/dompet.dart';
import 'package:flutter_dompet/pages/dompet/dompet_detail_page.dart';
import 'package:flutter_dompet/utils/price_ext.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/custom_themes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return DompetDetailPage(
              dompet: dompet,
              title: 'Detail Dompet ${dompet.id}',
            );
          }),
        );
        // BlocProvider.of<DompetBloc>(context)
        //     .add(DompetEvent.getDetail(dompet.id!));
      },
      child: Container(
        // height: Dimensions.cardHeightnew,
        height: 80, // Tinggi Card sesuai dengan tinggi gambar
        margin: const EdgeInsets.all(2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Product Image (di sebelah kiri)
            Container(
              width: 80, // Atur lebar gambar sesuai kebutuhan Anda
              decoration: BoxDecoration(
                color: ColorResources.getIconBg(context),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  fit: BoxFit.cover,
                  width: 80, // Atur lebar gambar sesuai kebutuhan Anda
                  image: 'https://picsum.photos/200${dompet.id}',
                  imageErrorBuilder: (c, o, s) => Image.asset(
                    Images.placeholder,
                    fit: BoxFit.cover,
                    width: 80, // Atur lebar gambar sesuai kebutuhan Anda
                  ),
                ),
              ),
            ),

            // Product Details (di sebelah kanan)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: Dimensions.paddingSizeSmall,
                  bottom: 5,
                  left: 5,
                  right: 5,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dompet.name ?? '-',
                        textAlign: TextAlign.center,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      const SizedBox.shrink(),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        '${dompet.saldo}'.formatPrice(),
                        style: titilliumSemiBold.copyWith(
                          color: ColorResources.getPrimary(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
