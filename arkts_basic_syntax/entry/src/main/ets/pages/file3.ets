class Controller {
  value: string = ''

  constructor(value: string) {
    this.value = value
  }
}

type ControllerConstructor = () => Controller

export class Menu {
  controller: ControllerConstructor = () => {
    return new Controller('abc')
  }

  createController() {
    if (this.controller) {
      return this.controller()
    }
    return null
  }
}