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
                    IndexedSlider(index: $index1, labels: ["", "", ""])
                        .backgroundColor(.yellow)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                        .frame(width: proxy.size.width / 3,
                               height: proxy.size.height / 20)
                    IndexedSlider(index: $index2, labels: ["1", "2", "3", "4", "5", "6", "7", "9"])
                        .backgroundColor(.orange)
                        .foregroundColor(.red)
                        .cornerRadius(20)
                        .frame(width: proxy.size.width / 1.5,
                               height: proxy.size.height / 10)
                    IndexedSlider(index: $index3, labels: ["I", "ii", "iii", "IV", "V", "vi", "VII"])
                        .foregroundColor(.black.opacity(0.5))
                        .cornerRadius(1000)
                        .frame(height: proxy.size.height / 10)
                }
            }
        }
        .navigationTitle("Indexed Slider")
        .padding()
    }
}
