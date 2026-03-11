import 'package:euro/utils/paths/image_path.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ImageUtils {

  static Widget buildImage(String imageName,{double size = 40}) {

    if(imageName.endsWith(".png")){
      final name = imageName.replaceAll(".png", "");

      return Image.asset(
        ImagePath.getPng(imageName: name),
        width: size,
        height: size,
      );
    }

    if(imageName.endsWith(".svg")){
      final name = imageName.replaceAll(".svg", "");

      return SvgPicture.asset(
        ImagePath.getSvg(imageName: name),
        width: size,
        height: size,
      );
    }

    return const SizedBox();
  }

}