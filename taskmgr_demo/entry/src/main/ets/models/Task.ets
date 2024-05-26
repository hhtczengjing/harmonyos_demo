export default class Task {
  id: string
  name: string
  update: string
  progress: number

  constructor(name: string, update: string, progress: number) {
    this.id = new Date().getTime().toString()
    this.name = name
    this.update = update
    this.progress = progress
  }
}