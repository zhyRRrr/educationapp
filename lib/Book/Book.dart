import 'package:education_app/Book/OneClass/pdf.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Book());
}

class Book extends StatelessWidget {
  final List<String> imageUrlsone = [
    'https://ci.xiaohongshu.com/1040g00831139533c6ci05pg9b53hhspk6ktp9s0?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g2sg30v963mdgli505n7fsl9lo207ii24it8?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g008311qgeeki0o005paes1s0ifa8bn80p2o?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/spectrum/1040g34o311vode00j2005p46f5g7otdsafroqko?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g2sg3148vfc976kdg4a476shnqgkgn2l803g?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/spectrum/1040g0k030o1mltr6i0005p0od1bkcet4t27jj9g?imageView2/2/w/0/format/webp',
  ];

  final List<String> imageUrlstwo = [
    'https://ci.xiaohongshu.com/1040g00830vkp6ng0m2505ocu71lk1hf6dkd6sk0?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g2sg30trorikd4o0049e5meia9j754ev3j48?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/spectrum/1040g0k030oj6ttlaic005p0od1bkcet4q948pp8?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/spectrum/1040g0k030on7ggmdj6005p0od1bkcet45aj4a60?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/01029201kvt4f7c4pm9011bsk53cg3scs2?imageView2/2/w/0/format/webp',
    'https://www.szxuexiao.com/uploadimages/keben2021/qd1rj2njyyx2013/1.jpg',
  ];

