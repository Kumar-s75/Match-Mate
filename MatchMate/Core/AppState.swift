import Foundation
import SwiftUI

@Observable
final class AppState {
    var matches: [Match] = []
}