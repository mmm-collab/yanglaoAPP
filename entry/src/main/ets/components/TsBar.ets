@Component
export struct TsBar {
  @Prop data: number[]
  @Prop color: string

  build() {
    Row() {
      ForEach(this.data, (item: number, index: number) => {
        Column() {
          Column() {
            Text(item.toString())
              .fontSize(10)
              .fontColor('#999999')
              .margin({ bottom: 4 })
          }
          .height('100%')
          .justifyContent(FlexAlign.End)

          Column() {}
            .width(4)
            .height(`${(item / Math.max(...this.data)) * 100}%`)
            .backgroundColor(this.color)
            .borderRadius(2)
        }
        .height('100%')
        .layoutWeight(1)
        .margin({ right: index < this.data.length - 1 ? 8 : 0 })
      })
    }
    .width('100%')
    .height('100%')
  }
}