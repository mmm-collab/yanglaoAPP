@Component
export default struct Message {
  build() {
    Column() {
      Text('消息')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}