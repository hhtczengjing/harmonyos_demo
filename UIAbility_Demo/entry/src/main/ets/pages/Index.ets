import { common, Want } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  private context = getContext(this) as common.UIAbilityContext;

  build() {
    Column() {
      Button('打开UIAbility')
        .onClick(() => {
          let want: Want = {
            deviceId: '',
            bundleName: 'com.devzeng.uiability_demo',
            // moduleName: 'share',
            abilityName: 'ShareAbility',
            parameters: {
              "text": "测试数据"
            }
          };
          this.context.startAbility(want);
        })

      Button('打开UIAbility2')
        .onClick(() => {
          let want: Want = {
            deviceId: '',
            bundleName: 'com.devzeng.uiability_demo',
            // moduleName: 'share',
            abilityName: 'ShareAbility',
            parameters: {
              "text": "测试数据"
            }
          };
          this.context.startAbilityForResult(want).then((result) => {

          })
        })
        .margin({top: 20})
    }
    .justifyContent(FlexAlign.Center)
    .height('100%')
    .width('100%')
  }
}