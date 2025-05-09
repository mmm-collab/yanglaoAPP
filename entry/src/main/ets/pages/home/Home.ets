<<<<<<< HEAD
import http from '@ohos.net.http';
import router from '@ohos.router'
import preferences from '@ohos.data.preferences';

interface Alll {
  title:string
  icon:string
}

interface NewsData {
  title: string
  content: string
  imageUrls: string[]
  likeCount: number
  starCount: number
  commentCount: number
}

interface ResponseData {
  code: number
  msg: string
  data: NewsData[]
}

interface FunctionNavItem extends Alll {
  url: string
}

@Component
export default struct Home {
  @State isLoading: boolean = true
  @State newsData: NewsData[] = []
  @StorageLink('currentCity') currentCity: string = '上海'

  aboutToAppear() {
    preferences.getPreferences(globalThis.getContext(), 'city_prefs').then(prefs => {
      prefs.get('currentCity', '上海').then(city => {
        const cityStr = String(city);
        AppStorage.SetOrCreate('currentCity', cityStr);
        this.currentCity = cityStr;
      });
    });
    this.fetchNewsData();
  }

  fetchNewsData() {
    this.isLoading = true
    let httpRequest = http.createHttp()
    httpRequest.request(
      "https://mock.presstime.cn/mock/6819c85b5ca065b2e0d4510b/api/shouye",
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        }
      }
    ).then((resp: http.HttpResponse) => {
      if (resp.responseCode === 200) {
        const responseData = JSON.parse(resp.result.toString()) as ResponseData
        console.info('接口返回数据:', JSON.stringify(responseData))
        if (responseData.code === 400 && Array.isArray(responseData.data)) {
          console.error('数据格式错误:', responseData)
        } else {
          this.newsData = responseData.data
          console.info('设置后的数据:', JSON.stringify(this.newsData))
          console.info('数据长度:', this.newsData.length)
        }
        this.isLoading = false
      }
    }).catch((err: Error) => {
      console.error('获取数据失败:', err.message)
      this.isLoading = false
    }).finally(() => {
      httpRequest.destroy()
    })
  }

  build() {
    Column() {
      if (this.isLoading) {
        LoadingProgress()
          .width(50)
          .height(50)
          .margin({ top: 100 })
      }
      List({ space: 12 }) {
        ListItem() {
          // 顶部区域
          Row() {
            Row() {
              Image($r('app.media.ding'))
                .width(20)
                .height(20)
              Text(this.currentCity)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .margin({ left: 4 })
              Image($r('app.media.xia'))
                .width(16)
                .height(16)
                .margin({ left: 2 })
                .onClick(() => {
                  router.pushUrl({ url: 'pages/region/Region' })
                })
            }

            Image($r('app.media.er'))
              .width(24)
              .height(24)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({ left: 16, right: 16, top: 12 })
        }

        ListItem() {
          // 搜索框
          Row() {
            Image($r('app.media.sou'))
              .width(20)
              .height(20)
            Text('搜索')
              .fontSize(14)
              .fontColor('#999999')
              .margin({ left: 8 })
          }
          .width('92%')
          .height(40)
          .backgroundColor('#F5F5F5')
          .borderRadius(20)
          .padding({ left: 16 })
          .margin({ top: 12 })
        }

        ListItem() {
          // 快捷标签
          Row() {
            Text('高血压')
              .fontSize(14)
              .padding({
                left: 12,
                right: 12,
                top: 6,
                bottom: 6
              })
              .backgroundColor('#F0F0F0')
              .borderRadius(16)
            Text('冠心病')
              .fontSize(14)
              .padding({
                left: 12,
                right: 12,
                top: 6,
                bottom: 6
              })
              .backgroundColor('#F0F0F0')
              .borderRadius(16)
              .margin({ left: 8 })
            Text('如何控制血糖')
              .fontSize(14)
              .padding({
                left: 12,
                right: 12,
                top: 6,
                bottom: 6
              })
              .backgroundColor('#F0F0F0')
              .borderRadius(16)
              .margin({ left: 8 })
          }
          .width('100%')
          .margin({ top: 12 })
          .padding({ left: 16, right: 16 })
          .justifyContent(FlexAlign.Start)
        }

        ListItem() {
          // 服务卡片
          Grid() {
            GridItem() {
              Column() {
                Image($r('app.media.zhineg'))
                  .width(40)
                  .height(40)
                  .margin({ left: 12 })
                Text('家政护理')
                  .fontSize(16)
                  .margin({ top: 8 })
                Text('快速上门服务')
                  .fontSize(12)
                  .fontColor('#999999')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .padding(16)
              .onClick(() => {
                router.pushUrl({ url: 'pages/nursing/Nursing' })
              })
            }
            .backgroundColor(Color.White)
            .borderRadius(12)

            GridItem() {
              Column() {
                Image($r('app.media.kang'))
                  .width(40)
                  .height(40)
                  .margin({ left: 12 })
                Text('康复理疗')
                  .fontSize(16)
                  .margin({ top: 8 })
                Text('全套护理方案')
                  .fontSize(12)
                  .fontColor('#999999')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .padding(16)
              .onClick(() => {
                router.pushUrl({ url: 'pages/rehabilitation/Rehabilitation' })
              })
            }
            .backgroundColor(Color.White)
            .borderRadius(12)

            GridItem() {
              Column() {
                Image($r('app.media.fuwu'))
                  .width(40)
                  .height(40)
                  .margin({ left: 12 })
                Text('上门体检')
                  .fontSize(16)
                  .margin({ top: 8 })
                Text('专业医师团队')
                  .fontSize(12)
                  .fontColor('#999999')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .padding(16)
              .onClick(() => {
                router.pushUrl({ url: 'pages/examination/Examination' })
              })
            }
            .backgroundColor(Color.White)
            .borderRadius(12)
          }
          .width('92%')
          .height(120)
          .columnsTemplate('1fr 1fr 1fr')
          .rowsTemplate('1fr')
          .columnsGap(8)
          .margin({ top: 16, left: 16, right: 16 })
        }

        ListItem() {
          // 功能区域
          Column() {
            Grid() {
              ForEach([
                { icon: 'shuju', title: '健康数据', url: 'pages/health/Health' },
                { icon: 'she', title: '设备中心', url: 'pages/device/Device' },
                { icon: 'yao', title: '用药信息', url: 'pages/medicine/Medicine' },
                { icon: 'jian', title: '健康膳食', url: 'pages/diet/Diet' },
                { icon: 'disease', title: '疾病宝典', url: 'pages/disease/Disease' },
                { icon: 'archive', title: '健康档案', url: 'pages/archive/Archive' },
                { icon: 'activity', title: '老年活动', url: 'pages/activity/Activity' },
                { icon: 'news', title: '健康资讯', url: 'pages/news/News' },
                { icon: 'elderly', title: '养老机构', url: 'pages/elderly/Elderly' },
                { icon: 'lecture', title: '健康讲座', url: 'pages/lecture/Lecture' }
              ], (item: FunctionNavItem) => {
                GridItem() {
                  Column() {
                    Image($r(`app.media.${item.icon}`))
                      .width(24)
                      .height(24)
                    Text(item.title)
                      .fontSize(12)
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Center)
                  .onClick(() => {
                    router.pushUrl({ url: item.url })
                  })
                }
              })
            }
            .width('92%')
            .height(200)
            .columnsTemplate('1fr 1fr 1fr 1fr')
            .rowsTemplate('1fr 1fr 1fr')
            .columnsGap(8)
            .rowsGap(12)
            .backgroundColor(Color.White)
            .padding(12)
            .borderRadius(12)
          }
          .margin({ top: 12 })
          .width('100%')
        }

        ListItem() {
          // 健康提醒
          Row() {
            Row() {
              Text('健康')
                .fontSize(16)
                .fontColor('#00CC66')
              Text('提醒')
                .fontSize(16)
                .fontColor('#00CC66')
            }

            Row() {
              Image($r('app.media.lingdan'))
                .width(16)
                .height(20)
              Text('用药提醒')
                .fontSize(14)
                .margin({ left: 4 })
              Text('服药时间：06:30 卡托普利 \n 2片')
                .fontSize(14)
                .margin({ left: 8 })
            }
            .margin({ left: 12 })
          }
          .width('92%')
          .height(60)
          .backgroundColor(Color.White)
          .padding({
            left: 16,
            right: 16,
            top: 12,
            bottom: 12
          })
          .margin({ top: 12,left:20 })
          .borderRadius(12)
        }

        ListItem() {
          // 疾病宝典
          Column() {
            Row() {
              Text('疾病宝典')
                .fontSize(16)
              Row() {
                Text('更多')
                  .fontSize(14)
                  .fontColor('#999999')
                Image($r('app.media.xiangyou'))
                  .width(16)
                  .height(16)
                  .margin({ left: 4 })
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ bottom: 12 })

            Flex({ wrap: FlexWrap.Wrap }) {
              Text('白内障')
                .fontSize(14)
                .backgroundColor('#F5F5F5')
                .padding({
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 8
                })
                .borderRadius(20)
                .margin({ right: 8, bottom: 8 })
              Text('高血压')
                .fontSize(14)
                .backgroundColor('#F5F5F5')
                .padding({
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 8
                })
                .borderRadius(20)
                .margin({ right: 8, bottom: 8 })
              Text('中风')
                .fontSize(14)
                .backgroundColor('#F5F5F5')
                .padding({
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 8
                })
                .borderRadius(20)
                .margin({ right: 8, bottom: 8 })
              Text('阿尔茨海默症')
                .fontSize(14)
                .backgroundColor('#F5F5F5')
                .padding({
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 8
                })
                .borderRadius(20)
                .margin({ right: 8, bottom: 8 })
              Text('糖尿病')
                .fontSize(14)
                .backgroundColor('#F5F5F5')
                .padding({
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 8
                })
                .borderRadius(20)
                .margin({ right: 8, bottom: 8 })
              Text('心率不齐')
                .fontSize(14)
                .backgroundColor('#F5F5F5')
                .padding({
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 8
                })
                .borderRadius(20)
                .margin({ right: 8, bottom: 8 })
            }
          }
          .width('92%')
          .padding(16)
          .backgroundColor(Color.White)
          .margin({ top: 12 ,left:15})
          .borderRadius(12)
        }

        ListItem() {
          Column() {
            ForEach(this.newsData, (item: NewsData) => {
              Column() {
                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .margin({ bottom: 8 })

                Text(item.content)
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ bottom: 12 })

                Row() {
                  ForEach(item.imageUrls, (url: string) => {
                    Image(url)
                      .width(90)
                      .height(80)
                      .borderRadius(8)
                      .margin({ right: 8 })
                      .objectFit(ImageFit.Cover)
                  })
                }


                Row() {
                  Image($r('app.media.feng'))
                    .width(20)
                    .height(20)

                  Row() {
                    Image($r('app.media.xin'))
                      .width(20)
                      .height(20)
                      .margin({ left: 16 })
                    Text(item.likeCount.toString())
                      .fontSize(14)
                      .fontColor('#999999')
                      .margin({ left: 4 })
                  }

                  Row() {
                    Image($r('app.media.shou'))
                      .width(20)
                      .height(20)
                      .margin({ left: 16 })
                    Text(item.starCount.toString())
                      .fontSize(14)
                      .fontColor('#999999')
                      .margin({ left: 4 })
                  }

                  Row() {
                    Image($r('app.media.xinxi'))
                      .width(20)
                      .height(20)
                      .margin({ left: 16 })
                    Text(item.commentCount.toString())
                      .fontSize(14)
                      .fontColor('#999999')
                      .margin({ left: 4 })
                  }
                }
                .margin({ top: 12 })
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(12)
              .margin({ bottom: 12,left:20 })
            })
          }
          .width('92%')
          .margin({ top: 12 })
        }
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Auto)
      .linearGradient({
        angle: 180,
        colors: [['#F0F8FF', 0.0], ['#E6F3FF', 1.0]]
      })
    }
  }
=======


@Component
export default struct Home {


  build() {
    Column(){
      Text('首页')
    }
  }
>>>>>>> 78d4053a4b4de55729e6dc489f25006b715845d4
}