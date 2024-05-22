type I = (value: string) => void

export class A {
  name: string = ''
  version: number = 0

  foo(str: string) {
    let tmpStr: Record<string, Object> = JSON.parse(str)
    if (tmpStr != undefined) {
      this.name = tmpStr.name as string
      this.version = tmpStr.version as number;
    }
  }

  bar(fn: I) {
    fn('abc')
  }

}