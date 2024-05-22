import {SettingListItem, SettingListItemData} from './mine/SettingListItem'
import UserInfoView from './mine/UserInfoView'

@Component
export default struct MineContentView {

  private items: SettingListItemData[] = [
    {icon: $r('app.media.news'), title: '推送通知', type: 1},
    {icon: $r('app.media.storage'), title: '数据管理', type: 0},
    {icon: $r('app.media.menu'), title: '菜单设置', type: 0},
    {icon: $r('app.media.recycle'), title: '清除缓存', type: 0},
    {icon: $r('app.media.privacy'), title: '隐私协议', type: 0},
    {icon: $r('app.media.about'), title: '关于我们', type: 0}
  ]

  build() {
    Column() {
      // 标题
      Text('我的')
        .textAlign(TextAlign.Start)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 登录用户
      UserInfoView()
        .margin({top: 24, left: 20, right: 20})
        .padding({top: 10, bottom: 10})
        .backgroundColor(Color.Red)
        .borderRadius(8)

      // 列表
      List() {
        ForEach(this.items, (item: SettingListItemData) => {
          ListItem() {
            SettingListItem({data: item})
          }
        })
      }
      .margin({top: 24})

      Blank()

      // 退出登录
      Button('退出')
        .fontColor(Color.Red)
        .backgroundColor(Color.Gray)
        .width('90%')
        .margin({bottom: 40})
    }
    .width('100%')
    .height('100%')
  }

}