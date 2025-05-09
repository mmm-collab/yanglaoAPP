import router from '@ohos.router';

@Entry
@Component
struct Examination {
  build() {
    Column() {
      // 顶部导航
      Row() {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.back()
          })
        Text('上门体检')
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
        Text('专业上门体检服务')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 16 })
        
        Text('专业医师团队提供便捷体检服务')
          .fontSize(16)
          .fontColor('#666666')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
  }
}