import { router } from '@kit.ArkUI'

@Component
export default struct DownloadPage {

  build() {
    Column() {
      Button("下载文件")
        .margin({ bottom: 20 })
        .onClick(() => {
          router.pushUrl({ url: "pages/DownloadPage1" })
        })

      Button("下载图片")
        .onClick(() => {
          router.pushUrl({ url: "pages/DownloadPage2" })
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}