import router from '@ohos.router';
import Home from '../pages/home/Home'
import My from './my/My'
import Message from '../pages/message/Message'
import Profile from '../pages/profile/profile'
@Entry
@Component
struct Index {
  @State currentIndex: number = 0;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Tabs({ barPosition: BarPosition.End }) {
          TabContent() {
            Navigation() {
              Home()
            }
          }
          .tabBar(this.TabBuilder('首页', 0, $r('app.media.ys'), $r('app.media.s')))

          TabContent() {
            Navigation() {
              My()
            }
          }
          .tabBar(this.TabBuilder('生活圈', 1, $r('app.media.y'), $r('app.media.yy')))

          TabContent() {
            Navigation() {
              Message()
            }
          }
          .tabBar(this.TabBuilder('消息', 2, $r('app.media.x'), $r('app.media.yx')))

          TabContent() {
            Navigation() {
              Profile()
            }
          }
          .tabBar(this.TabBuilder('我的', 3, $r('app.media.w'), $r('app.media.wy')))
        }
        .barHeight(56)
        .backgroundColor('#FFFFFF')
        .barMode(BarMode.Fixed)
        .onChange((index: number) => {
          this.currentIndex = index
        })
      }

      Button() {
        Image($r('app.media.j'))
          .width(24)
          .height(24)
      }
      .width(48)
      .height(48)
      .position({x: '50%', y: '92%'})
      .translate({x: -24})
      .backgroundColor('#7B48F8')
      .borderRadius(24)
      .onClick(() => {
        router.pushUrl({url:'pages/dong/Dong'})
      })
    }
  }

  @Builder TabBuilder(title: string, index: number, normalImg: Resource, selectedImg: Resource) {
    Column() {
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .width(24)
        .height(24)
      Text(title)
        .fontSize(12)
        .fontColor(this.currentIndex === index ? '#7B48F8' : '#999999')
        .margin({ top: 4 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}