import HomeMenuItemData from '../../models/home/HomeMenuItemData'

@Component
struct HomeMenuItem {
  @Prop data: HomeMenuItemData

  build() {
    Column() {
      Image(this.data.icon)
        .width(24)
        .height(24)
      Text(this.data.title)
        .fontSize(12)
        .margin({ top: 4 })
    }
  }
}

@Component
export default struct HomeMenu {
  @Prop menus: HomeMenuItemData[]

  build() {
    Grid() {
      ForEach(this.menus, (item: HomeMenuItemData) => {
        GridItem() {
          HomeMenuItem({ data: item })
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr')
    .columnsGap(8)
    .rowsGap(12)
    .padding({ top: 12, bottom: 12 })
    .height(124)
    .backgroundColor(Color.White)
    .borderRadius(24)
  }
}