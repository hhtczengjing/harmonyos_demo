@Component
export default struct ToDoItem {

  private content?: string
  @State isComplete: boolean = false

  @Builder labelIcon(icon: Resource) {
    Image(icon)
      .objectFit(ImageFit.Contain)
      .width(40)
      .height(40)
      .margin({left: 10})
  }

  build() {
    Row() {
      if (this.isComplete) {
        this.labelIcon($r('app.media.checked'))
      } else {
        this.labelIcon($r('app.media.unchecked'))
      }

      Text(this.content)
        .opacity(this.isComplete ? 0.4 : 1)
        .decoration({
          type: this.isComplete ? TextDecorationType.LineThrough : TextDecorationType.None
        })
    }
    .borderStyle(BorderStyle.Solid)
    .borderRadius(8)
    .backgroundColor(Color.White)
    .onClick(()=>{
      this.isComplete = !this.isComplete
    })
    .width('90%')
    .height(60)
  }
}