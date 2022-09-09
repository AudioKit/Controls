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
                    NavigationLink("Arc Knob",
                                   destination: ArcKnobDemoView())
                    NavigationLink("Ribbon",
                                   destination: RibbonDemoView())
                    NavigationLink("Simple Knob",
                                   destination: SmallKnobDemoView())
                    NavigationLink("Indexed Slider",
                                   destination: IndexedSliderDemoView())
                    NavigationLink("Pitch/Mod Wheel",
                                   destination: PitchModWheelDemoView())
                }
                Section(header: Text("Double-Parameter")) {
                    NavigationLink("Joystick",
                                   destination: JoystickDemoView())
                    NavigationLink("XY Pad",
                                   destination: XYPadDemoView())
                }
                Section(header: Text("Multiple Controls")) {
                    NavigationLink("Keyboard",
                                   destination: KeyboardDemoView())
                }
            }
        }.navigationTitle("Controls")
    }
}

