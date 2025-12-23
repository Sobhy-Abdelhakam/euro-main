abstract class ImagePath{
  static String getPng({required String imageName}){
    return "assets/images/png/$imageName.png";
  }

  static String getJpeg({required String imageName}){
    return "assets/images/jpeg/$imageName.jpeg";
  }

  static String getGif({required String imageName}){
    return "assets/images/gif/$imageName.gif";
  }

  static String getSvg({required String imageName}){
    return "assets/images/svg/$imageName.svg";
  }
}