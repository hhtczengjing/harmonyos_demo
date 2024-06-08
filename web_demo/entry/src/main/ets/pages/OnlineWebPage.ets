import { webview } from '@kit.ArkWeb';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
export default struct OnlineWebPage {
  private controller: WebviewController = new webview.WebviewController();
  @State progress: number = 0;

  build() {
    NavDestination() {
      Column() {
        Stack() {
          Web({ src: 'https://m.baidu.com', controller: this.controller })
            .onProgressChange((event) => {
              this.progress = event?.newProgress ?? 0;
            })

          if (this.progress != 100) {
            Progress({ value: this.progress })
          }
        }
        .width('100%')
        .height('90%')
        .alignContent(Alignment.Top)

        Row() {
          Button('后退')
            .margin({ top: 20 })
            .onClick(() => {
              if (this.controller.accessBackward()) {
                this.controller.backward()
              } else {
                promptAction.showToast({ message: '不可点击' })
              }
            })

          Button('前进')
            .margin({ top: 20 })
            .onClick(() => {
              if (this.controller.accessForward()) {
                this.controller.forward()
              } else {
                promptAction.showToast({ message: '不可点击' })
              }
            })
        }
        .width('100%')
        .height('10%')
        .justifyContent(FlexAlign.SpaceAround)
      }
      .height('100%')
      .width('100%')
    }
    .title('在线网页')
  }
}