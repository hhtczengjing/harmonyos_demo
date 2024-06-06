import { NaviBar } from './NaviBar';

@Entry
@Component
export default struct MyPresentPage {
  @State message: string = 'Hello World';
  @Link isPresent: boolean;

  build() {
    Column() {
      NaviBar({
        title: '测试页面',
        leftIcon: $r('sys.media.ohos_ic_public_close'),
        onClickLeft: () => {
          this.isPresent = !this.isPresent;
        }
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