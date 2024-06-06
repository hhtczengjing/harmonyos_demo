import { IRouterData } from './Commons';
import { router } from '@kit.ArkUI';
import { NaviBar } from './NaviBar';

@Entry
@Component
struct Index {
  private listArray: IRouterData[] = [
    { title: 'Push方式', params: { type: 'router', data: 'pages/PushDemoPage' } },
    { title: 'Present方式', params: { type: 'router', data: 'pages/PresentDemoPage' } }
  ];

  build() {
    Column() {
      NaviBar({ hasLeftIcon: false, title: '转场Demo' })

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
            .margin({ left: 12, right: 12 })
          }
          .onClick(() => {
            router.pushUrl({
              url: item.params?.data
            })
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
}