import HomeContentView from '../components/HomeContentView';
import MineContentView from '../components/MineContentView';

@Entry
@Component
struct MainPage {
  @State message: string = 'Hello World';

  build() {
    Tabs({barPosition: BarPosition.End}) {
      TabContent() {
        HomeContentView()
      }
      .tabBar("首页")

      TabContent() {
        MineContentView()
      }
      .tabBar("我的")
    }
    .height('100%')
    .width('100%')
  }
}