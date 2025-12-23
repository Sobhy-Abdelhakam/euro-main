import 'package:auto_size_text/auto_size_text.dart';
import 'package:euro/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServiceItem extends StatelessWidget {
  final ServiceModel data;

  const ServiceItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return getImage(data.img!,constraints.maxWidth/1.4);
            }),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 200,
              child: AutoSizeText(
                data.name!,
                maxLines: 2,
                style: const TextStyle(
                    color: Color(0xff707070),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getImage(String imageName,double width) {
  String type = imageName.split(".").last;
  if (type == "png") {
    return Image.asset(
      'assets/images/png/$imageName',
      width: width,
      height: width,
    );
  } else {
    return SvgPicture.asset(
      'assets/images/svg/$imageName',
      width: width,
      height: width,
    );
  }
}
