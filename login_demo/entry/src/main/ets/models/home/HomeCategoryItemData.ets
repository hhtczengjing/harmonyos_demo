export default class HomeCategoryItemData {
  bg: Resource
  title: string
  subtitle: string

  constructor(bg: Resource, title: string, subtitle: string) {
    this.bg = bg
    this.title = title
    this.subtitle = subtitle
  }
}