import MyPresentPage from './MyPresentPage';
import { NaviBar } from './NaviBar';
import { curves } from '@kit.ArkUI';

@Entry
@Component
struct PresentDemoPage {
  @State title: string = 'Present Demo';
  // 模态转场控制变量
  @State isPresent: boolean = false;

  // 第二步：定义模态展示界面
  // 通过@Builder构建模态展示界面
  @Builder
  MyPresentBuilder() {
  Column() {
    MyPresentPage({
      isPresent: $isPresent
    })
  }
  .margin({top: 32})
  .backgroundColor(0xf5f5f5)
  // 通过转场动画实现出现消失转场动画效果
  .transition(TransitionEffect.translate({ y: 1000 }).animation({ curve: curves.springMotion(0.6, 0.8) }))
}

  build() {
    Column() {
      NaviBar({ title: this.title })

      Column() {
        Button('打开页面')
          .bindContentCover(this.isPresent, this.MyPresentBuilder(), {
            modalTransition: ModalTransition.DEFAULT,
            onDisappear: () => {
              this.isPresent = !this.isPresent;
            }
          })
          .onClick(() => {
            // 第三步：通过模态接口调起模态展示界面，通过转场动画或者共享元素动画去实现对应的动画效果
            // 改变状态变量，显示模态界面
            this.isPresent = !this.isPresent;
          })
      }
    }
    .height('100%')
    .width('100%')
  }
}
