import router from '@ohos.router'

@Entry
@Component
struct Rehabilitation {
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
        Text('康复理疗')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.White)

      // 内容区域
      Column() {
        Text('康复理疗服务')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 16 })
        
        Text('专业的康复理疗团队')
          .fontSize(16)
          .fontColor('#666666')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
  }
}