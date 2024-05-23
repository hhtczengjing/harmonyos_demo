import SettingListItemData from '../../models/mine/SettingListItemData'

@Component
struct SettingListItem {

  @Prop data: SettingListItemData

  build() {
    Column() {
      Row() {
        // 图标
        Image(this.data.icon)
          .objectFit(ImageFit.Cover)
          .width(20)
          .height(20)
          .padding({left: 10})

        // 标题
        Text(this.data.title)
          .padding({left: 10})

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
            .padding({right: 10})
        }
      }
      .width('100%')
      .height('100%')


    }
    .width('100%')
    .height(56)
  }
}

export {
  SettingListItemData,
  SettingListItem
}