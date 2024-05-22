import { GlobalContext } from './GlobalContext'

export class Test1 {
  value: string = ''

  constructor(value: string) {
    this.value = value
  }

  foo(): void {
    GlobalContext.getContext().setObject('value', this.value)
  }
}