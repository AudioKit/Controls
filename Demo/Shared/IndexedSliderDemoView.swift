import Controls
import SwiftUI

struct IndexedSliderDemoView: View {
    @State var index1 = 0
    @State var index2 = 0
    @State var index3 = 0

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 40) {
                VStack(alignment: .center, spacing: 20) {
                    IndexedSlider(index: $index1,
                                  labels: ["", "", "", "", ""])
                        .frame(height: proxy.size.height / 10)
                    IndexedSlider(index: $index2,
                                  labels: ["1", "2", "3", "4", "5"])
                        .frame(height: proxy.size.height / 10)
                    IndexedSlider(index: $index3,
                                    labels: ["ONE", "TWO", "THREE", "FOUR", "FIVE"])
                        .frame(height: proxy.size.height / 10)
                }
            }
        }
        .navigationTitle("Indexed Slider")
        .padding()
    }
}
