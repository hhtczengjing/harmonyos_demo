import { NaviBar } from '../common/components/NaviBar';

@Entry
@Component
struct DownloadPage2 {
  @State message: string = 'Hello World';

  build() {
    Column() {
      NaviBar({
        title: '下载图片'
      })

      Column() {
        Text(this.message)
          .id('HelloWorld')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
      }
      .height('100%')
      .width('100%')
    }
    .height('100%')
    .width('100%')
  }
}