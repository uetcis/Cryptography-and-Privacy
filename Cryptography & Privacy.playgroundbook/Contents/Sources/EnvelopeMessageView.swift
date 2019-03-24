//
//  EnvelopeMessageView.swift
//  Book_Sources
//
//  Created by CaptainYukinoshitaHachiman on 2019/3/24.
//

import UIKit

public class EnvelopeMessageView: UIView {
	
	var deliveryStatus: DeliveryStatus? {
		didSet {
			setNeedsDisplay()
		}
	}
	
	public override func draw(_ rect: CGRect) {
		super.draw(rect)
		let width = rect.width
		let height = rect.height
		if width > height {
			let realWidth = height / 8 * 7
			let leadingMargin = (width - realWidth) / 2
			draw(in: CGRect(x: rect.minX + leadingMargin, y: rect.minY, width: realWidth, height: height))
		} else {
			let realHeight = width / 7 * 8
			let topMargin = (height - realHeight) / 2
			draw(in: CGRect(x: rect.minX, y: rect.minY + topMargin, width: width, height: realHeight))
		}
	}
	
	private func draw(in rect: CGRect) {
		let baseEnvelope = UIImage(named: "Envelope Base")!
		let frontEnvelope = UIImage(named: "Envelope Front")!
		baseEnvelope.draw(in: rect)
		let viewWidth = rect.width
		let viewHeight = rect.height
		let frontHeight = viewHeight / 8 * 7 / 4 * 3
		if let deliveryStatus = deliveryStatus {
			let introText = """
				From: \(deliveryStatus.senderName)
				To: \(deliveryStatus.receiverName)
				Content:
				""" as NSString
			let introAttributes: [NSAttributedString.Key: Any] = [
				.font: UIFont.systemFont(ofSize: 50, weight: .regular),
				.foregroundColor: #colorLiteral(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
			]
			let textWidth = viewWidth * 0.8
			let textMargin = (viewWidth - textWidth) / 2
			let introHeight = baseEnvelope.size.height - frontHeight
			let introOrigin = CGPoint(x: rect.minX + textMargin, y: rect.minY + textMargin / 2)
			var introSize = CGSize(width: textWidth, height: introHeight)
			var drawingOptions = NSStringDrawingOptions()
			drawingOptions.insert(NSStringDrawingOptions.usesLineFragmentOrigin)
			introSize = introText.boundingRect(with: introSize, options: drawingOptions,
											   attributes: introAttributes, context: nil).size
			let introFrame = CGRect(origin: introOrigin, size: introSize)
			introText.draw(in: introFrame, withAttributes: introAttributes)
			let contentFrame = CGRect(x: introFrame.minX, y: introFrame.maxY + 8, width: textWidth, height: 300)
			if let content = deliveryStatus.content {
				content.draw(in: contentFrame)
			} else {
				let contentAttributes: [NSAttributedString.Key: Any] = [
					.font: UIFont.systemFont(ofSize: 32, weight: .regular),
					.foregroundColor: #colorLiteral(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)]
				let drawableText = "[DATA ENCRYPTED]" as NSString
				drawableText.draw(in: contentFrame, withAttributes: contentAttributes)
			}
		}
		frontEnvelope.draw(in: CGRect(x: rect.minX, y: rect.maxY - frontHeight, width: viewWidth, height: frontHeight))
	}
	
}
