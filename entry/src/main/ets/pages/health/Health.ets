import { TsBar } from '../../components/TsBar'

@Entry
@Component
struct Health {
  @State age: number = 65
  @State userHeight: number = 172
  @State weight: number = 55.5
  @State steps: number = 6308
  @State sleepHours: number = 7
  @State sleepMinutes: number = 25
  @State bloodSugar: number = 10.2
  @State bloodPressureHigh: number = 138
  @State bloodPressureLow: number = 79
  @State bloodOxygen: number = 98
  @State heartRate: number = 138
  @State pressure: number = 48

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('健康数据')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })

      // 主要内容区域
      Scroll() {
        Column() {
          // 用户信息卡片
          Row() {
            Image($r('app.media.background'))
              .width(60)
              .height(60)
              .borderRadius(30)

            Column() {
              Text('王强')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)

              Row() {
                Text('血压偏高')
                  .fontSize(12)
                  .backgroundColor('#FFE4E4')
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .borderRadius(4)
                  .margin({ right: 8 })

                Text('血糖偏高')
                  .fontSize(12)
                  .backgroundColor('#FFE4E4')
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .borderRadius(4)
              }
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: 16 })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(12)

          // 基本信息
          Row() {
            Column() {
              Text('年龄')
                .fontSize(14)
                .opacity(0.6)
              Text(this.age.toString())
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
            }
            .layoutWeight(1)

            Column() {
              Text('身高')
                .fontSize(14)
                .opacity(0.6)
              Text(this.userHeight.toString() + 'cm')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
            }
            .layoutWeight(1)

            Column() {
              Text('体重')
                .fontSize(14)
                .opacity(0.6)
              Text(this.weight.toString() + 'kg')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .margin({ top: 12 })
          .borderRadius(12)

          // 已绑定设备
          Column() {
            Text('已绑定3个设备')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)

            Row() {
              ForEach([1, 2, 3], () => {
                Image($r('app.media.shoubioa'))
                  .width(60)
                  .height(60)
                  .margin({ right: 16 })
              })

              Image($r('app.media.jiahao'))
                .width(60)
                .height(60)
            }
            .margin({ top: 16 })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .margin({ top: 12 })
          .borderRadius(12)

          // 健康指标卡片
          Grid() {
            // 体重卡片
            GridItem() {
              Column() {
                Row() {
                  Image($r('app.media.tizhong'))
                    .width(24)
                    .height(24)
                  Text('体重')
                    .fontSize(16)
                    .margin({ left: 8 })
                }
                .width('100%')
                .backgroundColor('#F5F5F5')
                .padding(12)
                .borderRadius(8)
                .shadow({ radius: 4, color: '#0000001A', offsetX: 0, offsetY: 2 })

                Text(this.weight.toString())
                  .fontSize(24)
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 16, bottom: 16 })

                // 体重趋势图
                TsBar({
                  data: [54, 55, 55.5, 55, 55.5],
                  color: '#4CAF50'
                })
                .width('100%')
                .height(60)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(12)
            }

            // 步数卡片
            GridItem() {
              Column() {
                Row() {
                  Image($r('app.media.bushu'))
                    .width(24)
                    .height(24)
                  Text('步数')
                    .fontSize(16)
                    .margin({ left: 8 })
                }
                .width('100%')
                .backgroundColor('#F5F5F5')
                .padding(12)
                .borderRadius(8)
                .shadow({ radius: 4, color: '#0000001A', offsetX: 0, offsetY: 2 })

                Text(this.steps.toString())
                  .fontSize(24)
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 16, bottom: 16 })

                // 步数趋势图
                TsBar({
                  data: [5000, 6000, 6308, 5500, 6000],
                  color: '#FF9800'
                })
                .width('100%')
                .height(60)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(12)
            }

            // 睡眠卡片
            GridItem() {
              Column() {
                Row() {
                  Image($r('app.media.shuimain'))
                    .width(24)
                    .height(24)
                  Text('睡眠')
                    .fontSize(16)
                    .margin({ left: 8 })
                }
                .width('100%')
                .backgroundColor('#F5F5F5')
                .padding(12)
                .borderRadius(8)
                .shadow({ radius: 4, color: '#0000001A', offsetX: 0, offsetY: 2 })

                Row() {
                  Text(this.sleepHours.toString())
                    .fontSize(24)
                    .fontWeight(FontWeight.Medium)
                  Text('小时')
                    .fontSize(12)
                    .opacity(0.6)
                    .margin({ left: 4, right: 8 })
                  Text(this.sleepMinutes.toString())
                    .fontSize(24)
                    .fontWeight(FontWeight.Medium)
                  Text('分钟')
                    .fontSize(12)
                    .opacity(0.6)
                    .margin({ left: 4 })
                }
                .margin({ top: 16, bottom: 16 })

                // 睡眠趋势图
                TsBar({
                  data: [7, 6.5, 7.5, 7, 7.5],
                  color: '#2196F3'
                })
                .width('100%')
                .height(60)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(12)
            }

            // 血糖卡片
            GridItem() {
              Column() {
                Row() {
                  Image($r('app.media.xuetang'))
                    .width(24)
                    .height(24)
                  Text('血糖')
                    .fontSize(16)
                    .margin({ left: 8 })
                }
                .width('100%')
                .backgroundColor('#F5F5F5')
                .padding(12)
                .borderRadius(8)
                .shadow({ radius: 4, color: '#0000001A', offsetX: 0, offsetY: 2 })

                Text(this.bloodSugar.toString() + ' mmol/L')
                  .fontSize(24)
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 16, bottom: 16 })

                // 血糖趋势图
                TsBar({
                  data: [9.8, 10.0, 10.2, 9.9, 10.1],
                  color: '#F44336'
                })
                .width('100%')
                .height(60)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(12)
            }

            // 血压卡片
            GridItem() {
              Column() {
                Row() {
                  Image($r('app.media.xueya'))
                    .width(24)
                    .height(24)
                  Text('血压')
                    .fontSize(16)
                    .margin({ left: 8 })
                }
                .width('100%')
                .backgroundColor('#F5F5F5')
                .padding(12)
                .borderRadius(8)
                .shadow({ radius: 4, color: '#0000001A', offsetX: 0, offsetY: 2 })

                Row() {
                  Text(this.bloodPressureHigh.toString())
                    .fontSize(24)
                    .fontWeight(FontWeight.Medium)
                  Text('/')
                    .fontSize(24)
                    .fontWeight(FontWeight.Medium)
                    .margin({ left: 8, right: 8 })
                  Text(this.bloodPressureLow.toString())
                    .fontSize(24)
                    .fontWeight(FontWeight.Medium)
                }
                .margin({ top: 16, bottom: 16 })

                // 血压趋势图
                TsBar({
                  data: [135, 138, 136, 137, 138],
                  color: '#E91E63'
                })
                .width('100%')
                .height(60)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(12)
            }

            // 血氧饱和度卡片
            GridItem() {
              Column() {
                Row() {
                  Image($r('app.media.baohedu'))
                    .width(24)
                    .height(24)
                  Text('血氧饱和度')
                    .fontSize(16)
                    .margin({ left: 8 })
                }
                .width('100%')
                .backgroundColor('#F5F5F5')
                .padding(12)
                .borderRadius(8)
                .shadow({ radius: 4, color: '#0000001A', offsetX: 0, offsetY: 2 })

                Text(this.bloodOxygen.toString() + '%')
                  .fontSize(24)
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 16, bottom: 16 })

                // 血氧趋势图
                TsBar({
                  data: [97, 98, 98, 97, 98],
                  color: '#9C27B0'
                })
                .width('100%')
                .height(60)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(12)
            }

            // 心率卡片
            GridItem() {
              Column() {
                Row() {
                  Image($r('app.media.xinlv'))
                    .width(24)
                    .height(24)
                  Text('心率')
                    .fontSize(16)
                    .margin({ left: 8 })
                }
                .width('100%')
                .backgroundColor('#F5F5F5')
                .padding(12)
                .borderRadius(8)
                .shadow({ radius: 4, color: '#0000001A', offsetX: 0, offsetY: 2 })

                Text(this.heartRate.toString() + ' bpm')
                  .fontSize(24)
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 16, bottom: 16 })

                // 心率趋势图
                TsBar({
                  data: [135, 138, 136, 137, 138],
                  color: '#FF5722'
                })
                .width('100%')
                .height(60)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(12)
            }

            // 压力卡片
            GridItem() {
              Column() {                Row() {
                  Image($r('app.media.yali'))
                    .width(24)
                    .height(24)
                  Text('压力')
                    .fontSize(16)
                    .margin({ left: 8 })
                }

                Text(this.pressure.toString())
                  .fontSize(24)
                  .fontWeight(FontWeight.Medium)
                  .margin({ top: 16, bottom: 16 })

                // 压力趋势图
                TsBar({
                  data: [45, 48, 47, 46, 48],
                  color: '#795548'
                })
                .width('100%')
                .height(60)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(12)
            }
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .margin({ top: 12 })
        }
        .padding(16)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