  final List<String> imageUrlsthree = [
    'https://ci.xiaohongshu.com/1040g00830vtpn58c646g5ocu71lk1hf64vhqn6g?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/1040g00830vv67svclo6g5ocu71lk1hf62e0kmj0?imageView2/2/w/0/format/webp',
    'https://ci.xiaohongshu.com/spectrum/1040g0k0311vo9nk432005p46f5g7otdstc2pc8o?imageView2/2/w/0/format/webp',
    'https://qbm-images.oss-cn-hangzhou.aliyuncs.com/MDM/Product/TextbookAttachmentController/2951/451a61b7-af23-45b4-9a8e-116a14b8d1da.png',
    'https://th.bing.com/th/id/R.7e284531f9e703811fcdfe4f8ecd015b?rik=p4BTFRtnMmhW%2bg&riu=http%3a%2f%2fwww.kjzhan.com%2fuploads%2fallimg%2f150705%2f1-150F50T041.jpg&ehk=oPKVzoE2T0doZ4Ph0kNBwck8Cyf27JJRMz%2baqWD2xgE%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.38d6e1ec7069a09bcc03eb221702fb87?rik=jHktghYJ3wqkog&riu=http%3a%2f%2fwww.kjzhan.com%2fuploads%2fallimg%2f150705%2f1-150F50T410.jpg&ehk=Wo04K0FTEXXjGlIUzzilk53cG3dkduKL%2bz7PaMsHmxc%3d&risl=&pid=ImgRaw&r=0',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Section(
              title: '一年级教材书',
              images: imageUrlsone,
              pages: [
                NetworkPDFPage(url: onechineseuppdfUrl), // 语文
                NetworkPDFPage(url: onechinesedownpdfUrl), // 语文下册
                NetworkPDFPage(url: onemathuppdfUrl), // 数学
                NetworkPDFPage(url: onemathdownpdfUrl), // 数学下册
                NetworkPDFPage(url: oneenglishuppdfUrl), // 英语上册
                NetworkPDFPage(url: oneenglishdownpdfUrl), // 英语下册
              ],
            ),
            Section(
              title: '二年级教材书',
              images: imageUrlstwo,
              pages: [
                NetworkPDFPage(url: twochinesedownpdfUrl), // 语文下册
                NetworkPDFPage(url: twochinesedownpdfUrl), // 语文下册
                NetworkPDFPage(url: twomathdownpdfUrl), // 数学下册
                NetworkPDFPage(url: twomathdownpdfUrl), // 数学下册
                NetworkPDFPage(url: twoenglishuppdfUrl), // 英语上册
                NetworkPDFPage(url: twoenglishdownpdfUrl), // 英语下册
              ],
            ),
            Section(
              title: '三年级教材书',
              images: imageUrlsthree,
              pages: [
                NetworkPDFPage(url: threechinesedownpdfUrl), // 语文下册
                NetworkPDFPage(url: threechinesedownpdfUrl), // 语文下册
                NetworkPDFPage(url: threemathdownpdfUrl), // 数学下册
                NetworkPDFPage(url: threemathdownpdfUrl), // 数学下册
                NetworkPDFPage(url: threeenglishuppdfUrl), // 英语上册
                NetworkPDFPage(url: threeenglishdownpdfUrl), // 英语下册
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final List<String> images;
  final List<Widget> pages;

  Section({required this.title, required this.images, required this.pages});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200, // 图片高度
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // 跳转到对应页面
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => pages[index],
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // 改变阴影的位置
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                      width: 150, // 图片宽度
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

final String oneenglishuppdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/c4857bdb-4166-4552-b65e-41b545d8f7b8.pkg/pdf.pdf"; // 替换为你的PDF URL

final String oneenglishdownpdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/2be25dca-f388-4252-b9ad-f044a00d8e9e.pkg/pdf.pdf"; // 替换为你的PDF URL

final String onechineseuppdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/1c73b348-e8b6-47d6-84b0-6dbacbe28268.pkg/pdf.pdf";

final String onechinesedownpdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/b87e153f-a64c-451a-aa6c-6ed9ac7d6821.pkg/pdf.pdf"; // 替换为你的PDF URL

final String onemathuppdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/c3e06fe4-c6b3-49cb-8727-4f8ff69bbfbc.pkg/pdf.pdf";

final String onemathdownpdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets_document/6bf8ae7e-d987-40b4-8fb3-bbb98fcb50b5.pkg/pdf.pdf"; // 替换为你的PDF URL

final String twochineseuppdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/2ce8f153-7bff-4c97-b6db-9aac414fea19.pkg/pdf.pdf"; // 替换为你的PDF URL

final String twochinesedownpdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/0f93b83e-b3c2-4a5d-8acd-ea460ab962d4.pkg/pdf.pdf"; // 替换为你的PDF URL

final String twomathuppdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/8cfc5a2a-425c-4b9a-a97c-e78d4a4c1e3a.pkg/pdf.pdf";

final String twomathdownpdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets_document/c1897b18-b302-4e8d-9fd4-40915c4b05c2.pkg/pdf.pdf"; // 替换为你的PDF URL

final String twoenglishuppdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/0913d789-323f-4c44-9a25-7bb44c6b1f61.pkg/pdf.pdf"; // 替换为你的PDF URL

final String twoenglishdownpdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/5d2d0020-786f-4edc-9662-9037465c59bf.pkg/pdf.pdf"; // 替换为你的PDF URL

final String threechineseuppdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/837f368e-fd4e-404a-ae3f-342d75bc0227.pkg/pdf.pdf";

final String threechinesedownpdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/8e107655-5128-451f-84e5-d158725c537b.pkg/pdf.pdf"; // 替换为你的PDF URL

final String threemathuppdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/33c8d495-9862-4e19-aab9-61d2af08608a.pkg/pdf.pdf"; // 替换为你的PDF URL

final String threemathdownpdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets_document/8666a8bd-a0e7-49aa-ba07-bf419ceead24.pkg/pdf.pdf"; // 替换为你的PDF URL

final String threeenglishuppdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/02fea7d7-163d-4351-97f0-1ca455bbc4ef.pkg/pdf.pdf"; // 替换为你的PDF URL

final String threeenglishdownpdfUrl =
    "https://r1-ndr.ykt.cbern.com.cn/edu_product/esp/assets/8a029005-c465-4909-9aaa-9bf7948f479e.pkg/pdf.pdf";
