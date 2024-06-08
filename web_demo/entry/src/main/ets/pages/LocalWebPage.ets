import { webview } from '@kit.ArkWeb';
import { promptAction } from '@kit.ArkUI';

export class LocalWebJavaScriptProxy {
  messageFromHtml(value: string) {
    promptAction.showToast({ message: `抽奖结果: ${value}` })
  }
}

@Entry
@Component
export default struct LocalWebPage {
  private controller: WebviewController = new webview.WebviewController();
  private jsBridge: LocalWebJavaScriptProxy = new LocalWebJavaScriptProxy();
  @State progress: number = 0;

  build() {
    NavDestination() {
      Column() {
        Stack() {
          Web({ src: $rawfile('local/index.html'), controller: this.controller })
            .javaScriptProxy({
              object: this.jsBridge,
              name: 'linkObj',
              methodList: ['messageFromHtml'],
              controller: this.controller
            })
            .onProgressChange((event) => {
              this.progress = event?.newProgress ?? 0;
            })

          if (this.progress != 100) {
            Progress({ value: this.progress })
          }
        }
        .height('60%')
        .width('100%')
        .alignContent(Alignment.Top)

        if (this.progress == 100) {
          Button('开始抽奖')
            .margin({ top: 20 })
            .onClick(() => {
              this.controller.runJavaScript('startDraw()');
            })
        }
      }
      .height('100%')
      .width('100%')
    }
    .title('本地网页')
  }
}