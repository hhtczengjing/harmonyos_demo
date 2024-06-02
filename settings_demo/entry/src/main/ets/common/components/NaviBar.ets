import { router } from '@kit.ArkUI'

@Component
export struct NaviBar {
  @Prop
  topHeight: number = 0
  @Prop
  title: string = ''
  @Prop
  hasBorder: boolean = false
  @Prop
  hasLeftIcon: boolean = true
  @Prop
  leftIcon: ResourceStr = $r('app.media.ic_public_back')
  onClickLeft: (() => void) | null = null

  build() {
    Row({ space: 16 }) {

      if (this.hasLeftIcon) {
        Image(this.leftIcon)
          .size({ width: 24, height: 24 })
          .onClick(() => {
            router.back()
          })
      }

      Row() {
        if (this.title) {
          Text(this.title)
            .fontWeight(600)
            .layoutWeight(1)
            .textAlign(TextAlign.Start)
            .fontSize(18)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
      }
      .height(56)
      .layoutWeight(1)
    }

    .padding({ left: 16, right: 16, top: this.topHeight })
    .height(56 + this.topHeight)
    .width('100%')
    .border({
      width: { bottom: this.hasBorder ? 0.5 : 0 },
      color: '#f3f4f5'
    })
  }
}