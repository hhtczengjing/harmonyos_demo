export default class Task {
  name: string
  update: string
  progress: number

  constructor(name: string, update: string, progress: number) {
    this.name = name
    this.update = update
    this.progress = progress
  }
}