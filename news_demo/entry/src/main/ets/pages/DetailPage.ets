import { webview } from '@kit.ArkWeb'
import CommonConstants from '../common/constants/CommonConstants'
import { router } from '@kit.ArkUI'

@Component
@Entry
export default struct DetailPage {
  controller: webview.WebviewController = new webview.WebviewController()
  @State url: string = 'https://m.163.com/news/video/VB2EE7PH4.html'

  aboutToAppear(): void {
    let params = router.getParams() as Record<string, string>
    this.url = params.m_url ?? ""
  }

  build() {
    Column() {
      Web({
        controller: this.controller,
        src: this.url
      })
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
  }
}