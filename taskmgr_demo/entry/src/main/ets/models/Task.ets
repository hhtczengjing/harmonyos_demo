import { dateFormat } from '../common/utils/DateTime'

export default class Task {
  id: number
  name: string
  progress: number
  create_at: number
  update_at: number

  public get update(): string {
    return dateFormat(this.update_at)
  }

  constructor(id: number, name: string, progress: number, create_at: number, update_at: number) {
    this.id = id
    this.name = name
    this.progress = progress
    this.create_at = create_at
    this.update_at = update_at
  }

  updateData(update: string, progress: number) {
    this.progress = progress
  }

}