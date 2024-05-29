import { preferences, ValueType } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';

export default class PreferencesManager {
  private context: Context
  private name: string

  constructor(context: Context, name: string) {
    this.context = context;
    this.name = name;
  }

  async getObject(key: string) {
    let myPreferences = await preferences.getPreferences(this.context, this.name)
    let value = await myPreferences.get(key, undefined)
    return value;
  }

  async setObject(key: string, value: ValueType) {
    let myPreferences: preferences.Preferences | null = null;
    preferences.getPreferences(this.context, this.name).then((object: preferences.Preferences) => {
      myPreferences = object;
      myPreferences.put(key, value).then(() => {
        myPreferences?.flush();
      });
    })
  }

  async deleteObject(key: string) {
    let myPreferences: preferences.Preferences | null = null;
    preferences.getPreferences(this.context, this.name).then((object: preferences.Preferences) => {
      myPreferences = object;
      myPreferences.delete(key).then(() => {
        myPreferences?.flush();
        console.info(`Succeeded in deleting the key '${key}'.`);
      }).catch((err: BusinessError) => {
        console.error(`Failed to delete the key '${key}'. code = ${err.code}, message = ${err.message}`);
      });
    })
  }

  async hasKey(key: string) {
    let myPreferences: preferences.Preferences | null = null;
    preferences.getPreferences(this.context, this.name).then((object: preferences.Preferences) => {
      myPreferences = object;
      myPreferences.has(key).then(async (isExist: boolean) => {
        console.info(`preferences has ${key} is ${isExist}`);
      }).catch((err: Error) => {
        console.error('Has the value failed with err: ' + err);
      });
    })
  }
}