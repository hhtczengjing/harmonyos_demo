import { webview } from '@kit.ArkWeb'
import CommonConstants from '../common/constants/CommonConstants'
import { router } from '@kit.ArkUI'
import { NaviBar } from '../common/components/NaviBar'

@Component
@Entry
export default struct DetailPage {
  controller: webview.WebviewController = new webview.WebviewController()
  @State url: string = ''
  @State title: string = ''

  aboutToAppear(): void {
    let params = router.getParams() as Record<string, string>
    this.url = params.m_url ?? ""
    this.title = params.title ?? ""
  }

  build() {
    Column() {
      NaviBar({
        title: this.title
      })

      Web({
        controller: this.controller,
        src: this.url
      })
        .onPageBegin((event) => {
          this.controller.runJavaScript("document.querySelector('header').hidden = true;")
        })
        .onPageEnd((event) => {
          this.controller.runJavaScript("document.querySelector('header').hidden = true;")
        })
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
  }
}