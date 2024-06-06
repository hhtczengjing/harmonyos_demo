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
  leftIcon: ResourceStr = $r('sys.media.ohos_ic_back')
  @Prop
  rightIcon: ResourceStr = $r('sys.media.ohos_ic_public_more')
  @Prop
  showRightIcon: boolean = false
  @BuilderParam
  titleBuilder: () => void
  @BuilderParam
  menuBuilder: () => void = this.defaultMenu
  onClickRight: () => void = () => {
  }
  onClickLeft: (() => void) | null = null

  @Builder
  defaultMenu() {

  }

  build() {
    Row({ space: 16 }) {
      if (this.hasLeftIcon) {
        Image(this.leftIcon)
          .size({ width: 24, height: 24 })
          .onClick(() => {
            if (this.onClickLeft) {
              this.onClickLeft()
            } else {
              router.back()
            }
          })
          .fillColor('#131313')
      }

      Row() {
        if (this.title) {
          Text(this.title)
            .fontWeight(600)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .fontSize(18)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        } else if (this.titleBuilder) {
          this.titleBuilder()
        }
      }
      .height(56)
      .layoutWeight(1)

      if (this.showRightIcon) {
        Image(this.rightIcon)
          .size({ width: 24, height: 24 })
          .objectFit(ImageFit.Contain)
          .onClick(() => {
            this.onClickRight()
          })
          .bindMenu(this.menuBuilder)
      } else {
        Blank()
          .width(24)
      }
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