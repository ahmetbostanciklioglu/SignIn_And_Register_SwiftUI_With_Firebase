import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    
    var body: some View {
        NavigationView {
            VStack {
                if self.status {
                    HomeView()
                } else {
                    ZStack(alignment: .top) {
                        NavigationLink(destination: RegisterView(show: self.$show), isActive: self.$show) {
                            Text("")
                        }
                        .hidden()
                        
                        LoginView(show: self.$show)
                    }
                }
            }
            .navigationTitle("")
            .toolbarVisibility(.hidden)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                NotificationCenter.default
                    .addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { _ in
                        self.status = UserDefaults.standard
                            .value(forKey: "status") as? Bool ?? false
                    }
            }
        }
       
    }
}

#Preview {
    ContentView()
}
