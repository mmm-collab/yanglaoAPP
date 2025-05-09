import router from '@ohos.router'

interface Comment {
  id: number
  userName: string
  avatar: string
  rating: number
  location: string
  content: string
  time: string
  likes: number
}

@Entry
@Component
struct CommentList {
  @State currentTab: number = 0
  @State total_reviews: number = 2000
  @State positive_reviews: number = 1988
  @State negative_reviews: number = 12
  @State tabs: string[] = [`全部(${this.total_reviews})`, `好评(${this.positive_reviews})`, `差评(${this.negative_reviews})`]
  @State showSortDialog: boolean = false
  @State sortType: string = '默认排序'
  @State comments: Comment[] = [
    {
      id: 1001,
      userName: "王强",
      avatar: "https://picsum.photos/40",
      rating: 1.0,
      location: "北京",
      content: "阿姨打扫的很敷衍，很多地方都没有打扫到位，态度也不好。",
      time: "2天前",
      likes: 0
    },
    {
      id: 1002,
      userName: "李明",
      avatar: "https://picsum.photos/40",
      rating: 5.0,
      location: "上海",
      content: "服务很专业，阿姨态度很好，打扫得很干净。",
      time: "3天前",
      likes: 12
    },
    {
      id: 1003,
      userName: "张华",
      avatar: "https://picsum.photos/40",
      rating: 4.0,
      location: "广州",
      content: "整体还不错，就是有些角落没有打扫到。",
      time: "1周前",
      likes: 5
    }
  ]

  build() {
    Stack() {
      Column() {
        // 顶部导航栏
        Row() {
          Row() {
            Image($r('app.media.back'))
              .width(24)
              .height(24)
              .onClick(() => router.back())
            Text('全部评价')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .margin({ left: 16 })
          }
          Image($r('app.media.background'))
            .width(24)
            .height(24)
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#fff')
        .justifyContent(FlexAlign.SpaceBetween)

        // 评论分类标签和排序
        Row() {
          Row() {
            ForEach(this.tabs, (item: string, index: number) => {
              Text(item)
                .fontSize(14)
                .fontColor(this.currentTab === index ? '#333' : '#999')
                .backgroundColor(this.currentTab === index ? '#F5F5F5' : '#fff')
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .borderRadius(16)
                .margin({ right: 8 })
                .onClick(() => {
                  this.currentTab = index
                })
            })
          }
          Row() {
            Text(this.sortType)
              .fontSize(14)
              .fontColor('#333')
            Image($r('app.media.background'))
              .width(16)
              .height(16)
              .margin({ left: 4 })
              .fillColor('#333')
          }
          .height(32)
          .padding({ left: 12, right: 12 })
          .backgroundColor('#F5F5F5')
          .borderRadius(16)
          .margin({ left: 'auto' })
          .onClick(() => {
            this.showSortDialog = true
          })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#fff')

        // 评论列表
        List({ space: 8 }) {
          ForEach(this.comments.filter(item => {
            if (this.currentTab === 1) return item.rating >= 4
            if (this.currentTab === 2) return item.rating < 4
            return true
          }), (item: Comment) => {
            ListItem() {
              Column() {
                Row() {
                  Image(item.avatar)
                    .width(40)
                    .height(40)
                    .borderRadius(20)
                  Column() {
                    Row() {
                      Text(item.userName)
                        .fontSize(14)
                        .fontWeight(FontWeight.Medium)
                      Text(item.time)
                        .fontSize(12)
                        .fontColor('#999')
                        .margin({ left: 8 })
                    }
                    .margin({ bottom: 4 })
                    Row() {
                      Row() {
                        ForEach([1, 2, 3, 4, 5], (star: number) => {
                          Text('★')
                            .fontColor(star <= item.rating ? '#FFB800' : '#DDD')
                            .fontSize(14)
                            .margin({ right: 2 })
                        })
                      }
                      Text(item.rating.toString())
                        .fontSize(14)
                        .fontWeight(FontWeight.Bold)
                        .fontColor('#FFB800')
                        .margin({ left: 8 })
                      Text(item.location)
                        .fontSize(12)
                        .fontColor('#999')
                        .margin({ left: 8 })
                    }
                  }
                  .alignItems(HorizontalAlign.Start)
                  .margin({ left: 12 })
                  Column() {
                    Image($r('app.media.background'))
                      .width(20)
                      .height(20)
                      .fillColor('#999')
                    Text(item.likes.toString())
                      .fontSize(12)
                      .fontColor('#999')
                      .margin({ top: 4 })
                  }
                  .margin({ left: 'auto' })
                  .alignItems(HorizontalAlign.Center)
                  .onClick(() => {
                    // 点赞功能待实现
                  })
                }
                Text(item.content)
                  .fontSize(14)
                  .fontColor('#333')
                  .margin({ top: 8 })
              }
              .padding({ top: 16, bottom: 16 })
              .width('100%')
              .backgroundColor('#fff')
              .margin({ bottom: 8 })
            }
          })
        }
        .margin({ top: 12 })
        .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')

      // 排序弹框
      if (this.showSortDialog) {
        Column() {
          Column() {
            Text('排序')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .margin({ top: 16, bottom: 16 })
            Column() {
              Row() {
                Text('评分：由高到低')
                  .fontSize(14)
                  .fontColor('#333')
              }
              .width('100%')
              .height(48)
              .padding({ left: 16, right: 16 })
              .backgroundColor(this.sortType === '评分：由高到低' ? '#F5F5F5' : '#fff')
              .onClick(() => {
                this.sortType = '评分：由高到低'
                this.showSortDialog = false
                // 实现排序逻辑
                this.comments.sort((a, b) => b.rating - a.rating)
              })

              Row() {
                Text('评分：由低到高')
                  .fontSize(14)
                  .fontColor('#333')
              }
              .width('100%')
              .height(48)
              .padding({ left: 16, right: 16 })
              .backgroundColor(this.sortType === '评分：由低到高' ? '#F5F5F5' : '#fff')
              .onClick(() => {
                this.sortType = '评分：由低到高'
                this.showSortDialog = false
                // 实现排序逻辑
                this.comments.sort((a, b) => a.rating - b.rating)
              })

              Row() {
                Text('评价时间')
                  .fontSize(14)
                  .fontColor('#333')
              }
              .width('100%')
              .height(48)
              .padding({ left: 16, right: 16 })
              .backgroundColor(this.sortType === '评价时间' ? '#F5F5F5' : '#fff')
              .onClick(() => {
                this.sortType = '评价时间'
                this.showSortDialog = false
                // 实现排序逻辑
                // 这里需要将time转换为可比较的格式
              })

              Row() {
                Text('点赞量：由高到低')
                  .fontSize(14)
                  .fontColor('#333')
              }
              .width('100%')
              .height(48)
              .padding({ left: 16, right: 16 })
              .backgroundColor(this.sortType === '点赞量：由高到低' ? '#F5F5F5' : '#fff')
              .onClick(() => {
                this.sortType = '点赞量：由高到低'
                this.showSortDialog = false
                // 实现排序逻辑
                this.comments.sort((a, b) => b.likes - a.likes)
              })
            }
            .width('100%')
            .backgroundColor('#fff')
          }
          .width('100%')
          .backgroundColor('#fff')
          .borderRadius({ topLeft: 16, topRight: 16 })
          .position({ x: 0, y: '50%' })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.5)')
        .onClick(() => {
          this.showSortDialog = false
        })
      }
    }
  }
}