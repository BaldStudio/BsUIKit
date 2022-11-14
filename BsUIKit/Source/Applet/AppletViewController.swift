//
//  AppletViewController.swift
//  BsCoreServices
//
//  Created by crzorz on 2022/5/19.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

import UIKit

class AppletViewController: UIViewController {
    weak var applet: Applet?

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        popAppletIfNeeded()
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        popAppletIfRemoved(from: parent)
    }
    
    func popAppletIfNeeded() {
        
        guard let trasnCoor = transitionCoordinator else {
            logger.debug("transitionCoordinator is nil；ARE YOU KIDDING ME?")
            return
        }
        
        trasnCoor.animate(alongsideTransition: nil) {
            
            // 检查转场状态
            
            if $0.isCancelled {
                logger.debug("取消操作：滑动返回")
                return
            }

            if $0.presentationStyle == .none {
                logger.debug("转场类型为 push/pop")
                return
            }

            // 检查转场上下文信息
            
            guard let fromApplet = self.applet else {
                logger.debug("\(self) 所属的 Applet 为 nil")
                return
            }

            guard let vc = $0.viewController(forKey: .to) else {
                logger.debug("转场的目标控制器为 nil")
                return
            }
            
            guard let toVC = vc as? AppletViewController else {
                logger.debug("目标控制器不是 AppletViewController 类型, 无需切换 Applet")
                return
            }
            
            guard let toApplet = toVC.applet else {
                logger.debug("\(self) 所属的 Applet 为 nil")
                return
            }

            logger.debug("from \(fromApplet.description)")
            logger.debug("to \(toApplet.description)")

            if AppletManager.lastAppet == fromApplet {
                logger.debug("更新应用栈数据，当前栈顶 \(fromApplet.description)")
                AppletManager.pop()
            }
        }
    }
    
    func popAppletIfRemoved(from parent: UIViewController?) {
        guard parent == nil else {
            logger.debug("当前控制器被添加到\(parent!)")
            return
        }
        
        guard let vc = BsContext.navigationController?.topViewController else {
            logger.debug("导航栈是空的")
            return
        }
        
        guard let toVC = vc as? AppletViewController else {
            logger.debug("目标控制器不是 AppletViewController 类型, 无需切换 Applet")
            
            if let topApplet = AppletManager.lastAppet {
                /*
                 前置的是普通ViewController，不是Applet根视图
                 所以栈同步需要放在这里去做掉
                */
                logger.debug("更新应用栈数据，当前栈顶 \(topApplet.description)")
                AppletManager.pop()
            }
            return
        }
        
        guard let toApplet = toVC.applet else {
            logger.debug("\(self) 所属的 Applet 为 nil")
            return
        }

        logger.debug("更新应用栈数据，当前栈顶 \(toApplet.description)")
        
        AppletManager.pop()
    }

}

