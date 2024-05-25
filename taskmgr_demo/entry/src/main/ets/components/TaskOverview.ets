@Component
@Preview
export default struct TaskOverview {
  @Prop totalCount: number = 10;
  @Prop completedCount: number = 2;
  @Prop updateAt: string = '2024/5/25 20:00:00';

  @Builder
  Header() {
    Row() {
      Image($r('app.media.startIcon'))
        .width(96)
        .height(96)
        .objectFit(ImageFit.Fill)

      Column() {
        Text('2024开发任务')
          .fontSize($r('sys.float.ohos_id_text_size_sub_title1'))
          .fontColor($r('sys.color.ohos_id_color_text_primary'))
          .fontWeight(FontWeight.Bolder)

        Text('高质量完成交付')
          .fontSize($r('sys.float.ohos_id_text_size_sub_title2'))
          .fontColor($r('sys.color.ohos_id_color_text_secondary'))
      }
      .margin({left: 20})
    }
    .padding(10)
    .width('100%')
  }

  @Builder
  TotalProgress() {
    Row() {
      Column() {
        Text('总进度')
          .fontSize($r('sys.float.ohos_id_text_size_sub_title1'))
          .fontWeight(FontWeight.Bold)

        Text(`最近更新: ${this.updateAt}`)
          .fontSize($r('sys.float.ohos_id_text_size_sub_title3'))
          .fontColor($r('sys.color.ohos_id_color_text_secondary'))
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Text(`${this.completedCount}/${this.totalCount}`)

        Progress({
          value: this.completedCount,
          total: this.totalCount,
          type: ProgressType.Ring
        })
          .width(50)
      }
    }
    .padding(10)
    .width('100%')
  }

  build() {
    Column() {
      this.Header()
      this.TotalProgress()
    }
    .borderRadius(10)
  }
}