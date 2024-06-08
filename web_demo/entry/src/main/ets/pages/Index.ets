import LocalWebPage from './LocalWebPage';
import OnlineWebPage from './OnlineWebPage';

@Builder
export function navDestinationBuilder(name: string, params: object) {
  if (name === 'LocalWebPage') {
    LocalWebPage()
  } else {
    OnlineWebPage()
  }
}

@Entry
@Component
struct Index {
  @Provide("navPaths") navPaths: NavPathStack = new NavPathStack();

  build() {
    Column() {
      Navigation(this.navPaths) {
        Button('加载本地网页')
          .margin({top: 20})
          .onClick(() => {
            this.navPaths.pushDestinationByName('LocalWebPage', undefined)
          })

        Button('加载在线网页')
          .margin({top: 20})
          .onClick(() => {
            this.navPaths.pushDestinationByName('OnlineWebPage', undefined)
          })
      }
      .title('ArkWeb 示例')
      .mode(NavigationMode.Auto)
      .navDestination(navDestinationBuilder)
    }
    .height('100%')
    .width('100%')
  }
}