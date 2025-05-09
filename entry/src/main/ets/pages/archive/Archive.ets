import router from '@ohos.router'

@Entry
@Component
struct Archive {
  build() {
    Column() {
      Text('健康档案页面')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40 })
      Button('返回')
        .margin({ top: 20 })
        .onClick(() => router.back())
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
} 