//
//  Floating.swift
//  DateTest
//
//  Created by Damiaan on 19/07/2020.
//

import SwiftUI

extension View {
	func float<Content: View>(above: Content) -> ModifiedContent<Self, Above<Content>> {
		self.modifier(Above(aboveContent: above))
	}
	func float<Content: View>(below: Content) -> ModifiedContent<Self, Below<Content>> {
		self.modifier(Below(belowContent: below))
	}
	func float<Content: View>(trailing: Content) -> ModifiedContent<Self, Trailing<Content>> {
		self.modifier(Trailing(trailingContent: trailing))
	}
}

struct Above<AboveContent: View>: ViewModifier {
	let aboveContent: AboveContent

	func body(content: Content) -> some View {
		content.overlay(
			aboveContent.alignmentGuide(.top) { $0[.bottom] },
			alignment: .top
		)
	}
}

struct Below<AboveContent: View>: ViewModifier {
	let belowContent: AboveContent

	func body(content: Content) -> some View {
		content.overlay(
			belowContent.alignmentGuide(.bottom) { $0[.top] },
			alignment: .bottom
		)
	}
}

struct Trailing<AboveContent: View>: ViewModifier {
	let trailingContent: AboveContent

	func body(content: Content) -> some View {
		content.overlay(
			trailingContent.alignmentGuide(.trailing) { $0[.leading] },
			alignment: .trailing
		)
	}
}

struct Floating_Previews: PreviewProvider {
	static var previews: some View {
		HStack {
			Text("Block 1").float(above: TextBox(content: "This floats above 1"))
			Divider()
			Text("Block 2")
			Divider()
			Text("Block 3").float(below: TextBox(content: "This floats below 3"))
		}.fixedSize()
	}

	struct TextBox: View {
		let content: String

		var body: some View {
			Text(content)
				.padding(3)
				.background(Color.gray.opacity(0.6))
				.cornerRadius(3)
				.frame(width: 100)
				.fixedSize()
				.foregroundColor(.white)
				.padding()
		}
	}
}
