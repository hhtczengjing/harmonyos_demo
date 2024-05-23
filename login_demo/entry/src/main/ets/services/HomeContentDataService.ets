import HomeCategoryItemData from '../models/home/HomeCategoryItemData'
import HomeMenuItemData from '../models/home/HomeMenuItemData'
import HomeContentData from '../models/HomeContentData'

export class HomeContentDataService {

  requestData(): HomeContentData {
    let x = this.getSwiperImages()
    let y = this.getMenuData()
    let z = this.getCategoriesData()
    let data = new HomeContentData(x, y, z)
    return data
  }

  private getSwiperImages(): Array<Resource> {
    let swiperImages: Resource[] = [
      $r('app.media.fig1'),
      $r('app.media.fig2'),
      $r('app.media.fig3'),
      $r('app.media.fig4')
    ];
    return swiperImages;
  }

  private getMenuData(): HomeMenuItemData[] {
    let menus: HomeMenuItemData[] = [
      { title: '我的最爱', icon: $r('app.media.love') },
      { title: '历史记录', icon: $r('app.media.record') },
      { title: '消息', icon: $r('app.media.message') },
      { title: '我的最爱', icon: $r('app.media.shopping') },
      { title: '我的目标', icon: $r('app.media.target') },
      { title: '圈子', icon: $r('app.media.circle') },
      { title: '收藏', icon: $r('app.media.favorite') },
      { title: '回收站', icon: $r('app.media.recycle') }
    ]
    return menus;
  }

  private getCategoriesData(): HomeCategoryItemData[] {
    let lists: HomeCategoryItemData[] = [
      new HomeCategoryItemData($r('app.media.top'), '排行榜', '南京站，我们不见不散'),
      new HomeCategoryItemData($r('app.media.new'), '新品首发', '南京站，我们不见不散'),
      new HomeCategoryItemData($r('app.media.brand'), '大牌闪购', '更多大牌'),
      new HomeCategoryItemData($r('app.media.found'), '发现好物', '南京站，我们不见不散')
    ]
    return lists;
  }
}

export default new HomeContentDataService()