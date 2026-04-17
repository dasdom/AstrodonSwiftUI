//  Created by Dominik Hauser on 14.04.26.
//  
//


import Testing
import ViewInspector
@testable import AstrodonSwiftUI

@MainActor
struct AuthorizationViewTests {

  let viewModel: AuthorizationViewModel
  let sut: AuthorizationView

  init() {
    viewModel = AuthorizationViewModel()
    sut = AuthorizationView(viewModel: viewModel)
  }

  @Test func authButton_whenHostTextFieldEmpty_disabled() async throws {
    let hostTextField = try sut.inspect().find(ViewType.TextField.self, containing: "Host")

    let input = try hostTextField.input()
    try #require(input.isEmpty == true)

    let authButton = try sut.inspect().find(button: "Sign in")
    #expect(authButton.isDisabled() == true)
  }

  @Test func authButton_whenHostTextFieldNotEmpty_enabled() async throws {
    let hostTextField = try sut.inspect().find(ViewType.TextField.self, containing: "Host")
    try hostTextField.setInput("chaos.social")

    let authButton = try sut.inspect().find(button: "Sign in")
    #expect(authButton.isDisabled() == false)
  }

  @Test func codeButton_whenCodeTextFieldEmpty_disabled() async throws {
    let codeTextField = try sut.inspect().find(ViewType.TextField.self,
                                               where: { try $0.labelView().text().string() == "Code" })

    let input = try codeTextField.input()
    try #require(input.isEmpty == true)

    let codeButton = try sut.inspect().find(button: "Send")
    #expect(codeButton.isDisabled() == true)
  }
}
