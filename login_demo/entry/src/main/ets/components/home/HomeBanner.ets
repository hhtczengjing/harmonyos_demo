@Component
export default struct HomeBanner {
  @Prop swiperData: Resource[] =
    [$r('app.media.fig1'), $r('app.media.fig2'), $r('app.media.fig3'), $r('app.media.fig4')]
  private swiperController: SwiperController = new SwiperController()

  build() {
    Swiper(this.swiperController) {
      ForEach(this.swiperData, (item: Resource) => {
        Image(item)
          .objectFit(ImageFit.Cover)
          .width('100%')
          .height('100%')
          .borderRadius(16)
      })
    }
    .autoPlay(true)
    .height(144)
  }
}