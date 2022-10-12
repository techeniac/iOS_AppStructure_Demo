//
//  BNCurvedPageControl.swift
//  BezierPath
//
//  Created by Bijesh on 20/12/18.
//  Copyright © 2018 Bijesh. All rights reserved.
//
import UIKit

public protocol BNCurvedPageControlDelegate: class {
    func goToPage(_ button: UIButton!)
}

open class BNCurvedPageControl: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    var path: UIBezierPath!
    open var numberOfPoints:Int = 6
    open var currentPage:Int = 0
    
    var screenScale = (UIScreen.main.bounds.width / 320.0)
    
    var pointList = [CGPoint]()
    var imgStepList = [UIButton]()
    
    var imgheight : CGFloat = 40.0
    
    var P1:CGPoint = CGPoint.init()
    var P2:CGPoint = CGPoint.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isOpaque = true
    }
    
    var imgAniView:UIButton!
    
    override open func draw(_ rect: CGRect) {
        
        if AppConstants.DeviceType.IS_IPAD {
            screenScale = 1.2
        }
        
        imgheight = 40.0 * screenScale
        
        plotButtons(x: numberOfPoints)
        goToIndicator(x: currentPage)
        
        createCurve()
        
        UIColor.clear.setFill()
        path.fill()
        
        changeStepImage(step: currentPage, newStep: currentPage)
    }
    
    func createCurve() {
        
        imgAniView = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: imgheight, height: imgheight))
        imgAniView.backgroundColor = UIColor.clear
        imgAniView.isHidden = true
        imgAniView.clipsToBounds = true
        imgAniView.tag = 100
        imgAniView.isUserInteractionEnabled = false
        imgAniView.setImage(UIImage(named: "blue_current"), for: UIControl.State.normal)
        self.addSubview(imgAniView)
        
        P1 = CGPoint(x: pointList[0].x+(imgheight/2), y: pointList[0].y+(imgheight/2))
        P2 = CGPoint(x: pointList[2].x+(imgheight/2), y: pointList[2].y+(imgheight/2))
        
        path = UIBezierPath()
        //        path.lineWidth = 3.0
        path.lineJoinStyle = .round
        
        path.move(to: CGPoint(x: -10, y: P1.y - (8 * screenScale)))
        
        path.addQuadCurve(to: P1, controlPoint: CGPoint(x: pointList[0].x / 2 + 40, y: pointList[0].y + (screenScale * 10)))
        
        let cntPoint = CGPoint(x: pointList[0].x + (pointList[2].x - pointList[0].x) + (screenScale * 25) , y: pointList[0].y + ((pointList[1].y - pointList[0].y) / 2) + (screenScale * 20))
        path.addQuadCurve(to: P2, controlPoint: cntPoint)
        
        path.addLine(to: CGPoint(x: (pointList.last?.x ?? 0) + (imgheight/2), y: self.frame.height))
        
        path.addLine(to: CGPoint(x: 0, y: self.frame.height+50))
        
        for vw in self.subviews {
            if (vw.tag == 500) {
                
                path.close()
                
                let s = CAShapeLayer()
                s.fillColor = UIColor.white.cgColor
                s.frame = layer.bounds
                s.path = path.cgPath
                
                vw.layer.backgroundColor = UIColor.clear.cgColor
                vw.layer.addSublayer(s)
                
                vw.layer.masksToBounds = true
                vw.layer.shadowColor = UIColor.black.withAlphaComponent(0.23).cgColor
                vw.layer.shadowOffset = CGSize(width: 5, height: -5)
                vw.layer.shadowOpacity = 1.0
                vw.layer.shadowPath = path.cgPath
                vw.layer.shadowRadius = 5
            }
        }
    }
    
    private func plotButtons(x:Int){
        
        for i in 0...x-1 {
            
            var xPosition:CGFloat = self.frame.size.width - imgheight
            
            var yPosition:CGFloat = ((self.frame.size.height) / CGFloat(numberOfPoints)) * CGFloat(i)
            
            if i == 0 {
                xPosition -= (AppConstants.DeviceType.IS_IPAD ? 170 : 125) * screenScale
            }
            else if i == 1 {
                yPosition -= 26 * screenScale
                xPosition -= 27 * screenScale
            }
            else {
                xPosition -= 10 * screenScale
                yPosition -= 30 * screenScale
            }
            
            pointList.append(CGPoint(x: xPosition, y: yPosition))
            
            let imgStepView:UIButton = UIButton.init(frame: CGRect.init(x: xPosition, y: yPosition, width: imgheight, height: imgheight))
            imgStepView.backgroundColor = UIColor.clear
            imgStepView.tag = i
            imgStepView.setImage(UIImage.init(named: "grey_pending"), for: .normal)
            imgStepView.clipsToBounds = true
            imgStepView.isUserInteractionEnabled = false
            self.addSubview(imgStepView)
            
            imgStepList.append(imgStepView)
        }
    }
    
    open func goToIndicator(x:Int) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        if (path != nil) {
            
            let startPoint = currentPage
            let endPoint = x
            
            imgAniView.frame.origin = CGPoint(x:  pointList[startPoint].x + (imgheight / 2), y:  pointList[startPoint].y + (imgheight / 2))
            
            imgAniView.isHidden = false
            
            let keyFrameAnimation = CAKeyframeAnimation(keyPath:"position")
            
            let mutablePath = CGMutablePath()
            mutablePath.move(to: imgAniView.frame.origin)
            
            
            if (x > 2 || currentPage > 2) {
                // Line
                mutablePath.addLine(to:  CGPoint(x:  pointList[endPoint].x + (imgheight / 2), y:  pointList[endPoint].y + (imgheight / 2)))
            }
            else {
                if ((startPoint == 2 && endPoint == 1) || (startPoint == 1 && endPoint == 2))
                {
                    if (startPoint == 1 && endPoint == 2) {
                        mutablePath.addQuadCurve(to: CGPoint(x:  pointList[endPoint].x + (imgheight / 2), y:  pointList[endPoint].y + (imgheight / 2)), control: CGPoint(x:  pointList[startPoint].x + (imgheight), y:  pointList[endPoint].y + (imgheight/2)))
                    }
                    else {
                        mutablePath.addQuadCurve(to: CGPoint(x:  pointList[endPoint].x + (imgheight / 2), y:  pointList[endPoint].y + (imgheight / 2)), control: CGPoint(x:  pointList[endPoint].x + (imgheight), y:  pointList[startPoint].y + (imgheight/2)))
                    }
                }
                else {
                    mutablePath.addQuadCurve(to: CGPoint(x:  pointList[endPoint].x + (imgheight / 2), y:  pointList[endPoint].y + (imgheight / 2)), control: CGPoint(x: pointList[1].x + imgheight / 2 - (5 * screenScale), y:  pointList[0].y + imgheight + (5 * screenScale)))
                }
            }
            
            keyFrameAnimation.path = mutablePath
            keyFrameAnimation.duration = 0.6
            keyFrameAnimation.fillMode = CAMediaTimingFillMode.forwards
            
            keyFrameAnimation.isRemovedOnCompletion = true
            
            self.imgAniView.layer.add(keyFrameAnimation, forKey: "animation")
            changeStepImage(step: currentPage, newStep: x)
            self.perform(#selector(hideBtn), with: nil, afterDelay: 0.6)
        }
        else {
            changeStepImage(step: currentPage, newStep: x)
        }
        currentPage = x
    }
    
    @objc func hideBtn() {
        self.imgAniView.isHidden = true
        changeStepImage(step: currentPage, newStep: currentPage)
    }
    
    func changeStepImage(step: Int, newStep: Int) {
        if (path == nil) {
            return
        }
        
        let imgName = (newStep == step) ? "blue_current" : (step > newStep) ? "grey_pending" : "blue_done"
        imgStepList[step].setImage(UIImage(named: imgName), for: .normal)        
    }
    
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
        
    }
}
