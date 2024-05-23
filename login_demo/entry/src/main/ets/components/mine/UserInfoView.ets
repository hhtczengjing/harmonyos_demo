import UserInfoData from '../../models/mine/UserInfoData'

@Component
export default struct UserInfoView {
  @Prop data? : UserInfoData

  build() {
    Row() {
      // 头像
      Image($r('app.media.account'))
        .objectFit(ImageFit.Cover)
        .width(48)
        .height(48)

      // 姓名 + 邮箱
      Column() {
        Text(this.data?.name)
          .fontSize(20)

        Text(this.data?.email)
          .fontSize(12)
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 24 })
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .height(96)
    .backgroundColor(Color.White)
    .padding({ left: 24 })
    .borderRadius(16)
  }
}