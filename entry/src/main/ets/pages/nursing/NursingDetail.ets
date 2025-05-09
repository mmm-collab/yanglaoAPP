import router from '@ohos.router'

interface Staff {
  name: string
  avatar: string
  tag: string
}
interface XianshiDetail {
  id: number
  name: string
  currentPrice: number
  originalPrice: number
  image: string
  discount: string
  rating: number
  commentCount: number
  scene: string
  area: string
  scope: string
  overtime: string
  staffList: Staff[]
}

@Entry
@Component
struct NursingDetail {
  @State detail: XianshiDetail = router.getParams() as XianshiDetail

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          // 顶部图片
          Image(this.detail.image)
            .width('100%')
            .height(260)
            .objectFit(ImageFit.Cover)

          // 主要内容区域
          Column() {
            // 标题、价格、折扣
            Text(this.detail.name)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 12 })

            Row() {
              Text('￥' + this.detail.currentPrice)
                .fontSize(24)
                .fontColor('#FF4D4F')
                .fontWeight(FontWeight.Bold)
              Text('￥' + this.detail.originalPrice)
                .fontSize(14)
                .fontColor('#999')
                .decoration({ type: TextDecorationType.LineThrough })
                .margin({ left: 8 })
              Text(this.detail.discount)
                .fontSize(12)
                .fontColor('#FF4D4F')
                .backgroundColor('#FFF0F0')
                .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                .borderRadius(4)
                .margin({ left: 8 })
            }
            .margin({ bottom: 12 })

            // 评分
            Row() {
              Text('★★★★★')
                .fontColor('#FFD700')
                .fontSize(16)
              Text(this.detail.rating + '分')
                .fontSize(14)
                .fontColor('#333')
                .margin({ left: 8 })
              Text('(' + this.detail.commentCount + '人评价)')
                .fontSize(12)
                .fontColor('#999')
                .margin({ left: 8 })
            }
            .margin({ bottom: 20 })

            // 服务内容
            Text('服务内容')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 12 })

            Column({ space: 12 }) {
              Row() {
                Text('适用场景').fontColor('#666').fontSize(14)
                Text(this.detail.scene).fontSize(14)
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)

              Row() {
                Text('适用面积').fontColor('#666').fontSize(14)
                Text(this.detail.area).fontSize(14)
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)

              Row() {
                Text('适用范围').fontColor('#666').fontSize(14)
                Text(this.detail.scope).fontSize(14)
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)

              Row() {
                Text('超时费用').fontColor('#666').fontSize(14)
                Text(this.detail.overtime).fontSize(14)
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)
            }
            .margin({ bottom: 20 })

            // 服务人员
            Text('服务人员')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 12 })

            List() {
              ForEach(this.detail.staffList, (staff: Staff) => {
                ListItem() {
                  Row() {
                    Image(staff.avatar)
                      .width(60)
                      .height(60)
                      .borderRadius(30)
                    Column() {
                      Text(staff.name)
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                        .margin({ bottom: 8 })
                      Text('全屋空调')
                        .fontSize(14)
                        .fontColor('#999')
                        .margin({ bottom: 8 })
                      Text(staff.tag)
                        .fontSize(12)
                        .fontColor('#FF4D4F')
                        .backgroundColor('#FFF0F0')
                        .padding({ left: 8, right: 8, top: 2, bottom: 2 })
                        .borderRadius(12)
                    }
                    .alignItems(HorizontalAlign.Start)
                    .margin({ left: 16 })
                  }
                  .padding({ top: 16, bottom: 16 })
                  .width('100%')
                }
              })
            }
            .height(240)
            .margin({ bottom: 20 })

            // 服务详情
            Text('服务详情')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 12 })

            Text('运接一家专业的清洁公司或个人人员进行日常保洁服务，可以确保清洁效果和服务质量，让客户安心。')
              .fontSize(14)
              .fontColor('#666')
              .margin({ bottom: 16 })
              .lineHeight(22)

            Row({ space: 12 }) {
              Image($r('app.media.background'))
                .width('48%')
                .height(120)
                .borderRadius(8)
                .objectFit(ImageFit.Cover)
              Image($r('app.media.background'))
                .width('48%')
                .height(120)
                .borderRadius(8)
                .objectFit(ImageFit.Cover)
            }
            .margin({ bottom: 20 })

            // 购买须知
            Text('购买须知')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 12 })

            Column({ space: 12 }) {
              Row() {
                Text('有效期').fontColor('#666').fontSize(14)
                Text('购买后60天内有效').fontSize(14)
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)

              Row() {
                Text('预约规则').fontColor('#666').fontSize(14)
                Text('请提前预约，预约后服务2小时内可退').fontSize(14)
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)
            }
            .margin({ bottom: 20 })

            // 用户评价
            Row() {
              Text('用户评价')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
              Text('(2000)')
                .fontSize(14)
                .fontColor('#999')
                .margin({ left: 4 })
              Text('4.9')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFB800')
                .margin({ left: 'auto' })
            }
            .margin({ bottom: 12 })

            Column({ space: 16 }) {
              ForEach([1, 2], () => {
                Column() {
                  Row() {
                    Image('https://picsum.photos/40')
                      .width(40)
                      .height(40)
                      .borderRadius(20)
                    Column() {
                      Row() {
                        Text('王强')
                          .fontSize(14)
                          .fontWeight(FontWeight.Medium)
                        Text('2天前')
                          .fontSize(12)
                          .fontColor('#999')
                          .margin({ left: 8 })
                      }
                      .margin({ bottom: 4 })
                      Row() {
                        Text('★★★★★')
                          .fontColor('#FFB800')
                          .fontSize(14)
                        Text('5.0')
                          .fontSize(14)
                          .fontWeight(FontWeight.Bold)
                          .fontColor('#FFB800')
                          .margin({ left: 8 })
                        Text('北京')
                          .fontSize(12)
                          .fontColor('#999')
                          .margin({ left: 8 })
                      }
                    }
                    .alignItems(HorizontalAlign.Start)
                    .margin({ left: 12 })
                  }
                  Text('非常满意日常保洁服务，清洁人员非常专业、认真，服务态度非常好。')
                    .fontSize(14)
                    .fontColor('#333')
                    .margin({ top: 8, bottom: 12 })
                }
              })
            }
            .margin({ bottom: 12 })

            Row() {
              Text('查看全部评价')
                .fontSize(14)
                .fontColor('#666')
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/nursing/CommentList',
                    params: {
                      rating: this.detail.rating,
                      commentCount: this.detail.commentCount
                    }
                  })
                })
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
            .height(40)
            .backgroundColor('#F5F5F5')
            .borderRadius(20)
            .margin({ bottom: 80 })

          }
          .padding(16)
          .backgroundColor('#fff')
          .borderRadius({ topLeft: 20, topRight: 20 })
          .margin({ top: -20 })
        }
      }
      .scrollBar(BarState.Off)

      // 顶部返回按钮
      Row() {
        Image($r('app.media.back'))
          .width(32)
          .height(32)
          .fillColor('#fff')
          .onClick(() => router.back())
      }
      .position({ x: 16, y: 16 })

      // 底部购买按钮
      Button('立即购买', { type: ButtonType.Capsule })
        .width('90%')
        .height(48)
        .fontSize(18)
        .fontColor('#fff')
        .backgroundColor('#FF4D4F')
        .margin({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}