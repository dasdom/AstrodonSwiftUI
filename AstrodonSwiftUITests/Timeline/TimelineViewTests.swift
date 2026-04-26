//  Created by Dominik Hauser on 25.04.26.
//
//


import Testing
import ViewInspector
@testable import AstrodonSwiftUI

extension InspectableSheet: @retroactive BasePopupPresenter {}
extension InspectableSheet: @retroactive PopupPresenter { }

@MainActor
struct TimelineViewTests {
  let viewModel: TimelineViewModel
  let sut: TimelineView

  init() {
    viewModel = TimelineViewModel()
    sut = TimelineView(viewModel: viewModel)
  }

  @Test func doesNotShowAuthView_ifIsPresentingIsFalse() async throws {
    viewModel.isPresentingAuth = false

    #expect(throws: (any Error).self) {
      let _ = try sut.inspect().vStack().sheet()
    }
  }

  @Test func showsAuthView_ifIsPresentingIsTrue() async throws {
    viewModel.isPresentingAuth = true

    let _ = try sut.inspect().vStack().sheet().view(AuthorizationView.self)
  }

}
