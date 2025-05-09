import router from '@ohos.router'
import http from '@ohos.net.http'

interface Xianshi {
  id:number
  name: string
  currentPrice: number,
  originalPrice: number,
  image: string
}

interface RehabCareData {
  rehabCare: Xianshi[]
}

interface ResponseData {
  code: number,
  msg: string,
  data: RehabCareData
}

interface TuiItem {
  service_name: string
  service_duration: string
  service_personnel: string
  service_type: string
  after_sales_guarantee: string
  price: string
  sold_quantity: number
  image: string
}

interface TuiResponse {
  data: TuiItem[]
}

@Entry
@Component
struct Nursing {
  @State isLoading: boolean = true
  @State rehabCare: Xianshi[] = []
  @State tuiList: TuiItem[] = []

  aboutToAppear() {
    console.info('开始获取数据...')
    this.fetchServiceData()
    this.fetchTuiList()
  }

  fetchServiceData() {
    this.isLoading = true
    let httpRequest = http.createHttp()
    httpRequest.request(
      "https://mock.presstime.cn/mock/6819c85b5ca065b2e0d4510b/api/you",
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
        if (
          responseData.code === 200 &&
          responseData.data &&
          Array.isArray(responseData.data.rehabCare)
        ) {
          this.rehabCare = responseData.data.rehabCare
          console.info('设置后的数据:', JSON.stringify(this.rehabCare))
          console.info('数据长度:', this.rehabCare.length)
        } else {
          console.error('数据格式错误:', responseData)
          this.rehabCare = []
        }
        this.isLoading = false
      }
    }).catch((err: Error) => {
      console.error('获取数据失败:', err.message)
    }).finally(() => {
      httpRequest.destroy()
    })
  }

  fetchTuiList() {
    let httpRequest = http.createHttp()
    httpRequest.request(
      "https://mock.presstime.cn/mock/6819c85b5ca065b2e0d4510b/api/tui",
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        }
      }
    ).then((resp: http.HttpResponse) => {
      if (resp.responseCode === 200) {
        const responseData = JSON.parse(resp.result.toString()) as TuiResponse
        if (responseData.data && Array.isArray(responseData.data)) {
          this.tuiList = responseData.data
        } else {
          this.tuiList = []
        }
      }
    }).catch((err: Error) => {
      this.tuiList = []
    }).finally(() => {
      httpRequest.destroy()
    })
  }

  build() {
    Column() {
      // 顶部导航
      Row() {
        Image($r("app.media.back"))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text('家政护理')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // 主要内容区域
      Scroll() {
        Column() {
          // 搜索框
          Row() {
            Image($r('app.media.sou'))
              .width(20)
              .height(20)
            TextInput({ placeholder: '搜索' })
              .fontSize(14)
              .backgroundColor('transparent')
              .placeholderColor('#999999')
              .margin({ left: 8 })
              .width('90%')
          }
          .width('92%')
          .height(40)
          .backgroundColor('#F5F5F5')
          .borderRadius(20)
          .padding({ left: 16 })
          .margin({ top: 12 })

          // 服务分类
          Grid() {
            GridItem() {
              Column() {
                Image($r("app.media.icon"))
                  .width(40)
                  .height(40)
                Text('生活照料')
                  .fontSize(14)
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Center)
            }

            GridItem() {
              Column() {
                Image($r('app.media.lian'))
                  .width(40)
                  .height(40)
                Text('临床护理')
                  .fontSize(14)
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Center)
            }

            GridItem() {
              Column() {
                Image($r('app.media.kanghu'))
                  .width(40)
                  .height(40)
                Text('康复护理')
                  .fontSize(14)
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Center)
            }

            GridItem() {
              Column() {
                Image($r('app.media.xinliguanhuai'))
                  .width(40)
                  .height(40)
                Text('心理关怀')
                  .fontSize(14)
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Center)
            }

            GridItem() {
              Column() {
                Image($r('app.media.shangmenzuofan'))
                  .width(40)
                  .height(40)
                Text('上门做饭')
                  .fontSize(14)
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Center)
            }

            GridItem() {
              Column() {
                Image($r('app.media.jiangkangguanli'))
                  .width(40)
                  .height(40)
                Text('健康管理')
                  .fontSize(14)
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Center)
            }

            GridItem() {
              Column() {
                Image($r('app.media.peitong'))
                  .width(40)
                  .height(40)
                Text('陪同就医')
                  .fontSize(14)
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Center)
            }

            GridItem() {
              Column() {
                Image($r('app.media.richangqingjie'))
                  .width(40)
                  .height(40)
                Text('日常清洁')
                  .fontSize(14)
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Center)
            }
          }
          .width('92%')
          .height(250)
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .rowsTemplate('1fr 1fr')
          .rowsGap(20)
          .columnsGap(16)
          .margin({ top: 20 })

          // 限时优惠
          Column() {
            // 标题和倒计时
            Row() {
              Text('限时优惠')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333')
              Row() {
                Text('03').fontColor('#FF4D4F').fontSize(15)
                Text(' : ').fontColor('#FF4D4F').fontSize(15)
                Text('33').fontColor('#FF4D4F').fontSize(15)
                Text(' : ').fontColor('#FF4D4F').fontSize(15)
                Text('33').fontColor('#FF4D4F').fontSize(15)
              }
              .margin({ right: 8 })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ bottom: 12 })

            // 横向滑动卡片
            List({ space: 12, initialIndex: 0 }) {
              ForEach(this.rehabCare, (item: Xianshi) => {
                ListItem() {
                  Column() {
                    Image(item.image)
                      .width(140)
                      .height(100)
                      .borderRadius(8)
                      .objectFit(ImageFit.Cover)
                      .onClick(() => {
                        router.pushUrl({
                          url: 'pages/nursing/NursingDetail',
                          params: item
                        })
                      })
                    Text(item.name)
                      .fontSize(14)
                      .fontColor('#333')
                      .margin({ top: 8 })
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                    Row() {
                      Text('¥' + item.currentPrice)
                        .fontSize(16)
                        .fontColor('#FF4D4F')
                      Text('¥' + item.originalPrice)
                        .fontSize(12)
                        .fontColor('#999999')
                        .decoration({ type: TextDecorationType.LineThrough })
                        .margin({ left: 8 })
                    }
                    .margin({ top: 4 })
                  }
                  .padding(8)
                  .backgroundColor('#fff')
                  .borderRadius(12)
                  .shadow({ radius: 8, color: '#eee', offsetX: 0, offsetY: 2 })
                  .width(160)
                }
              })
            }
            .height(180)
            .listDirection(Axis.Horizontal)
            .margin({ top: 8 })
          }
          .width('100%')
          .backgroundColor('#EAF3FA')
          .borderRadius(16)
          .padding(16)
          .margin({ top: 16, bottom: 16 })

          // 为您推荐
          Text('为您推荐')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .alignSelf(ItemAlign.Start)
            .margin({ top: 20, left: 16 })

            // 推荐服务列表
            List() {
              ForEach(this.tuiList, (item: TuiItem) => {
                ListItem() {
                  Row() {
                    Image(item.image)
                      .width(120)
                      .height(80)
                      .borderRadius(8)
                    Column() {
                      Text(item.service_name)
                        .fontSize(14)
                        .maxLines(2)
                      Row() {
                        Text(item.price)
                          .fontSize(16)
                          .fontColor('#FF4D4F')
                        Text('已售 ' + item.sold_quantity)
                          .fontSize(12)
                          .fontColor('#999999')
                          .margin({ left: 'auto' })
                      }
                      .width('100%')
                      .margin({ top: 8 })
                    }
                    .layoutWeight(1)
                    .margin({ left: 12 })
                  }
                  .padding(12)
                  .backgroundColor(Color.White)
                  .borderRadius(8)
                  .margin({ bottom: 12 })
                }
              })
            }
            .width('92%')
            .margin({ top: 12 })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}