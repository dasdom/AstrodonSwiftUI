//  Created by Dominik Hauser on 14.04.26.
//
//


import SwiftUI
import AuthenticationServices

struct AuthorizationView: View {

  @Environment(\.webAuthenticationSession) private var webAuthenticationSession

  @State var viewModel = AuthorizationViewModel()

  var body: some View {
    VStack {
      TextField("Host", text: $viewModel.serverHost)

      Button("Sign in") {
        Endpoint.host = viewModel.serverHost
        Task {
          if let url = Endpoint.authCode.url {
            do {
              // Perform the authentication and await the result.
              let urlWithToken = try await webAuthenticationSession.authenticate(
                using: url,
                callbackURLScheme: "astrodon"
              )
              print("urlWithToken: \(urlWithToken)")
            } catch {
              print("\(error)")
            }
          }
        }
      }
      .disabled(viewModel.serverHost.isEmpty)

      TextField("Code", text: $viewModel.code)

      Button("Send") {
        do {
          try viewModel.fetchToken()
        } catch {
          print("\(error)")
        }
      }
      .disabled(viewModel.code.isEmpty)
    }
    .padding()
  }
}

#Preview {
  AuthorizationView()
}
