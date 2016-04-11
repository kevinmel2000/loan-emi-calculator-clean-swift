//
//  EmiCalculatorConfigurator.swift
//  EmiCalculator
//
//  Created by Tirupati Balan on 11/04/16.
//  Copyright (c) 2016 CelerStudio. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension EmiCalculatorViewController: EmiCalculatorPresenterOutput
{
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  {
    router.passDataToNextScene(segue)
  }
}

extension EmiCalculatorInteractor: EmiCalculatorViewControllerOutput
{
}

extension EmiCalculatorPresenter: EmiCalculatorInteractorOutput
{
}

class EmiCalculatorConfigurator
{
  // MARK: Object lifecycle
  
  class var sharedInstance: EmiCalculatorConfigurator
  {
    struct Static {
      static var instance: EmiCalculatorConfigurator?
      static var token: dispatch_once_t = 0
    }
    
    dispatch_once(&Static.token) {
      Static.instance = EmiCalculatorConfigurator()
    }
    
    return Static.instance!
  }
  
  // MARK: Configuration
  
  func configure(viewController: EmiCalculatorViewController)
  {
    let router = EmiCalculatorRouter()
    router.viewController = viewController
    
    let presenter = EmiCalculatorPresenter()
    presenter.output = viewController
    
    let interactor = EmiCalculatorInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
