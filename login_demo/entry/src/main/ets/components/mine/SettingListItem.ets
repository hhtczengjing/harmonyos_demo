import SettingListItemData from '../../models/mine/SettingListItemData'

@Component
export default struct SettingListItem {
  @Prop data: SettingListItemData

  build() {
    Row() {
      // 图标
      Image(this.data.icon)
        .objectFit(ImageFit.Cover)
        .width(22)
        .height(22)

      // 标题
      Text(this.data.title)
        .fontSize(16)
        .padding({ left: 10 })

      Blank()

      // 箭头
      if (this.data.type == 1) {
        Toggle({ type: ToggleType.Switch, isOn: false })
          .selectedColor('#007DFF')
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            console.info('Component status:' + isOn)
          })
      } else {
        Image($r('app.media.right_grey'))
          .objectFit(ImageFit.Cover)
          .width(20)
          .height(20)
          .padding({ right: 10 })
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .height(48)
    .width('100%')
    .padding({
      left: 8,
      right: 22
    })
  }
}