import HomeContentView from '../components/HomeContentView';
import MineContentView from '../components/MineContentView';

@Entry
@Component
struct MainPage {
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()

  @Builder
  tabBarBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.controller.changeIndex(this.currentIndex);
    })
  }

  build() {
    Tabs({barPosition: BarPosition.End, controller: this.controller}) {
      TabContent() {
        HomeContentView()
      }
      .tabBar(this.tabBarBuilder('首页', 0, $r('app.media.ic_home_selected'), $r('app.media.ic_home')))

      TabContent() {
        MineContentView()
      }
      .tabBar(this.tabBarBuilder('我的', 1, $r('app.media.ic_mine_selected'), $r('app.media.ic_mine')))
    }
    .scrollable(false)
    .barWidth('100%')
    .barHeight(48)
    .backgroundColor('#FFFFFF')
    .onChange((index: number) => {
      this.currentIndex = index;
    })
    .height('100%')
    .width('100%')
  }
}
