@Component
export struct MyCommonPage {
  title: string = '';
  params?: object = undefined;
  @Consume('pathInfos') pathInfos: NavPathStack;

  build() {
    NavDestination() {
      Column() {
        Text(`title: ${this.title}`)
          .width('100%')
          .fontSize(20)
          .fontColor(0x333333)
          .textAlign(TextAlign.Center)
          .textShadow({ radius: 2, offsetX: 4, offsetY: 4, color: 0x909399 })
          .padding({ top: 30 })

        Text(`params: ${JSON.stringify(this.params)}`)
          .width('100%')
          .fontSize(18)
          .fontColor(0x666666)
          .textAlign(TextAlign.Center)
          .padding({ top: 45 })

        Button('点此返回')
          .width('50%')
          .height(40)
          .margin({ top: 50 })
          .onClick(() => {
            this.pathInfos.pop();
          })
      }
      .height('100%')
      .width('100%')
      .backgroundColor(0xf4f4f5)
    }
    .title(`${this.title}`)
  }
}