//
//  PulleyHandler.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/3/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import UIKit

// MARK: Pan Gesture Actions

final class PulleyHandler {
    
    let pulleyGesture = UIPanGestureRecognizer(target: nil, action: nil)
    
    weak var coordinator: CoordinatorViewController!
    
    init(coordinator: CoordinatorViewController) {
        self.coordinator = coordinator
    }
    
    public func addGesture() {
        pulleyGesture.addTarget(self, action: #selector(panGestureDidUpdate(_:)))
        pulleyGesture.cancelsTouchesInView = true
        coordinator.waterfallViewController.view.addGestureRecognizer(pulleyGesture)
    }
    
    public func removeGesture() {
        coordinator.view.removeGestureRecognizer(pulleyGesture)
    }
    
    /**
     Called when user interacts with the pulley bar
     */
    @objc func panGestureDidUpdate(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            panGestureDidChange(sender)
        case .ended, .failed, .cancelled:
            panGestureDidTerminate(sender)
        default:
            return
        }
    }
    
    /**
     Called when the user drags the drawer to either move the drawer along with the drag, or cancel
     the gesture if the user drags out of bounds.
     */
    private func panGestureDidChange(_ sender: UIPanGestureRecognizer) {
        // Move the list view along with the vertical portion of the drag
        guard !shouldCancelPulleyInteraction(sender) else {
            sender.isEnabled = false
            return
        }
        moveWaterfallForPulleyInteraction(sender)
    }
    
    /**
     Handles tear down when the drawer pan gesture is ended by any means.
     */
    private func panGestureDidTerminate(_ sender: UIPanGestureRecognizer) {
        defer { sender.isEnabled = true }
        let thresholdSpeed: CGFloat = 20
        let velocity = sender.velocity(in: coordinator.view).y
        abs(velocity) > thresholdSpeed
            ? gravitateWaterfall(fromFlick: sender)
            : gravitateWaterfall(fromRelease: sender)
    }
    
    /**
     Returns true if the drawer's drag gesture should be cancelled because the user has dragged the drawer
     below or above the min and max resting positions, respectively.
     */
    private func shouldCancelPulleyInteraction(_ sender: UIPanGestureRecognizer) -> Bool {
        let currentY = coordinator.waterfallViewController.view.frame.origin.y
        let isBelowBounds = currentY > getRestingY(forPosition: .closed)
        let isAboveBounds = currentY < getRestingY(forPosition: .opened)
        return isBelowBounds || isAboveBounds
    }
    
    /**
     Moves the drawer in accordance with the user's vertical drag
     */
    private func moveWaterfallForPulleyInteraction(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: coordinator.view)
        moveDrawer(byAmount: translation.y)
        sender.setTranslation(CGPoint.zero, in: coordinator.view)  // Reset since we only want the change in y each call
    }
    
    /**
     Animates the drawer accelerating into a fixed position after the user releases the drawer.
     */
    private func gravitateWaterfall(fromRelease sender: UIPanGestureRecognizer) {
        // Check if it terminated after threshold, if so animate change
        let releasedY = sender.location(in: coordinator.view).y
        let nextPosition = closestDrawerPosition(toVerticalPosition: releasedY)
        moveDrawer(toPosition: nextPosition, animated: true)
    }
    
    /**
     Animates the drawer accelerating into a fixed position after the user flicks the drawer in a direction.
     */
    private func gravitateWaterfall(fromFlick sender: UIPanGestureRecognizer) {
        // TODO: Is this correct?
        let velocity = sender.velocity(in: coordinator.view).y
        let recentPosition = closestDrawerPosition(toVerticalPosition:
            coordinator.contentViewController.view.frame.origin.y)
        let nextPosition = velocity > 0
            ? recentPosition.previousPosition : recentPosition.nextPosition
        moveDrawer(toPosition: nextPosition ?? recentPosition, animated: true)  // One of them must have adjacent position
    }
    
    /**
     Calculates the gap between the top of the drawer in a closed position and
     the bottom of the navigation bar.
     */
    private var clearanceWhileClosed: CGFloat {
        let offset = getRestingY(forPosition: .closed)
        let navBarHeight = coordinator.contentViewController
            .navigationController?.navigationBar.frame.size.height ?? 0
        return coordinator.view.frame.height - navBarHeight - offset
    }
    
    /**
     Retuns the resting y position of drawer position state with respect to the parent view's
     coordinate system.
     */
    func getRestingY(forPosition position: DrawerPosition) -> CGFloat {
        switch position {
        case .closed:
            let navController = coordinator.waterfallViewController as? UINavigationController
            let clearance = navController?.navigationBar.frame.size.height ?? 0
            return coordinator.view.frame.size.height - clearance
        case .partial, .opened:
            let clearance = getRestingY(forPosition: .closed)
                - (coordinator.navigationController?.navigationBar.frame.size.height ?? 0)
            let factor: CGFloat = position == .partial ? 0.8 : 0.2
            return clearance * factor
        }
    }
    
    private func closestDrawerPosition(toVerticalPosition y: CGFloat) -> DrawerPosition {
        var displacements: [DrawerPosition: CGFloat] = [:]
        for position in DrawerPosition.orderedPositions {
            displacements[position] = abs(getRestingY(forPosition: position) - y)
        }
        let sortedDisplacements = displacements.sorted {
            return $0.value < $1.value
        }
        return sortedDisplacements.first!.key
    }
    
    private func moveDrawer(toPosition position: DrawerPosition, animated: Bool) {
        // Determine the delta y that needs to be applied to the drawer
        let deltaY = getRestingY(forPosition: position)
            - coordinator.waterfallViewController.view.frame.origin.y
        
        // Move the drawer and animate if needed
        let translation = {
            self.moveDrawer(byAmount: deltaY)
            
        }
        animated ? UIView.animate(withDuration: 0.3,
                                  animations: translation) : translation()
    }
    
    private func moveDrawer(byAmount amount: CGFloat) {
        self.coordinator.waterfallViewController.view.frame.origin.y += amount
        self.coordinator.waterfallViewController.view.frame.size.height -= amount
    }
}
