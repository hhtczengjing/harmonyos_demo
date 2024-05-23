@Builder
export function Header(content?: string | Resource) {
  Row() {
    Text(content)
      .fontSize(24)
      .fontWeight(FontWeight.Bold)
      .textAlign(TextAlign.Start)
      .width('100%')
      .padding({ left: 12 })
  }
  .backgroundColor(Color.White)
  .height(48)
}