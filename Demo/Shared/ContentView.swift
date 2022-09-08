import Controls
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MasterView()
            DetailView()
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct DetailView: View {
    var body: some View {
        EmptyView()
    }
}

struct MasterView: View {
    var body: some View {
        Form {
            List {
                Section(header: Text("Single-Parameter")) {
                    NavigationLink("Scrubber",
                                   destination: ScrubberDemoView())
                    NavigationLink("Indexed Slider",
                                   destination: IndexedSliderDemoView())
                    NavigationLink("Pitch/Mod Wheel",
                                   destination: PitchModWheelDemoView())
                }
                Section(header: Text("Double-Parameter")) {
                    NavigationLink("XY Pad",
                                   destination: XYPadDemoView())
                }
                Section(header: Text("Dev")) {
                    NavigationLink("Old",
                                   destination: OldContentView())
                }
            }
        }.navigationTitle("Controls")
    }
}

struct OldContentView: View {
    @State var arcKnobValue: Float = 0.33
    @State var knobValue: Float = 0.33

    @State var radius: Float = 0
    @State var angle: Float = 0

    @State var midiValue: Int = 0

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    VStack(spacing: 10) {
                        Joystick(radius: $radius, angle: $angle)
                    }
                    VStack(spacing: 10) {
                        SimpleKnob(value: $knobValue)
                        ArcKnob(value: $arcKnobValue)
                        MIDIKnob(value: $midiValue)
                    }
                }
            }
        }.navigationTitle("Old Demo")
    }
}
