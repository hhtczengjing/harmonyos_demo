import { common } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  private context = getContext(this) as common.UIAbilityContext;

  build() {
    Column() {
      Button("返回")
        .onClick(()=>{
          this.context.terminateSelf((err) => {
            console.log("err " + err)
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}