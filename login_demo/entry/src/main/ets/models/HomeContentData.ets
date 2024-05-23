import HomeCategoryItemData from './home/HomeCategoryItemData'
import HomeMenuItemData from './home/HomeMenuItemData'

export default class HomeContentData {
  banners: Resource[]
  menus: HomeMenuItemData[]
  categories: HomeCategoryItemData[]

  constructor(banners: Resource[], menus: HomeMenuItemData[], categories: HomeCategoryItemData[]) {
    this.banners = banners
    this.menus = menus
    this.categories = categories
  }
}