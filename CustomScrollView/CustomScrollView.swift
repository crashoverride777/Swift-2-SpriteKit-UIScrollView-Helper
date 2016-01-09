
//  Created by Dominik on 22/08/2015.

//    The MIT License (MIT)
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

//    Dont forget to add the custom "-D DEBUG" flag in Targets -> BuildSettings -> SwiftCompiler-CustomFlags -> DEBUG)

//    v1.0  

import SpriteKit

var nodesTouched: [AnyObject] = [] // global

class CustomScrollView: UIScrollView {
    
    // MARK: - Static Properties
    
    /// Touches allowed
    static var disabledTouches = false
    
    /// Scroll view
    private static var scrollView: UIScrollView!
    
    // MARK: - Properties
    
    /// Current scene
    private var currentScene: SKScene?
    
    /// Moveable node
    private var moveableNode: SKNode?
    
    // MARK: - Init
    init(frame: CGRect, scene: SKScene, moveableNode: SKNode) {
        print("Scroll View init")
        super.init(frame: frame)
        
        CustomScrollView.scrollView = self
        currentScene = scene
        self.moveableNode = moveableNode
        self.frame = frame
        indicatorStyle = .White
        scrollEnabled = true
        //self.minimumZoomScale = 1
        //self.maximumZoomScale = 3
        canCancelContentTouches = false
        userInteractionEnabled = true
        delegate = self
        
        // flip for spritekit (only needed for horizontal)
        //let verticalFlip = CGAffineTransformMakeScale(-1,-1)
        //self.transform = verticalFlip
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Touches
extension CustomScrollView {
    
    /// began
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Touch began scroll view")
        
        guard !CustomScrollView.disabledTouches else { return }
        currentScene?.touchesBegan(touches, withEvent: event)
    }
    
    /// moved
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Touch moved scroll view")
        
        guard !CustomScrollView.disabledTouches else { return }
        currentScene?.touchesMoved(touches, withEvent: event)
    }
    
    /// ended
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Touch ended scroll view")
        
        guard !CustomScrollView.disabledTouches else { return }
        currentScene?.touchesEnded(touches, withEvent: event)
    }
    
    /// cancelled
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        print("Touch cancelled scroll view")
        
        guard !CustomScrollView.disabledTouches else { return }
        currentScene?.touchesCancelled(touches, withEvent: event)
    }
}

// MARK: - Touch Controls
extension CustomScrollView {
    
    /// Disable
    class func disable() {
        print("Disabled scroll view")
        CustomScrollView.scrollView?.userInteractionEnabled = false
        CustomScrollView.disabledTouches = true
    }
    
    /// Enable
    class func enable() {
        print("Enabled scroll view")
        CustomScrollView.scrollView?.userInteractionEnabled = true
        CustomScrollView.disabledTouches = false
    }
}

// MARK: - Delegates
extension CustomScrollView: UIScrollViewDelegate {
    
    /// did scroll
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("Scroll view did scroll")
        
        /// Left-Right
        //moveableNode!.position.x = scrollView.contentOffset.x
        
        /// Up-Downm
        moveableNode!.position.y = scrollView.contentOffset.y
    }
}
