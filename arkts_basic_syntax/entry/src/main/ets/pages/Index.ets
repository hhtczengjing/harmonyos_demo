import {Test1} from './file1'
import {Test2} from './file2'
import {Menu} from './file3'
import {A} from './file4'
import {WTest} from './file5'

@Entry
@Component
struct Index {
  @State message: string = 'Hello，World!';
  @State message2: string = 'HarmonyOS Next';

  build() {
    Column() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Red)

      Button('按钮').onClick((event: ClickEvent) => {
        WTest()

        let a: A = new A()
        a.foo("{\"name\":\"test\", \"version\": 1}")
        console.log(`name: ${a.name} version: ${a.version}`)
        a.bar((value: string)=>{
          console.log(`value: ${value}`)
        })

        let menu = new Menu()
        console.log(menu.createController()?.value)

        let t1 = new Test1("Test1")
        t1.foo()
        let t2 = new Test2()
        t2.foo()
      })

      Text(this.message2)
        .fontSize(38)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
    }
    .height('100%')
    .width('100%')
  }
}