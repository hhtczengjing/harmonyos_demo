import { IRouterData } from './Commons';

@Component
export struct MySharePage {
  @Consume('pathInfos') pathInfos: NavPathStack;
  title: string = '';
  params?: object = undefined;
  private listArray: IRouterData[] = [
    { title: '投屏', params: { type: 'MyCommonPage', data: '测试参数1' } },
    { title: '打印', params: { type: 'MyCommonPage', data: '测试参数2' } },
    { title: 'VPN', params: { type: 'MyCommonPage', data: '测试参数3' } },
    { title: '私人DNS', params: { type: 'MyCommonPage', data: '测试参数4' } },
    { title: 'NFC', params: { type: 'MyCommonPage', data: '测试参数5' } }
  ];

  build() {
    NavDestination() {
      Column() {
        List({ space: 12 }) {
          ForEach(this.listArray, (item: IRouterData) => {
            ListItem() {
              Column() {
                Row() {
                  Row() {
                    Text(item.title.slice(0, 1))
                      .fontColor(Color.White)
                      .fontSize(14)
                      .fontWeight(FontWeight.Bold)
                  }
                  .width(30)
                  .height(30)
                  .borderRadius(15)
                  .backgroundColor('#a8a8a8')
                  .justifyContent(FlexAlign.Center)
                  .margin({ right: 10 })

                  Text(item.title)
                    .fontSize(16)
                    .margin({ bottom: 5 })

                  Blank()

                  Image($r('sys.media.ohos_ic_public_arrow_right'))
                    .width(24)
                    .height(24)
                    .objectFit(ImageFit.Cover)
                    .margin({ right: 6 })
                }
                .borderRadius(15)
                .shadow({ radius: 100, color: '#ededed' })
                .width('100%')
                .alignItems(VerticalAlign.Center)
                .padding({ left: 15, top: 15, bottom: 15 })
                .backgroundColor(Color.White)
              }
              .margin({left: 12, right: 12})
            }
            .onClick(() => {
              this.pathInfos.pushPathByName(item.title, item.params)
            })
          })
        }
        .width('100%')
        .margin({ top: 15 })
      }
      .height('100%')
      .width('100%')
      .backgroundColor(0xf4f4f5)
    }
    .title(`${this.title}`)
  }
}