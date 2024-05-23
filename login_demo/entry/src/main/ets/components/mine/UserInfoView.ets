import UserInfoData from '../../models/mine/UserInfoData'

@Component
struct UserInfoView {
  @Prop data? : UserInfoData

  build() {
    Row() {
      // 头像
      if (this.data?.avatar) {
        Image(this.data?.avatar)
          .objectFit(ImageFit.Cover)
          .width(80)
          .height(80)
      } else {
        Image($r('app.media.account'))
          .objectFit(ImageFit.Cover)
          .width(80)
          .height(80)
      }

      // 姓名 + 邮箱
      Column() {
        Text(this.data?.name)
          .width('100%')

        Text(this.data?.email)
          .width('100%')
      }
    }
  }
}

export {
  UserInfoData,
  UserInfoView
}