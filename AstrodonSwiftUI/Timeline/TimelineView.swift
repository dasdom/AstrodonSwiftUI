//  Created by Dominik Hauser on 12.04.26.
//
//


import SwiftUI

struct TimelineView: View {

  @State var viewModel = TimelineViewModel()

  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .padding()
    .sheet2(isPresented: $viewModel.isPresentingAuth) {
      AuthorizationView()
    }
  }
}

#Preview {
  TimelineView()
}
