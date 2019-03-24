//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import PlaygroundSupport

/// Instantiates a new instance of a live view.
///
/// By default, this loads an instance of `LiveViewController` from `LiveView.storyboard`.
public func instantiateLiveView() -> UIViewController {
	let storyboard = UIStoryboard(name: "LiveView", bundle: nil)
	guard let viewController = storyboard.instantiateInitialViewController() else {
		fatalError("LiveView.storyboard does not have an initial scene; please set one or update this function")
	}
	
	guard let liveViewController = viewController as? LiveViewController else {
		fatalError("LiveView.storyboard's initial scene is not a LiveViewController; please either update the storyboard or this function")
	}
	
	return liveViewController
}

/*
public class MessageHandler: PlaygroundRemoteLiveViewProxyDelegate {
	public func remoteLiveViewProxy(
		_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy,
		received message: PlaygroundValue
		) {
		print("Received a message from the always-on live view", message)
	}
	
	public func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) {}
	
	public init() {
	}
}
*/

public func getRemoteView() -> PlaygroundRemoteLiveViewProxy {
	guard let remoteView = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy else {
		fatalError("Always-on live view not configured in this page's LiveView.swift.")
	}
	return remoteView
}
