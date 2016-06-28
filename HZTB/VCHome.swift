//
//  VCHome.swift
//  HZTB
//
//  Created by Pivotal on 5/25/16.
//  Copyright © 2016 pivotaldesign.biz. All rights reserved.
//

import UIKit

// MARK: VCHome is ViewController
class VCHome: UIViewController {
    
    let interactor = Interactor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        print("VCHome : viewDidLoad")
        NSNotificationCenter.defaultCenter().addObserver( self, selector:#selector(onRegistrationNotification), name: PIVDStaticNames.REGISTRATION_SUCCESS, object: nil )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
        
    }
    
    
    @objc private func onRegistrationNotification(data:NSObject){
        print("VCHome : onRegistrationNotification ================ ")
        print(data)
        print("VCHome : onRegistrationNotification / ================ ")
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("VCHome : prepareForSegue")
        if let destinationViewController = segue.destinationViewController as? VCSlideMenu {
            destinationViewController.transitioningDelegate = self
            // 2
            destinationViewController.interactor = interactor
        }
    }
    
    // MARK: Expose to Storyboard
    @IBAction func openMenu(sender: AnyObject) {
        performSegueWithIdentifier("openMenu", sender: nil)
    }
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .Right)
        MenuHelper.mapGestureStateToInteractor( sender.state, progress: progress, interactor: interactor){
            self.performSegueWithIdentifier("openMenu", sender: nil)
        }
    }
    @IBAction func showRegistrationView(sender:AnyObject){
        print("showRegistrationView");
        /*
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *initViewController = [storyboard instantiateViewControllerWithIdentifier:@"sid_registration"];
        */
        
        /*
        let vc = ViewController() //change this to your class name
        self.presentViewController(vc, animated: true, completion: nil)
        */
        
        /*
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("sid_registration")
        //self.presentViewController(vc!, animated: true, completion: nil)
        navigationController?.pushViewController(vc!, animated: true)
        */
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("sid_registration") as! VCRegistration
        //self.presentViewController(vc, animated: true, completion: nil)
        //navigationController?.presentViewController(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



// MARK: Extension of the VCHome
extension VCHome: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    // 3
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

// MARK: Camera button for URLScheme test
extension VCHome {
    @IBAction func onURLSchemeTest(sender:AnyObject){
        print("onURLSchemeTest")
        //let n:NSURL = NSURL(string: "")!
        //UIApplication.sharedApplication().openURL(NSURL(fileURLWithPath: "hztbuddy://test_page/one?token=12345&domain=foo.com"))
    }
}

