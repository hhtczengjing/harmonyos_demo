import HomeCategoryItemData from '../../models/home/HomeCategoryItemData'

@Component
struct HomeCategoryItem {
  @Prop data: HomeCategoryItemData

  build() {
    Column() {
      Text(this.data.title)
        .width('100%')
        .textAlign(TextAlign.Start)
        .fontColor(Color.White)
        .fontSize(16)

      Text(this.data.subtitle)
        .width('100%')
        .textAlign(TextAlign.Start)
        .fontColor(Color.White)
        .fontSize(12)
    }
    .padding({ top: 8, left: 8 })
    .borderRadius(12)
    .align(Alignment.TopStart)
    .backgroundImage(this.data.bg)
    .backgroundImageSize(ImageSize.Cover)
    .width('100%')
    .height('100%')
  }
}

@Component
export default struct HomeCategory {
  @Prop categories: HomeCategoryItemData[]

  build() {
    Column() {
      Text('列表')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ top: 12 })

      Grid() {
        ForEach(this.categories, (item: HomeCategoryItemData) => {
          GridItem() {
            HomeCategoryItem({data: item})
          }
        })
      }
      .columnsTemplate("1fr 1fr")
      .rowsTemplate("1fr 1fr")
      .columnsGap(10)
      .rowsGap(10)
      .height(240)
      .margin({ top: 10 })
    }
  }
}