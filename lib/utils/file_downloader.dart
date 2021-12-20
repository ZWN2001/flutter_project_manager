import 'dart:html' as html;

class FileDownloadUtil{
  static int downloadFile(String url){
    try{
      html.AnchorElement anchorElement =  new html.AnchorElement(href: url);
      anchorElement.download = url;
      anchorElement.click();
      return 0;
    }on Error{
      return -1;
    }

  }
}