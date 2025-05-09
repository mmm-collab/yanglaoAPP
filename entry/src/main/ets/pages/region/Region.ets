import preferences from '@ohos.data.preferences';
import router from '@ohos.router';
interface RegionGroup {
  letter: string;
  regions: string[];
}

@Entry
@Component
struct Region {
  @State currentCity: string = '上海'
  @State hotCities: string[] = ['北京', '上海', '广州', '深圳', '青岛', '苏州', '重庆', '成都', '杭州']
  @State allRegions: RegionGroup[] = [
    { letter: 'A', regions: ['阿巴嘎旗', '阿拉善左旗', '阿拉善右旗', '阿荣旗'] },
    { letter: 'B', regions: ['北京', '保定', '蚌埠', '包头'] },
    { letter: 'C', regions: ['成都', '重庆', '长沙', '长春'] },
    { letter: 'D', regions: ['大连', '东莞', '大同', '丹东'] },
    // 可以继续添加更多字母分组
  ]
  @State letters: string[] = [
    'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
  ]
  @State selectedLetter: string = 'A'
  @State filterLetter: string | null = null // 新增：筛选字母

  // 新增：生成热门城市行的辅助方法
  private getHotCityRows(): string[][] {
    let result: string[][] = []
    let len = this.hotCities.length
    for (let i = 0; i < len; i += 3) {
      result.push(this.hotCities.slice(i, i + 3))
    }
    return result
  }

  async aboutToAppear() {
    // 页面出现时优先读取本地存储的城市名
    let prefs = await preferences.getPreferences(globalThis.getContext(), 'city_prefs');
    let city = await prefs.get('currentCity', '上海');
    if (typeof city !== 'string') {
      city = String(city);
    }
    AppStorage.SetOrCreate('currentCity', city);
    this.currentCity = city;
  }
  build() {
    Column() {
      // 顶部导航
      Row() {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .onClick(() => { router.back() })
        Text('选择地区')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 12 })
      }
      .width('100%')
      .height(48)
      .padding({ left: 16, right: 16, top: 8 })
      .alignItems(VerticalAlign.Center)

      // 当前定位城市（动态显示）
      Row() {
        Image($r('app.media.ding'))
          .width(18)
          .height(18)
        Text('当前定位城市')
          .fontSize(14)
          .fontColor('#888')
          .margin({ left: 6, right: 8 })
        Text(this.currentCity) // 动态显示当前城市
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
        Text('重新定位')
          .fontSize(14)
          .fontColor('#3B6EFF')
          .margin({ left: 12 })
          .onClick(() => { /* 重新定位逻辑 */ })
      }
      .padding({ left: 16, top: 8, bottom: 8 })
      .alignItems(VerticalAlign.Center)

      // 热门地区
      Column() {
        Text('热门地区')
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })
        ForEach(this.getHotCityRows(), (row: string[]) => {
          Row() {
            ForEach(row, (city: string) => {
              Button(city)
                .fontSize(15)
                .backgroundColor('#F5F5F5')
                .fontColor('#222')
                .borderRadius(8)
                .padding({ left: 18, right: 18, top: 8, bottom: 8 })
                .margin({ right: 12, bottom: 12 })
                .onClick(() => {
                  this.currentCity = city // 点击热门城市，切换定位
                })
            })
            ForEach(Array(3 - row.length).fill(0), (_: number) => {
              Blank().width(80).margin({ right: 12, bottom: 12 })
            })
          }
          .justifyContent(FlexAlign.Center)
        })
      }
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })

      // 所有地区和字母索引
      Row() {
        // 地区列表内容区
        Scroll() {
          Column() {
            ForEach(
              this.filterLetter === null
                ? this.allRegions
                : this.allRegions.filter((item: RegionGroup) => item.letter === this.filterLetter),
              (item: RegionGroup) => {
                Column() {
                  Text(item.letter)
                    .fontSize(15)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#888')
                    .margin({ top: 12, bottom: 4, left: 8 })
                  ForEach(item.regions, (region: string) => {
                    Text(region)
                      .fontSize(16)
                      .padding({ left: 16, top: 12, bottom: 12 })
                      .backgroundColor(Color.White)
                      .align(Alignment.Start)
                      .onClick(() => {
                        this.currentCity = region // 点击地区城市，切换定位
                        AppStorage.SetOrCreate('currentCity', region);
                        preferences.getPreferences(globalThis.getContext(), 'city_prefs').then(prefs => {
                          prefs.put('currentCity', region);
                          prefs.flush();
                        });
                      })
                  })
                }
                .id('region-' + item.letter)
              }
            )
          }
        }
        .layoutWeight(1)
        .height('100%')
        .backgroundColor('#FAFAFA')
        .borderRadius(12)
        .margin({ left: 0, right: 0, top: 0, bottom: 0 })

        // 右侧字母索引
        Scroll() {
          Column() {
            ForEach(this.letters, (letter: string) => {
              Text(letter)
                .fontSize(13)
                .fontColor(this.selectedLetter === letter ? '#3B6EFF' : '#888')
                .backgroundColor(this.selectedLetter === letter ? '#E6EEFF' : 'transparent')
                .borderRadius(8)
                .padding({ left: 4, right: 4, top: 2, bottom: 2 })
                .onClick(() => {
                  this.selectedLetter = letter
                  this.filterLetter = (this.filterLetter === letter) ? null : letter
                })
            })
          }
        }
        .width(32)
        .height('100%')
        .margin({ right: 8, top: 0 })
      }
      .width('100%')
      .margin({ top: 8 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF')
  }
}