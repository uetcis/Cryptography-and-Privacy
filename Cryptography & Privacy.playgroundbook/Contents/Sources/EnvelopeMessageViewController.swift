//
//  EnvelopeMessageViewController.swift
//  Book_Sources
//
//  Created by CaptainYukinoshitaHachiman on 2019/3/24.
//

import UIKit
import PlaygroundSupport

@objc(Book_Sources_EnvelopeMessageViewController)
public class EnvelopeMessageViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
	
	public func receive(_ message: PlaygroundValue) {
		if case .data(let data) = message {
			let decoder = JSONDecoder()
			let status = try? decoder.decode(DeliveryStatus.self, from: data)
			self.deliveryStatus = status
		}
	}
	
	public var deliveryStatus: DeliveryStatus? {
		get {
			return envelopeView.deliveryStatus
		}
		set {
			envelopeView.deliveryStatus = newValue
			if let viewer = newValue?.viewer {
				label.text = "Viewer: " + viewer
			}
		}
	}
	
	let envelopeView = EnvelopeMessageView()
	let label = UILabel()
	let backgroundView = UIImageView(image: UIImage(named: "Background"))
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(backgroundView)
		view.addSubview(envelopeView)
		view.addSubview(label)
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
		envelopeView.backgroundColor = .clear
		label.backgroundColor = .clear
		backgroundView.backgroundColor = #colorLiteral(red: 0.1999745071, green: 0.2000150084, blue: 0.1999689043, alpha: 1)
		label.translatesAutoresizingMaskIntoConstraints = false
		envelopeView.translatesAutoresizingMaskIntoConstraints = false
		backgroundView.translatesAutoresizingMaskIntoConstraints = false
		backgroundView.contentMode = .scaleAspectFill
		envelopeView.contentMode = .redraw
		let envelopeConstrains = [
			NSLayoutConstraint(item: envelopeView,
							   attribute: .centerX,
							   relatedBy: .equal,
							   toItem: view,
							   attribute: .centerX,
							   multiplier: 1,
							   constant: 0),
			NSLayoutConstraint(item: envelopeView,
							   attribute: .centerY,
							   relatedBy: .equal,
							   toItem: view,
							   attribute: .centerY,
							   multiplier: 1,
							   constant: 0),
			NSLayoutConstraint(item: envelopeView,
							   attribute: .height,
							   relatedBy: .equal,
							   toItem: view,
							   attribute: .height,
							   multiplier: 0.8,
							   constant: 0),
			NSLayoutConstraint(item: envelopeView,
							   attribute: .width,
							   relatedBy: .equal,
							   toItem: view,
							   attribute: .width,
							   multiplier: 0.8,
							   constant: 0)
		]
		view.addConstraints(envelopeConstrains)
		
		let backgroundConstraints = [
			NSLayoutConstraint(item: backgroundView,
							   attribute: .leading,
							   relatedBy: .equal,
							   toItem: view,
							   attribute: .leading,
							   multiplier: 1,
							   constant: 0),
			NSLayoutConstraint(item: backgroundView,
							   attribute: .trailing,
							   relatedBy: .equal,
							   toItem: view,
							   attribute: .trailing,
							   multiplier: 1,
							   constant: 0),
			NSLayoutConstraint(item: backgroundView,
							   attribute: .top,
							   relatedBy: .equal,
							   toItem: view,
							   attribute: .top,
							   multiplier: 1,
							   constant: 0),
			NSLayoutConstraint(item: backgroundView,
							   attribute: .bottom,
							   relatedBy: .equal,
							   toItem: view,
							   attribute: .bottom,
							   multiplier: 1,
							   constant: 0)
		]
		view.addConstraints(backgroundConstraints)
		
		let labelConstraints = [
			NSLayoutConstraint(item: label,
							   attribute: .centerX,
							   relatedBy: .equal,
							   toItem: view,
							   attribute: .centerX,
							   multiplier: 1,
							   constant: 0),
			NSLayoutConstraint(item: label,
							   attribute: .bottom,
							   relatedBy: .equal,
							   toItem: envelopeView,
							   attribute: .top,
							   multiplier: 1,
							   constant: 8),
			NSLayoutConstraint(item: label,
							   attribute: .top,
							   relatedBy: .greaterThanOrEqual,
							   toItem: view.safeAreaLayoutGuide,
							   attribute: .top,
							   multiplier: 1,
							   constant: 0)
		]
		view.addConstraints(labelConstraints)
	}
	
}
