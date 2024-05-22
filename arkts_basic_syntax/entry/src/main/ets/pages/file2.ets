import {GlobalContext} from './GlobalContext'

export class Test2 {

  foo(): void {
    let value = GlobalContext.getContext().getObject('value') as string
    console.log(`Test2 -> ${value}`)
  }
}