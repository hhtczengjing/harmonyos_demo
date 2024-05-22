@Component
export default struct HomeContentView {
  private swiperController: SwiperController = new SwiperController()
  private images: Resource[] = [$r('app.media.fig1'), $r('app.media.fig2'), $r('app.media.fig3'), $r('app.media.fig4')]
  private menus: string[] = ['1', '2', '3', '4', '5', '6', '7', '8']
  private lists: string[] = ['1', '2', '3', '4']

  build() {
    Column() {
      // 标题
      Text('首页')
        .textAlign(TextAlign.Start)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 轮播图
      Swiper(this.swiperController) {
        ForEach(this.images, (item: Resource) => {
          Image(item)
            .objectFit(ImageFit.Cover)
            .width('100%')
            .height('100%')
        })
      }
      .padding(20)
      .height(240)

      // 快捷入口
      Grid() {
        ForEach(this.menus, (item: string) => {
          GridItem() {
            Text('xxxx')
              .backgroundColor(Color.Blue)
              .width('100%')
              .height('100%')
          }
        })
      }
      .columnsTemplate("1fr 1fr 1fr 1fr")
      .rowsTemplate("1fr 1fr")
      .columnsGap(10)
      .rowsGap(10)
      .height(120)

      // 列表
      Text('列表')
      Grid() {
        ForEach(this.lists, (item: string) => {
          GridItem() {
            Text('xxxx')
              .backgroundColor(Color.Blue)
              .width('100%')
              .height('100%')
          }
        })
      }
      .columnsTemplate("1fr 1fr")
      .rowsTemplate("1fr 1fr")
      .columnsGap(10)
      .rowsGap(10)
      .height(180)
    }
    .width('100%')
    .height('100%')
  }

}