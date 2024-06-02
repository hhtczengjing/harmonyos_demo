import { preferences } from '@kit.ArkData';
import GlobalContext from './GlobalContext';

const PREFERENCES_NAME = 'myPreferences';
const PREFERENCES_KEY = 'AppSettingsPreferences';
const TAG = '[PreferencesManager]';

/**
 * 首选项公共类
 */
export class PreferencesManager {
  // 无参构造函数
  private constructor() { }
  // 全局上下文
  private static instance: PreferencesManager;

  public static sharedManager(): PreferencesManager {
    if (!PreferencesManager.instance) {
      PreferencesManager.instance = new PreferencesManager();
    }
    return PreferencesManager.instance;
  }

  // 初始化
  init(context: Context) {
    // 获取首选项
    let appSettingsPreferences: Function = (() => {
      let preference: Promise<preferences.Preferences> = preferences.getPreferences(context, PREFERENCES_NAME);
      return preference;
    });
    // 将首选项存储在全局对象里
    GlobalContext.getContext().setObject(PREFERENCES_KEY, appSettingsPreferences);
  }

  save(key: string, value: string|number) {
    let getPreferences: Function = GlobalContext.getContext().getObject(PREFERENCES_KEY) as Function;
    getPreferences().then(async (preferences: preferences.Preferences) => {
      await preferences.put(key, value);
      preferences.flush();
    }).catch((err: Error) => {
      console.error(TAG, '存储首选项失败，错误: ' + err);
    });
  }

  async getValue<T>(key: string, defaultValue: T) {
    let result: T = defaultValue;
    let getPreferences: Function = GlobalContext.getContext().getObject(PREFERENCES_KEY) as Function;
    result = await (await getPreferences()).get(key, result);
    return result;
  }

  async delete(key: string) {
    let getFontPreferences: Function = GlobalContext.getContext().getObject(PREFERENCES_KEY) as Function;
    const preferences: preferences.Preferences = await getFontPreferences();
    preferences.delete(key).then(() => {
      console.info(TAG, `已成功删除${key}。`);
    }).catch((err: Error) => {
      console.error(TAG, `未能删除${key},原因: ` + err);
    });
  }
}