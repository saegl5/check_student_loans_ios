//
//  MyMainPage.swift
//  Student Loans
//
//  Created by Ed Silkworth on 10/9/15.
//  Copyright © 2015-2019 Ed Silkworth. All rights reserved.
//

import UIKit
import AVKit

class MyMainPage: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    //------------------------------------------
    //  KEEP INTEREST RATES UPDATED
    //  CONSULT: https://studentaid.ed.gov/sa/types/loans/interest-rates
    //
    //  Loan Types: Direct Subsidized Loans & Direct Unsubsidized Loans
    //  Borrower Type: Undergraduate
        internal var APR_DIRECT = 4.45 //% (if rates are ever different, pick the higher one)
    //
    //  Loan Types: Perkins Loans
        internal var APR_PERKINS = 5.00 //%
    //------------------------------------------
    //  Notes:
    //  (1) Theoretically, to round an amount to the nearest cent, use round(amount*100)/100.
    //      However, iOS sometimes rounds the remainder .##4999... down (e.g., 2.454999... to 2.45).
    //      So, test the remainder: (let amount be "a")
    //
    //          if (a*100 - floor(a*100) > 0.499999) && (a*100 - floor(a*100) < 0.5)
    //              { a = round(a*100 + 1)/100 }
    //          else { a = round(a*100)/100 }
    //
    //      Using 2.454999... as an example:
    //
    //          2.454999...*100 = 245.4999...
    //          floor(245.4999...) = 245
    //          So, 245.4999... - 245 = 0.4999...
    //          Meaning, 0.4999... > 0.499999 && 0.4999... < 0.5 are true
    //
    //          Therefore, a = round(245.4999... + 1)/100
    //          = round(246.4999...)/100
    //          = 256/100 = 2.56
    //
    //  (2) If one casts a Double as an Integer, iOS will simply truncate the decimal part of a number.
    //      For example, Int(38.999...) = 38, even though 38.999... = 39. So, test the remainder:
    //
    //          if (a - floor(a) > 0.99999)
    //              { a = Int(a + 1) }
    //          else { a = Int(a) }
    //
    //      Using 38.999... as an example:
    //
    //          floor(38.999...) = 38
    //          So, 38.999... - 38 = 0.999...
    //          Meaning, 0.999... > 0.99999 is true
    //
    //          Therefore, a = Int(38.999... + 1)
    //          = Int(39.999...) = 39

//    let decision = false // false = No, true = Yes, default is false

//    @IBOutlet weak var splash_screen: UIView! //for old splash screen
//    @IBOutlet weak var step_1: UIImageView! //for old splash screen
//    @IBOutlet weak var step_2: UIImageView! //for old splash screen
//    @IBOutlet weak var step_3: UIImageView! //for old splash screen
//    @IBOutlet weak var step_4: UIImageView! //for old splash screen
//    @IBOutlet weak var disregard: UIButton! //for old splash screen
    @IBOutlet weak var loaned_title: UILabel!
    
    @IBOutlet weak var loaned: UISlider!
    @IBOutlet weak var loaned_minimum: UILabel!
    @IBOutlet weak var loaned_min_input: UITextField!
    @IBOutlet weak var loaned_max_input: UITextField!
    @IBOutlet weak var stack_min: UIStackView!
    @IBOutlet weak var stack_max: UIStackView!
    //horizontally center each stack to slider, then double-click their constraints to align their centers to leading/trailing edge of slider
    
    //@IBOutlet weak var input_background: UIView!
    @IBOutlet weak var stack_inputs: UIStackView!
    @IBOutlet weak var even_out: UILabel!
    @IBOutlet weak var stack_inputs_down: UIStackView!
    @IBOutlet weak var stack_inputs_timers_down: UIStackView!
    @IBOutlet weak var down_sign: UILabel!
    @IBOutlet weak var down_number: UITextField!
    @IBOutlet weak var up_sign: UILabel!
    @IBOutlet weak var up_number: UITextField!
    
    @IBOutlet weak var down_timer1: UIImageView!
    @IBOutlet weak var down_timer2: UIImageView!
    @IBOutlet weak var down_timer1_seconds: UITextField!
    var set_down_timer1_seconds = 2.0 //2*4=8 quarter seconds
    @IBOutlet weak var down_timer2_seconds: UITextField!
    var set_down_timer2_seconds = 4.0 //4*4=16 quarter seconds
    @IBOutlet weak var down_timer1_seconds_label: UILabel!
    @IBOutlet weak var down_timer2_seconds_label: UILabel!
    @IBOutlet weak var down_timer1_increment: UITextField!
    var set_down_timer1_increment = 100.0
    @IBOutlet weak var down_timer2_increment: UITextField!
    var set_down_timer2_increment = 1000.0
    
    @IBOutlet weak var stack_inputs_up: UIStackView!
    @IBOutlet weak var stack_inputs_timers_up: UIStackView!
    
    @IBOutlet weak var up_timer1: UIImageView!
    @IBOutlet weak var up_timer2: UIImageView!
    @IBOutlet weak var up_timer1_seconds: UITextField!
    var set_up_timer1_seconds = 2.0 //2*4=8 quarter seconds
    @IBOutlet weak var up_timer2_seconds: UITextField!
    var set_up_timer2_seconds = 4.0 //4*4=16 quarter seconds
    @IBOutlet weak var up_timer1_seconds_label: UILabel!
    @IBOutlet weak var up_timer2_seconds_label: UILabel!
    @IBOutlet weak var up_timer1_increment: UITextField!
    var set_up_timer1_increment = 100.0
    @IBOutlet weak var up_timer2_increment: UITextField!
    var set_up_timer2_increment = 1000.0

    
    @IBOutlet weak var increment_input_left_label: UILabel!
    @IBOutlet weak var increment_input: UITextField!
    @IBOutlet weak var increment_input_right_label: UILabel!
    @IBOutlet weak var input_number_of_increments: UITextField!
    @IBOutlet weak var bare_track: UIImageView!
    @IBOutlet weak var loaned_maximum: UILabel! //somehow got shifted down here
    @IBOutlet weak var apr_title: UILabel!
    @IBOutlet weak var apr: UISwitch!
    @IBOutlet weak var edit_slider: UIButton!
    @IBOutlet weak var edit_apr: UIButton!
    @IBOutlet weak var edit_pay: UIButton!
    @IBOutlet weak var submit_changes: UIButton!
    @IBOutlet weak var submit_changes_apr: UIButton!
    @IBOutlet weak var submit_changes_pay: UIButton!
    @IBOutlet weak var interest_rate_unpressed: UIButton!
    @IBOutlet weak var interest_rate_unpressed_copy: UIButton!
    @IBOutlet weak var interest_rate_pressed: UIButton!
    @IBOutlet weak var interest_rate_pressed_copy: UIButton!
    @IBOutlet weak var interest_rate_disabled: UIButton!
    
    @IBOutlet weak var invisible: UIButton!
    @IBOutlet weak var edit_apr_text: UIStackView!
    @IBOutlet weak var invisible_back: UIButton!
    @IBOutlet weak var edit_apr_text_back: UIStackView!
    @IBOutlet weak var apr_number: UITextField!
    @IBOutlet weak var apr_number_back: UITextField!
    @IBOutlet weak var apr_sign: UILabel!
    @IBOutlet weak var edit_pay_text: UIStackView!
    @IBOutlet weak var pay_sign: UILabel!
    @IBOutlet weak var pay_number: UITextField!
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var down_unpressed: UIButton!
    @IBOutlet weak var down_pressed: UIButton!
    @IBOutlet weak var pay_monthly_title: UILabel!
    @IBOutlet weak var pay_monthly_box: UILabel!
    @IBOutlet weak var up_unpressed: UIButton!
    @IBOutlet weak var up_pressed: UIButton!
    @IBOutlet weak var minimum: UILabel!
    @IBOutlet weak var abs_10yr: UIStackView!
    @IBOutlet weak var absolute: UIButton!
    @IBOutlet weak var tenyr: UIButton!
    @IBOutlet weak var time_title: UILabel!
    @IBOutlet weak var years: UILabel!
    @IBOutlet weak var years_text: UILabel!
    @IBOutlet weak var months: UILabel!
    @IBOutlet weak var months_text: UILabel!
    @IBOutlet weak var savings_title: UILabel!
    @IBOutlet weak var savings: UILabel!
    @IBOutlet weak var savings_change: UILabel!
    @IBOutlet var swipe: UISwipeGestureRecognizer!
    @IBOutlet weak var locked: UIButton!
    @IBOutlet weak var unlocked: UIButton!
    @IBOutlet weak var swipe_label: UILabel! //indicates if swipe is enabled or not
    @IBOutlet weak var swipe_note: UILabel! //just says, "swipe"
    @IBOutlet weak var swiping: UIButton!
    @IBOutlet weak var stopped: UIButton!
    @IBOutlet weak var swipe_blink: UILabel!
    @IBOutlet weak var suggest: UILabel!
    
    @IBOutlet weak var layout_interest_rate: NSLayoutConstraint!
    @IBOutlet weak var layout_minimum: NSLayoutConstraint!
    @IBOutlet weak var layout_savings: NSLayoutConstraint!
    @IBOutlet weak var layout_loaned: NSLayoutConstraint!
    @IBOutlet weak var layout_months: NSLayoutConstraint!
    @IBOutlet weak var layout_stack_min: NSLayoutConstraint!
    @IBOutlet weak var layout_stack_max: NSLayoutConstraint!
    @IBOutlet weak var layout_loaned_trailing: NSLayoutConstraint!
    @IBOutlet weak var layout_loaned_leading: NSLayoutConstraint!
    @IBOutlet weak var loaned_height: NSLayoutConstraint!
    @IBOutlet weak var stack_Y: NSLayoutConstraint!
    @IBOutlet weak var loaned_Y: NSLayoutConstraint!
//    @IBOutlet weak var splash_width: NSLayoutConstraint!
//    @IBOutlet weak var splash_height: NSLayoutConstraint!
//    @IBOutlet weak var step1height: NSLayoutConstraint!
//    @IBOutlet weak var step2height: NSLayoutConstraint!
//    @IBOutlet weak var step3height: NSLayoutConstraint!
    @IBOutlet weak var absmin: UILabel!
    @IBOutlet weak var tenyrmin: UILabel!
    @IBOutlet weak var linemin: UIImageView!
    
    
    var min_value = 2000.0
    var max_value = 10000.0
    var number_of_increments = 40.0 //20 is optimal
    var unlocked_indicator = 0 //1 if locked, 0 if not
    var tenyr_indicator = 0.0
    lazy var increment = (max_value - min_value)/number_of_increments//that is, "increment size"
    lazy var progress = min_value
    
    internal lazy var p = min_value
    internal lazy var i = APR_DIRECT / 12 / 100 //need to convert to periodic rate in decimal form
    //i is essentially espilon
    internal lazy var i_reference = APR_DIRECT / 12 / 100
    internal var savings_reference = 0.00
    internal lazy var a = min_value * APR_DIRECT / 12 / 100 + 0.01 //values are cast in viewDidLoad()
    internal lazy var a_reference = min_value * APR_DIRECT / 12 / 100 + 0.01 //brought back because of + - buttons
    internal var numberFormatter:NumberFormatter = NumberFormatter()
    let shared_preferences: UserDefaults = UserDefaults.standard
    lazy var rates = [String(format: "%.2f",APR_DIRECT), String(format: "%.2f",APR_PERKINS)]//for apr_number and its back
    lazy var rates_text = [String(format: "%.2f",APR_DIRECT) + "% - Direct Loan", String(format: "%.2f",APR_PERKINS) + "% - Perkins Loan"]//for table
    lazy var rates_reference = [APR_DIRECT / 12 / 100, APR_PERKINS / 12 / 100, Double()] //rates_reference[2] will store custom rate
    /*let loaned_subview = UIView()*/
    //let bubble_label = UILabel(frame: CGRect(x: -30, y: -5, width: 80, height: -32))
    var bubble_label = UILabel(frame: CGRect(x: -30, y: -5, width: 80, height: -32))
    let bubble_label_arrow = UILabel(frame: CGRect(x: 4.5, y: -5, width: 14, height: 7))
    


//    var step_1_images = [UIImage]() //for old splash screen
//    var step_2_images = [UIImage]() //for old splash screen
//    var step_3_images = [UIImage]() //for old splash screen
//    var bottom_images = [UIImage]() //for old splash screen
//    var slide_images = [UIImage]() //for old splash screen

    var timer1 = Timer()
    var timer2 = Timer()
//    var timer_step = Timer()
    var down_button_increment = 50.0
    var temp_down = 50.0
    var up_button_increment = 50.0
    var temp_up = 50.0
    var timer_count = 0.0
//    var splash_timer_count = 0 //for old splash screen
//    let step_1_background = UIImageView() //for old splash screen
//    let step_2_background = UIImageView() //for old splash screen
//    let splash_screen_background = UIImageView() //for old splash screen
//    let tip_1 = UILabel() //for old splash screen
//    let tip_2 = UILabel() //for old splash screen
//    let tip_3 = UILabel() //for old splash screen
//    let tip_4 = UILabel() //for old splash screen
    
    @IBOutlet weak var edit_slider_shape: UIView!
    let edit_slider_shape_tweak = CAShapeLayer()
    @IBOutlet weak var edit_apr_shape: UIView!
    let edit_apr_shape_tweak = CAShapeLayer()
    let edit_apr_shape_tweak_trianglePath = UIBezierPath()
    let edit_apr_shape_tweak_triangleLayer = CAShapeLayer()
    let switch_outline = CAShapeLayer()
    let switch_thumb_outline = CAShapeLayer()
    let interest_rate_unpressed_outline = CAShapeLayer()
    @IBOutlet weak var edit_pay_shape: UIView!
    let edit_pay_shape_tweak = CAShapeLayer()
    let down_outline = CAShapeLayer()
    let pay_outline = CAShapeLayer()
    let up_outline = CAShapeLayer()
    
    @IBOutlet weak var question: UIButton!
    //let swipe_tab_shape_path = UIBezierPath()
    //let swipe_tab_shape_path_layer = CAShapeLayer()
    //let swipe_stop_tab_shape_path = UIBezierPath()
    //let swipe_stop_tab_shape_path_layer = CAShapeLayer()
    
//    @IBAction func Splash(_ sender: UIButton) { //for old splash screen
////        splash_screen.isHidden = true
//        splash_screen_background.isHidden = true
////        timer_step.invalidate() //needed?
//        splash_timer_count = -1 //make sure exiting loop
//        tip_1.isHidden = true
//        tip_2.isHidden = true
//        tip_3.isHidden = true
//        //tip_3.text = "" //just in case tip tries to appear again
//        tip_4.isHidden = true
////        step_1.isHidden = true
////        step_2.isHidden = true
////        step_3.isHidden = true
////        step_4.isHidden = true
//        step_1_background.isHidden = true
//        step_2_background.isHidden = true
//        //swipe.isEnabled = true
//        //minimum.isHidden = false
//    }
//
////    func Step_Main() {
////        timer_step = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MyMainPage.Step_Instructions), userInfo: nil, repeats: false)
////    }
//
//    @objc func Step_Instructions() {
//
//        if (splash_timer_count == 0) {
//            /*step_1.frame = CGRect(x: step_1.frame.origin.x, y: step_1.frame.origin.y, width: step_1.frame.width, height: 140.5)*/
//            /*print(step_1.frame.origin.x,step_1.frame.origin.y,terminator: " ")*/
//
//            tip_1.frame = CGRect(x: 25, y: -step_2.frame.height, width: view.frame.maxX-50, height: view.frame.maxY)
//            tip_1.bounds = view.frame
//            tip_1.text = "Select estimated cost"
//            tip_1.textAlignment = .center
//            tip_1.numberOfLines = 0
//            tip_1.textColor = UIColor.white
//            tip_1.font = UIFont.boldSystemFont(ofSize: 26.0)
//            let frame_height_temp = step_1.frame.height
//            //print(frame_height_temp, step_1.frame.height,terminator: "\n")
//
//
//
//            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                //start at (0,0), that is top-left, of frame width and frame height
//                //gradually, move to (0,frame height), of frame width but 0 height
////                self.step_1.frame = CGRect(x: self.step_1.frame.origin.x, y: self.step_1.frame.origin.y+self.step_1.frame.height, width: self.step_1.frame.width, height: 0)
//                //i think the 0.5 had something to do with a screenshot mistake
//                /*print(self.step_1.frame.origin.x,self.step_1.frame.origin.y,terminator: " ")*/
//
//                }, completion: {
//                    //once finished, NOT! gradually finish
//                    (finished: Bool) -> Void in
//
//                    self.step_2_background.frame = CGRect(x: self.step_2.frame.origin.x, y: self.step_2.frame.origin.y, width: self.step_2.frame.width, height: self.step_2.frame.height) //shifted a little
//                    self.splash_screen.addSubview(self.step_2_background)
//                    self.step_2.backgroundColor = nil
//                    self.step_2_background.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.85)
//
//
//                    self.tip_1.isHidden = false
//                    self.step_2_background.addSubview(self.tip_1)
//                    self.step_2_background.bringSubviewToFront(self.tip_1)
//
////                    self.Step_Main()
//                    self.splash_timer_count += 1
//                    self.step_1.frame = CGRect(x: self.step_1.frame.origin.x, y: self.step_1.frame.origin.y-frame_height_temp, width: self.step_1.frame.width, height: frame_height_temp)
//                    /*print(self.step_1.frame.origin.x,self.step_1.frame.origin.y,terminator: " ")*/
//
////                    self.step_1.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.0)
//            })
//        }
//
//        else if (splash_timer_count <= step_1_images.count) {
//
////            self.Step_Main()
//            step_1.image = step_1_images[splash_timer_count-1]
//            splash_timer_count += 1
//            /*print(step_1_images.count-1)*/
//            }
//
//        else if (splash_timer_count == step_1_images.count+1) {
//            tip_1.isHidden = true
//
//            tip_2.frame = CGRect(x: 25, y: -step_2.frame.height, width: view.frame.maxX-50, height: view.frame.maxY)
//            tip_2.bounds = view.frame
//            tip_2.text = "Select interest rate"
//            tip_2.textAlignment = .center
//            tip_2.numberOfLines = 0
//            tip_2.textColor = UIColor.white
//            tip_2.font = UIFont.boldSystemFont(ofSize: 26.0)
//            let frame_height_temp = step_1.frame.height
//
//            //frame height already included the 0.5, since frame height continually updated, so i took it out
//
//            if (view.frame.height == 568) {
//                step_1_background.image = UIImage(named: "s11se.png")
//            }
//            else if (view.frame.height == 667) {
//                step_1_background.image = UIImage(named: "s11.png")
//            }
//            else {
//                step_1_background.image = UIImage(named: "s11p.png")
//            }
//
//            step_1_background.frame = CGRect(x: 0, y: 0, width: step_1.frame.width, height: step_1.frame.height)
////            splash_screen.addSubview(step_1)
//            splash_screen.addSubview(step_1_background)
//            splash_screen.bringSubviewToFront(step_1)
//            step_1.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.85)
//            step_1.image = nil
//            step_1.frame = CGRect(x: step_1.frame.origin.x, y: step_1.frame.origin.y, width: step_1.frame.width, height: 0)
//            /*step_2.frame = CGRect(x: self.step_2.frame.origin.x, y: self.step_2.frame.origin.y, width: self.step_2.frame.width, height: 242)*/
//            //VERY ODD!!!!
//
//            //hard keeping track of positions
//            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                self.step_1.frame = CGRect(x: self.step_1.frame.origin.x, y: self.step_1.frame.origin.y, width: self.step_1.frame.width, height: frame_height_temp)
//                //this time leaving y be so that the animation is fluid
//                /*self.step_2.frame = CGRect(x: self.step_2.frame.origin.x, y: self.step_2.frame.origin.y+242, width: self.step_2.frame.width, height: 0)*/
//                self.step_2_background.frame = CGRect(x: self.step_2.frame.origin.x, y: self.step_2.frame.origin.y+self.step_2.frame.height, width: self.step_2.frame.width, height: 0)
//
//                /*print(self.step_2.frame.origin.x,self.step_2.frame.origin.y,terminator: " ")*/
//
//                /*let step_dot = UIImageView()
//                step_dot.backgroundColor = UIColor(red: 0.0/255, green: 255.0/255, blue: 0.0/255, alpha: 0.75)
//                step_dot.frame = CGRect(x: self.step_2.frame.origin.x, y: self.step_2.frame.origin.y, width: self.step_2.frame.width, height: 1)
//                self.splash_screen.addSubview(step_dot)*/
//
//            }, completion: {
//                (finished: Bool) -> Void in
//                self.tip_2.isHidden = false
//                self.step_1.addSubview(self.tip_2)
//                self.step_1.bringSubviewToFront(self.tip_2)
////                self.Step_Main()
//                self.splash_timer_count += 1
//                self.step_2.image = self.step_2_images[0]
//                /*self.step_2.frame = CGRect(x: self.step_2.frame.origin.x, y: self.step_2.frame.origin.y-242, width: self.step_2.frame.width, height: 242)
//                self.step_2.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.0)*/
//            })
//        }
//
//        else if (splash_timer_count <= step_1_images.count+step_2_images.count) {
//            /*step_1.image = step_1_images[0]*/
////            self.Step_Main()
//
//            step_2.image = step_2_images[splash_timer_count-step_1_images.count-1]
//            //print("step_2[",splash_timer_count-step_1_images.count-1,"]",terminator:"\n")
//
//            splash_timer_count += 1
//
//
//            if (splash_timer_count == step_1_images.count+step_2_images.count) {
//                tip_2.text = "...or none"
//
//            }
//            /*else if (splash_timer_count == step_1_images.count+step_2_images.count+1) {
//                minimum.isHidden = true //hide "minimum" when it should hide
//
//            }*/
//        }
//
//        else if (splash_timer_count == step_1_images.count+step_2_images.count+1) {
//            tip_2.isHidden = true
//
//            tip_3.frame = CGRect(x: 25, y: -step_3.frame.height-130, width: view.frame.maxX-50, height: view.frame.maxY)
//            tip_3.bounds = view.frame
//            tip_3.text = "Select monthly payment"
//            tip_3.textAlignment = .center
//            tip_3.numberOfLines = 0
//            tip_3.textColor = UIColor.white
//            tip_3.font = UIFont.boldSystemFont(ofSize: 26.0)
//
//
//            if (view.frame.height == 568) {
////                step_2.image = UIImage(named: "s1se_cX.png")
//                //s1_cX2
//            }
//            else if (view.frame.height == 667) {
////                step_2.image = UIImage(named: "s1_cX.png")
//                //s1_cX2
//            }
//            else {
////                step_2.image = UIImage(named: "s1p_cX.png")
//                //s1_cX2
//            }
//
//
//            let frame_height_temp = step_3.frame.height
//
//            /*let step_1_background = UIImageView()
//            step_1_background.image = UIImage(named: "s11.png")*/
//            /*step_2_background.frame = CGRect(x: 0, y: 0, width: step_1.frame.width, height: 140.5)*/
//            step_2_background.frame = CGRect(x: step_2.frame.origin.x, y: step_2.frame.origin.y, width: step_2.frame.width, height: 0)
//            /*splash_screen.addSubview(step_1)
//            splash_screen.addSubview(step_1_background)
//            splash_screen.bringSubviewToFront(step_1)*/
//            /*step_2.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.75)
//            step_2.image = nil*/
//            /*step_2.frame = CGRect(x: step_2.frame.origin.x, y: step_2.frame.origin.y, width: step_2.frame.width, height: 0)*/
//            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                /*self.step_2.frame = CGRect(x: self.step_2.frame.origin.x, y: self.step_2.frame.origin.y, width: self.step_2.frame.width, height:  242)*/
//                self.step_3.frame = CGRect(x: self.step_3.frame.origin.x, y: self.step_3.frame.origin.y+self.step_3.frame.height, width: self.step_3.frame.width, height: 0)
//                self.step_2_background.frame = CGRect(x: self.step_2.frame.origin.x, y: self.step_2.frame.origin.y-30, width: self.step_2.frame.width, height: 0.70*self.step_2.frame.height)
//            }, completion: {
//                (finished: Bool) -> Void in
//                self.tip_3.isHidden = false
//
//                self.step_2_background.addSubview(self.tip_3)
//                self.step_2_background.bringSubviewToFront(self.tip_3)
////                self.Step_Main()
//                self.splash_timer_count += 1
//                self.step_3.frame = CGRect(x: self.step_3.frame.origin.x, y: self.step_3.frame.origin.y-frame_height_temp, width: self.step_3.frame.width, height: frame_height_temp)
//                self.step_3.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.0)
//                /*self.step_2.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.0)*/
//            })
//
//        }
//
//        else if (splash_timer_count <= step_1_images.count+step_2_images.count+step_3_images.count) {
//
//            if (splash_timer_count <= step_1_images.count+step_2_images.count+4) {
//
//                if (splash_timer_count == step_1_images.count+step_2_images.count+2) {
//
//
//                    if (view.frame.height == 568) {
////                        step_2.image = UIImage(named: "s2se_cX.png")
//                        //s1_cX2
//                    }
//                    else if (view.frame.height == 667) {
////                        step_2.image = UIImage(named: "s2_cX.png")
//                        //s1_cX2
//                    }
//                    else {
////                        step_2.image = UIImage(named: "s2p_cX.png")
//                        //s1_cX2
//                    }
//
//
//                }
//
//                else if (splash_timer_count == step_1_images.count+step_2_images.count+3) {
//
//
//                    if (view.frame.height == 568) {
////                        step_2.image = UIImage(named: "s3se_cX.png")
//                        //s1_cX2
//                    }
//                    else if (view.frame.height == 667) {
////                        step_2.image = UIImage(named: "s3_cX.png")
//                        //s1_cX2
//                    }
//                    else {
////                        step_2.image = UIImage(named: "s3p_cX.png")
//                        //s1_cX2
//                    }
//
//
//                }
//
//                else {
//
//
//                    if (view.frame.height == 568) {
////                        step_2.image = UIImage(named: "s4se_cX.png")
//                        //s1_cX2
//                    }
//                    else if (view.frame.height == 667) {
////                        step_2.image = UIImage(named: "s4_cX.png")
//                        //s1_cX2
//                    }
//                    else {
////                        step_2.image = UIImage(named: "s4p_cX.png")
//                        //s1_cX2
//                    }
//
//
//                }
//
//
//
//            }
//            else if (splash_timer_count == step_1_images.count+step_2_images.count+5) {
//                if (view.frame.height == 568) {
////                    step_2.image = UIImage(named: "s4se_c2X.png")
//                    //s1_cX
//                }
//                else if (view.frame.height == 667) {
////                    step_2.image = UIImage(named: "s4_c2X.png")
//                    //s1_cX
//                }
//                else {
////                    step_2.image = UIImage(named: "s4p_c2X.png")
//                    //s1_cX
//                }
//            }
//            else if (splash_timer_count < step_1_images.count+step_2_images.count+step_3_images.count) {
//
//
//                if (splash_timer_count == step_1_images.count+step_2_images.count+6) {
//
//                    if (view.frame.height == 568) {
////                        step_2.image = UIImage(named: "s3se_cNX.png")
//                        //s1_cX3
//                    }
//                    else if (view.frame.height == 667) {
////                        step_2.image = UIImage(named: "s3_cNX.png")
//                        //s1_cX3
//                    }
//                    else {
////                        step_2.image = UIImage(named: "s3p_cNX.png")
//                        //s1_cX3
//                    }
//
//                }
//
//                else {
//
//                    if (view.frame.height == 568) {
////                        step_2.image = UIImage(named: "s2se_cNX.png")
//                        //s1_cX3
//                    }
//                    else if (view.frame.height == 667) {
////                        step_2.image = UIImage(named: "s2_cNX.png")
//                        //s1_cX3
//                    }
//                    else {
////                        step_2.image = UIImage(named: "s2p_cNX.png")
//                        //s1_cX3
//                    }
//
//                }
//
//
//
//            }
//            else {
//                if (view.frame.height == 568) {
////                    step_2.image = UIImage(named: "s2se_cN2X.png")
//                    //s1_cX
//                }
//                else if (view.frame.height == 667) {
////                    step_2.image = UIImage(named: "s2_cN2X.png")
//                    //s1_cX
//                }
//                else {
////                    step_2.image = UIImage(named: "s2p_cN2X.png")
//                    //s1_cX
//                }
//            }
////            self.Step_Main()
//            /*step_2.image = step_2_images[0]*/
//            step_3.image = step_3_images[splash_timer_count-step_1_images.count-step_2_images.count-1]
//            splash_timer_count += 1
//
//            /*timer_step.invalidate()*/
//        }
//        else if (splash_timer_count == step_1_images.count+step_2_images.count+step_3_images.count+1) {
//            tip_3.isHidden = true
//            tip_4.frame = CGRect(x: 25, y: -50, width: view.frame.maxX-50, height: view.frame.maxY)
//            tip_4.bounds = view.frame
//            tip_4.text = "View results"
//            tip_4.textAlignment = .center
//            tip_4.numberOfLines = 0
//            tip_4.textColor = UIColor.white
//            tip_4.font = UIFont.boldSystemFont(ofSize: 26.0)
//            let frame_height_temp = step_4.frame.height
//
//
//            /*step_2_background.frame = CGRect(x: step_2.frame.origin.x, y: step_2.frame.origin.y-242, width: step_2.frame.width, height: 0)*/
//            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                self.step_4.frame = CGRect(x: self.step_4.frame.origin.x, y: self.step_4.frame.origin.y+0.70*self.step_2.frame.height, width: self.step_4.frame.width, height: 0)
//                self.step_2_background.frame = CGRect(x: self.step_2.frame.origin.x, y: self.step_2.frame.origin.y, width: self.step_2.frame.width, height: self.step_2.frame.height+self.step_3.frame.height)
//            }, completion: {
//                (finished: Bool) -> Void in
//                self.tip_4.isHidden = false
//
//                self.step_2_background.addSubview(self.tip_4)
//                self.step_2_background.bringSubviewToFront(self.tip_4)
////                self.Step_Main()
//                self.splash_timer_count += 1
//                self.step_4.frame = CGRect(x: self.step_4.frame.origin.x, y: self.step_4.frame.origin.y-(0.70*self.step_2.frame.height), width: self.step_4.frame.width, height: frame_height_temp)
//                //0.70*self.step_2.frame.height
//                self.step_4.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.0)
//            })
//        }
//        else if (splash_timer_count <= step_1_images.count+step_2_images.count+step_3_images.count+bottom_images.count+1) { //slight shift
//            step_4.image = bottom_images[splash_timer_count-step_1_images.count-step_2_images.count-step_3_images.count-2] //slight shift
//            /*print("bottom_images[",splash_timer_count-step_1_images.count-step_2_images.count-step_3_images.count-2,"]",terminator: "\n")
//            print(splash_timer_count,terminator: "\n")*/
//
//
////            self.Step_Main()
//
//
//            splash_timer_count += 1
//
//        }
//        else if (splash_timer_count == step_1_images.count+step_2_images.count+step_3_images.count+bottom_images.count+2) {
//            /*if (splash_timer_count == step_1_images.count+step_2_images.count+step_3_images.count+bottom_images.count+2) {*/
//                tip_4.text = "Swipe left for more"
//            splash_screen.addSubview(disregard)
//            splash_screen.bringSubviewToFront(disregard)
//
//            //}
//
//            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                self.step_2_background.frame = CGRect(x: self.step_2.frame.origin.x, y: self.step_2.frame.origin.y, width: self.step_2.frame.width, height: self.step_2.frame.height+self.step_3.frame.height+0.70*self.step_2.frame.height)
//            }, completion: {
//                (finished: Bool) -> Void in
//                /*self.step_1.image = nil
//                self.step_2.image = nil
//                self.step_3.image = nil
//                self.step_4.image = nil
//                self.step_1_background.image = nil
//                self.step_2_background.image = nil*/
////                self.Step_Main()
//                self.splash_timer_count += 1
//
//                /*self.step_4.frame = CGRect(x: self.step_4.frame.origin.x, y: self.step_4.frame.origin.y-169.5, width: self.step_4.frame.width, height: 169.5)
//                self.step_4.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.0)*/
//            })
//        }
//        else if (splash_timer_count == step_1_images.count+step_2_images.count+step_3_images.count+bottom_images.count+3) {
//            //step_1_images.count+step_2_images.count+step_3_images.count+bottom_images.count+slide_images.count+4) {
//            self.tip_4.isHidden = true
////            self.splash_screen_background.frame = CGRect(x: self.splash_screen.frame.maxX, y: self.splash_screen.frame.origin.y, width: self.splash_screen.frame.width, height: self.splash_screen.frame.height)
//            self.splash_screen_background.image = self.slide_images[0]
//            self.splash_screen.addSubview(self.splash_screen_background)
//            splash_screen.addSubview(disregard)
//            splash_screen.bringSubviewToFront(disregard)
//
//
//
//            //splash_screen_background.image = slide_images[splash_timer_count-step_1_images.count-step_2_images.count-step_3_images.count-bottom_images.count-3]
//            /*self.Step_Main()
//            splash_timer_count += 1*/
//            /*print(splash_timer_count,terminator:"\n")
//            print(1/pow(2.0,Double(splash_timer_count-26)),terminator:"\n")*/
//
//            UIView.animate(
//                withDuration: 0.5,
//                delay: 0.0,
//                options: UIViewAnimationOptions.curveEaseOut,
//                animations: {
//                    self.splash_screen_background.frame = CGRect(x: self.splash_screen.frame.origin.x, y: self.splash_screen.frame.origin.y, width: self.splash_screen.frame.width, height: self.splash_screen.frame.height)//slightly faster
//                },
//                completion: {
//                    (finished: Bool) -> Void in
////                self.Step_Main()
//                self.splash_timer_count += 1
//
//                /*self.step_4.frame = CGRect(x: self.step_4.frame.origin.x, y: self.step_4.frame.origin.y-169.5, width: self.step_4.frame.width, height: 169.5)
//                 self.step_4.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.0)*/
//                }
//            )
//
//        }
//        else { //reset and cycle
//            //pause screen
//            func delay(_ delay:Double, closure:@escaping ()->()) {
//                DispatchQueue.main.asyncAfter(
//                    deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
//            }
//            delay(2)
//            {
//                self.step_1.image = nil
//                self.step_2.image = nil
//                self.step_3.image = nil
//                self.step_4.image = nil
//                self.step_1_background.image = nil
//                self.step_2_background.image = nil
//                self.splash_timer_count = 0
//                self.splash_screen_background.image = nil
//                self.step_1.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.85)
//                /*step_2.backgroundColor = UIColor(red: 255.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.75)*/
//
//                self.step_2_background.frame = CGRect(x: self.step_2.frame.origin.x, y: self.step_2.frame.origin.y, width: self.step_2.frame.width, height: self.step_2.frame.height) //shifted a little
//                self.step_2_background.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.85)
//                /*splash_screen.addSubview(step_2)*/
//                self.splash_screen.addSubview(self.step_2_background)
//                /*splash_screen.bringSubviewToFront(step_1)*/
//                self.step_3.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.85)
//                self.step_4.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.85)
//                self.splash_screen.addSubview(self.disregard)
//                self.splash_screen.bringSubviewToFront(self.disregard)
//                //self.minimum.isHidden = false
////                self.Step_Main()
//
//            }
//
//        }
//
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "myAVPlayerViewController") {
            let destination = segue.destination as! AVPlayerViewController
            let url = Bundle.main.url(forResource: "introduction", withExtension: ".mov")//, subdirectory: "Resources/\"How to Use App\" Video")
            //let url = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
            if let movieURL = url {
                destination.player = AVPlayer(url: movieURL as URL)
                destination.player?.play()
                //present(destination, animated: false, completion: { self.video.play() } )
            }
        }
        else {
            return
        }
    }
    
    
    //var video = AVPlayer()
    //let videoController = AVPlayerViewController()

    //func Introduction() {
        //present("myAVPlayerViewController", animated: false, completion: { self.video.play() } )
        /*if let filePath = Bundle.main.url(forResource: "introduction", withExtension: "mov") {
            video = AVPlayer(url: filePath)
            //videoController = AVPlayerViewController()
            videoController.player = video
            /*//attaches videoController to self:
            videoController.view.frame = self.view.frame
            self.view.addSubview(videoController.view)
            self.addChildViewController(videoController)*/
            //self.view.bringSubviewToFront(videoController.view)
            //self.showDetailViewController(videoController, sender: self) //shows "done"button
            //self.present(videoController, animated: false, completion: nil)
            present(videoController, animated: false, completion: { self.video.play() } )
            //present(videoController, animated: false, completion: {
            //    self.video.play()
            //})
            
        }*/
        /*let fileManager = FileManager.default
        
        // Get attributes of 'myfile.txt' file
        
        do {
            let attributes = try fileManager.attributesOfItem(atPath: "/Users/ed/Google Drive/Dissertation/Projects/iPhone/Instructional Apps to Promote Financial Literacy/introduction.mov")
            print(attributes)
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }*/

    //}

    
    @IBAction func Locked(_ sender: UIButton) {
        unlocked.isHidden = false
        locked.isHidden = true
        edit_slider.isHidden = false
        edit_apr.isHidden = false
        edit_pay.isHidden = false
        swipe_label.isHidden = false
        swipe_note.isHidden = true
        unlocked_indicator = 1
        abs_10yr.isHidden = false
        swipe_blink.layer.removeAllAnimations() //in case someone clicks lock button before blinking animation stops
        
        if (i == 0) {
            edit_apr.isHidden = true
        }
        else {
            edit_apr.isHidden = false
        }
        
        if swipe.isEnabled {
            swiping.isHidden = false
            stopped.isHidden = true
        }
        else {
            stopped.isHidden = false
            swiping.isHidden = true
        }
        
        edit_slider.alpha = 0
        edit_apr.alpha = 0
        edit_pay.alpha = 0
        swipe_label.alpha = 0
        stopped.alpha = 0
        swiping.alpha = 0
        abs_10yr.alpha = 0
        
        time_title.alpha = 1
        savings_title.alpha = 1
        years.alpha = 1
        years_text.alpha = 1
        months.alpha = 1
        months_text.alpha = 1
        savings.alpha = 1
        savings_change.alpha = 1

        
        //swipe_blink.isHidden = true

        //UIView.animate(withDuration: 0.25, animations: {
            /*self.edit_slider.alpha = 1.0
            self.edit_apr.alpha = 1.0
            self.edit_pay.alpha = 1.0
            self.swipe_label.alpha = 1.0
            self.stopped.alpha = 1.0
            self.swiping.alpha = 1.0
            self.abs_10yr.alpha = 1.0
            
            self.time_title.alpha = 0
            self.savings_title.alpha = 0
            self.years.alpha = 0
            self.years_text.alpha = 0
            self.months.alpha = 0
            self.months_text.alpha = 0
            self.savings.alpha = 0
            self.savings_change.alpha = 0*/

        //},
          //             completion: {
          //              (finished: Bool) -> Void in
                        //UIView.animate(withDuration: 0.25) {//otherwise increment_input wouldn't blend
                        //}
        //})
        
        
        UIView.animate(withDuration: 0.25,
                       animations: {
                        self.edit_slider.alpha = 1.0
                        self.edit_apr.alpha = 1.0
                        self.edit_pay.alpha = 1.0
                        self.swipe_label.alpha = 1.0
                        self.stopped.alpha = 1.0
                        self.swiping.alpha = 1.0
                        self.abs_10yr.alpha = 1.0
                        
                        self.time_title.alpha = 0
                        self.savings_title.alpha = 0
                        self.years.alpha = 0
                        self.years_text.alpha = 0
                        self.months.alpha = 0
                        self.months_text.alpha = 0
                        self.savings.alpha = 0
                        self.savings_change.alpha = 0
                    },
                       completion: { (finished: Bool) -> Void in
                        //UIView.animate(withDuration: 0.25,
                                       //animations: {  },
                                       //completion: { (finished: Bool) -> Void in
                                        self.swipe_blink.isHidden = false
                                        self.swipe_blink.text = "Relock for time and savings."
                                        self.swipe_blink.alpha = 0.0
                                        UIView.animate(withDuration: 0.5, delay: 0.5, options: [.repeat, .autoreverse, .curveEaseInOut],
                                                       animations: { UIView.setAnimationRepeatCount(3); self.swipe_blink.alpha = 1.0 },
                                                       completion: { (finished: Bool) -> Void in
                                                        self.swipe_blink.alpha = 0.0
                                                        self.swipe_blink.isHidden = true
                                        }
                                        )
                        //}
                        //)
        }
        )

        


        //a little more insight: blinking won't resume without this, unless blinking animation completes before lock button is clicked
    }
    
    @IBAction func Unlocked(_ sender: UIButton) {
        unlocked.isHidden = true
        locked.isHidden = false
        edit_slider.isHidden = true
        edit_apr.isHidden = true
        edit_pay.isHidden = true
        swiping.isHidden = true
        stopped.isHidden = true
        swipe_label.isHidden = true
        swipe_note.isHidden = false
        unlocked_indicator = 0
        abs_10yr.isHidden = true
        
        //if user was editing slider, apr or pay, will close them, too
        if (i == 0) {
            //apr_number.text = String(format: "%.2f", i * 12 * 100)
            //apr_number_back.text = String(format: "%.2f", i * 12 * 100)
            interest_rate_unpressed.isHidden = true
            interest_rate_unpressed_copy.isHidden = true
            interest_rate_disabled.isHidden = false
            //edit_apr.isHidden = true
            //edit_apr_shape.isHidden = true
            //edit_apr_shape.willRemoveSubview(edit_apr_text)
            //view.addSubview(edit_apr_text)
            //submit_changes_apr.isHidden = true
            apr_sign.alpha = 0.125
            //apr_number.alpha = 0.125
            //apr_number.isUserInteractionEnabled = false
            //apr_number.font = UIFont(name: "HelveticaNeue", size: 17.0)
        }
        
        time_title.alpha = 1
        savings_title.alpha = 1
        years.alpha = 1
        years_text.alpha = 1
        months.alpha = 1
        months_text.alpha = 1
        savings.alpha = 1
        savings_change.alpha = 1
        swipe_blink.layer.removeAllAnimations() //in case someone clicks lock button before blinking animation stops

    }
    
    @IBAction func Swiping(_ sender: UIButton) { //turns OFF swiping
        swipe.isEnabled = false
        stopped.isHidden = false
        swiping.isHidden = true
        swipe_note.text = "Swipe disabled."
        swipe_blink.layer.removeAllAnimations() //in case someone clicks lock button before blinking animation stops
    }
    
    @IBAction func Stopped(_ sender: UIButton) { //turns ON swiping
        swipe.isEnabled = true
        swiping.isHidden = false
        stopped.isHidden = true
        swipe_note.text = "Swipe enabled."
        swipe_blink.layer.removeAllAnimations() //in case someone clicks lock button before blinking animation stops

        
        if swipe.isEnabled { //do i really need IF statement for this?
            
            UIView.animate(withDuration: 0.25,
                animations: { self.swiping.transform = CGAffineTransform(scaleX: 1.125, y: 1.125) },
                completion: { (finished: Bool) -> Void in
                    UIView.animate(withDuration: 0.25,
                        animations: { self.swiping.transform = CGAffineTransform.identity },
                        completion: { (finished: Bool) -> Void in
                            self.swipe_blink.isHidden = false
                            self.swipe_blink.text = "Swipe left."
                            self.swipe_blink.alpha = 0.0
                                UIView.animate(withDuration: 0.5, delay: 0.5, options: [.repeat, .autoreverse, .curveEaseInOut],
                                    animations: { UIView.setAnimationRepeatCount(3); self.swipe_blink.alpha = 1.0 },
                                    completion: { (finished: Bool) -> Void in
                                        self.swipe_blink.alpha = 0.0
                                    }
                                )
                        }
                    )
                }
            )
        }
        else {
            swipe_blink.isHidden = true
        }
    }
    
    
    //@IBOutlet weak var loaned_max: UILabel!
    //register what users input for their own numbers
    @IBAction func Loaned_Min_Input(_ sender: UITextField) {
        //loaned.minimumValue = String(sender.text)
        //print(loaned_min_input.text!)
        //let tempX = NSDecimalNumber(string: loaned_min_input.text!)
        //let tempX = loaned_min_input.text!
        //print(tempX)
        //print(loaned.maximumValue)
        //loaned.minimumValue = Float(truncating: removeFormat(string: tempX*0))
        //loaned_max.text = String(describing: max_value)
        //loaned.minimumValue = Float(truncating: tempX)
        //print(loaned.minimumValue)

        min_value = Double(truncating: removeFormat(string: loaned_min_input.text!))
        if (min_value - floor(min_value) > 0.499999) && (min_value - floor(min_value) < 0.5)
            { min_value = round(min_value + 1) }
        else { min_value = round(min_value) }
        
        if (min_value < 0) {
            //min_value = Double() //essentially, empty
            min_value = 0
            //loaned.isEnabled = true
            //loaned_min_input.text = ""
            loaned_min_input.text = String(format: "%.0f", min_value)
            //suggest.isHidden = false
            //suggest.text = "Minimum must be at least $0"
        }
        //else if (min_value == max_value) {
            
          //  loaned.isEnabled = false
        //}
        else if (min_value >= max_value) {
            min_value = max_value-1
            loaned_min_input.text = String(format: "%.0f", min_value)
            //loaned.isEnabled = false
        }
        else {
        //    loaned.isEnabled = true
        }
        //max_value = min_value + Int(loaned.maximumValue)*increment//doesn't know increment size yet, until move slider
        increment = (max_value - min_value)/number_of_increments
        /*if (increment - floor(increment) == 0) {
            increment_input.text = String(format: "%.0f", increment)
            //increment_input.font = UIFont(name: "HelveticaNeue", size: 17.0)
            increment_input.textColor = UIColor(red: 161/255.0, green: 166/255.0, blue: 168/255.0, alpha: 1.0)
        }
        else {
            increment_input.text = String(format: "%.5f", increment)
            //increment_input.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
            increment_input.textColor = UIColor.red
        }*/
        if (increment - floor(increment) == 0) {
            increment_input.text = String(format: "%.0f", increment)
            //increment_input.font = UIFont(name: "HelveticaNeue", size: 17.0)
            increment_input.textColor = UIColor(red: 161/255.0, green: 166/255.0, blue: 168/255.0, alpha: 1.0)
            increment_input.alpha = 0.25
            increment_input.layer.removeAllAnimations()
            even_out.isHidden = true
            submit_changes.isEnabled = true
            suggest.isHidden = true
        }
        else {
            even_out.isHidden = false
            submit_changes.isEnabled = false
            if (number_of_increments == 0) {
                increment_input.text = "∞"
            }
            else {
                increment_input.text = String(format: "%.5f", increment)
            }
            //increment_input.font = UIFont(name: "HelveticaNeue", size: 17.0)
            increment_input.textColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 1.0)
            increment_input.alpha = 1.0
            UIView.animate(withDuration: 0.0625, delay: 0.0, options: [.repeat, .autoreverse, .curveEaseInOut], animations:
                {
                    UIView.setAnimationRepeatCount(3)
                    self.increment_input.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                self.increment_input.alpha = 1.0
            })
            suggest.isHidden = false
        }
        //loaned_min_input.text = String(format: "%.0f", min_value)
        var suggestions = [Int]()
        var tailored_suggestions = String()
        //var suggestions = ""
        var suggestions_index = -1
        for testing_suggestions in 20...60 {
            let result = (max_value - min_value)/Double(testing_suggestions)
            if (result - floor(result) == 0) {
                //suggestions += "\(testing_suggestions)   "
                suggestions.append(testing_suggestions)
                suggestions_index += 1
            }
        }
        if (suggestions == []) {
        //if (suggestions == "") {
            suggest.text = "Even out the minimum or maximum, first."
        }
        else {
            if (suggestions_index == 0) {
            //if (suggestions.count == 5) { //3 for two digits and 3 spaces, for only one suggestion
                suggest.text = "Suggestion: \(suggestions[suggestions_index]) increments"
                //suggest.text = "Suggestion:   \(suggestions) increments"
            }
            else if (suggestions_index == 1) {//use "or"
                suggest.text = "Suggestions: \(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
            }
            else {//use commas and "or" (e.g., "20, 25 or 40")
                for tailoring_suggestions in 0...(suggestions_index-2) {
                    tailored_suggestions += "\(suggestions[tailoring_suggestions]), "
                    //tailored_suggestions.append(suggestions[tailoring_suggestions])
                }
                suggest.text = "Suggestions: \(tailored_suggestions)\(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
                //suggest.text = "Suggestions:   \(suggestions) increments"
                //suggest.text = "left out"
            }
        }


        //progress = increment * progress + min_value
        //print("min_value changed to",min_value,"and increment is now",increment)
        //print("progress",progress)
        
        //if (progress != min_value) {
            if (min_value < progress) {
                var value = (progress - min_value)/increment
                if (value - floor(value) > 0.499999) && (value - floor(value) < 0.5)
                    { value = round(value + 1) }
                else { value = round(value) }
                
                //let rounded_value = round(value)
                self.loaned.setValue(Float(value), animated: true) //figure out where it will go
                //increment * progress + min_value
                //print("value changed to",rounded_value,"= (",progress,"-",min_value,")/",increment)
            }
            else {
                p = Double(min_value)
                shared_preferences.set(p, forKey: "loaned"); shared_preferences.synchronize()
                let value = 0
                self.loaned.setValue(Float(value), animated: true)
                //print("value changed to",value)
                progress = increment * Double(self.loaned.value) + min_value
                //print("progress changed to",progress,"which equals",increment,"*",self.loaned.value,"+",min_value)
            }
        var temp = Double()
        if (tenyr_indicator == 0) {
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { temp = (round(p*i*100 + 1) + 1)/100}
            else { temp = (round(p*i*100) + 1)/100 }
        }
        else {
            if (i != 0) {
                temp = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
            }
            else {
                temp = ceil(p/120*100)/100
            }
        }
        


            if (temp >= a)
            {
                a = temp
                a_reference = temp
                shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
                if (a - floor(a) == 0) {
                    pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
                }
                else if ((a - floor(a))*100 < 9.99999) {
                    pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
                }
                else {
                    pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
                }

                minimum.isHidden = false
                minimum.text = "Minimum"
            }
            else
            {
                //minimum.isHidden = true
                minimum.isHidden = false
                minimum.text = " "
            }
            Lengthsaving()

        //} else {
            //do nothing else
        //}
    }
    
    @IBAction func Loaned_Max_Input(_ sender: UITextField) {
        max_value = Double(truncating: removeFormat(string: loaned_max_input.text!))
        if (max_value - floor(max_value) > 0.499999) && (max_value - floor(max_value) < 0.5)
            { max_value = round(max_value + 1) }
        else { max_value = round(max_value) }
        
        if (max_value <= min_value) {
            max_value = min_value+1
            loaned_max_input.text = String(format: "%.0f", max_value)
            //loaned.isEnabled = false
        }
        //else if (max_value == min_value) {
            //loaned.isEnabled = false
        //}
        else {
            //loaned.isEnabled = true
        }
        bubble_label = UILabel(frame: CGRect(x: -String(format: "%.0f", max_value).count*6+0, y: -5, width: String(format: "%.0f", max_value).count*12+20, height: -32))
        //bubble_label = UILabel(frame: CGRect(x: -30, y: -5, width: 80, height: -32))

        
        increment = (max_value - min_value)/number_of_increments
        /*if (increment - floor(increment) == 0) {
            increment_input.text = String(format: "%.0f", increment)
            //increment_input.font = UIFont(name: "HelveticaNeue", size: 17.0)
            increment_input.textColor = UIColor(red: 161/255.0, green: 166/255.0, blue: 168/255.0, alpha: 1.0)
        }
        else {
            increment_input.text = String(format: "%.5f", increment)
            //increment_input.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
            increment_input.textColor = UIColor.red
        }*/
        
        if (increment - floor(increment) == 0) {
            increment_input.text = String(format: "%.0f", increment)
            //increment_input.font = UIFont(name: "HelveticaNeue", size: 17.0)
            increment_input.textColor = UIColor(red: 161/255.0, green: 166/255.0, blue: 168/255.0, alpha: 1.0)
            increment_input.alpha = 0.25
            increment_input.layer.removeAllAnimations()
            even_out.isHidden = true
            submit_changes.isEnabled = true
            suggest.isHidden = true
        }
        else {
            even_out.isHidden = false
            submit_changes.isEnabled = false
            if (number_of_increments == 0) {
                increment_input.text = "∞"
            }
            else {
                increment_input.text = String(format: "%.5f", increment)
            }
            //increment_input.font = UIFont(name: "HelveticaNeue", size: 17.0)
            increment_input.textColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 1.0)
            increment_input.alpha = 1.0
            UIView.animate(withDuration: 0.0625, delay: 0.0, options: [.repeat, .autoreverse, .curveEaseInOut], animations:
                {
                    UIView.setAnimationRepeatCount(3)
                    self.increment_input.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                self.increment_input.alpha = 1.0
            })
            suggest.isHidden = false
        }
        //loaned_max_input.text = String(format: "%.0f", max_value)

        var suggestions = [Int]()
        var tailored_suggestions = String()
        //var suggestions = ""
        var suggestions_index = -1
        for testing_suggestions in 20...60 {
            let result = (max_value - min_value)/Double(testing_suggestions)
            if (result - floor(result) == 0) {
                //suggestions += "\(testing_suggestions)   "
                suggestions.append(testing_suggestions)
                suggestions_index += 1
            }
        }
        if (suggestions == []) {
            suggest.text = "Even out the minimum or maximum, first."
        }
        else {
            if (suggestions_index == 0) {
                suggest.text = "Suggestion: \(suggestions[suggestions_index]) increments"
            }
            else if (suggestions_index == 1) {//use "or"
                suggest.text = "Suggestions: \(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
            }
            else {//use commas and "or" (e.g., "20, 25 or 40")
                for tailoring_suggestions in 0...(suggestions_index-2) {
                    tailored_suggestions += "\(suggestions[tailoring_suggestions]), "
                }
                suggest.text = "Suggestions: \(tailored_suggestions)\(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
            }
        }

        /*else if (increment*10 - floor(increment*10) == 0) {
            increment_input.text = String(format: "%.1f", increment)
        }
        else {
            increment_input.text = String(format: "%.2f", increment)
        }*/
        //print("max_value changed to",max_value,"and increment is now",increment)
        if (max_value > progress) {
            var value = (progress - min_value)/increment
            if (value - floor(value) > 0.499999) && (value - floor(value) < 0.5)
                { value = round(value + 1)}
            else { value = round(value) }

            //let rounded_value = round(value)
            self.loaned.setValue(Float(value), animated: true)
            //self.loaned.setValue(Float(value), animated: true)
            //print("value changed to",rounded_value,"= (",progress,"-",min_value,")/",increment)

        }
        else {
            p = Double(max_value)
            shared_preferences.set(p, forKey: "loaned"); shared_preferences.synchronize()
            let value = number_of_increments
            self.loaned.setValue(Float(value), animated: true)
            //print("value changed to",value)
            progress = increment * Double(self.loaned.value) + min_value
            //print("progress changed to",progress,"which equals",increment,"*",self.loaned.value,"+",min_value)
        }
        var temp = Double()
        if (tenyr_indicator == 0) {
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { temp = (round(p*i*100 + 1) + 1)/100}
            else { temp = (round(p*i*100) + 1)/100 }
        }
        else {
            if (i != 0) {
                temp = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
            }
            else {
                temp = ceil(p/120*100)/100
            }
        }
        


        if (temp >= a)
        {
            a = temp
            a_reference = temp
            shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
            if (a - floor(a) == 0) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
            }
            else if ((a - floor(a))*100 < 9.99999) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
            }
            else {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
            }

            minimum.isHidden = false
            minimum.text = "Minimum"
        }
        else
        {
            minimum.isHidden = false
            minimum.text = " "
        }
        Lengthsaving()
    }
    
    
    @IBAction func Increment_Input(_ sender: UITextField) {
        //increment = Double(truncating: removeFormat(string: increment_input.text!))
        //number_of_increments = round((max_value - min_value)/increment)
        //input_number_of_increments.text = String(format: "%.0f", number_of_increments)
        //loaned slider value is already updating
        //print("increment changed to",increment,"and number of increments is now",number_of_increments)
        /*if (max_value > progress) {
            let value = (progress - min_value)/increment
            let rounded_value = round(value)
            self.loaned.setValue(Float(rounded_value), animated: true)
            //self.loaned.setValue(Float(value), animated: true)
            print("value changed to",rounded_value,"= (",progress,"-",min_value,")/",increment)
            
        }
        else {
            p = Double(max_value)
            shared_preferences.set(p, forKey: "loaned"); shared_preferences.synchronize()
            let value = number_of_increments
            self.loaned.setValue(Float(value), animated: true)
            print("value changed to",value)
            progress = increment * Double(self.loaned.value) + min_value
            print("progress changed to",progress,"which equals",increment,"*",self.loaned.value,"+",min_value)
        }*/
        /*let temp = ceil(Double(Int(p*i*100)+1))/100
        if (temp >= a)
        {
            a = temp
            shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
            pay_monthly_box.text = "$" + String(format: "%.2f", a)
            
            minimum.isHidden = false
            minimum.text = "Minimum"
        }
        else
        {
            minimum.isHidden = false
            minimum.text = " "
        }
        Lengthsaving()*/
    }

    @IBAction func Input_Number_of_Increments(_ sender: UITextField) {
        number_of_increments = Double(truncating: removeFormat(string: input_number_of_increments.text!))
        if (number_of_increments - floor(number_of_increments) > 0.499999) && (number_of_increments - floor(number_of_increments) < 0.5)
            { number_of_increments = round(number_of_increments + 1) }
        else { number_of_increments = round(number_of_increments) }
        
        if (number_of_increments < 0) {
            //number_of_increments = Double() //essentially, empty
            number_of_increments = 0 //essentially, empty
            input_number_of_increments.text = String(format: "%.0f", number_of_increments)
            //loaned.isEnabled = true
            //input_number_of_increments.text = ""
        }
        
        increment = (max_value - min_value)/number_of_increments
        self.loaned.maximumValue = Float(number_of_increments)

        if (increment - floor(increment) == 0) {
            increment_input.text = String(format: "%.0f", increment)
            increment_input.textColor = UIColor(red: 161/255.0, green: 166/255.0, blue: 168/255.0, alpha: 1.0)
            increment_input.alpha = 0.25
            increment_input.layer.removeAllAnimations()
            even_out.isHidden = true
            submit_changes.isEnabled = true
            suggest.isHidden = true
        }
        else {
            even_out.isHidden = false
            submit_changes.isEnabled = false
            if (number_of_increments == 0) {
                increment_input.text = "∞"
            }
            else {
                increment_input.text = String(format: "%.5f", increment)
            }

            increment_input.textColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 1.0)
            increment_input.alpha = 1.0
            UIView.animate(withDuration: 0.0625, delay: 0.0, options: [.repeat, .autoreverse, .curveEaseInOut], animations:
                {
                    UIView.setAnimationRepeatCount(3)
                    self.increment_input.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                self.increment_input.alpha = 1.0
            })
            suggest.isHidden = false
        }
        //input_number_of_increments.text = String(format: "%.0f", number_of_increments)
        
        var suggestions = [Int]()
        var tailored_suggestions = String()
        //var suggestions = ""
        var suggestions_index = -1
        for testing_suggestions in 20...60 {
            let result = (max_value - min_value)/Double(testing_suggestions)
            if (result - floor(result) == 0) {
                //suggestions += "\(testing_suggestions)   "
                suggestions.append(testing_suggestions)
                suggestions_index += 1
            }
        }
        if (suggestions == []) {
            suggest.text = "Even out the minimum or maximum, first."
        }
        else {
            if (suggestions_index == 0) {
                suggest.text = "Suggestion: \(suggestions[suggestions_index]) increments"
            }
            else if (suggestions_index == 1) {//use "or"
                suggest.text = "Suggestions: \(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
            }
            else {//use commas and "or" (e.g., "20, 25 or 40")
                for tailoring_suggestions in 0...(suggestions_index-2) {
                    tailored_suggestions += "\(suggestions[tailoring_suggestions]), "
                }
                suggest.text = "Suggestions: \(tailored_suggestions)\(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
            }
        }
        //input_number_of_increments.text = String(format: "%.0f", number_of_increments) //otherwise won't show real value
    }
    
    @IBAction func Apr_Number(_ sender: UITextField) {
        //i = Double(truncating: removeFormat(string: input_number_of_increments.text!))
        i = Double(truncating: removeFormat(string: apr_number.text!))
        let temp_new = i*100 - floor(i*100)
        if (temp_new > 0.499999) && (temp_new < 0.5)
            { i = round(i*100 + 1)/100 / 12 / 100 }
        else { i = round(i*100)/100 / 12 / 100}
        
        if (i <= 0) {
            i = 0.01 / 12 / 100
            apr_number.text = String(format: "%.2f", i * 12 * 100)
            apr_number_back.text = String(format: "%.2f", i * 12 * 100)
        }
        else {
            //keep going
        }
        /*if (i == 0) {
            apr.isOn = false
        }
        else {
            //keep going
        }*/
        rates_reference[2] = i
        shared_preferences.set(2, forKey: "position"); shared_preferences.synchronize()
        shared_preferences.set(i * 12 * 100, forKey: "interest"); shared_preferences.synchronize()
        
        var temp = Double()
        if (tenyr_indicator == 0) {
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { temp = (round(p*i*100 + 1) + 1)/100}
            else { temp = (round(p*i*100) + 1)/100 }
        }
        else {
            if (i != 0) {
                temp = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
            }
            else {
                temp = ceil(p/120*100)/100
            }
        }

        if (temp >= a)
        {
            a = temp
            a_reference = temp
            shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
            if (a - floor(a) == 0) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
            }
            else if ((a - floor(a))*100 < 9.99999) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
            }
            else {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
            }

            minimum.isHidden = false
            minimum.text = "Minimum"
        }
        else
        {
            minimum.isHidden = false
            minimum.text = " "
        }
        Lengthsaving()
    }
    
    @IBAction func Down_Number(_ sender: UITextField) {
        down_button_increment = Double(truncating: removeFormat(string: down_number.text!))

        if (down_button_increment - floor(down_button_increment) > 0.499999) && (down_button_increment - floor(down_button_increment) < 0.5)
            { down_button_increment = round(down_button_increment + 1) }
        else { down_button_increment = round(down_button_increment) }

        if (down_button_increment <= 1.0) {
            down_button_increment = 1.0
            down_number.text = String(format: "%.0f", down_button_increment)

        }
        else if (down_button_increment > set_down_timer1_increment) {
            down_button_increment = set_down_timer1_increment
            down_number.text = String(format: "%.0f", down_button_increment)
        }
        else {
            //keep going
        }
        //down_number.text = numberFormatter.string(from: NSNumber(value: down_button_increment))!
    }
    
    @IBAction func Up_Number(_ sender: UITextField) {
        up_button_increment = Double(truncating: removeFormat(string: up_number.text!))
        
        if (up_button_increment - floor(up_button_increment) > 0.499999) && (up_button_increment - floor(up_button_increment) < 0.5)
            { up_button_increment = round(up_button_increment + 1) }
        else { up_button_increment = round(up_button_increment) }
        
        if (up_button_increment <= 1.0) {
            up_button_increment = 1.0
            up_number.text = String(format: "%.0f", up_button_increment)
        }
        else if (up_button_increment > set_up_timer1_increment) {
            up_button_increment = set_up_timer1_increment
            up_number.text = String(format: "%.0f", up_button_increment)
        }
        else {
            //keep going
        }
    }
    
    @IBAction func Pay_Number(_ sender: UITextField) {
        //a = round(Double(truncating: removeFormat(string: pay_number.text!))*100)/100
        
        a = Double(truncating: removeFormat(string: pay_number.text!))
        
        let temp_new2 = a*100 - floor(a*100)
        if (temp_new2 > 0.499999) && (temp_new2 < 0.5)
            { a = round(a*100 + 1)/100 }
        else { a = round(a*100)/100 }

        
        var temp = Double()
        if (tenyr_indicator == 0) {
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { temp = (round(p*i*100 + 1) + 1)/100}
            else { temp = (round(p*i*100) + 1)/100 }
        }
        else {
            if (i != 0) {
                temp = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
            }
            else {
                temp = ceil(p/120*100)/100
            }
        }


        if (a <= temp) {
        //if (a <= ceil(Double(Int(p*i*100)+1))/100) {
            /*let temp = Int((p * i + 0.01) * 100)*/
            //let temp = ceil(Double(Int(p*i*100)+1))/100
            
            a = temp
            a_reference = temp
            minimum.isHidden = false
            minimum.text = "Minimum"
            pay_number.text = String(format: "%.2f", a)
            //print(a)
        }
        else {
            minimum.isHidden = false
            minimum.text = " "
        }
        shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
        Lengthsaving()
    }
    
    @IBAction func Down_Timer1_Seconds(_ sender: UITextField) {
        set_down_timer1_seconds = Double(truncating: removeFormat(string: down_timer1_seconds.text!))
        
        if (set_down_timer1_seconds - floor(set_down_timer1_seconds) > 0.499999) && (set_down_timer1_seconds - floor(set_down_timer1_seconds) < 0.5)
            { set_down_timer1_seconds = round(set_down_timer1_seconds + 1) }
        else { set_down_timer1_seconds = round(set_down_timer1_seconds) }

        
        if (set_down_timer1_seconds < 1.0) {
            set_down_timer1_seconds = 1.0
            down_timer1_seconds.text = String(format: "%.0f", set_down_timer1_seconds)
        }
        else if (set_down_timer1_seconds > set_down_timer2_seconds) {
            set_down_timer1_seconds = set_down_timer2_seconds - 1.0
            down_timer1_seconds.text = String(format: "%.0f", set_down_timer1_seconds)
        }
        else {
            //keep
        }
    }
    
    @IBAction func Down_Timer2_Seconds(_ sender: UITextField) {
        
        set_down_timer2_seconds = Double(truncating: removeFormat(string: down_timer2_seconds.text!))
        
        if (set_down_timer2_seconds - floor(set_down_timer2_seconds) > 0.499999) && (set_down_timer2_seconds - floor(set_down_timer2_seconds) < 0.5)
            { set_down_timer2_seconds = round(set_down_timer2_seconds + 1) }
        else { set_down_timer2_seconds = round(set_down_timer2_seconds) }

        
        if (set_down_timer2_seconds <= set_down_timer1_seconds) {
            set_down_timer2_seconds = set_down_timer1_seconds + 1.0
            down_timer2_seconds.text = String(format: "%.0f", set_down_timer2_seconds)
        }
        else {
            //keep
        }
    }
    
    @IBAction func Up_Timer1_Seconds(_ sender: UITextField) {
        
        set_up_timer1_seconds = Double(truncating: removeFormat(string: up_timer1_seconds.text!))
        
        if (set_up_timer1_seconds - floor(set_up_timer1_seconds) > 0.499999) && (set_up_timer1_seconds - floor(set_up_timer1_seconds) < 0.5)
            { set_up_timer1_seconds = round(set_up_timer1_seconds + 1) }
        else { set_up_timer1_seconds = round(set_up_timer1_seconds) }

        
        if (set_up_timer1_seconds < 1.0) {
            set_up_timer1_seconds = 1.0
            up_timer1_seconds.text = String(format: "%.0f", set_up_timer1_seconds)
        }
        else if (set_up_timer1_seconds > set_up_timer2_seconds) {
            set_up_timer1_seconds = set_up_timer2_seconds - 1.0
            up_timer1_seconds.text = String(format: "%.0f", set_up_timer1_seconds)
        }
        else {
            //keep
        }
    }

    @IBAction func Up_Timer2_Seconds(_ sender: UITextField) {
        
        set_up_timer2_seconds = Double(truncating: removeFormat(string: up_timer2_seconds.text!))
        
        if (set_up_timer2_seconds - floor(set_up_timer2_seconds) > 0.499999) && (set_up_timer2_seconds - floor(set_up_timer2_seconds) < 0.5)
            { set_up_timer2_seconds = round(set_up_timer2_seconds + 1) }
        else { set_up_timer2_seconds = round(set_up_timer2_seconds) }

        
        if (set_up_timer2_seconds <= set_up_timer1_seconds) {
            set_up_timer2_seconds = set_up_timer1_seconds + 1.0
            up_timer2_seconds.text = String(format: "%.0f", set_up_timer2_seconds)
        }
        else {
            //keep
        }
    }
    
    @IBAction func Down_Timer1_Increment(_ sender: UITextField) {
        
        set_down_timer1_increment = Double(truncating: removeFormat(string: down_timer1_increment.text!))
        
        if (set_down_timer1_increment - floor(set_down_timer1_increment) > 0.499999) && (set_down_timer1_increment - floor(set_down_timer1_increment) < 0.5)
            { set_down_timer1_increment = round(set_down_timer1_increment + 1) }
        else { set_down_timer1_increment = round(set_down_timer1_increment) }

        
        if (set_down_timer1_increment < down_button_increment) {
            set_down_timer1_increment = down_button_increment
            down_timer1_increment.text = String(format: "%.0f", set_down_timer1_increment)
        }
        else if (set_down_timer1_increment > set_down_timer2_increment) {
            set_down_timer1_increment = set_down_timer2_increment
            down_timer1_increment.text = String(format: "%.0f", set_down_timer1_increment)
        }
        else {
            //keep
        }
    }
    
    @IBAction func Down_Timer2_Increment(_ sender: UITextField) {
        
        set_down_timer2_increment = Double(truncating: removeFormat(string: down_timer2_increment.text!))
        
        if (set_down_timer2_increment - floor(set_down_timer2_increment) > 0.499999) && (set_down_timer2_increment - floor(set_down_timer2_increment) < 0.5)
            { set_down_timer2_increment = round(set_down_timer2_increment + 1) }
        else { set_down_timer2_increment = round(set_down_timer2_increment) }

        
        if (set_down_timer2_increment < set_down_timer1_increment) {
            set_down_timer2_increment = set_down_timer1_increment
            down_timer2_increment.text = String(format: "%.0f", set_down_timer2_increment)
        }
        else {
            //keep
        }
    }
    
    @IBAction func Up_Timer1_Increment(_ sender: UITextField) {
        
        set_up_timer1_increment = Double(truncating: removeFormat(string: up_timer1_increment.text!))
        
        if (set_up_timer1_increment - floor(set_up_timer1_increment) > 0.499999) && (set_up_timer1_increment - floor(set_up_timer1_increment) < 0.5)
            { set_up_timer1_increment = round(set_up_timer1_increment + 1) }
        else { set_up_timer1_increment = round(set_up_timer1_increment) }

        
        if (set_up_timer1_increment < up_button_increment) {
            set_up_timer1_increment = up_button_increment
            up_timer1_increment.text = String(format: "%.0f", set_up_timer1_increment)
        }
        else if (set_up_timer1_increment > set_up_timer2_increment) {
            set_up_timer1_increment = set_up_timer2_increment
            up_timer1_increment.text = String(format: "%.0f", set_up_timer1_increment)
        }
        else {
            //keep
        }
    }

    @IBAction func Up_Timer2_Increment(_ sender: UITextField) {
        
        set_up_timer2_increment = Double(truncating: removeFormat(string: up_timer2_increment.text!))
        
        if (set_up_timer2_increment - floor(set_up_timer2_increment) > 0.499999) && (set_up_timer2_increment - floor(set_up_timer2_increment) < 0.5)
            { set_up_timer2_increment = round(set_up_timer2_increment + 1) }
        else { set_up_timer2_increment = round(set_up_timer2_increment) }

        
        if (set_up_timer2_increment < set_up_timer1_increment) {
            set_up_timer2_increment = set_up_timer1_increment
            up_timer2_increment.text = String(format: "%.0f", set_up_timer2_increment)
        }
        else {
            //keep
        }
    }

    
    
    
    //---------------------------
    
    //do so by simply pressing the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    //if users input a comma, extract number from it
    func removeFormat(string:String) -> NSNumber{
        let formatter = NumberFormatter()
        // specify a locale where the decimalSeparator is a comma
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        return formatter.number(from: string) ?? 0
    }





    

    @IBAction func Edit_Slider_Expand(_ sender: UIButton?) {//"?" is so i can call function without pressing button, if slider needs fixed when app opens
        //easiest to start with whole numbers
        loaned_min_input.text = String(format: "%.0f", min_value)
        loaned_max_input.text = String(format: "%.0f", max_value)
        input_number_of_increments.text = String(format: "%.0f", number_of_increments)
        
        if (increment - floor(increment) == 0) {
            increment_input.text = String(format: "%.0f", increment)
            increment_input.textColor = UIColor(red: 161/255.0, green: 166/255.0, blue: 168/255.0, alpha: 1.0)
            increment_input.alpha = 0.25
            increment_input.layer.removeAllAnimations()
            even_out.isHidden = true
            submit_changes.isEnabled = true
            suggest.isHidden = true
        }
        else {
            even_out.isHidden = false
            submit_changes.isEnabled = false
            if (number_of_increments == 0) {
                increment_input.text = "∞"
            }
            else {
                increment_input.text = String(format: "%.5f", increment)
            }
            
            increment_input.textColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 1.0)
            suggest.isHidden = false
        }
        var suggestions = [Int]()
        var tailored_suggestions = String()
        //var suggestions = ""
        var suggestions_index = -1
        for testing_suggestions in 20...60 {
            let result = (max_value - min_value)/Double(testing_suggestions)
            if (result - floor(result) == 0) {
                //suggestions += "\(testing_suggestions)   "
                suggestions.append(testing_suggestions)
                suggestions_index += 1
            }
        }
        if (suggestions == []) {
            suggest.text = "Even out the minimum or maximum, first."
        }
        else {
            if (suggestions_index == 0) {
                suggest.text = "Suggestion: \(suggestions[suggestions_index]) increments"
            }
            else if (suggestions_index == 1) {//use "or"
                suggest.text = "Suggestions: \(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
            }
            else {//use commas and "or" (e.g., "20, 25 or 40")
                for tailoring_suggestions in 0...(suggestions_index-2) {
                    tailored_suggestions += "\(suggestions[tailoring_suggestions]), "
                }
                suggest.text = "Suggestions: \(tailored_suggestions)\(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
            }
        }

        
        edit_slider.isHidden = true
        //loaned.isEnabled = false
        loaned_min_input.isUserInteractionEnabled = true
        loaned_max_input.isUserInteractionEnabled = true
        input_number_of_increments.isUserInteractionEnabled = true
        
        edit_slider_shape.isHidden = false
        submit_changes.isHidden = false
        increment_input_left_label.isHidden = false
        increment_input.isHidden = false
        increment_input_right_label.isHidden = false
        input_number_of_increments.isHidden = false
        bare_track.isHidden = false
        //loaned_min_input.isHidden = false
        
        view.addSubview(edit_slider_shape)
        //edit_slider_shape.frame = CGRect(x: view.frame.origin.x+5, y: edit_slider_shape.frame.origin.y, width: view.frame.width-10, height: edit_slider_shape.frame.height)
        view.bringSubviewToFront(edit_slider_shape)
        
        view.willRemoveSubview(stack_min)
        view.addSubview(stack_max)
        edit_slider_shape.addSubview(stack_min)
        edit_slider_shape.addSubview(stack_max)
        edit_slider_shape.addSubview(stack_inputs)
        edit_slider_shape.addSubview(bare_track)
        edit_slider_shape.addSubview(even_out)
        //view.willRemoveSubview(loaned)
        //edit_slider_shape.addSubview(loaned)
        //edit_slider_shape.addSubview(loaned_min_input)
        //edit_slider_shape.addSubview(loaned_max_input)
        edit_slider_shape.addSubview(submit_changes)
        edit_slider_shape.bringSubviewToFront(stack_min)
        edit_slider_shape.bringSubviewToFront(stack_max)
        edit_slider_shape.bringSubviewToFront(even_out)
        //edit_slider_shape.bringSubviewToFront(loaned_min_input)
        //edit_slider_shape.bringSubviewToFront(loaned_max_input)
        edit_slider_shape.bringSubviewToFront(submit_changes)
        //from old idea, now part of stack_inputs:
        edit_slider_shape.bringSubviewToFront(stack_inputs)
        //edit_slider_shape.bringSubviewToFront(increment_input_left_label)
        //edit_slider_shape.bringSubviewToFront(increment_input)
        //edit_slider_shape.bringSubviewToFront(increment_input_right_label)
        //edit_slider_shape.bringSubviewToFront(input_number_of_increments)
        edit_slider_shape.bringSubviewToFront(bare_track)
        
        edit_slider_shape.addSubview(loaned_title)
        edit_slider_shape.bringSubviewToFront(loaned_title)
        submit_changes.alpha = 0.0
        
        
        //changed mind on increment input


        //edit_slider_shape.transform = CGAffineTransform(scaleX: 0.9375, y: 0.9375)
        
        UIView.animate(withDuration: 0.0125, animations: {
            //necessary????
            //self.edit_slider_shape.transform = CGAffineTransform(scaleX: 0.9375, y: 0.9375)
            /*self.increment_input_left_label.alpha = 0.0
            self.increment_input.alpha = 0.0
            self.increment_input_right_label.alpha = 0.0
            self.input_number_of_increments.alpha = 0.0
            self.bare_track.alpha = 0.0
            self.loaned_minimum.alpha = 1.0
            self.loaned_maximum.alpha = 1.0
            self.loaned_title.alpha = 1.0*/
            //self.edit_slider_shape_tweak.fillColor = UIColor(red:74/255.0, green:82/255.0, blue:86/255.0, alpha: 0.75).cgColor
            self.edit_slider_shape_tweak.fillColor = UIColor(red:32/255.0, green:36/255.0, blue:38/255.0, alpha: 0.0).cgColor
            //self.input_background.alpha = 0.0
            //self.loaned.setThumbImage(UIImage(named: "Thumb"), for: .normal)
        },
                       completion: {
                        (finished: Bool) -> Void in
                        UIView.animate(withDuration: 0.25, animations: {
                            
                            
                            
                                       //) {//otherwise increment_input wouldn't blend
                            //self.edit_slider_shape.transform = CGAffineTransform.identity
                        self.increment_input_left_label.alpha = 0.25
                        self.increment_input.alpha = 0.25
                        self.increment_input_right_label.alpha = 0.25
                            self.loaned_minimum.alpha = 0.125
                            self.loaned_maximum.alpha = 0.125
                            self.loaned_title.alpha = 0.125
                            self.loaned_title.font = UIFont(name: "HelveticaNeue", size: 17.0)
                            self.input_number_of_increments.alpha = 1
                            self.bare_track.alpha = 0.5
                            //self.increment_input.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            self.input_number_of_increments.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            self.loaned_min_input.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            self.loaned_max_input.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            //self.edit_slider_shape_tweak.fillColor = UIColor(red:74/255.0, green:82/255.0, blue:86/255.0, alpha: 1.0).cgColor
                            self.edit_slider_shape_tweak.fillColor = UIColor(red:32/255.0, green:36/255.0, blue:38/255.0, alpha: 1.0).cgColor
                            //self.loaned.setThumbImage(UIImage(), for: .normal)
                            //self.input_background.alpha = 0.75
                            self.submit_changes.alpha = 1.0
                            self.loaned_min_input.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                            self.loaned_max_input.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                            self.input_number_of_increments.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                        }, completion: {
                            (finished: Bool) -> Void in
                            if (self.increment - floor(self.increment) != 0) {
                                self.increment_input.alpha = 1.0
                                UIView.animate(withDuration: 0.0625, delay: 0.0, options: [.repeat, .autoreverse, .curveEaseInOut], animations:
                                    {
                                        UIView.setAnimationRepeatCount(3)
                                        self.increment_input.alpha = 0.0
                                }, completion: {
                                    (finished: Bool) -> Void in
                                    self.increment_input.alpha = 1.0
                                })
                            }
                        }
                        )

                        //}
        })

    }
    @IBAction func Edit_Slider_Close(_ sender: UIButton) {
        //loaned.setThumbImage(UIImage(named: "Thumb"), for: .normal)
        
        if (locked.isHidden == false) {
            edit_slider.isHidden = true//else it'll show if correct slider on startup
        }
        else {
            edit_slider.isHidden = false
        }
        increment_input_left_label.isHidden = true
        increment_input.isHidden = true
        increment_input_right_label.isHidden = true
        input_number_of_increments.isHidden = true
        bare_track.isHidden = true
        //loaned.isEnabled = true
        loaned_min_input.isUserInteractionEnabled = false
        loaned_max_input.isUserInteractionEnabled = false
        input_number_of_increments.isUserInteractionEnabled = false
        
        edit_slider_shape.isHidden = true
        //edit_slider_shape_tweak.fillColor = UIColor(red:74/255.0, green:82/255.0, blue:86/255.0, alpha: 0.75).cgColor
        edit_slider_shape_tweak.fillColor = UIColor(red:32/255.0, green:36/255.0, blue:38/255.0, alpha: 0.0).cgColor
        increment_input_left_label.alpha = 0.0
        increment_input.alpha = 0.0
        increment_input_right_label.alpha = 0.0
        input_number_of_increments.alpha = 0.0
        loaned_minimum.alpha = 1.0
        loaned_maximum.alpha = 1.0
        loaned_title.alpha = 1.0
        bare_track.alpha = 0.0
        //increment_input.font = UIFont(name: "HelveticaNeue", size: 17.0)
        input_number_of_increments.font = UIFont(name: "HelveticaNeue", size: 17.0)
        loaned_min_input.font = UIFont(name: "HelveticaNeue", size: 17.0)
        loaned_max_input.font = UIFont(name: "HelveticaNeue", size: 17.0)
        loaned_title.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
        submit_changes.isHidden = true
        //loaned_min_input.isHidden = false
        
        //edit_slider_shape.willRemoveSubview(loaned_min_input)
        //edit_slider_shape.willRemoveSubview(loaned_max_input)
        edit_slider_shape.willRemoveSubview(stack_min)
        edit_slider_shape.willRemoveSubview(stack_max)
        view.addSubview(stack_min)
        view.addSubview(stack_max)
        //view.addSubview(loaned_min_input)
        //view.addSubview(loaned_max_input)
        
        edit_slider_shape.willRemoveSubview(loaned_title)
        //edit_slider_shape.willRemoveSubview(loaned)
        view.addSubview(loaned_title)
        //view.addSubview(loaned)

        
        //input_background.alpha = 0.0
        
        //to tidy up:
        loaned_min_input.text = numberFormatter.string(from: NSNumber(value: min_value))! //otherwise won't show real value
        loaned_max_input.text = numberFormatter.string(from: NSNumber(value: max_value))! //otherwise won't show real value
        //input_number_of_increments.text = numberFormatter.string(from: NSNumber(value: number_of_increments))!
        loaned_min_input.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        loaned_max_input.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        input_number_of_increments.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        loaned.isHidden = false//show if it's hidden
    }
    
    
    @IBAction func Edit_Apr_Expand(_ sender: UIButton) {
        edit_apr.isHidden = true
        apr_number.isUserInteractionEnabled = true
        apr_number.text = String(format: "%.2f", i * 12 * 100)
        apr_number_back.text = String(format: "%.2f", i * 12 * 100)
        
        edit_apr_shape.isHidden = false
        submit_changes_apr.isHidden = false
        
        view.addSubview(edit_apr_shape)
        view.bringSubviewToFront(edit_apr_shape)
        
        edit_apr_shape.addSubview(edit_apr_text)
        edit_apr_shape.addSubview(submit_changes_apr)
        edit_apr_shape.bringSubviewToFront(edit_apr_text)
        edit_apr_shape.bringSubviewToFront(submit_changes_apr)
        
        edit_apr_shape.addSubview(apr_title)
        edit_apr_shape.bringSubviewToFront(apr_title)
        //edit_apr_shape.addSubview(apr)
        //edit_apr_shape.bringSubviewToFront(apr)
        //apr.isEnabled = false
        //apr.alpha = 0.125
        submit_changes_apr.alpha = 0.0


        
        UIView.animate(withDuration: 0.0125, animations: {
            self.interest_rate_unpressed_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
            self.edit_apr_shape_tweak_triangleLayer.strokeColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
            /*if (self.apr.isOn == false) {
                self.apr_number.alpha = 0.125
            }
            else {
                //self.apr_number.alpha = 1.0
            }*/
            //self.edit_apr_shape_tweak.fillColor = UIColor(red:74/255.0, green:82/255.0, blue:86/255.0, alpha: 0.75).cgColor
            self.edit_apr_shape_tweak.fillColor = UIColor(red:32/255.0, green:36/255.0, blue:38/255.0, alpha: 0.0).cgColor
            //self.table_view.alpha = 1.0
            self.switch_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
            self.switch_thumb_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
            /*self.apr_title.alpha = 1.0*/

        },
                       completion: {
                        (finished: Bool) -> Void in
                        UIView.animate(withDuration: 0.25) {//otherwise increment_input wouldn't blend
                            self.apr_sign.alpha = 0.125
                            self.interest_rate_unpressed_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.5).cgColor
                            self.edit_apr_shape_tweak_triangleLayer.strokeColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.125).cgColor
                            self.apr_number.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            /*if (self.apr.isOn == false) {
                                self.apr_number.alpha = 1.0
                            }
                            else {
                                //self.apr_number.alpha = 1.0
                            }*/
                            //self.edit_apr_shape_tweak.fillColor = UIColor(red:74/255.0, green:82/255.0, blue:86/255.0, alpha: 1.0).cgColor
                            self.edit_apr_shape_tweak.fillColor = UIColor(red:32/255.0, green:36/255.0, blue:38/255.0, alpha: 1.0).cgColor
                            self.table_view.alpha = 0.0 //if it's open
                            self.switch_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.5).cgColor
                            self.switch_thumb_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.5).cgColor
                            self.apr_title.alpha = 0.125
                            self.apr_title.font = UIFont(name: "HelveticaNeue", size: 17.0)
                            self.submit_changes_apr.alpha = 1.0
                            self.apr_number.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)


                        }
        })
        
    }
    @IBAction func Edit_Apr_Close(_ sender: UIButton) {
        edit_apr.isHidden = false
        //increment_input_left_label.isHidden = true
        //increment_input.isHidden = true
        //increment_input_right_label.isHidden = true
        //input_number_of_increments.isHidden = true
        //loaned_min_input.isUserInteractionEnabled = false
        //loaned_max_input.isUserInteractionEnabled = false
        //input_number_of_increments.isUserInteractionEnabled = false
        apr_number.isUserInteractionEnabled = false
        
        /*if (apr.isOn == false) {
            apr_number.alpha = 0.125
        }
        else {
            //apr_number.alpha = 1.0
        }*/
        
        edit_apr_shape.isHidden = true
        //edit_apr_shape_tweak.fillColor = UIColor(red:74/255.0, green:82/255.0, blue:86/255.0, alpha: 0.75).cgColor
        edit_apr_shape_tweak.fillColor = UIColor(red:32/255.0, green:36/255.0, blue:38/255.0, alpha: 0.0).cgColor
        //increment_input_left_label.alpha = 0.0
        //increment_input.alpha = 0.0
        //increment_input_right_label.alpha = 0.0
        //input_number_of_increments.alpha = 0.0
        //loaned_minimum.alpha = 1.0
        //loaned_maximum.alpha = 1.0
        apr_sign.alpha = 1.0
        interest_rate_unpressed_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
        edit_apr_shape_tweak_triangleLayer.strokeColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
        switch_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
        switch_thumb_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
        //input_number_of_increments.font = UIFont(name: "HelveticaNeue", size: 17.0)
        //loaned_min_input.font = UIFont(name: "HelveticaNeue", size: 17.0)
        //loaned_max_input.font = UIFont(name: "HelveticaNeue", size: 17.0)
        apr_number.font = UIFont(name: "HelveticaNeue", size: 17.0)
        submit_changes_apr.isHidden = true
        
        edit_apr_shape.willRemoveSubview(edit_apr_text)
        //edit_apr_shape.willRemoveSubview(stack_max)
        view.addSubview(edit_apr_text) //may need to put in front again???
        //view.addSubview(stack_max)
        
        edit_apr_shape.willRemoveSubview(apr_title)
        view.addSubview(apr_title)
        //edit_apr_shape.willRemoveSubview(apr)
        //view.addSubview(apr)
        //apr.isEnabled = true
        //apr.alpha = 1.0
        apr_title.alpha = 1.0
        apr_title.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
        interest_rate_unpressed_copy.isHidden = true
        //interest_rate_disabled.isHidden = false
        interest_rate_unpressed.isHidden = false
        //interest_rate_disabled.isHidden = true
        apr_number.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        apr_number.text = String(format: "%.2f", i * 12 * 100)
        apr_number_back.text = String(format: "%.2f", i * 12 * 100)
    }
    
    //-----------------------------
    
    @IBAction func Edit_Pay_Expand(_ sender: UIButton) {
        edit_pay.isHidden = true
        down_number.isUserInteractionEnabled = true
        pay_number.isUserInteractionEnabled = true
        up_number.isUserInteractionEnabled = true
        down_timer1_seconds.isUserInteractionEnabled = true
        down_timer2_seconds.isUserInteractionEnabled = true
        down_timer1_increment.isUserInteractionEnabled = true
        down_timer2_increment.isUserInteractionEnabled = true
        up_timer1_seconds.isUserInteractionEnabled = true
        up_timer2_seconds.isUserInteractionEnabled = true
        up_timer1_increment.isUserInteractionEnabled = true
        up_timer2_increment.isUserInteractionEnabled = true
        
        down_number.text = String(format: "%.0f", down_button_increment)
        pay_number.text = String(format: "%.2f", a)
        up_number.text = String(format: "%.0f", up_button_increment)
        down_timer1_seconds.text = String(format: "%.0f", set_down_timer1_seconds)
        down_timer2_seconds.text = String(format: "%.0f", set_down_timer2_seconds)
        down_timer1_increment.text = String(format: "%.0f", set_down_timer1_increment)
        down_timer2_increment.text = String(format: "%.0f", set_down_timer2_increment)
        up_timer1_seconds.text = String(format: "%.0f", set_up_timer1_seconds)
        up_timer2_seconds.text = String(format: "%.0f", set_up_timer2_seconds)
        up_timer1_increment.text = String(format: "%.0f", set_up_timer1_increment)
        up_timer2_increment.text = String(format: "%.0f", set_up_timer2_increment)


        down_sign.isHidden = false
        down_number.isHidden = false
        up_sign.isHidden = false
        up_number.isHidden = false
        stack_inputs_timers_down.isHidden = false
        stack_inputs_timers_up.isHidden = false
        //abs_10yr.isHidden = true

        edit_pay_shape.isHidden = false
        submit_changes_pay.isHidden = false
        
        view.addSubview(edit_pay_shape)
        view.bringSubviewToFront(edit_pay_shape)
        
        edit_pay_shape.addSubview(edit_pay_text)
        edit_pay_shape.addSubview(stack_inputs_down)
        edit_pay_shape.addSubview(stack_inputs_up)
        edit_pay_shape.addSubview(submit_changes_pay)
        edit_pay_shape.addSubview(stack_inputs_timers_down)
        edit_pay_shape.addSubview(stack_inputs_timers_up)
        edit_pay_shape.bringSubviewToFront(edit_pay_text)
        edit_pay_shape.bringSubviewToFront(stack_inputs_down)
        edit_pay_shape.bringSubviewToFront(stack_inputs_up)
        edit_pay_shape.bringSubviewToFront(submit_changes_pay)
        edit_pay_shape.bringSubviewToFront(stack_inputs_timers_down)
        edit_pay_shape.bringSubviewToFront(stack_inputs_timers_up)
        
        edit_pay_shape.addSubview(pay_monthly_title)
        edit_pay_shape.bringSubviewToFront(pay_monthly_title)
        
        //edit_pay_shape.addSubview(minimum)
        //edit_pay_shape.bringSubviewToFront(minimum)
        submit_changes_pay.alpha = 0.0


        
        UIView.animate(withDuration: 0.0125, animations: {
            self.down_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
            self.pay_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
            self.up_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
            /*self.pay_sign.alpha = 1.0
            self.down_sign.alpha = 0.0
            self.down_number.alpha = 0.0
            self.up_sign.alpha = 0.0
            self.up_number.alpha = 0.0*/
            //self.edit_pay_shape_tweak.fillColor = UIColor(red:74/255.0, green:82/255.0, blue:86/255.0, alpha: 0.75).cgColor
            self.edit_pay_shape_tweak.fillColor = UIColor(red:32/255.0, green:36/255.0, blue:38/255.0, alpha: 0.0).cgColor
            self.pay_monthly_title.alpha = 1.0
            self.minimum.textColor = UIColor(red:109/255.0, green:130/255.0, blue:159/255.0, alpha: 1.0)

            //self.table_view.alpha = 1.0
        },
                       completion: {
                        (finished: Bool) -> Void in
                        UIView.animate(withDuration: 0.25) {//otherwise increment_input wouldn't blend
                            self.pay_sign.alpha = 0.125
                            self.down_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.5).cgColor
                            self.pay_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.5).cgColor
                            self.up_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.5).cgColor
                            self.down_number.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            self.pay_number.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            self.up_number.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            self.down_timer1_seconds.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            self.down_timer2_seconds.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            self.down_timer1_increment.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            self.down_timer2_increment.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            self.up_timer1_seconds.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            self.up_timer2_seconds.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            self.up_timer1_increment.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            self.up_timer2_increment.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
                            //self.edit_pay_shape_tweak.fillColor = UIColor(red:74/255.0, green:82/255.0, blue:86/255.0, alpha: 0.9).cgColor
                            self.edit_pay_shape_tweak.fillColor = UIColor(red:32/255.0, green:36/255.0, blue:38/255.0, alpha: 1.0).cgColor
                            self.down_sign.alpha = 0.25
                            self.down_number.alpha = 1.0
                            self.up_sign.alpha = 0.25
                            self.up_number.alpha = 1.0
                            
                            self.down_timer1.alpha = 0.25
                            self.down_timer2.alpha = 0.25
                            self.down_timer1_seconds.alpha = 0.75
                            self.down_timer2_seconds.alpha = 0.75
                            self.down_timer1_seconds_label.alpha = 0.25
                            self.down_timer2_seconds_label.alpha = 0.25
                            self.down_timer1_increment.alpha = 0.75
                            self.down_timer2_increment.alpha = 0.75
                            
                            self.up_timer1.alpha = 0.25
                            self.up_timer2.alpha = 0.25
                            self.up_timer1_seconds.alpha = 0.75
                            self.up_timer2_seconds.alpha = 0.75
                            self.up_timer1_seconds_label.alpha = 0.25
                            self.up_timer2_seconds_label.alpha = 0.25
                            self.up_timer1_increment.alpha = 0.75
                            self.up_timer2_increment.alpha = 0.75
                            
                            self.pay_monthly_title.alpha = 0.125
                            self.minimum.textColor = UIColor(red:255/255.0, green:255/255.0, blue:255/255.0, alpha: 0.03125)
                            self.pay_monthly_title.font = UIFont(name: "HelveticaNeue", size: 17.0)
                            self.view.bringSubviewToFront(self.table_view) //in case someone wants to open table_view
                            self.submit_changes_pay.alpha = 1.0
                            self.down_number.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                            self.pay_number.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                            self.up_number.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                            self.down_timer1_seconds.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                            self.down_timer2_seconds.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                            self.down_timer1_increment.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                            self.down_timer2_increment.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                            self.up_timer1_seconds.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                            self.up_timer2_seconds.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                            self.up_timer1_increment.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                            self.up_timer2_increment.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0.125)
                        }
        })
        
    }
    @IBAction func Edit_Pay_Close(_ sender: UIButton) {
        edit_pay.isHidden = false
        down_sign.isHidden = true
        down_number.isHidden = true
        up_sign.isHidden = true
        up_number.isHidden = true
        stack_inputs_timers_down.isHidden = true
        stack_inputs_timers_up.isHidden = true
        //abs_10yr.isHidden = false
        
        down_number.isUserInteractionEnabled = false
        pay_number.isUserInteractionEnabled = false
        up_number.isUserInteractionEnabled = false
        down_timer1_seconds.isUserInteractionEnabled = false
        down_timer2_seconds.isUserInteractionEnabled = false
        down_timer1_increment.isUserInteractionEnabled = false
        down_timer2_increment.isUserInteractionEnabled = false
        up_timer1_seconds.isUserInteractionEnabled = false
        up_timer2_seconds.isUserInteractionEnabled = false
        up_timer1_increment.isUserInteractionEnabled = false
        up_timer2_increment.isUserInteractionEnabled = false


        edit_pay_shape.isHidden = true
        //edit_pay_shape_tweak.fillColor = UIColor(red:74/255.0, green:82/255.0, blue:86/255.0, alpha: 0.75).cgColor
        edit_pay_shape_tweak.fillColor = UIColor(red:32/255.0, green:36/255.0, blue:38/255.0, alpha: 0.0).cgColor
        pay_sign.alpha = 1.0
        down_sign.alpha = 0.0
        down_number.alpha = 0.0
        up_sign.alpha = 0.0
        up_number.alpha = 0.0
        
        down_timer1.alpha = 0.0
        down_timer2.alpha = 0.0
        down_timer1_seconds.alpha = 0.0
        down_timer2_seconds.alpha = 0.0
        down_timer1_seconds_label.alpha = 0.0
        down_timer2_seconds_label.alpha = 0.0
        down_timer1_increment.alpha = 0.0
        down_timer2_increment.alpha = 0.0
        
        up_timer1.alpha = 0.0
        up_timer2.alpha = 0.0
        up_timer1_seconds.alpha = 0.0
        up_timer2_seconds.alpha = 0.0
        up_timer1_seconds_label.alpha = 0.0
        up_timer2_seconds_label.alpha = 0.0
        up_timer1_increment.alpha = 0.0
        up_timer2_increment.alpha = 0.0
        
        down_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
        pay_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
        up_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
        down_number.font = UIFont(name: "HelveticaNeue", size: 17.0)
        pay_number.font = UIFont(name: "HelveticaNeue", size: 17.0)
        up_number.font = UIFont(name: "HelveticaNeue", size: 17.0)
        down_timer1_seconds.font = UIFont(name: "HelveticaNeue", size: 17.0)
        down_timer2_seconds.font = UIFont(name: "HelveticaNeue", size: 17.0)
        down_timer1_increment.font = UIFont(name: "HelveticaNeue", size: 17.0)
        down_timer2_increment.font = UIFont(name: "HelveticaNeue", size: 17.0)
        up_timer1_seconds.font = UIFont(name: "HelveticaNeue", size: 17.0)
        up_timer2_seconds.font = UIFont(name: "HelveticaNeue", size: 17.0)
        up_timer1_increment.font = UIFont(name: "HelveticaNeue", size: 17.0)
        up_timer2_increment.font = UIFont(name: "HelveticaNeue", size: 17.0)

        submit_changes_pay.isHidden = true
        
        edit_pay_shape.willRemoveSubview(edit_pay_text)
        view.addSubview(edit_pay_text) //may need to put in front again???
        
        edit_pay_shape.willRemoveSubview(pay_monthly_title)
        view.addSubview(pay_monthly_title)
        view.bringSubviewToFront(table_view) //may be redundant
        //edit_pay_shape.willRemoveSubview(minimum)
        //view.addSubview(minimum)
        pay_monthly_title.alpha = 1.0
        minimum.textColor = UIColor(red:109/255.0, green:130/255.0, blue:159/255.0, alpha: 1.0)
        pay_monthly_title.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
        down_number.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        pay_number.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        up_number.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        down_timer1_seconds.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        down_timer2_seconds.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        down_timer1_increment.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        down_timer2_increment.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        up_timer1_seconds.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        up_timer2_seconds.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        up_timer1_increment.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)
        up_timer2_increment.backgroundColor = UIColor(red: 109/255.0, green: 129/255.0, blue: 158/255.0, alpha: 0)

        down_number.text = numberFormatter.string(from: NSNumber(value: down_button_increment))!
        if (a - floor(a) == 0) {
            pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
        }
        else if ((a - floor(a))*100 < 9.99999) {
            pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
        }
        else {
            pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
        }
        up_number.text = numberFormatter.string(from: NSNumber(value: up_button_increment))!
        down_timer1_seconds.text = numberFormatter.string(from: NSNumber(value: set_down_timer1_seconds))!
        down_timer2_seconds.text = numberFormatter.string(from: NSNumber(value: set_down_timer2_seconds))!
        down_timer1_increment.text = numberFormatter.string(from: NSNumber(value: set_down_timer1_increment))!
        down_timer2_increment.text = numberFormatter.string(from: NSNumber(value: set_down_timer2_increment))!
        up_timer1_seconds.text = numberFormatter.string(from: NSNumber(value: set_up_timer1_seconds))!
        up_timer2_seconds.text = numberFormatter.string(from: NSNumber(value: set_up_timer2_seconds))!
        up_timer1_increment.text = numberFormatter.string(from: NSNumber(value: set_up_timer1_increment))!
        up_timer2_increment.text = numberFormatter.string(from: NSNumber(value: set_up_timer2_increment))!


    }

    @IBAction func Absolute_Clicked(_ sender: UIButton) {
        absolute.setImage(UIImage(named: "Submit"), for: .normal)
        tenyr.setImage(UIImage(named: "Off"), for: .normal)
        UIView.animate(withDuration: 0.25,
            animations: { self.absolute.transform = CGAffineTransform(scaleX: 1.125, y: 1.125) },
            completion: { (finished: Bool) -> Void in
                UIView.animate(withDuration: 0.25,
                    animations: { self.absolute.transform = CGAffineTransform.identity },
                    completion: { (finished: Bool) -> Void in }
                )
            }
        )
        tenyr_indicator = 0.0
        shared_preferences.set(tenyr_indicator, forKey: "tenyr"); shared_preferences.synchronize()

        var temp = Double()
        if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
        { temp = (round(p*i*100 + 1) + 1)/100}
        else { temp = (round(p*i*100) + 1)/100 }
        if (temp >= a)
        {
            a = temp
            a_reference = temp
            shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
            if (a - floor(a) == 0) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
            }
            else if ((a - floor(a))*100 < 9.99999) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
            }
            else {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
            }

            minimum.isHidden = false
            minimum.text = "Minimum"
        }
        else
        {
            //minimum.isHidden = true
            minimum.isHidden = false
            minimum.text = " "
        }
        Lengthsaving()
    }
    
    @IBAction func TenYr_Clicked(_ sender: UIButton) {
        tenyr.setImage(UIImage(named: "Submit"), for: .normal)
        absolute.setImage(UIImage(named: "Off"), for: .normal)
        UIView.animate(withDuration: 0.25,
            animations: { self.tenyr.transform = CGAffineTransform(scaleX: 1.125, y: 1.125) },
            completion: { (finished: Bool) -> Void in
                UIView.animate(withDuration: 0.25,
                    animations: { self.tenyr.transform = CGAffineTransform.identity },
                    completion: { (finished: Bool) -> Void in }
                )
            }
        )
        tenyr_indicator = 1.0
        shared_preferences.set(tenyr_indicator, forKey: "tenyr"); shared_preferences.synchronize()
        //let x = (-i*p*pow(1+i,120)) / (1 - pow(1+i,120))
        //var temp = Double()
        //if (x*100 - floor(x*100) > 0.499999) && (x*100 - floor(x*100) < 0.5)
        //{ temp = (round(x*100 + 1) + 1)/100}
        //else { temp = (round(x*100) + 1)/100 }
        var temp = Double()
            if (i != 0) {
                temp = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
            }
            else {
                temp = ceil(p/120*100)/100
            }

        
        
        if (temp >= a)
        {
            a = temp
            a_reference = temp
            shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
            //pay_number.text = String(format: "%.2f", a)
            if (a - floor(a) == 0) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
            }
            else if ((a - floor(a))*100 < 9.99999) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
            }
            else {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
            }

            
            minimum.isHidden = false
            minimum.text = "Minimum"
        }
        else
        {
            //minimum.isHidden = true
            minimum.isHidden = false
            minimum.text = " "
        }
        Lengthsaving()

    }
    
    
    //-----------------------------
    
    //instructions for slider
    @IBAction func Slider(_ sender: UISlider) {
        //increment = 200
        if (sender.value - floor(sender.value) > 0.99999)
        { sender.value = roundf(sender.value + 1) }
        else { sender.value = roundf(sender.value) }
        //sender.value = roundf(sender.value)
        //print(sender.value)

        //sender.value = roundf(sender.value)
        //sender.value = Double(sender.value)
        //print(sender.value)
        //var progress:Int = Int(sender.value)
        //progress = Int(sender.value)
        //progress = increment * progress + 2000
        progress = increment * Double(sender.value) + min_value
//        progress = increment * sender.value + min_value
        //print(increment)
        //print(sender.value)
        //print("progress changed to",progress,"which equals",increment,"*",sender.value,"+",min_value)

        /*//catching exception
        if progress.isNaN {
            progress = min_value
            //loaned.isEnabled = false
        }
        else {
            //loaned.isEnabled = true
            //keep going
        }*/


        //set up loaned_view
        /*view.addSubview(loaned_subview)
        loaned_subview.translatesAutoresizingMaskIntoConstraints = false //Don't forget this line
        let leftSideConstraint = NSLayoutConstraint(item: loaned_subview, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: loaned_subview, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(item: loaned_subview, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(item: loaned_subview, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0.0)
        view.addConstraints([leftSideConstraint, bottomConstraint, heightConstraint, widthConstraint])
        
        //subview slider and labels around it*/
        //view.addSubview(loaned_minimum)
        //view.addSubview(loaned_maximum)
        view.addSubview(loaned)
        
        //subview slider thumb bubble, so it moves with thumb
        if let thumb_bubble = loaned.subviews.last as? UIImageView {
            bubble_label.backgroundColor = UIColor(red: 161.0/255, green: 166.0/255, blue: 168.0/255, alpha: 1.0)
            bubble_label.textColor = UIColor(red: 64.0/255, green: 73.0/255, blue: 77.0/255, alpha: 1.0)
            bubble_label.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
            
            bubble_label.textAlignment = .center
            bubble_label.layer.masksToBounds = true
            bubble_label.layer.cornerRadius = 5
            
            /*let arrow_pressed_copy_label = CATextLayer()
            arrow_pressed_copy_label.foregroundColor = UIColor(red: 254.0/255, green: 254.0/255, blue: 254.0/255, alpha: 1.0).cgColor
            /*arrow_pressed_copy_label.frame = CGRect(x: 0.75*interest_rate_pressed_copy.frame.width-15, y: interest_rate_pressed_copy.frame.height/2-15+0.5, width: interest_rate_pressed_copy.frame.width, height: interest_rate_pressed_copy.frame.height)*/
            arrow_pressed_copy_label.string = "↓"
            arrow_pressed_copy_label.fontSize = 20
            interest_rate_pressed_copy.layer.addSublayer(arrow_pressed_copy_label)*/
            
            let trianglePath = UIBezierPath()
            trianglePath.move(to: CGPoint(x: 0, y: 0))
            trianglePath.addLine(to: CGPoint(x: 14, y: 0))
            trianglePath.addLine(to: CGPoint(x: 7, y: 7))
            trianglePath.close()
            
            let triangleLayer = CAShapeLayer()
            triangleLayer.path = trianglePath.cgPath
            triangleLayer.fillColor = UIColor(red: 161.0/255, green: 166.0/255, blue: 168.0/255, alpha: 1.0).cgColor
            bubble_label_arrow.layer.addSublayer(triangleLayer)
            
            /*loaned.layer.addSublayer(mintrack_triangleLayer)*/
            
            /*loaned.minimumTrackImage(for: .normal).layer.mask = mintrack_triangleLayer*/


            /*bubble_label_arrow.backgroundColor = UIColor(patternImage: UIImage(named: "bubble_label_arrow.png")!)*/
            thumb_bubble.addSubview(bubble_label)
            thumb_bubble.addSubview(bubble_label_arrow)
            thumb_bubble.bringSubviewToFront(bubble_label_arrow)
            thumb_bubble.bringSubviewToFront(bubble_label)
            bubble_label.text = "$" + numberFormatter.string(from: NSNumber(value: progress))!
            var previous_subviews = loaned.subviews
            previous_subviews.removeAll()
            //thumb_bubble.isHidden = true
        }
        
        if (Double(progress) != p) {
        p = Double(progress)
            

//        if (progress != p) {
//            p = progress
        
        //print(p,terminator:"\n")
        /*let temp = Double(Int((p * i + 0.01) * 100)) / 100*/
            var temp = Double()
            if (tenyr_indicator == 0) {
                if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
                { temp = (round(p*i*100 + 1) + 1)/100}
                else { temp = (round(p*i*100) + 1)/100 }
            }
            else {
                if (i != 0) {
                    temp = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
                }
                else {
                    temp = ceil(p/120*100)/100
                }
            }

            //let x = (-i*p*pow(1+i,120)) / (1 - pow(1+i,120))
            //var temp = Double()
            //if (x*100 - floor(x*100) > 0.499999) && (x*100 - floor(x*100) < 0.5)
            //{ temp = (round(x*100 + 1) + 1)/100}
            //else { temp = (round(x*100) + 1)/100 }
            


        //print(p)
        //print(i)
        //print(Int(p*i*100))
        //print(temp)
        //print(a)
            
        if (temp >= a)
        {
            a = temp
            a_reference = temp
            shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
            if (a - floor(a) == 0) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
            }
            else if ((a - floor(a))*100 < 9.99999) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
            }
            else {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
            }

            minimum.isHidden = false
            minimum.text = "Minimum"
        }
        else
        {
            //minimum.isHidden = true
            minimum.isHidden = false
            minimum.text = " "
        }
        Lengthsaving()
        shared_preferences.set(p, forKey: "loaned"); shared_preferences.synchronize() //could place sooner because needless if !=p
            
            //print(p,terminator:"\n")//do nothing

            
            
        } else {
            //do nothing?
            //print("Slider Released")
            
            
        }
        view.willRemoveSubview(loaned)

    }
    
    @IBAction func Slider_Touch_Down(_ sender: UISlider) {
        /*bubble_label.isHidden = false
        bubble_label_arrow.isHidden = false*/
        bubble_label.isHidden = false
        bubble_label_arrow.isHidden = false

        
        UIView.animate(withDuration: 0.125, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.bubble_label.alpha = 1.0
            self.bubble_label_arrow.alpha = 1.0

        }, completion: {
            (finished: Bool) -> Void in
            /*self.test.text = "Hello"*/

            /*// Fade in
             UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
             self.test.alpha = 1.0
             }, completion: nil)*/
        }
        )

        
    }
    @IBAction func Slider_Touch_Up(_ sender: UISlider) {
        /*bubble_label.isHidden = true
        bubble_label_arrow.isHidden = true*/
        UIView.animate(withDuration: 0.125, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.bubble_label.alpha = 0.0
            self.bubble_label_arrow.alpha = 0.0
        }, completion: nil)
        bubble_label.isHidden = true
        bubble_label_arrow.isHidden = true

        /*loaned_subview.removeFromSuperview()*/
    }
    
    
    //instructions for switch
    @IBAction func Switch(_ sender: UISwitch) {
        if apr.isOn {
            i = i_reference
            apr_number.text = String(format: "%.2f", i * 12 * 100)
            apr_number_back.text = String(format: "%.2f", i * 12 * 100)
            interest_rate_unpressed.isHidden = false
            interest_rate_disabled.isHidden = true
            if (unlocked_indicator == 1) {
                edit_apr.isHidden = false
            }
            apr_sign.alpha = 1
            apr_number.alpha = 1
            invisible.isHidden = false
            //invisible_back.isHidden = true
            //apr_number.isUserInteractionEnabled = true
            /*arrow_unpressed.isHidden = false
            arrow_disabled.isHidden = true*/
            //print(i)
            
        }
        else {
            i_reference = rates_reference[shared_preferences.integer(forKey: "position")]
//            if (decision == true) {
//                apr_number.text = String(format: "%.2f", i * 12 * 100)
//                apr_number_back.text = String(format: "%.2f", i * 12 * 100)
//                i = 0
//            }
//            else {
                i = 0
                apr_number.text = String(format: "%.2f", i * 12 * 100)
                apr_number_back.text = String(format: "%.2f", i * 12 * 100)
//            }
            
            interest_rate_unpressed.isHidden = true
            interest_rate_unpressed_copy.isHidden = true
            interest_rate_disabled.isHidden = false
            edit_apr.isHidden = true
            edit_apr_shape.isHidden = true
            edit_apr_shape.willRemoveSubview(edit_apr_text)
            view.addSubview(edit_apr_text)
            view.bringSubviewToFront(invisible)
            view.bringSubviewToFront(invisible_back)
            submit_changes_apr.isHidden = true
            apr_sign.alpha = 0.125
            apr_number.alpha = 0.125
            apr_number.isUserInteractionEnabled = false
            apr_number.font = UIFont(name: "HelveticaNeue", size: 17.0)
            invisible.isHidden = true
            invisible_back.isHidden = true
            /*if (i_reference == 0) {
                apr.isOn = false
            }
            else {
                //keep going
            }*/

            
            /*arrow_unpressed.isHidden = true
            arrow_unpressed_copy.isHidden = true
            arrow_disabled.isHidden = false*/
            /*table_view.isHidden = true*/
            /*down_unpressed.isHidden = false
            pay_monthly_title.isHidden = false
            pay_monthly_box.isHidden = false
            up_unpressed.isHidden = false*/
            self.table_view.alpha = 0.0 //need self?

            /*UIView.animate(withDuration: 0.125, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                /*self.table_view.frame = CGRect(x: self.table_view.frame.origin.x, y: self.table_view.frame.origin.y, width: self.table_view.frame.width, height: 0)*/
                /*self.view.addSubview(self.table_view)*/
                self.table_view.alpha = 0.0
                /*self.bubble_label.alpha = 0.0
                 self.bubble_label_arrow.alpha = 0.0*/
            }, completion: nil)*/
        

            
        }
        /*let temp = Double(Int((p * i + 0.01) * 100)) / 100*/
        /*        var temp = Double()
        if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { temp = (round(p*i*100 + 1) + 1)/100}
        else { temp = (round(p*i*100) + 1)/100 }*/

        var temp = Double()
        if (tenyr_indicator == 0) {
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { temp = (round(p*i*100 + 1) + 1)/100}
            else { temp = (round(p*i*100) + 1)/100 }
        }
        else {
            if (i != 0) {
                temp = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
            }
            else {
                temp = ceil(p/120*100)/100
            }
        }


        if (temp >= a)
        {
            a = temp
            a_reference = temp
            shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
            if (a - floor(a) == 0) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
            }
            else if ((a - floor(a))*100 < 9.99999) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
            }
            else {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
            }
            minimum.isHidden = false
            minimum.text = "Minimum"
        }
        else
        {
            //minimum.isHidden = true
            minimum.isHidden = false
            minimum.text = " "
        }
        Lengthsaving()
        shared_preferences.set(i * 12 * 100, forKey: "interest"); shared_preferences.synchronize()
    }
    
    /*@IBAction func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "iOScreator", message:
            "Hello, world!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }*/

    
    //instructions for interest_rate and arrow
    @IBAction func Interest_Rate_Unpressed(_ sender: UIButton) {
        /*table_view.isHidden = false*/
        /*down_unpressed.isHidden = true
        pay_monthly_title.isHidden = true
        pay_monthly_box.isHidden = true
        up_unpressed.isHidden = true
        minimum.isHidden = true*/
        interest_rate_unpressed_copy.isHidden = false
        interest_rate_pressed.isHidden = true
        edit_apr_text.isHidden = false
        edit_apr_text_back.isHidden = true
        invisible.isHidden = true
        invisible_back.isHidden = false
        /*arrow_unpressed.isHidden = true
        arrow_unpressed_copy.isHidden = false*/
        /*arrow_pressed.isHidden = true*/
        
        table_view.alpha = 1.0
        table_view.frame = CGRect(x: table_view.frame.origin.x, y: table_view.frame.origin.y, width: table_view.frame.width, height: 0)
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.table_view.frame = CGRect(x: self.table_view.frame.origin.x, y: self.table_view.frame.origin.y, width: self.table_view.frame.width, height: 100)

            /*self.bubble_label.alpha = 1.0
            self.bubble_label_arrow.alpha = 1.0*/
            
        }, completion: /*{
            (finished: Bool) -> Void in
            /*self.test.text = "Hello"*/
            
            /*// Fade in
             UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
             self.test.alpha = 1.0
             }, completion: nil)*/
        }*/
        nil)

        
    }
    @IBAction func Interest_Rate_Unpressed_Copy(_ sender: UIButton) {
        /*table_view.isHidden = true*/
        /*down_unpressed.isHidden = false
        pay_monthly_title.isHidden = false
        pay_monthly_box.isHidden = false
        up_unpressed.isHidden = false*/
        var temp = Double()
        if (tenyr_indicator == 0) {
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { temp = (round(p*i*100 + 1) + 1)/100}
            else { temp = (round(p*i*100) + 1)/100 }
        }
        else {
            if (i != 0) {
                temp = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
            }
            else {
                temp = ceil(p/120*100)/100
            }
        }

        if (temp == a)
        {
            minimum.isHidden = false
        }
        else
        {
            minimum.isHidden = true
        }
        interest_rate_pressed_copy.isHidden = true
        interest_rate_unpressed.isHidden = false
        edit_apr_text.isHidden = false
        edit_apr_text_back.isHidden = true
        invisible.isHidden = false
        invisible_back.isHidden = true
        /*arrow_pressed_copy.isHidden = true*/
        /*arrow_unpressed.isHidden = false
        arrow_unpressed_copy.isHidden = true*/
        
        
        /*UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.table_view.frame = CGRect(x: self.table_view.frame.origin.x, y: self.table_view.frame.origin.y, width: self.table_view.frame.width, height: 0)*/
            /*self.bubble_label.alpha = 0.0
            self.bubble_label_arrow.alpha = 0.0*/
        /*}, completion: {
            (finished: Bool) -> Void in*/
            /*if self.table_view.frame.height == 0 {*/
                //completion block always called, even though animation cancelled, so different if test was needed
                self.table_view.alpha = 0.0
                //self.table_view.isHidden = true
            //}
            /*else {
                self.table_view.alpha = 1.0
            }*/
        //})


    }
    @IBAction func Interest_Rate_Pressed(_ sender: UIButton) {
        interest_rate_unpressed.isHidden = true
        interest_rate_pressed.isHidden = false
        edit_apr_text.isHidden = true
        edit_apr_text_back.isHidden = false
        /*arrow_unpressed.isHidden = true*/
        /*arrow_pressed.isHidden = false*/
    }
    @IBAction func Interest_Rate_Pressed_Copy(_ sender: UIButton) {
        interest_rate_unpressed_copy.isHidden = true
        interest_rate_pressed_copy.isHidden = false
        edit_apr_text.isHidden = true
        edit_apr_text_back.isHidden = false
        /*arrow_unpressed_copy.isHidden = true*/
        /*arrow_pressed_copy.isHidden = false*/
    }
    /*@IBAction func Arrow_Unpressed(_ sender: UIButton) {
        table_view.isHidden = false
        /*arrow_pressed.isHidden = true*/
        /*arrow_unpressed.isHidden = true
        arrow_unpressed_copy.isHidden = false*/
        /*down_unpressed.isHidden = true
        pay_monthly_title.isHidden = true
        pay_monthly_box.isHidden = true
        up_unpressed.isHidden = true
        minimum.isHidden = true*/
        interest_rate_unpressed.isHidden = true
        interest_rate_unpressed_copy.isHidden = false
        /*interest_rate_pressed.isHidden = true*/
    }*/
    /*@IBAction func Arrow_Unpressed_Copy(_ sender: UIButton) {
        table_view.isHidden = true
        /*arrow_pressed_copy.isHidden = true*/
        /*arrow_unpressed_copy.isHidden = true
        arrow_unpressed.isHidden = false*/
        /*down_unpressed.isHidden = false
        pay_monthly_title.isHidden = false
        pay_monthly_box.isHidden = false
        up_unpressed.isHidden = false*/
        let temp = Double(Int((p * i + 0.01) * 100)) / 100
        if (temp == a)
        {
            minimum.isHidden = false
        }
        else
        {
            minimum.isHidden = true
        }
        /*interest_rate_pressed_copy.isHidden = true*/
        interest_rate_unpressed_copy.isHidden = true
        interest_rate_unpressed.isHidden = false
    }*/
    /*@IBAction func Arrow_Pressed(_ sender: UIButton) {
        arrow_unpressed.isHidden = true
        arrow_pressed.isHidden = false
        interest_rate_unpressed.isHidden = true
        interest_rate_pressed.isHidden = false
    }
    @IBAction func Arrow_Pressed_Copy(_ sender: UIButton) {
        arrow_unpressed_copy.isHidden = true
        arrow_pressed_copy.isHidden = false
        interest_rate_unpressed_copy.isHidden = true
        interest_rate_pressed_copy.isHidden = false
    }*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell:UITableViewCell = self.table_view.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell!
        let cell:UITableViewCell! = self.table_view.dequeueReusableCell(withIdentifier: "cell")

        cell.textLabel!.text = self.rates_text[(indexPath as NSIndexPath).row]
        cell.textLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)

        cell.textLabel!.textColor = UIColor(red: 64.0/255, green: 73.0/255, blue: 77.0/255, alpha: 1.0)
        /*cell.textLabel!.textAlignment = NSTextAlignment.center*/
        cell.indentationLevel = 2
        /*cell.backgroundColor = UIColor(red: 175.0/255, green: 175.0/255, blue: 175.0/255, alpha: 1.0)*/
        /*table_view.layer.cornerRadius=5*/
        /*table_view.backgroundView = UIImageView(image: UIImage(named: "tableview_background.png")!)*/
        /*table_view.backgroundColor = UIColor(red: 74.0/255, green: 82.0/255, blue: 86.0/255, alpha: 1.0)*/
        table_view.backgroundColor = UIColor.clear
        
        if (indexPath.row == 0) {
            cell.backgroundColor = UIColor(red: 161.0/255, green: 166.0/255, blue: 168.0/255, alpha: 1.0)


        } else {
            cell.backgroundColor = UIColor(red: 161.0/255, green: 166.0/255, blue: 168.0/255, alpha: 1.0)
            let custom_background = CAShapeLayer()
            custom_background.frame = cell.bounds
            custom_background.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: table_view.frame.width, height: cell.frame.height), byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
            cell.layer.mask = custom_background
        }
       
        table_view.rowHeight = 48
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        
        
        /*table_view.layer.shadowColor = UIColor.black.cgColor
        table_view.layer.shadowOffset = CGSize(width: 0, height: 1)
        table_view.layer.shadowOpacity = 0.125
        table_view.layer.shadowRadius = 1
        table_view.clipsToBounds = false*/
        
        view.addSubview(table_view)
        view.addSubview(interest_rate_pressed_copy)
        view.addSubview(interest_rate_unpressed_copy)
        view.addSubview(invisible)
        view.addSubview(invisible_back)
        view.bringSubviewToFront(interest_rate_unpressed_copy)
        view.bringSubviewToFront(interest_rate_unpressed)
        view.bringSubviewToFront(edit_apr_text_back)
        view.bringSubviewToFront(edit_apr_text)
        view.bringSubviewToFront(edit_apr_shape)
        view.bringSubviewToFront(edit_apr)//or else edit_apr_shape starts out behind interest_rate_unpressed
        view.bringSubviewToFront(invisible)
        view.bringSubviewToFront(invisible_back)
//        view.bringSubviewToFront(splash_screen) //for old splash screen
        //view.bringSubviewToFront(videoController.view)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        CATransaction.setCompletionBlock { () -> Void in
            UIView.setAnimationsEnabled(true)
        } /* didn't want text to blink when changed */
        
        /*let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!*/
        /*selectedCell.contentView.backgroundColor = UIColor(red: 175.0/255, green: 175.0/255, blue: 175.0/255, alpha: 1.0)*/
        /*selectedCell.contentView.backgroundColor = UIColor.clear*/
        table_view.reloadData() /* <-- fixes bug */
        i = rates_reference[(indexPath as NSIndexPath).row]
        /*table_view.isHidden = true*/
        
      
        
        
        /*down_unpressed.isHidden = false
        pay_monthly_title.isHidden = false
        pay_monthly_box.isHidden = false
        up_unpressed.isHidden = false*/
        interest_rate_unpressed_copy.isHidden = true
        interest_rate_unpressed.isHidden = false
        invisible.isHidden = false
        invisible_back.isHidden = true
        /*arrow_unpressed_copy.isHidden = true
        arrow_unpressed.isHidden = false*/
        apr_number.text = String(rates[(indexPath as NSIndexPath).row])
        apr_number_back.text = String(rates[(indexPath as NSIndexPath).row])
        //interest_rate_unpressed.setTitle(rates[(indexPath as NSIndexPath).row], for: UIControlState())
        //interest_rate_unpressed_copy.setTitle(rates[(indexPath as NSIndexPath).row], for: UIControlState())
        //interest_rate_pressed.setTitle(rates[(indexPath as NSIndexPath).row], for: UIControlState())
        //interest_rate_pressed_copy.setTitle(rates[(indexPath as NSIndexPath).row], for: UIControlState())
        //interest_rate_disabled.setTitle(rates[(indexPath as NSIndexPath).row], for: UIControlState())
        /*let temp = Double(Int((p * i + 0.01) * 100)) / 100*/
        var temp = Double()
        if (tenyr_indicator == 0) {
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { temp = (round(p*i*100 + 1) + 1)/100}
            else { temp = (round(p*i*100) + 1)/100 }
        }
        else {
            if (i != 0) {
                temp = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
            }
            else {
                temp = ceil(p/120*100)/100
            }
        }
        

        if (temp >= a)
        {
            a = temp
            a_reference = temp
            shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
            if (a - floor(a) == 0) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
            }
            else if ((a - floor(a))*100 < 9.99999) {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
            }
            else {
                pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
            }

            
            minimum.isHidden = false
            minimum.text = "Minimum"
        }
        else
        {
            //minimum.isHidden = true
            minimum.isHidden = false
            minimum.text = " "

        }
        Lengthsaving()
        shared_preferences.set(i * 12 * 100, forKey: "interest"); shared_preferences.synchronize()
        shared_preferences.set((indexPath as NSIndexPath).row, forKey: "position"); shared_preferences.synchronize()
        CATransaction.commit()
        self.table_view.alpha = 0.0

        /*UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            UIView.setAnimationsEnabled(true)
            self.table_view.frame = CGRect(x: self.table_view.frame.origin.x, y: self.table_view.frame.origin.y, width: self.table_view.frame.width, height: 0)
            
            /*self.bubble_label.alpha = 0.0
             self.bubble_label_arrow.alpha = 0.0*/
        }, completion: {
            (finished: Bool) -> Void in
            self.table_view.alpha = 0.0
        })*/

    }
    
    
    //instructions for down button
    @IBAction func Down_Start_Timer(_ sender: UIButton) {
        timer1 = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(MyMainPage.Down), userInfo: nil, repeats: false)
        timer1 = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(MyMainPage.Down), userInfo: nil, repeats: true)
        down_unpressed.isHidden = true
        down_pressed.isHidden = false
    }
    @IBAction func Down_Stop_Timer(_ sender: UIButton) {
        timer1.invalidate()
        down_unpressed.isHidden = false
        down_pressed.isHidden = true
        timer_count = 0
        
        //some of this could be refined:
        var temp_before = Double()
        if (tenyr_indicator == 0) {
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { temp_before = (round(p*i*100 + 1) + 1)/100}
            else { temp_before = (round(p*i*100) + 1)/100 }
        }
        else {
            if (i != 0) {
                temp_before = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
            }
            else {
                temp_before = ceil(p/120*100)/100
            }
        }

        
        if (a == temp_before) {//} && !(a - Double(temp_down) == 0.0) {
                minimum.isHidden = false
        }
        /*else if (a == 0.01) && !(a - Double(temp_down) == 0.0) {
            minimum.isHidden = false
        }*/
        else {
            minimum.isHidden = true
        }
    }
    @objc func Down() {
        temp_down = down_button_increment
        
//        if (decision == true) {
//            if (timer_count < set_down_timer1_seconds*4) { //down_button_increment = 50
//                if (timer_count > 0) { minimum.text = "▼ \(numberFormatter.string(from: NSNumber(value: temp_down))!)"; minimum.isHidden = false}
//            }
//            else if (timer_count < set_down_timer2_seconds*4) { temp_down = set_down_timer1_increment; minimum.text = "▼ \(numberFormatter.string(from: NSNumber(value: temp_down))!)" }
//            else { temp_down = set_down_timer2_increment; minimum.text = "▼ \(numberFormatter.string(from: NSNumber(value: temp_down))!)" }
//        }
//        else {
            if (timer_count < set_down_timer1_seconds*4) { //down_button_increment = 50
                if (timer_count > 0) { minimum.text = "↓ \(numberFormatter.string(from: NSNumber(value: temp_down))!)"; minimum.isHidden = false}
            }
            else if (timer_count < set_down_timer2_seconds*4) { temp_down = set_down_timer1_increment; minimum.text = "↓ \(numberFormatter.string(from: NSNumber(value: temp_down))!)" }
            else { temp_down = set_down_timer2_increment; minimum.text = "↓ \(numberFormatter.string(from: NSNumber(value: temp_down))!)" }

//        }
        
        //else if (timer_count < 32) { temp_down = temp_down*2*10; minimum.text = "↓ \(numberFormatter.string(from: NSNumber(value: temp_down))!)" }
        //else { temp_down = temp_down*2*10*10; minimum.text = "↓ \(numberFormatter.string(from: NSNumber(value: temp_down))!)" }
        
        //print(a)
        //print(Double(temp_down))
        
        //print(i_reference)
        
        //if apr.isOn {
        
            var temp = Double()
            /*if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
                { temp = (round(p*i*100 + 1)+1)/100}
            else { temp = (round(p*i*100)+1)/100 }*/
        if (tenyr_indicator == 0) {
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { temp = (round(p*i*100 + 1) + 1)/100}
            else { temp = (round(p*i*100) + 1)/100 }
        }
        else {
            if (i != 0) {
                temp = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
            }
            else {
                temp = ceil(p/120*100)/100
            }
        }

        if (a == a_reference) && (a - floor(a) > 0) { //latter condition is in case a has no remainder, or else will get stuck in loop; besides, what if someone manually inputs a
                if (floor(a / down_button_increment)*down_button_increment <= temp) {//} || (a - Double(temp_down) <= temp)
                    a = temp
                    a_reference = temp
                    if (a - floor(a) == 0) {
                        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
                    }
                    else if ((a - floor(a))*100 < 9.99999) {
                        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
                    }
                    else {
                        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
                    }
                    //minimum.isHidden = false
                    minimum.text = "Minimum"
                }
                else {
                    //if (a == temp) {
                    //if (a - floor(a) > 0) && (a != 0.01) {
                    //a = floor(a) - down_button_increment
                    a = floor(a / down_button_increment)*down_button_increment
                    timer_count += 1
                    pay_number.text = "\(numberFormatter.string(from: NSNumber(value: a))!)"
                    //minimum.isHidden = true
                }
            }
            else {
                if (a - temp_down <= temp) {
                    a = temp
                    a_reference = temp
                    if (a - floor(a) == 0) {
                        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
                    }
                    else if ((a - floor(a))*100 < 9.99999) {
                        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
                    }
                    else {
                        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
                    }
                    //minimum.isHidden = false
                    minimum.text = "Minimum"
                }
                else {
                    a -= temp_down
                    timer_count += 1
                    pay_number.text = "\(numberFormatter.string(from: NSNumber(value: a))!)"
                    //minimum.isHidden = true
                }
            }
        
        
        
        
        
        
        
        
            /*if (a - Double(temp_down) <= temp) {
            //if (a - Double(temp_down) <= ceil(Double(Int(p*i*100)+1))/100) {
                /*let temp = Int((p * i + 0.01) * 100)*/
                //let temp = ceil(Double(Int(p*i*100)+1))/100

                a = temp
                a_reference = temp
                pay_number.text = String(format: "%.2f", a)
                /*minimum.isHidden = false*/
                minimum.text = "Minimum"
            }*/
            /*else {
                if (a == a_reference) {
                    //if (a == temp) {
                    //if (a - floor(a) > 0) && (a != 0.01) {
                    a = floor(a)
                    timer_count += 1
                    pay_number.text = "\(numberFormatter.string(from: NSNumber(value: a))!)"
                    /*minimum.isHidden = true*/
                }
                else {
                    a -= Double(temp_down)
                    timer_count += 1
                    pay_number.text = "\(numberFormatter.string(from: NSNumber(value: a))!)"
                    /*minimum.isHidden = true*/
                }
            }*/
        //}
        /*else {
            //var temp = Double()
            //if (p*i_reference*100 - floor(p*i_reference*100) > 0.99999) {
                //temp = ceil(Double(Int(p*i_reference*100+1)+1))/100 }
            //else { temp = ceil(Double(Int(p*i_reference*100)+1))/100 }
        
            if (a - Double(temp_down) <= 0.01) {
                /*let temp = Int((p * i + 0.01) * 100)*/
                let temp = ceil(Double(Int(p*i*100)+1))/100 //still okay, since i = 0
         
                a = temp
                a_reference = temp
                pay_number.text = String(format: "%.2f", a)
                /*minimum.isHidden = false*/
                minimum.text = "Minimum"
            }
            else {
                if (a == a_reference) {
                    //if (a == temp) {
                    //if (a - floor(a) > 0) && (a != 0.01) {
                    a = floor(a)
                    timer_count += 1
                    pay_number.text = "\(numberFormatter.string(from: NSNumber(value: a))!)"
                    /*minimum.isHidden = true*/
                }
                else {
                    a -= Double(temp_down)
                    timer_count += 1
                    pay_number.text = "\(numberFormatter.string(from: NSNumber(value: a))!)"
                    /*minimum.isHidden = true*/
                }
            }
            //print(a)
            //print(Double(temp_down))
            //print(ceil(Double(Int(p*i*100)+1))/100)

        }*/
        Lengthsaving()
        shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
    }
    
    //instructions for up button
    @IBAction func Up_Start_Timer(_ sender: UIButton) {
        timer2 = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(MyMainPage.Up), userInfo: nil, repeats: false)
        timer2 = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(MyMainPage.Up), userInfo: nil, repeats: true)
        up_unpressed.isHidden = true
        up_pressed.isHidden = false
    }
    @IBAction func Up_Stop_Timer(_ sender: UIButton) {
        timer2.invalidate()
        up_unpressed.isHidden = false
        up_pressed.isHidden = true
        timer_count = 0
        minimum.isHidden = true
        
        //some of this may be redundant
        /*if (a - Double(temp_up) <= ceil(Double(Int(p*i*100)+1))/100) && !(a - Double(temp_up) == 0.0) {
            minimum.isHidden = false
        }
        else if (a - Double(temp_up) <= 0.01) && !(a - Double(temp_up) == 0.0) {
            minimum.isHidden = false
        }
        else {
            minimum.isHidden = true
        }*/
    }
    @objc func Up() {
        minimum.isHidden = true
        temp_up = up_button_increment
        
//        if (decision == false) {
            if (timer_count < set_up_timer1_seconds*4) { //up_button_increment = 50
                if (timer_count > 0) { minimum.text = "↑ \(numberFormatter.string(from: NSNumber(value: temp_up))!)"; minimum.isHidden = false}
                //if (timer_count > 0) { minimum.text = "↑ 50"; minimum.isHidden = false}
            }
            else if (timer_count < set_up_timer2_seconds*4) { temp_up = set_up_timer1_increment; minimum.text = "↑ \(numberFormatter.string(from: NSNumber(value: temp_up))!)"; minimum.isHidden = false }
            //else if (timer_count < 16) { up_button_increment = 100; minimum.text = "↑ 100"; minimum.isHidden = false }
            else { temp_up = set_up_timer2_increment; minimum.text = "↑ \(numberFormatter.string(from: NSNumber(value: temp_up))!)"; minimum.isHidden = false }
            //else { up_button_increment = 1000; minimum.text = "↑ 1,000"; minimum.isHidden = false }
//        }
//        else {
//            if (timer_count < set_up_timer1_seconds*4) { //up_button_increment = 50
//                if (timer_count > 0) { minimum.text = "▲ \(numberFormatter.string(from: NSNumber(value: temp_up))!)"; minimum.isHidden = false}
//                //if (timer_count > 0) { minimum.text = "↑ 50"; minimum.isHidden = false}
//            }
//            else if (timer_count < set_up_timer2_seconds*4) { temp_up = set_up_timer1_increment; minimum.text = "▲ \(numberFormatter.string(from: NSNumber(value: temp_up))!)"; minimum.isHidden = false }
//                //else if (timer_count < 16) { up_button_increment = 100; minimum.text = "↑ 100"; minimum.isHidden = false }
//            else { temp_up = set_up_timer2_increment; minimum.text = "▲ \(numberFormatter.string(from: NSNumber(value: temp_up))!)"; minimum.isHidden = false }
//            //else { up_button_increment = 1000; minimum.text = "↑ 1,000"; minimum.isHidden = false }
//        }
        //print(a)

        if (a == a_reference) || (a - floor(a) > 0) {//later inequality is just in case someone manually inputs a
        //if (a == ceil(Double(Int(p*i*100)+1))/100) || (a == ceil(Double(Int(p*i_reference*100)+1))/100) || (a - floor(a) > 0) { //won't catch every case
        //if (a - floor(a) > 0) {//for minimum, I don't anticipate remainder will ever be zero, but...
        //if (a == ceil(Double(Int(p*i*100)+1))/100) {

            if (up_button_increment < a) {
                //if (a / up_button_increment - floor(a / up_button_increment) > 0.499999) && (a / up_button_increment - floor(a / up_button_increment) < 0.5)
                //{ a = ceil(a / up_button_increment + 1)*up_button_increment }
                //else { a = ceil(a / up_button_increment)*up_button_increment }
                a = ceil(a / up_button_increment)*up_button_increment
                //print(a)
                //a = floor(a) + up_button_increment
                //a = floor(a + 1)
                timer_count += 1
            }
            else if (a < up_button_increment) {
                a = up_button_increment
                timer_count += 1
            }
            else {
                a += temp_up
                timer_count += 1
            }
        }
        else {
            //these wouldn't be rounded yet, so...
            a += temp_up
            //a += Double(up_button_increment)
            timer_count += 1
        }
        
        var temp_overpay = Double() //for interest, not pay
        if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { temp_overpay = (round(p*i*100 + 1))/100}
        else { temp_overpay = (round(p*i*100))/100 }

        
        if (a > p + temp_overpay) {
            minimum.text = "Overpaying!"
        }
        /*minimum.isHidden = true*/
        /*if (a >= 500) {
            /*minimum.isHidden = false*/
            /*minimum.text = "Awesome!"*/
        }*/
        Lengthsaving()
        shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
        pay_number.text = "\(numberFormatter.string(from: NSNumber(value: a))!)"
    }
    
    //instructions for calculating time and savings
    func Lengthsaving() {
        var j = 0
        var k = 0
        //p = p*(1+1.066/100) //includes loan fees
        var remainingbalance = p
        var remainingbalance_repay_minimum = p
        
        /*var temp_interest_amount = Double()
        if (remainingbalance*i*100 - floor(remainingbalance*i*100) > 0.99999) {
            temp_interest_amount = ceil(Double(Int(remainingbalance*i*100)+1))/100 }
        else { temp_interest_amount = ceil(Double(Int(remainingbalance*i*100)))/100 }*/
        
        var temp_interest_amount = Double()
        if (remainingbalance*i*100 - floor(remainingbalance*i*100) > 0.499999) && (remainingbalance*i*100 - floor(remainingbalance*i*100) < 0.5)
            { temp_interest_amount = (round(remainingbalance*i*100 + 1))/100}
        else { temp_interest_amount = (round(remainingbalance*i*100))/100 }

        
        /*var temp_interest_min = Double()
        if (remainingbalance_repay_minimum*i*100 - floor(remainingbalance_repay_minimum*i*100) > 0.99999) {
            temp_interest_min = ceil(Double(Int(remainingbalance_repay_minimum*i*100)+1))/100 }
        else { temp_interest_min = ceil(Double(Int(remainingbalance_repay_minimum*i*100)))/100 }*/
        
        var temp_interest_min = Double()
        if (remainingbalance_repay_minimum*i*100 - floor(remainingbalance_repay_minimum*i*100) > 0.499999) && (remainingbalance_repay_minimum*i*100 - floor(remainingbalance_repay_minimum*i*100) < 0.5)
            { temp_interest_min = (round(remainingbalance_repay_minimum*i*100 + 1))/100}
        else { temp_interest_min = (round(remainingbalance_repay_minimum*i*100))/100 }

        
        /*var temp_pay = Double()
        if (p*i*100 - floor(p*i*100) > 0.99999) {
            temp_pay = ceil(Double(Int(p*i*100)+2))/100 }
        else { temp_pay = ceil(Double(Int(p*i*100)+1))/100 }*/
        
        var temp_pay = Double()
        if (tenyr_indicator == 0) {
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { temp_pay = (round(p*i*100 + 1) + 1)/100}
            else { temp_pay = (round(p*i*100) + 1)/100 }
        }
        else {
            if (i != 0) {
                temp_pay = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
            }
            else {
                temp_pay = ceil(p/120*100)/100
            }
        }


        let temp_pay_first = temp_pay
        
        //if (i != 0) {
            
            while (remainingbalance + temp_interest_amount > a) {
                
                remainingbalance = remainingbalance + temp_interest_amount - a
                let temp_new3 = remainingbalance*100 - floor(remainingbalance*100)
                if (temp_new3 > 0.499999) && (temp_new3 < 0.5)
                { remainingbalance = round(remainingbalance*100 + 1)/100}
                else { remainingbalance = round(remainingbalance*100)/100 }
                
                if (remainingbalance*i*100 - floor(remainingbalance*i*100) > 0.499999) && (remainingbalance*i*100 - floor(remainingbalance*i*100) < 0.5)
                { temp_interest_amount = (round(remainingbalance*i*100 + 1))/100}
                else { temp_interest_amount = (round(remainingbalance*i*100))/100 }

                //print(remainingbalance,"=",remainingbalance-(temp_interest_amount - a),"+",temp_interest_amount,"-",a)
                j += 1

            }

            while (remainingbalance_repay_minimum + temp_interest_min > temp_pay) {
                
                remainingbalance_repay_minimum = remainingbalance_repay_minimum + temp_interest_min - temp_pay
                
                let temp_new4 = remainingbalance_repay_minimum*100 - floor(remainingbalance_repay_minimum*100)
                if (temp_new4 > 0.499999) && (temp_new4 < 0.5)
                { remainingbalance_repay_minimum = round(remainingbalance_repay_minimum*100 + 1)/100}
                else { remainingbalance_repay_minimum = round(remainingbalance_repay_minimum*100)/100 }
                
                if (remainingbalance_repay_minimum*i*100 - floor(remainingbalance_repay_minimum*i*100) > 0.499999) && (remainingbalance_repay_minimum*i*100 - floor(remainingbalance_repay_minimum*i*100) < 0.5)
                { temp_interest_min = (round(remainingbalance_repay_minimum*i*100 + 1))/100}
                else { temp_interest_min = (round(remainingbalance_repay_minimum*i*100))/100 }
                
                if (tenyr_indicator == 0) {
                    if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
                    { temp_pay = (round(p*i*100 + 1) + 1)/100}
                    else { temp_pay = (round(p*i*100) + 1)/100 }
                }
                else {
                    if (i != 0) {
                        temp_pay = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
                    }
                    else {
                        temp_pay = ceil(p/120*100)/100
                    }
                }

                
                //print(remainingbalance_repay_minimum,"=",remainingbalance_repay_minimum-(temp_interest_min - temp_pay),"+",temp_interest_min,"-",temp_pay)

                k += 1
            }
            //print("mainpage",k)
            
            /*if (i != 0) {
                /*while (remainingbalance + ceil(Double(Int(remainingbalance * i * 100))) / 100 > a) {
                 remainingbalance = remainingbalance + ceil(Double(Int(remainingbalance * i * 100))) / 100 - a
                 j += 1
                 /*print(remainingbalance, i, remainingbalance + Double(Int(remainingbalance * i * 100)) / 100, a, terminator: "\n")*/
                 
                 }*/
                
                
                /*while (remainingbalance_repay_minimum + Double(Int(ceil(remainingbalance_repay_minimum * i * 100))) / 100 > Double(Int(ceil((p * i + 0.01) * 100))) / 100) {
                 remainingbalance_repay_minimum = remainingbalance_repay_minimum + Double(Int(ceil(remainingbalance_repay_minimum * i * 100))) / 100 - Double(Int(ceil((p * i + 0.01) * 100))) / 100
                 k += 1
                 
                 }*/
            }*/
        //}
        /*else {
            k = Int(p / 0.01 - 1)
            remainingbalance_repay_minimum = 0.01
        }*/
        /*else {
            if (ceil((p / a) - 1) - floor(ceil((p / a) - 1)) > 0.99999)
                { j = Int(ceil((p / a) - 1) + 1) }
            else { j = Int(ceil((p / a) - 1)) }

            if (p / 0.01 - 1 - floor(p / 0.01 - 1) > 0.99999)
            { k = Int(p / 0.01 - 1 + 1) }
            else { k = Int(p / 0.01 - 1) }

            remainingbalance = p - a * Double(j)
            remainingbalance_repay_minimum = 0.01
        }*/
        var temp = Int()
        
        if (Double((j + 1) / 12) - floor(Double((j + 1) / 12)) > 0.99999) //seems like too much
        { temp = Int(floor(Double((j + 1) / 12) + 1)) }
        else { temp = Int(floor(Double((j + 1) / 12))) }

        
        //if (floor(Double((j + 1) / 12)) - floor(floor(Double((j + 1) / 12))) > 0.99999) //seems like too much
        //{ temp = Int(floor(Double((j + 1) / 12)) + 1) }
        //else { temp = Int(floor(Double((j + 1) / 12))) }
        //print("mainpage",j)
        //print(j+1)
        /*if (a == 0.01) { years.text = "😢" } else { years.text = String(temp) }*/
        /*if (a == 0.01) { years.text = UIImageView(image: UIImage(named: "SadFace")) } else { years.text = String(temp) }*/
        years.text = numberFormatter.string(from: NSNumber(value: temp))!
        
//        if (decision == false) {
            if (temp == 1) {years_text.text = "year"}
            else {years_text.text = "years"}
//        }
//        else {
//            years_text.text = "year(s)"
//        }
//
        months.text = String((j + 1) - temp * 12)
        
//        if (decision == false) {
            if ((j + 1) - temp * 12 == 1) {months_text.text = "month"}
            else {months_text.text = "months"}
//        }
//        else {
//            months_text.text = "month(s)"
//        }
        
        if (remainingbalance_repay_minimum*i*100 - floor(remainingbalance_repay_minimum*i*100) > 0.499999) && (remainingbalance_repay_minimum*i*100 - floor(remainingbalance_repay_minimum*i*100) < 0.5)
        { temp_interest_min = (round(remainingbalance_repay_minimum*i*100 + 1))/100}
        else { temp_interest_min = (round(remainingbalance_repay_minimum*i*100))/100 }
        let temp_interest_last_min = temp_interest_min
        
        let total_repay_minimum_fromloop = Double(k) * temp_pay_first;        let total_repay_minimum_finalmonth = remainingbalance_repay_minimum + temp_interest_last_min;                                         let total_repay_minimum = total_repay_minimum_fromloop + total_repay_minimum_finalmonth
        
        if (remainingbalance*i*100 - floor(remainingbalance*i*100) > 0.499999) && (remainingbalance*i*100 - floor(remainingbalance*i*100) < 0.5)
        { temp_interest_amount = (round(remainingbalance*i*100 + 1))/100}
        else { temp_interest_amount = (round(remainingbalance*i*100))/100 }
        let temp_interest_last_amount = temp_interest_amount

        
        //let total_repay_minimum_fromloop = Double(k) * ceil(Double(Int(p*i*100)+1))/100
        //let total_repay_minimum_finalmonth = remainingbalance_repay_minimum + ceil(Double(Int(remainingbalance_repay_minimum*i*100)))/100
        //let total_repay_minimum = total_repay_minimum_fromloop + total_repay_minimum_finalmonth
        let total = Double(j) * a + remainingbalance + temp_interest_last_amount
        var saved = total_repay_minimum - total
        savings_reference = shared_preferences.double(forKey: "savings_change_key")
        if (savings_reference - floor(savings_reference) > 0.499999) && (savings_reference - floor(savings_reference) < 0.5)
            { savings_reference = (round(savings_reference + 1))/100}
        else { savings_reference = round(savings_reference) }

        if (saved <= 0) {
            
//            if (decision == false) {
                savings.text = "$" + numberFormatter.string(from: 0)!
                if (0-savings_reference) < 0 {//rounding error is insignificant
                    savings_change.text = "↓ $" + numberFormatter.string(from: NSNumber(value: abs(0-savings_reference)))!
                }
                else if (0-savings_reference) == 0 {
                    savings_change.text = "no change"
                }
                else {
                    savings_change.text = "↑ $" + numberFormatter.string(from: NSNumber(value: 0-savings_reference))!
                }
//            }
//            else {
//                savings.text = "$" + numberFormatter.string(from: 0)!
//                if (0-savings_reference) < 0 {//rounding error is insignificant
//                    savings_change.text = "▼ $" + numberFormatter.string(from: NSNumber(value: abs(0-savings_reference)))!
//                }
//                else if (0-savings_reference) == 0 {
//                    savings_change.text = "no change"
//                }
//                else {
//                    savings_change.text = "▲ $" + numberFormatter.string(from: NSNumber(value: 0-savings_reference))!
//                }
//            }
        }
        else {
//            if (decision == false) {
                if (saved - floor(saved) > 0.499999) && (saved - floor(saved) < 0.5)
                    { saved = (round(saved + 1))/100}
                else { saved = round(saved) }

                savings.text = "$" + numberFormatter.string(from: NSNumber(value: saved))!
                if (saved-savings_reference) < 0 {
                    savings_change.text = "↓ $" + numberFormatter.string(from: NSNumber(value: abs(saved-savings_reference)))!
                }
                else if (saved-savings_reference) == 0 {
                    savings_change.text = "no change"
                }
                else {
                    savings_change.text = "↑ $" + numberFormatter.string(from: NSNumber(value: saved-savings_reference))!
                }
//            }
//            else {
//                if (saved - floor(saved) > 0.499999) && (saved - floor(saved) < 0.5)
//                { saved = (round(saved + 1))/100}
//                else { saved = round(saved) }
//
//                savings.text = "$" + numberFormatter.string(from: NSNumber(value: saved))!
//                if (saved-savings_reference) < 0 {
//                    savings_change.text = "▼ $" + numberFormatter.string(from: NSNumber(value: abs(saved-savings_reference)))!
//                }
//                else if (saved-savings_reference) == 0 {
//                    savings_change.text = "no change"
//                }
//                else {
//                    savings_change.text = "▲ $" + numberFormatter.string(from: NSNumber(value: saved-savings_reference))!
//                }
//            }
//
        }
        shared_preferences.set(saved, forKey: "savings_change_key"); shared_preferences.synchronize()

    }
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unlocked.alpha = 1.0
        absmin.alpha = 1.0
        absolute.alpha = 1.0
        linemin.alpha = 0.0625
        tenyrmin.alpha = 1.0
        tenyr.alpha = 1.0
        years.alpha = 1.0
        months.alpha = 1.0
        minimum.alpha = 1.0
        
//        shared_preferences.set(decision, forKey: "decision"); shared_preferences.synchronize()

        //reset frames, or else calayers won't conform to them
        edit_slider_shape.frame = CGRect(x: view.frame.origin.x+5, y: edit_slider_shape.frame.origin.y, width: view.frame.width-10, height: edit_slider_shape.frame.height)
        edit_apr_shape.frame = CGRect(x: view.frame.origin.x+5, y: edit_apr_shape.frame.origin.y, width: view.frame.width-10, height: edit_apr_shape.frame.height)
        edit_pay_shape.frame = CGRect(x: view.frame.origin.x+5, y: edit_pay_shape.frame.origin.y, width: view.frame.width-10, height: edit_pay_shape.frame.height)


        //view.addSubview(videoController.view)
        view.addSubview(stack_min)
        view.addSubview(stack_max)
        //view.addSubview(input_background)
        //view.bringSubviewToFront(input_background)
        //input_background.alpha = 0.0
//        if (decision == true) {
//            locked.isHidden = true
//            swipe_note.isHidden = true
//            swipe.isEnabled = true
//            APR_DIRECT = 3.76
//            time_title.text =  "Est. Payoff Time"
//            savings_title.text = "Est. Savings"
//            layout_interest_rate.isActive = false
//            layout_minimum.isActive = false
//            layout_savings.isActive = false
//            layout_loaned.isActive = false
//            layout_months.isActive = false
//            //view.addConstraint(NSLayoutConstraint(item: bottomLayoutGuide, attribute: .top, relatedBy: .equal, toItem: interest_rate_unpressed, attribute: .bottom, multiplier: 2.2, constant: 50))
//            //view.addConstraint(NSLayoutConstraint(item: bottomLayoutGuide, attribute: .top, relatedBy: .equal, toItem: minimum, attribute: .bottom, multiplier: 1.35, constant: 35))
//            //view.addConstraint(NSLayoutConstraint(item: bottomLayoutGuide, attribute: .top, relatedBy: .equal, toItem: savings, attribute: .bottom, multiplier: 1.05, constant: 23))
//            //view.addConstraint(NSLayoutConstraint(item: bottomLayoutGuide, attribute: .top, relatedBy: .equal, toItem: loaned, attribute: .bottom, multiplier: 4.5, constant: 122))
//            //view.addConstraint(NSLayoutConstraint(item: savings, attribute: .top, relatedBy: .equal, toItem: months, attribute: .bottom, multiplier: 1, constant: 25))
//
//            //may not be necessary:
//            view.addConstraint(NSLayoutConstraint(item: bottomLayoutGuide, attribute: .top, relatedBy: .equal, toItem: loaned, attribute: .bottom, multiplier: 5.54, constant: -1))
//            view.addConstraint(NSLayoutConstraint(item: bottomLayoutGuide, attribute: .top, relatedBy: .equal, toItem: interest_rate_unpressed, attribute: .bottom, multiplier: 2.39, constant: 0))
//            view.addConstraint(NSLayoutConstraint(item: bottomLayoutGuide, attribute: .top, relatedBy: .equal, toItem: minimum, attribute: .bottom, multiplier: 1.425, constant: 0))
//            view.addConstraint(NSLayoutConstraint(item: savings, attribute: .top, relatedBy: .equal, toItem: months, attribute: .bottom, multiplier: 1, constant: 25))
//            view.addConstraint(NSLayoutConstraint(item: bottomLayoutGuide, attribute: .top, relatedBy: .equal, toItem: savings, attribute: .bottom, multiplier: 1.085, constant: 0))
//
//            layout_stack_min.isActive = false
//            layout_stack_max.isActive = false
//            layout_loaned_trailing.isActive = false
//            layout_loaned_leading.isActive = false
//            stack_Y.isActive = false
//            loaned_Y.isActive = false
//            view.addConstraint(NSLayoutConstraint(item: loaned, attribute: .leading, relatedBy: .equal, toItem: stack_min, attribute: .centerX, multiplier: 1, constant: -10))
//            view.addConstraint(NSLayoutConstraint(item: stack_max, attribute: .centerX, relatedBy: .equal, toItem: loaned, attribute: .trailing, multiplier: 1, constant: -9.25))
//            view.addConstraint(NSLayoutConstraint(item: loaned, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 39))
//            view.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: loaned, attribute: .trailing, multiplier: 1, constant:39))
//            loaned_height.isActive = false
//            view.addConstraint(loaned.heightAnchor.constraint(equalToConstant: 35))
//            view.addConstraint(NSLayoutConstraint(item: loaned, attribute: .top, relatedBy: .equal, toItem: loaned_title, attribute: .bottom, multiplier: 1, constant: 38))
//            view.addConstraint(NSLayoutConstraint(item: stack_min, attribute: .top, relatedBy: .equal, toItem: loaned_title, attribute: .bottom, multiplier: 1, constant: 6))
//        }
//        else {
            locked.isHidden = false
            swipe_note.isHidden = false
            swipe.isEnabled = false
            //keep the APR as is
            time_title.text =  "Time"
            savings_title.text = "Savings"
            //don't change layout constraints
//        }
        //print(view.frame.height)
        if (view.frame.height == 736) {
//            splash_width.constant = 414
//            splash_height.constant = 736
            //splash_screen.backgroundColor = UIColor(patternImage: UIImage(named: "launchscreenbackgroundp.png")!) //for old splash screen
            //step1height.constant = CGFloat(Double(148))
            //step2height.constant = CGFloat(Double(307))
            //step3height.constant = CGFloat(Double(94))
//            step1height.constant = CGFloat(Double(150))
//            step2height.constant = CGFloat(Double(310))
//            step3height.constant = CGFloat(Double(89))

            //step1height.constant = CGFloat(Double(451/3))
            //step2height.constant = CGFloat(Double(929/3))
            //step3height.constant = CGFloat(Double(268/3))
        }
        else {
            //splash_screen.backgroundColor = UIColor(patternImage: UIImage(named: "launchscreenbackground.png")!) //for old splash screen
            //keep rest
        }

        unlocked.isHidden = true
        edit_slider.isHidden = true
        edit_apr.isHidden = true
        edit_pay.isHidden = true
        swiping.isHidden = true
        stopped.isHidden = true
        swipe_label.isHidden = true
        even_out.isHidden = true
        abs_10yr.isHidden = true
        suggest.isHidden = true
        //swipe_note.isHidden = true
        swipe_note.text = "Swipe disabled."
        swipe_blink.isHidden = true
        //print(rates_reference[0])
        //print(rates_reference[1])
        //print(rates_reference[2])
        loaned_min_input.delegate = self
        loaned_max_input.delegate = self
        increment_input.delegate = self
        input_number_of_increments.delegate = self
        apr_number.delegate = self
        pay_number.delegate = self
        down_number.delegate = self
        up_number.delegate = self
        down_timer1_seconds.delegate = self
        down_timer2_seconds.delegate = self
        down_timer1_increment.delegate = self
        down_timer2_increment.delegate = self
        up_timer1_seconds.delegate = self
        up_timer2_seconds.delegate = self
        up_timer1_increment.delegate = self
        up_timer2_increment.delegate = self


        //self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate;
        //view.gestureRecognizers?.removeAll()
        //self.interactivePopGestureRecognizer.isEnabled = false;
        //edit_slider_shape.backgroundColor = UIColor(red:74/255.0, green:82/255.0, blue:86/255.0, alpha: 0.9)
        edit_slider_shape.isHidden = true
        edit_apr_shape.isHidden = true
        edit_pay_shape.isHidden = true
        //view.addSubview(edit_pay_shape)
        //view.bringSubviewToFront(edit_pay_shape)

        submit_changes.isHidden = true
        submit_changes_apr.isHidden = true
        submit_changes_pay.isHidden = true
        
        stack_inputs_timers_down.isHidden = true
        stack_inputs_timers_up.isHidden = true
        //could probably have just hidden the stackview:
        increment_input_left_label.isHidden = true
        increment_input.isHidden = true
        increment_input_right_label.isHidden = true
        input_number_of_increments.isHidden = true
        bare_track.isHidden = true //needed?
        down_sign.isHidden = true
        down_number.isHidden = true
        up_sign.isHidden = true
        up_number.isHidden = true
        
        loaned_min_input.isUserInteractionEnabled = false
        loaned_max_input.isUserInteractionEnabled = false
        increment_input.isUserInteractionEnabled = false
        input_number_of_increments.isUserInteractionEnabled = false
        apr_number.isUserInteractionEnabled = false
        apr_number_back.isUserInteractionEnabled = false
        pay_number.isUserInteractionEnabled = false
        down_number.isUserInteractionEnabled = false
        up_number.isUserInteractionEnabled = false
        //no need to mention increment input, since hidden
        down_timer1_seconds.isUserInteractionEnabled = false
        down_timer2_seconds.isUserInteractionEnabled = false
        down_timer1_increment.isUserInteractionEnabled = false
        down_timer2_increment.isUserInteractionEnabled = false
        up_timer1_seconds.isUserInteractionEnabled = false
        up_timer2_seconds.isUserInteractionEnabled = false
        up_timer1_increment.isUserInteractionEnabled = false
        up_timer2_increment.isUserInteractionEnabled = false


        //edit_slider.adjustsImageWhenHighlighted = false
        //edit_apr.adjustsImageWhenHighlighted = false
        //edit_pay.adjustsImageWhenHighlighted = false
        submit_changes.adjustsImageWhenHighlighted = false
        submit_changes_apr.adjustsImageWhenHighlighted = false
        submit_changes_pay.adjustsImageWhenHighlighted = false
        swiping.adjustsImageWhenHighlighted = false
        stopped.adjustsImageWhenHighlighted = false
        absolute.adjustsImageWhenHighlighted = false
        tenyr.adjustsImageWhenHighlighted = false

        //calayer has awkward behavior for plus models, had to tweak code
        //view.addSubview(edit_slider_shape)
        //edit_slider_shape.frame = CGRect(x: view.frame.origin.x+5, y: edit_slider_shape.frame.origin.y, width: view.frame.width-10, height: edit_slider_shape.frame.height)

        edit_slider_shape_tweak.bounds = edit_slider_shape.frame
        edit_slider_shape_tweak.position = edit_slider_shape.center
        edit_slider_shape_tweak.path = UIBezierPath(roundedRect: edit_slider_shape.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //edit_slider_shape_tweak.fillColor = UIColor(red:74/255.0, green:82/255.0, blue:86/255.0, alpha: 0.75).cgColor
        edit_slider_shape_tweak.fillColor = UIColor(red:32/255.0, green:36/255.0, blue:38/255.0, alpha: 0.0).cgColor
        
        //edit_apr_shape.frame = CGRectGetWidth(edit_apr_shape.frame, view.frame.width - 10)
        edit_apr_shape_tweak.bounds = edit_apr_shape.frame
        edit_apr_shape_tweak.position = edit_apr_shape.center
        edit_apr_shape_tweak.path = UIBezierPath(roundedRect: edit_apr_shape.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //edit_apr_shape_tweak.fillColor = UIColor(red:74/255.0, green:82/255.0, blue:86/255.0, alpha: 0.75).cgColor
        edit_apr_shape_tweak.fillColor = UIColor(red:32/255.0, green:36/255.0, blue:38/255.0, alpha: 0.0).cgColor
        //edit_slider_shape.layer.addSublayer(edit_slider_shape_tweak)

        
        edit_apr_shape_tweak_trianglePath.move(to: CGPoint(x: 0, y: 0))
        edit_apr_shape_tweak_trianglePath.addLine(to: CGPoint(x: 17, y: 0))
        edit_apr_shape_tweak_trianglePath.addLine(to: CGPoint(x: 8.5, y: 12))
        edit_apr_shape_tweak_trianglePath.close()
        
        edit_apr_shape_tweak_triangleLayer.path = edit_apr_shape_tweak_trianglePath.cgPath
        let CGPoint_xtemp = ((edit_apr_shape.frame.width-interest_rate_unpressed.frame.width)/2)+(0.75*interest_rate_unpressed.frame.width-8.5)
        let CGPoint_ytemp = edit_apr_shape.frame.height-interest_rate_unpressed.frame.height-10+interest_rate_unpressed.frame.height/2-6
        edit_apr_shape_tweak_triangleLayer.position = CGPoint(x: CGPoint_xtemp, y: CGPoint_ytemp)//
        edit_apr_shape_tweak_triangleLayer.fillColor = UIColor.clear.cgColor
        edit_apr_shape_tweak_triangleLayer.borderWidth = 0.25
        //edit_apr_shape_tweak_triangleLayer.cornerRadius = 0

        
        edit_pay_shape_tweak.bounds = edit_pay_shape.frame
        edit_pay_shape_tweak.position = edit_pay_shape.center
        edit_pay_shape_tweak.path = UIBezierPath(roundedRect: edit_pay_shape.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //edit_pay_shape_tweak.fillColor = UIColor(red:74/255.0, green:82/255.0, blue:86/255.0, alpha: 0.75).cgColor
        edit_pay_shape_tweak.fillColor = UIColor(red:32/255.0, green:36/255.0, blue:38/255.0, alpha: 0.0).cgColor

        
        interest_rate_unpressed_outline.frame = CGRect(x: (edit_apr_shape.frame.width-interest_rate_unpressed.frame.width)/2, y: edit_apr_shape.frame.height-interest_rate_unpressed.frame.height-10, width: interest_rate_unpressed.frame.width, height: interest_rate_unpressed.frame.height)
        //interest_rate_unpressed_outline.frame = CGRect(x: (edit_apr_shape.frame.width-interest_rate_unpressed.frame.width)+100, y: interest_rate_unpressed.frame.origin.y, width: interest_rate_unpressed.frame.width, height: interest_rate_unpressed.frame.height)
        //interest_rate_unpressed_outline.bounds = interest_rate_unpressed.frame
        //interest_rate_unpressed_outline.position = interest_rate_unpressed.center
        //interest_rate_unpressed_outline.path = UIBezierPath(roundedRect: interest_rate_unpressed.bounds, byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //interest_rate_unpressed.layer.addSublayer(interest_rate_unpressed_center)
        interest_rate_unpressed_outline.fillColor = UIColor.clear.cgColor
        interest_rate_unpressed_outline.borderWidth = 0.25
        interest_rate_unpressed_outline.cornerRadius = 5
        
        switch_outline.frame = CGRect(x: edit_apr_shape.frame.width/2+2, y: 10, width: apr.frame.width, height: apr.frame.height)
        switch_outline.fillColor = UIColor.clear.cgColor
        switch_outline.borderWidth = 0.25
        switch_outline.cornerRadius = apr.frame.height/2

        switch_thumb_outline.frame = CGRect(x: edit_apr_shape.frame.width/2+apr.frame.width/2-2, y: 10+2, width: apr.frame.height-3, height: apr.frame.height-4)
        switch_thumb_outline.fillColor = UIColor.clear.cgColor
        switch_thumb_outline.borderWidth = 0.25
        switch_thumb_outline.cornerRadius = apr.frame.height/2

        let CGRect_xtemp = (edit_pay_shape.frame.width)/2-down_unpressed.frame.width-(pay_monthly_box.frame.width)/2+5
        let CGRect_ytemp = edit_pay_shape.frame.height - 65 - down_unpressed.frame.height-1
        down_outline.frame = CGRect(x: CGRect_xtemp, y: CGRect_ytemp, width: down_unpressed.frame.width, height: down_unpressed.frame.height)
        //down_outline.frame = CGRect(x: (edit_pay_shape.frame.width-down_unpressed.frame.width*2-pay_monthly_box.frame.width)/2+5, y: (edit_pay_shape.frame.height - down_unpressed.frame.height)/2-1, width: down_unpressed.frame.width, height: down_unpressed.frame.height)
        down_outline.fillColor = UIColor.clear.cgColor
        down_outline.borderWidth = 0.25
        down_outline.cornerRadius = 5
        //(edit_pay_shape.frame.width-interest_rate_unpressed.frame.width*2-pay_monthly_box.frame.width)/2
        //print(edit_pay_shape.frame.width)
        //print(interest_rate_unpressed.frame.width)
        //print(pay_monthly_box.frame.width)
        //print((edit_pay_shape.frame.width-interest_rate_unpressed.frame.width*2-pay_monthly_box.frame.width)/2)
        
        pay_outline.frame = CGRect(x: (edit_pay_shape.frame.width-down_unpressed.frame.width*2-pay_monthly_box.frame.width)/2+down_unpressed.frame.width, y: edit_pay_shape.frame.height - 65 - up_unpressed.frame.height, width: pay_monthly_box.frame.width, height: pay_monthly_box.frame.height)
        //pay_outline.frame = CGRect(x: (edit_pay_shape.frame.width-down_unpressed.frame.width*2-pay_monthly_box.frame.width)/2+down_unpressed.frame.width, y: (edit_pay_shape.frame.height - down_unpressed.frame.height)/2+(down_unpressed.frame.height-pay_monthly_box.frame.height)/2, width: pay_monthly_box.frame.width, height: pay_monthly_box.frame.height)
        pay_outline.fillColor = UIColor.clear.cgColor
        pay_outline.borderWidth = 0.25
        //pay_outline.cornerRadius = 5
        let CGRect_xtemp2pre = (edit_pay_shape.frame.width)/2-up_unpressed.frame.width-(pay_monthly_box.frame.width)/2
        let CGRect_xtemp2 = CGRect_xtemp2pre+down_unpressed.frame.width+pay_monthly_box.frame.width-5
        let CGRect_ytemp2 = edit_pay_shape.frame.height - 65 - up_unpressed.frame.height-1
        up_outline.frame = CGRect(x: CGRect_xtemp2, y: CGRect_ytemp2, width: up_unpressed.frame.width, height: up_unpressed.frame.height)
        //up_outline.frame = CGRect(x: (edit_pay_shape.frame.width-up_unpressed.frame.width*2-pay_monthly_box.frame.width)/2+down_unpressed.frame.width+pay_monthly_box.frame.width-5, y: (edit_pay_shape.frame.height - up_unpressed.frame.height)/2-1, width: up_unpressed.frame.width, height: up_unpressed.frame.height)
        up_outline.fillColor = UIColor.clear.cgColor
        up_outline.borderWidth = 0.25
        up_outline.cornerRadius = 5
        

        
        /*swipe_tab_shape_path.move(to: CGPoint(x: swiping.frame.width, y: swiping.frame.height/2))
        swipe_tab_shape_path.addArc(withCenter: CGPoint(x: swiping.frame.width, y: swiping.frame.height/2), radius: CGFloat(swiping.frame.width*2), startAngle: CGFloat(1/2*Double.pi), endAngle: CGFloat(3/2*Double.pi), clockwise: true)
        swipe_tab_shape_path_layer.path = swipe_tab_shape_path.cgPath
        swipe_tab_shape_path_layer.fillColor = UIColor(red: 74.0/255, green: 82.0/255, blue: 86.0/255, alpha: 1.0).cgColor
        swipe_tab_shape_path_layer.shadowColor = UIColor.black.cgColor*/

        


        /*swipe_stop_tab_shape_path.move(to: CGPoint(x: stop.frame.width, y: stop.frame.height/2))
        swipe_stop_tab_shape_path.addArc(withCenter: CGPoint(x: stop.frame.width, y: stop.frame.height/2), radius: CGFloat(stop.frame.width*2), startAngle: CGFloat(1/2*Double.pi), endAngle: CGFloat(3/2*Double.pi), clockwise: true)
        swipe_stop_tab_shape_path_layer.path = swipe_stop_tab_shape_path.cgPath
        swipe_stop_tab_shape_path_layer.position = CGPoint(x: 0, y: 0)//
        //swipe_stop_tab_shape_path_layer.fillColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0).cgColor
        stop.layer.addSublayer(swipe_stop_tab_shape_path_layer)*/


        increment_input_left_label.alpha = 0.0
        increment_input.alpha = 0.0
        increment_input_right_label.alpha = 0.0
        input_number_of_increments.alpha = 0.0
        bare_track.alpha = 0.0
        down_sign.alpha = 0.0
        down_number.alpha = 0.0
        up_sign.alpha = 0.0
        up_number.alpha = 0.0

        down_timer1.alpha = 0.0
        down_timer2.alpha = 0.0
        down_timer1_seconds.alpha = 0.0
        down_timer2_seconds.alpha = 0.0
        down_timer1_seconds_label.alpha = 0.0
        down_timer2_seconds_label.alpha = 0.0
        down_timer1_increment.alpha = 0.0
        down_timer2_increment.alpha = 0.0
        
        up_timer1.alpha = 0.0
        up_timer2.alpha = 0.0
        up_timer1_seconds.alpha = 0.0
        up_timer2_seconds.alpha = 0.0
        up_timer1_seconds_label.alpha = 0.0
        up_timer2_seconds_label.alpha = 0.0
        up_timer1_increment.alpha = 0.0
        up_timer2_increment.alpha = 0.0
        
        interest_rate_unpressed_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
        down_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
        pay_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
        up_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
        edit_apr_shape_tweak_triangleLayer.strokeColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
        switch_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor
        switch_thumb_outline.borderColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 255.0/255, alpha: 0.0).cgColor


        
        edit_slider_shape.layer.addSublayer(edit_slider_shape_tweak)
        edit_apr_shape.layer.addSublayer(edit_apr_shape_tweak)
        edit_apr_shape.layer.addSublayer(interest_rate_unpressed_outline)
        edit_apr_shape.layer.addSublayer(edit_apr_shape_tweak_triangleLayer)
        edit_apr_shape.layer.addSublayer(switch_outline)
        edit_apr_shape.layer.addSublayer(switch_thumb_outline)
        edit_pay_shape.layer.addSublayer(edit_pay_shape_tweak)
        edit_pay_shape.layer.addSublayer(down_outline)
        edit_pay_shape.layer.addSublayer(pay_outline)
        edit_pay_shape.layer.addSublayer(up_outline)

        
        /*edit_slider_shape.addSubview(increment_input_left_label)
        edit_slider_shape.addSubview(increment_input)
        edit_slider_shape.addSubview(increment_input_right_label)
        edit_slider_shape.addSubview(input_number_of_increments)*/

        edit_apr_text_back.isHidden = true

        
        //swipe.isEnabled = false //disable until opening is done
        
        /*DispatchQueue.global(qos: .background).async {
            
        //get most up-to-date information
        if let url = URL(string: "https://studentaid.ed.gov/sa/types/loans/interest-rates") {
            do {
                let contents = try String(contentsOf: url)

                    /*print(contents)*/
                    /*let detagSource = "<!DOCTYPE html> <html> <body> <h1>Perkins Loans (regardless of the first disbursement date) have a fixed interest rate of 5%</h1> </body> </html>"*/
                    .replacingOccurrences(
                        of: "<[^>]+>",
                        with: "",
                        options: .regularExpression,
                        range: nil
                    )
                    .replacingOccurrences(
                        of: "\\Qx3C/script>\\E",
                        with: "",
                        options: .regularExpression,
                        range: nil
                    )
                    .replacingOccurrences(
                        of: "\\Q//-->\\E",
                        with: "",
                        options: .regularExpression,
                        range: nil
                    )
                    .replacingOccurrences(
                        of: " ",
                        with: "",
                        options: .regularExpression,
                        range: nil
                    )

                //perkins loans
                let extractPerkinsLoanRate = contents
                    .replacingOccurrences(
                        of: "\\QPerkinsLoans(regardlessofthefirstdisbursementdate)haveafixedinterestrateof\\E",
                        with: "PerkinsLoans(regardlessofthefirstdisbursementdate)haveafixedinterestrateof>",
                        options: .regularExpression,
                        range: nil
                    )
                    .replacingOccurrences(
                        of: "\\Q%.\\E",
                        with: "<%.",
                        options: .regularExpression,
                        range: nil
                    )
 
                let outerBracketsPerkins = "<" + "\(extractPerkinsLoanRate)" + ">"
                
                let extractedPerkinsLoanRate = outerBracketsPerkins
                    .replacingOccurrences(
                        of: "<[^>]+>",
                        with: "",
                        options: .regularExpression,
                        range: nil
                    )
                /*let removeDuplicatesPerkins = Double(Int(ceil(Double(extractedPerkinsLoanRate)!)/10))*/
                
                var removeDuplicatesPerkins = self.APR_PERKINS
                if (Double(extractedPerkinsLoanRate) != nil) {
                    removeDuplicatesPerkins = Double(Int(Double(extractedPerkinsLoanRate)!/10))
                }
                else {
                    //skip
                }

                //direct loans
                let extractDirectLoanRate = contents
                    .replacingOccurrences(
                        of: "\\QDirectSubsidizedLoans,\\E",
                        with: "",
                        options: .regularExpression,
                        range: nil
                    )
                    .replacingOccurrences(
                        of: "\\QDirectSubsidizedLoans\\E",
                        with: "DirectSubsizedLoans>",
                        options: .regularExpression,
                        range: nil
                    )
                    .replacingOccurrences(
                        of: "\\Q%\\E",
                        with: "<%",
                        options: .regularExpression,
                        range: nil
                    )

                let outerBracketsDirect = "<" + "\(extractDirectLoanRate)" + ">"
                let extractedDirectLoanRate = outerBracketsDirect
                    .replacingOccurrences(
                        of: "<[^>]+>",
                        with: "",
                        options: .regularExpression,
                        range: nil
                    )
 
                let tidyDirectLoanRateMore = extractedDirectLoanRate
                    .replacingOccurrences(
                        of: "\\QUndergraduate\\E",
                        with: "",
                        options: .regularExpression,
                        range: nil
                    )
                    .replacingOccurrences(
                        of: "\\QandDirect\\E",
                        with: "<andDirect",
                        options: .regularExpression,
                        range: nil
                    )
                    .appending(
                        ">"
                    )
                    .replacingOccurrences(
                        of: "<[^>]+>",
                        with: "",
                        options: .regularExpression,
                        range: nil
                    )
                    .replacingOccurrences(
                        of: "\n",
                        with: "",
                        options: .regularExpression,
                        range: nil
                    )

                /*let tidiedDirectLoanRateMore = Double(Int(ceil(Double(tidyDirectLoanRateMore)!*100)))/100*/
                var tidiedDirectLoanRateMore = self.APR_DIRECT
                if (Double(tidyDirectLoanRateMore) != nil) {
                    tidiedDirectLoanRateMore = Double(tidyDirectLoanRateMore)!
                }
                else {
                    //skip
                }
                
                
                
                /*print(Double(tidyDirectLoanRateMore)!, terminator: "\n")
                print(Double(tidyDirectLoanRateMore)!*100, terminator: "\n")
                print(ceil(Double(tidyDirectLoanRateMore)!*100), terminator: "\n")
                print(Int(ceil(Double(tidyDirectLoanRateMore)!*100)), terminator: "\n")
                print(Double(Int(ceil(Double(tidyDirectLoanRateMore)!*100))), terminator: "\n")
                
                print(Double(Int(ceil(Double(tidyDirectLoanRateMore)!*100)))/100, terminator: "\n")*/

                DispatchQueue.main.async {
                    //self.rates = ["\(tidiedDirectLoanRateMore)"+"%",String(format: "%.2f", removeDuplicatesPerkins)+"%"]
                    self.rates = ["\(tidiedDirectLoanRateMore)",String(format: "%.2f", removeDuplicatesPerkins)]
                    self.rates_text = ["\(tidiedDirectLoanRateMore)"+"% - Direct Loan", String(format: "%.2f", removeDuplicatesPerkins)+"% - Perkins Loan"]
                    self.rates_reference = [tidiedDirectLoanRateMore / 12 / 100, removeDuplicatesPerkins / 12 / 100, Double()]
                    self.i = tidiedDirectLoanRateMore/12/100
                    /*let tempRate = Int(tidiedDirectLoanRateMore*100)
                     i = Double(tempRate)/100/12/100*/
                    self.apr_number.text = String(self.rates[0])
                    self.apr_number_back.text = String(self.rates[0])


                    //self.interest_rate_unpressed.setTitle(self.rates[0], for: UIControlState())
                    //self.interest_rate_unpressed_copy.setTitle(self.rates[0], for: UIControlState())
                    //self.interest_rate_pressed.setTitle(self.rates[0], for: UIControlState())
                    //self.interest_rate_pressed_copy.setTitle(self.rates[0], for: UIControlState())
                    //self.interest_rate_disabled.setTitle(self.rates[0], for: UIControlState())
                    self.i_reference = self.i
                    self.shared_preferences.set(self.i * 12 * 100, forKey: "interest"); self.shared_preferences.synchronize()
                    self.table_view.reloadData() /* <-- fixes bug */
                    self.table_view.frame = CGRect(x: self.table_view.frame.origin.x, y: self.table_view.frame.origin.y, width: self.table_view.frame.width, height: 0)
                }
                
                
                //additional fallback plans
            } catch {
                //do nothing, if contents could not be loaded (e.g., URL is under construction)
            }
        } else {
            //do nothing, if the URL moved
        }

        }//end of queue*/
        
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        
        loaned_min_input.text = numberFormatter.string(from: NSNumber(value: min_value))!
        loaned_max_input.text = numberFormatter.string(from: NSNumber(value: max_value))!
        apr_number.text = String(format: "%.2f", i * 12 * 100)
        apr_number_back.text = String(format: "%.2f", i * 12 * 100)
        
        shared_preferences.set(p, forKey: "loaned"); shared_preferences.synchronize()
        shared_preferences.set(i * 12 * 100, forKey: "interest"); shared_preferences.synchronize()
        /*let temp = Int((p * i + 0.01) * 100)*/
        var temp = Double()
        /*if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5) { temp = (round(p*i*100 + 1) + 1)/100}
        else { temp = (round(p*i*100) + 1)/100 }*/
        if (tenyr_indicator == 0) {
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { temp = (round(p*i*100 + 1) + 1)/100}
            else { temp = (round(p*i*100) + 1)/100 }
        }
        else {
            if (i != 0) {
                temp = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
            }
            else {
                temp = ceil(p/120*100)/100
            }
        }

        //print(temp)
        


        a = temp
        a_reference = temp
        shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
        shared_preferences.set(tenyr_indicator, forKey: "tenyr"); shared_preferences.synchronize()
        if (a - floor(a) == 0) {
            pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
        }
        else if ((a - floor(a))*100 < 9.99999) {
            pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
        }
        else {
            pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
        }
        Lengthsaving()

        /*arrow_pressed.isHidden = true
        arrow_pressed_copy.isHidden = true
        arrow_unpressed_copy.isHidden = true*/
        self.table_view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table_view.delegate = self
        table_view.dataSource = self
        /*table_view.isHidden = true*/
        table_view.alpha = 0.0 //temp
        table_view.isScrollEnabled = false
        table_view.layoutMargins = UIEdgeInsets.zero
        table_view.separatorInset = UIEdgeInsets.zero
        down_pressed.isHidden = true
        up_pressed.isHidden = true
        interest_rate_pressed.isHidden = true
        interest_rate_pressed_copy.isHidden = true
        interest_rate_unpressed_copy.isHidden = true
        invisible_back.isHidden = true
        self.navigationController!.navigationBar.isHidden = true
        loaned.setThumbImage(UIImage(named: "Thumb"), for: .normal)
        
        /*interest_rate_unpressed_copy.layer.shadowColor = UIColor.black.cgColor
        interest_rate_unpressed_copy.layer.shadowOffset = CGSize(width: 0, height: 1)
        interest_rate_unpressed_copy.layer.shadowOpacity = 0.125
        interest_rate_unpressed_copy.layer.shadowRadius = 2*/
        
        /*interest_rate_pressed.layer.shadowColor = UIColor.black.cgColor
        interest_rate_pressed.layer.shadowOffset = CGSize(width: 0, height: 1)
        interest_rate_pressed.layer.shadowOpacity = 0.125
        interest_rate_pressed.layer.shadowRadius = 1*/
        
        /*interest_rate_pressed_copy.layer.shadowColor = UIColor.black.cgColor
        interest_rate_pressed_copy.layer.shadowOffset = CGSize(width: 0, height: 1)
        interest_rate_pressed_copy.layer.shadowOpacity = 0.125
        interest_rate_pressed_copy.layer.shadowRadius = 1*/
        
        /*arrow_unpressed.layer.shadowColor = UIColor.black.cgColor
        arrow_unpressed.layer.shadowOffset = CGSize(width: 0, height: 1)
        arrow_unpressed.layer.shadowOpacity = 0.125
        arrow_unpressed.layer.shadowRadius = 2*/
        
        /*arrow_unpressed_copy.layer.shadowColor = UIColor.black.cgColor
        arrow_unpressed_copy.layer.shadowOffset = CGSize(width: 0, height: 1)
        arrow_unpressed_copy.layer.shadowOpacity = 0.125
        arrow_unpressed_copy.layer.shadowRadius = 3*/

        /*arrow_pressed.layer.shadowColor = UIColor.black.cgColor
        arrow_pressed.layer.shadowOffset = CGSize(width: 0, height: 1)
        arrow_pressed.layer.shadowOpacity = 0.125
        arrow_pressed.layer.shadowRadius = 2*/
        
        /*arrow_pressed_copy.layer.shadowColor = UIColor.black.cgColor
        arrow_pressed_copy.layer.shadowOffset = CGSize(width: 0, height: 1)
        arrow_pressed_copy.layer.shadowOpacity = 0.125
        arrow_pressed_copy.layer.shadowRadius = 2*/
        
        /*down_unpressed.layer.shadowColor = UIColor.black.cgColor
        down_unpressed.layer.shadowOffset = CGSize(width: 0, height: 1)
        down_unpressed.layer.shadowOpacity = 0.125
        down_unpressed.layer.shadowRadius = 2*/

        /*down_pressed.layer.shadowColor = UIColor.black.cgColor
        down_pressed.layer.shadowOffset = CGSize(width: 0, height: 1)
        down_pressed.layer.shadowOpacity = 0.125
        down_pressed.layer.shadowRadius = 1*/
        
        /*up_unpressed.layer.shadowColor = UIColor.black.cgColor
        up_unpressed.layer.shadowOffset = CGSize(width: 0, height: 1)
        up_unpressed.layer.shadowOpacity = 0.125
        up_unpressed.layer.shadowRadius = 2*/

        /*up_pressed.layer.shadowColor = UIColor.black.cgColor
        up_pressed.layer.shadowOffset = CGSize(width: 0, height: 1)
        up_pressed.layer.shadowOpacity = 0.125
        up_pressed.layer.shadowRadius = 1*/
        
        /*self.table_view.layer.shadowColor = UIColor.black.cgColor
        self.table_view.layer.shadowOffset = CGSize(width: 0, height: 2) /* <-- maybe change others? */
        self.table_view.layer.shadowOpacity = 0.125
        self.table_view.layer.shadowRadius = 1
        self.table_view.clipsToBounds = false*/
        /* ---------------- need affect for pressing on dropdown menu  -------------- */
        
        /*pay_monthly_box.backgroundColor = UIColor(patternImage: UIImage(named: "payment_background.png")!)*/
        
        /*self.table_view.separatorStyle = UITableViewCellSeparatorStyle.none*/
        self.table_view.separatorColor = UIColor(red: 151.0/255, green: 156.0/255, blue: 158.0/255, alpha: 1.0)
        
        apr.layer.cornerRadius = 16
        
        interest_rate_disabled.isHidden = true
        /*arrow_disabled.isHidden = true*/
        
        /*loaned.setMinimumTrackImage(UIImage(named: "mintrack.png")!.resizableImage(withCapInsets: .zero, resizingMode: .tile), for: .normal)*/
        //stretch?
        loaned.setMinimumTrackImage(UIImage(named: "MinTrack")!.resizableImage(withCapInsets: .zero, resizingMode: .tile), for: .normal) /*leave extra room around image that is background color, or else inset (though it should be zero) will be color of foreground*/
        loaned.setMaximumTrackImage(UIImage(named: "MaxTrack")!.resizableImage(withCapInsets: .zero, resizingMode: .tile), for: .normal)
        
        //view.addSubview(loaned)
        if (increment - floor(increment) != 0) {
            loaned.isHidden = true
            Edit_Slider_Expand(nil)
        }
        else {
            //Edit_Slider_Close(nil)
            //loaned.isHidden = false
        }
        
        
        /*let mintrack_trianglePath = UIBezierPath()
        mintrack_trianglePath.move(to: CGPoint(x: 309, y: 0))
        mintrack_trianglePath.addLine(to: CGPoint(x: 309, y: 20))
        mintrack_trianglePath.addLine(to: CGPoint(x: 0, y: 20))
        mintrack_trianglePath.close()
        
        let mintrack_triangleLayer = CAShapeLayer()
        mintrack_triangleLayer.path = mintrack_trianglePath.cgPath
        mintrack_triangleLayer.frame = CGRect(x: 0, y: 0, width: 309, height: 20)
        /*mintrack_triangleLayer.position = CGPoint(x: 0, y: 0)*/
        mintrack_triangleLayer.fillColor = UIColor(red: 55.0/255, green: 218.0/255, blue: 101.0/255, alpha: 1.0).cgColor
        /*let imageview = UIImageView()*/
        view.layer.mask = mintrack_triangleLayer*/
        /*loaned.layer.addSublayer(mintrack_triangleLayer)*/
        /*let image = UIImage.shape*/
        /*loaned.setMinimumTrackImage(UIImage(shapeImage), for: .normal)*/
            /*.resizableImage(withCapInsets: .zero), for: .normal)*/
        
        
        
        
        
        
            
            
            

 
 
        /*let loaned_background = CALayer()*/
        /*loaned_background.frame = CGRect(x: 0, y: 0, width: 309, height: 20)*/
        /*loaned.layer.addSublayer(loaned_background)
        loaned_background.contents = mintrack_triangleLayer*/
        /*loaned_background.addSublayer(mintrack_triangleLayer)*/

        
        /*interest_rate_unpressed.backgroundColor = UIColor(red: 161.0/255, green: 166.0/255, blue: 168.0/255, alpha: 1.0)*/
        /*interest_rate_unpressed.backgroundColor = UIColor(red: 64.0/255, green: 73.0/255, blue: 77.0/255, alpha: 1.0)*/
        /*bubble_label.font = UIFont.boldSystemFont(ofSize: 17.0)
        bubble_label.textAlignment = .center
        bubble_label.layer.masksToBounds = true*/
        /*interest_rate_unpressed.layer.cornerRadius = 5*/
        /*self.interest_rate_unpressed.layer.shadowColor = UIColor.black.cgColor
        self.interest_rate_unpressed.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.interest_rate_unpressed.layer.shadowOpacity = 0.125
        self.interest_rate_unpressed.layer.shadowRadius = 2*/

        //interest_rate_unpressed
        /*let interest_rate_unpressed_top = CAShapeLayer()
        interest_rate_unpressed_top.bounds = interest_rate_unpressed.frame
        interest_rate_unpressed_top.position = interest_rate_unpressed.center
        interest_rate_unpressed_top.path = UIBezierPath(roundedRect: CGRect(x: 0, y: -0.25, width: interest_rate_unpressed.frame.width, height: interest_rate_unpressed.frame.height), byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        interest_rate_unpressed.layer.addSublayer(interest_rate_unpressed_top)
        interest_rate_unpressed_top.fillColor = UIColor(red: 254.0/255, green: 254.0/255, blue: 254.0/255, alpha: 1.0).cgColor*/

        /*let interest_rate_unpressed_bottom = CAShapeLayer()
        interest_rate_unpressed_bottom.bounds = interest_rate_unpressed.frame
        interest_rate_unpressed_bottom.position = interest_rate_unpressed.center
        interest_rate_unpressed_bottom.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0.25, width: interest_rate_unpressed.frame.width, height: interest_rate_unpressed.frame.height), byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        interest_rate_unpressed.layer.addSublayer(interest_rate_unpressed_bottom)
        interest_rate_unpressed_bottom.fillColor = UIColor.black.cgColor*/
        
        let interest_rate_unpressed_center = CAShapeLayer()
        interest_rate_unpressed_center.bounds = interest_rate_unpressed.frame
        interest_rate_unpressed_center.position = interest_rate_unpressed.center
        interest_rate_unpressed_center.path = UIBezierPath(roundedRect: interest_rate_unpressed.bounds, byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        interest_rate_unpressed.layer.addSublayer(interest_rate_unpressed_center)
        interest_rate_unpressed_center.fillColor = UIColor(red: 68.0/255, green: 77.0/255, blue: 82.0/255, alpha: 1.0).cgColor
        
        let interest_rate_unpressed_trianglePath = UIBezierPath()
        interest_rate_unpressed_trianglePath.move(to: CGPoint(x: 0, y: 0))
        interest_rate_unpressed_trianglePath.addLine(to: CGPoint(x: 17, y: 0))
        interest_rate_unpressed_trianglePath.addLine(to: CGPoint(x: 8.5, y: 12))
        interest_rate_unpressed_trianglePath.close()
        
        let interest_rate_unpressed_triangleLayer = CAShapeLayer()
        interest_rate_unpressed_triangleLayer.path = interest_rate_unpressed_trianglePath.cgPath
        interest_rate_unpressed_triangleLayer.position = CGPoint(x: 0.75*interest_rate_unpressed.frame.width-8.5, y: interest_rate_unpressed.frame.height/2-6)
        interest_rate_unpressed_triangleLayer.fillColor = UIColor(red: 161.0/255, green: 166.0/255, blue: 168.0/255, alpha: 1.0).cgColor
        interest_rate_unpressed.layer.addSublayer(interest_rate_unpressed_triangleLayer)

        interest_rate_unpressed.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.25*interest_rate_unpressed.frame.width, bottom: 0.0, right: 0.0) //*****
        //print(0.25*interest_rate_unpressed.frame.width)
        
        interest_rate_unpressed.layer.shadowColor = UIColor.black.cgColor
        interest_rate_unpressed.layer.shadowOffset = CGSize(width: 0, height: 1)
        interest_rate_unpressed.layer.shadowOpacity = 0.25
        interest_rate_unpressed.layer.shadowRadius = 1
        
        let interest_rate_pressed_center = CAShapeLayer()
        interest_rate_pressed_center.bounds = interest_rate_pressed.frame
        interest_rate_pressed_center.position = interest_rate_pressed.center
        interest_rate_pressed_center.path = UIBezierPath(roundedRect: interest_rate_pressed.bounds, byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        interest_rate_pressed.layer.addSublayer(interest_rate_pressed_center)
        interest_rate_pressed_center.fillColor = UIColor(red: 68.0/255, green: 77.0/255, blue: 82.0/255, alpha: 1.0).cgColor
        
        
        let arrow_pressed_trianglePath = UIBezierPath()
        arrow_pressed_trianglePath.move(to: CGPoint(x: 0, y: 0))
        arrow_pressed_trianglePath.addLine(to: CGPoint(x: 17, y: 0))
        arrow_pressed_trianglePath.addLine(to: CGPoint(x: 8.5, y: 12))
        arrow_pressed_trianglePath.close()
        
        let arrow_pressed_triangleLayer = CAShapeLayer()
        arrow_pressed_triangleLayer.path = arrow_pressed_trianglePath.cgPath
        arrow_pressed_triangleLayer.position = CGPoint(x: 0.75*interest_rate_pressed.frame.width-8.5, y: interest_rate_pressed.frame.height/2-6)
        arrow_pressed_triangleLayer.fillColor = UIColor(red: 161.0/255, green: 166.0/255, blue: 168.0/255, alpha: 1.0).cgColor
        interest_rate_pressed.layer.addSublayer(arrow_pressed_triangleLayer)

        /*let arrow_pressed_label = CALayer()
        arrow_pressed_label.frame = CGRect(x: 0.75*interest_rate_pressed.frame.width-UIImage(named: "down_arrow_button.png")!.size.width/2-1, y: interest_rate_pressed.frame.height/2-UIImage(named: "down_arrow_button.png")!.size.height/2, width: UIImage(named: "down_arrow_button.png")!.size.width-1, height: UIImage(named: "down_arrow_button.png")!.size.height)
        arrow_pressed_label.contents = UIImage(named: "down_arrow_button.png")?.cgImage
        interest_rate_pressed.layer.addSublayer(arrow_pressed_label)*/
        
        interest_rate_pressed.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0.25*interest_rate_pressed.frame.width, bottom: 0.0, right: 0.0)
        
        interest_rate_pressed.layer.shadowColor = UIColor.black.cgColor
        interest_rate_pressed.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        interest_rate_pressed.layer.shadowOpacity = 0.0625
        interest_rate_pressed.layer.shadowRadius = 0
        

        //down_arrow_unpressed
        /*let arrow_unpressed_top = CAShapeLayer()
        arrow_unpressed_top.bounds = arrow_unpressed.frame
        arrow_unpressed_top.position = arrow_unpressed.center
        arrow_unpressed_top.path = UIBezierPath(roundedRect: CGRect(x: 0, y: -0.25, width: arrow_unpressed.frame.width, height: arrow_unpressed.frame.height), byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        arrow_unpressed.layer.addSublayer(arrow_unpressed_top)
        arrow_unpressed_top.fillColor = UIColor(red: 254.0/255, green: 254.0/255, blue: 254.0/255, alpha: 1.0).cgColor
        
        let arrow_unpressed_bottom = CAShapeLayer()
        arrow_unpressed_bottom.bounds = arrow_unpressed.frame
        arrow_unpressed_bottom.position = arrow_unpressed.center
        arrow_unpressed_bottom.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0.25, width: arrow_unpressed.frame.width, height: arrow_unpressed.frame.height), byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        arrow_unpressed.layer.addSublayer(arrow_unpressed_bottom)
        arrow_unpressed_bottom.fillColor = UIColor.black.cgColor
        
        let arrow_unpressed_center = CAShapeLayer()
        arrow_unpressed_center.bounds = arrow_unpressed.frame
        arrow_unpressed_center.position = arrow_unpressed.center
        arrow_unpressed_center.path = UIBezierPath(roundedRect: arrow_unpressed.bounds, byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        arrow_unpressed.layer.addSublayer(arrow_unpressed_center)
        arrow_unpressed_center.fillColor = UIColor(red: 74.0/255, green: 82.0/255, blue: 86.0/255, alpha: 1.0).cgColor
        
        let arrow_unpressed_center_label = CALayer()
        arrow_unpressed_center_label.frame = CGRect(x: arrow_unpressed.frame.width/2-UIImage(named: "down_arrow_button.png")!.size.width/2, y: arrow_unpressed.frame.height/2-UIImage(named: "down_arrow_button.png")!.size.height/2, width: UIImage(named: "down_arrow_button.png")!.size.width, height: UIImage(named: "down_arrow_button.png")!.size.height)
        arrow_unpressed_center_label.contents = UIImage(named: "down_arrow_button.png")?.cgImage
        arrow_unpressed.layer.addSublayer(arrow_unpressed_center_label)*/
        
        //interest_rate_unpressed_copy
        /*let interest_rate_unpressed_copy_top = CAShapeLayer()
        interest_rate_unpressed_copy_top.bounds = interest_rate_unpressed_copy.frame
        interest_rate_unpressed_copy_top.position = interest_rate_unpressed_copy.center
        interest_rate_unpressed_copy_top.path = UIBezierPath(roundedRect: CGRect(x: 0, y: -0.25, width: interest_rate_unpressed_copy.frame.width, height: interest_rate_unpressed_copy.frame.height), byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        interest_rate_unpressed_copy.layer.addSublayer(interest_rate_unpressed_copy_top)
        interest_rate_unpressed_copy_top.fillColor = UIColor(red: 254.0/255, green: 254.0/255, blue: 254.0/255, alpha: 1.0).cgColor
        
        let interest_rate_unpressed_copy_bottom = CAShapeLayer()
        interest_rate_unpressed_copy_bottom.bounds = interest_rate_unpressed_copy.frame
        interest_rate_unpressed_copy_bottom.position = interest_rate_unpressed_copy.center
        interest_rate_unpressed_copy_bottom.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0.25, width: interest_rate_unpressed_copy.frame.width, height: interest_rate_unpressed_copy.frame.height), byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        interest_rate_unpressed_copy.layer.addSublayer(interest_rate_unpressed_copy_bottom)
        interest_rate_unpressed_copy_bottom.fillColor = UIColor.black.cgColor*/

        
        let interest_rate_unpressed_copy_center = CAShapeLayer()
        interest_rate_unpressed_copy_center.bounds = interest_rate_unpressed_copy.frame
        interest_rate_unpressed_copy_center.position = interest_rate_unpressed_copy.center
        interest_rate_unpressed_copy_center.path = UIBezierPath(roundedRect: interest_rate_unpressed_copy.bounds, byRoundingCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        interest_rate_unpressed_copy.layer.addSublayer(interest_rate_unpressed_copy_center)
        interest_rate_unpressed_copy_center.fillColor = UIColor(red: 68.0/255, green: 77.0/255, blue: 82.0/255, alpha: 1.0).cgColor
        
        let interest_rate_unpressed_copy_trianglePath = UIBezierPath()
        interest_rate_unpressed_copy_trianglePath.move(to: CGPoint(x: 17, y: 12))
        interest_rate_unpressed_copy_trianglePath.addLine(to: CGPoint(x: 8.5, y: 0))
        interest_rate_unpressed_copy_trianglePath.addLine(to: CGPoint(x: 0, y: 12))
        interest_rate_unpressed_copy_trianglePath.close()
        
        let interest_rate_unpressed_copy_triangleLayer = CAShapeLayer()
        interest_rate_unpressed_copy_triangleLayer.path = interest_rate_unpressed_copy_trianglePath.cgPath
        interest_rate_unpressed_copy_triangleLayer.position = CGPoint(x: 0.75*interest_rate_unpressed_copy.frame.width-8.5, y: interest_rate_unpressed_copy.frame.height/2-6)
        interest_rate_unpressed_copy_triangleLayer.fillColor = UIColor(red: 161.0/255, green: 166.0/255, blue: 168.0/255, alpha: 1.0).cgColor
        interest_rate_unpressed_copy.layer.addSublayer(interest_rate_unpressed_copy_triangleLayer)


        /*let arrow_unpressed_copy_label = CALayer()
        arrow_unpressed_copy_label.frame = CGRect(x: 0.75*interest_rate_unpressed_copy.frame.width-UIImage(named: "down_arrow_button_behind.png")!.size.width/2, y: interest_rate_unpressed_copy.frame.height/2-UIImage(named: "down_arrow_button_behind.png")!.size.height/2, width: UIImage(named: "down_arrow_button_behind.png")!.size.width-1, height: UIImage(named: "down_arrow_button_behind.png")!.size.height)
        arrow_unpressed_copy_label.contents = UIImage(named: "down_arrow_button_behind.png")?.cgImage
        interest_rate_unpressed_copy.layer.addSublayer(arrow_unpressed_copy_label)*/
        
        interest_rate_unpressed_copy.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.25*interest_rate_unpressed_copy.frame.width, bottom: 0.0, right: 0.0)
        //print(0.25*interest_rate_unpressed_copy.frame.width)
        
        interest_rate_unpressed_copy.layer.shadowColor = UIColor.black.cgColor
        interest_rate_unpressed_copy.layer.shadowOffset = CGSize(width: 0, height: 1)
        interest_rate_unpressed_copy.layer.shadowOpacity = 0.25
        interest_rate_unpressed_copy.layer.shadowRadius = 1
        
        let interest_rate_pressed_copy_center = CAShapeLayer()
        interest_rate_pressed_copy_center.bounds = interest_rate_pressed_copy.frame
        interest_rate_pressed_copy_center.position = interest_rate_pressed_copy.center
        interest_rate_pressed_copy_center.path = UIBezierPath(roundedRect: interest_rate_pressed_copy.bounds, byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        interest_rate_pressed_copy.layer.addSublayer(interest_rate_pressed_copy_center)
        interest_rate_pressed_copy_center.fillColor = UIColor(red: 68.0/255, green: 77.0/255, blue: 82.0/255, alpha: 1.0).cgColor
        
        let arrow_pressed_copy_trianglePath = UIBezierPath()
        arrow_pressed_copy_trianglePath.move(to: CGPoint(x: 17, y: 12))
        arrow_pressed_copy_trianglePath.addLine(to: CGPoint(x: 8.5, y: 0))
        arrow_pressed_copy_trianglePath.addLine(to: CGPoint(x: 0, y: 12))
        arrow_pressed_copy_trianglePath.close()
        
        let arrow_pressed_copy_triangleLayer = CAShapeLayer()
        arrow_pressed_copy_triangleLayer.path = arrow_pressed_copy_trianglePath.cgPath
        arrow_pressed_copy_triangleLayer.position = CGPoint(x: 0.75*interest_rate_pressed_copy.frame.width-8.5, y: interest_rate_pressed_copy.frame.height/2-6)
        arrow_pressed_copy_triangleLayer.fillColor = UIColor(red: 161.0/255, green: 166.0/255, blue: 168.0/255, alpha: 1.0).cgColor
        interest_rate_pressed_copy.layer.addSublayer(arrow_pressed_copy_triangleLayer)

        /*let arrow_pressed_copy_label = CALayer()
        arrow_pressed_copy_label.frame = CGRect(x: 0.75*interest_rate_pressed_copy.frame.width-UIImage(named: "down_arrow_button_behind.png")!.size.width/2-1, y: interest_rate_pressed_copy.frame.height/2-UIImage(named: "down_arrow_button_behind.png")!.size.height/2, width: UIImage(named: "down_arrow_button_behind.png")!.size.width-1, height: UIImage(named: "down_arrow_button_behind.png")!.size.height)
        arrow_pressed_copy_label.contents = UIImage(named: "down_arrow_button_behind.png")?.cgImage
        interest_rate_pressed_copy.layer.addSublayer(arrow_pressed_copy_label)*/
        
        interest_rate_pressed_copy.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.25*interest_rate_pressed_copy.frame.width, bottom: 0.0, right: 0.0)
        
        interest_rate_pressed_copy.layer.shadowColor = UIColor.black.cgColor
        interest_rate_pressed_copy.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        interest_rate_pressed_copy.layer.shadowOpacity = 0.0625
        interest_rate_pressed_copy.layer.shadowRadius = 0


        
        //down_arrow_unpressed_copy
        /*let arrow_unpressed_copy_top = CAShapeLayer()
        arrow_unpressed_copy_top.bounds = arrow_unpressed_copy.frame
        arrow_unpressed_copy_top.position = arrow_unpressed_copy.center
        arrow_unpressed_copy_top.path = UIBezierPath(roundedRect: CGRect(x: 0, y: -0.25, width: arrow_unpressed_copy.frame.width, height: arrow_unpressed_copy.frame.height), byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        arrow_unpressed_copy.layer.addSublayer(arrow_unpressed_copy_top)
        arrow_unpressed_copy_top.fillColor = UIColor(red: 254.0/255, green: 254.0/255, blue: 254.0/255, alpha: 1.0).cgColor
        
        
        let arrow_unpressed_copy_bottom = CAShapeLayer()
        arrow_unpressed_copy_bottom.bounds = arrow_unpressed_copy.frame
        arrow_unpressed_copy_bottom.position = arrow_unpressed_copy.center
        arrow_unpressed_copy_bottom.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0.25, width: arrow_unpressed_copy.frame.width, height: arrow_unpressed_copy.frame.height), byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        arrow_unpressed_copy.layer.addSublayer(arrow_unpressed_copy_bottom)
        arrow_unpressed_copy_bottom.fillColor = UIColor.black.cgColor

        
        let arrow_unpressed_copy_center = CAShapeLayer()
        arrow_unpressed_copy_center.bounds = arrow_unpressed_copy.frame
        arrow_unpressed_copy_center.position = arrow_unpressed_copy.center
        arrow_unpressed_copy_center.path = UIBezierPath(roundedRect: arrow_unpressed_copy.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        arrow_unpressed_copy.layer.addSublayer(arrow_unpressed_copy_center)
        arrow_unpressed_copy_center.fillColor = UIColor(red: 74.0/255, green: 82.0/255, blue: 86.0/255, alpha: 1.0).cgColor
        
        let arrow_unpressed_copy_center_label = CALayer()
        arrow_unpressed_copy_center_label.frame = CGRect(x: arrow_unpressed_copy.frame.width/2-UIImage(named: "down_arrow_button_behind.png")!.size.width/2, y: arrow_unpressed_copy.frame.height/2-UIImage(named: "down_arrow_button_behind.png")!.size.height/2, width: UIImage(named: "down_arrow_button_behind.png")!.size.width, height: UIImage(named: "down_arrow_button_behind.png")!.size.height)
        arrow_unpressed_copy_center_label.contents = UIImage(named: "down_arrow_button_behind.png")?.cgImage
        arrow_unpressed_copy.layer.addSublayer(arrow_unpressed_copy_center_label)*/
        
        //interest_rate_disabled
        /*let interest_rate_disabled_top = CAShapeLayer()
        interest_rate_disabled_top.bounds = interest_rate_disabled.frame
        interest_rate_disabled_top.position = interest_rate_disabled.center
        interest_rate_disabled_top.path = UIBezierPath(roundedRect: CGRect(x: 0, y: -0.25, width: interest_rate_disabled.frame.width, height: interest_rate_disabled.frame.height), byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        interest_rate_disabled.layer.addSublayer(interest_rate_disabled_top)
        interest_rate_disabled_top.fillColor = UIColor(red: 254.0/255, green: 254.0/255, blue: 254.0/255, alpha: 1.0).cgColor
        
        let interest_rate_disabled_bottom = CAShapeLayer()
        interest_rate_disabled_bottom.bounds = interest_rate_disabled.frame
        interest_rate_disabled_bottom.position = interest_rate_disabled.center
        interest_rate_disabled_bottom.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0.25, width: interest_rate_disabled.frame.width, height: interest_rate_disabled.frame.height), byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        interest_rate_disabled.layer.addSublayer(interest_rate_disabled_bottom)
        interest_rate_disabled_bottom.fillColor = UIColor.black.cgColor*/
        
        let interest_rate_disabled_center = CAShapeLayer()
        interest_rate_disabled_center.bounds = interest_rate_disabled.frame
        interest_rate_disabled_center.position = interest_rate_disabled.center
        interest_rate_disabled_center.path = UIBezierPath(roundedRect: interest_rate_disabled.bounds, byRoundingCorners: [.bottomLeft, .topLeft, .bottomRight, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        interest_rate_disabled.layer.addSublayer(interest_rate_disabled_center)
        interest_rate_disabled_center.fillColor = UIColor(red: 68.0/255, green: 77.0/255, blue: 82.0/255, alpha: 1.0).cgColor
        
        let interest_rate_disabled_trianglePath = UIBezierPath()
        interest_rate_disabled_trianglePath.move(to: CGPoint(x: 0, y: 0))
        interest_rate_disabled_trianglePath.addLine(to: CGPoint(x: 17, y: 0))
        interest_rate_disabled_trianglePath.addLine(to: CGPoint(x: 8.5, y: 12))
        interest_rate_disabled_trianglePath.close()
        
        let interest_rate_disabled_triangleLayer = CAShapeLayer()
        interest_rate_disabled_triangleLayer.path = interest_rate_disabled_trianglePath.cgPath
        interest_rate_disabled_triangleLayer.position = CGPoint(x: 0.75*interest_rate_disabled.frame.width-8.5, y: interest_rate_disabled.frame.height/2-6)
        interest_rate_disabled_triangleLayer.fillColor = UIColor(red: 161.0/255, green: 166.0/255, blue: 168.0/255, alpha: 1.0).cgColor
        interest_rate_disabled.layer.addSublayer(interest_rate_disabled_triangleLayer)

        
        interest_rate_disabled.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.25*interest_rate_disabled.frame.width, bottom: 0.0, right: 0.0)
        
        interest_rate_disabled.layer.shadowColor = UIColor.black.cgColor
        interest_rate_disabled.layer.shadowOffset = CGSize(width: 0, height: 1)
        interest_rate_disabled.layer.shadowOpacity = 0.0625
        interest_rate_disabled.layer.shadowRadius = 1
        
        //down_arrow_disabled
        /*let arrow_disabled_top = CAShapeLayer()
        arrow_disabled_top.bounds = arrow_disabled.frame
        arrow_disabled_top.position = arrow_disabled.center
        arrow_disabled_top.path = UIBezierPath(roundedRect: CGRect(x: 0, y: -0.25, width: arrow_disabled.frame.width, height: arrow_disabled.frame.height), byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        arrow_disabled.layer.addSublayer(arrow_disabled_top)
        arrow_disabled_top.fillColor = UIColor(red: 254.0/255, green: 254.0/255, blue: 254.0/255, alpha: 1.0).cgColor
        
        let arrow_disabled_bottom = CAShapeLayer()
        arrow_disabled_bottom.bounds = arrow_disabled.frame
        arrow_disabled_bottom.position = arrow_disabled.center
        arrow_disabled_bottom.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0.25, width: arrow_disabled.frame.width, height: arrow_disabled.frame.height), byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        arrow_disabled.layer.addSublayer(arrow_disabled_bottom)
        arrow_disabled_bottom.fillColor = UIColor.black.cgColor
        
        let arrow_disabled_center = CAShapeLayer()
        arrow_disabled_center.bounds = arrow_disabled.frame
        arrow_disabled_center.position = arrow_disabled.center
        arrow_disabled_center.path = UIBezierPath(roundedRect: arrow_disabled.bounds, byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        arrow_disabled.layer.addSublayer(arrow_disabled_center)
        arrow_disabled_center.fillColor = UIColor(red: 74.0/255, green: 82.0/255, blue: 86.0/255, alpha: 1.0).cgColor
        
        let arrow_disabled_center_label = CALayer()
        arrow_disabled_center_label.frame = CGRect(x: arrow_disabled.frame.width/2-UIImage(named: "down_arrow_button.png")!.size.width/2, y: arrow_disabled.frame.height/2-UIImage(named: "down_arrow_button.png")!.size.height/2, width: UIImage(named: "down_arrow_button.png")!.size.width, height: UIImage(named: "down_arrow_button.png")!.size.height)
        arrow_disabled_center_label.contents = UIImage(named: "down_arrow_button.png")?.cgImage
        arrow_disabled.layer.addSublayer(arrow_disabled_center_label)*/
        
        let down_unpressed_center = CAShapeLayer()
        down_unpressed_center.bounds = down_unpressed.frame
        down_unpressed_center.position = down_unpressed.center
        down_unpressed_center.path = UIBezierPath(roundedRect: down_unpressed.bounds, byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        down_unpressed.layer.addSublayer(down_unpressed_center)
        down_unpressed_center.fillColor = UIColor(red: 68.0/255, green: 77.0/255, blue: 82.0/255, alpha: 1.0).cgColor
        
        /*let down_unpressed_label = CALayer()
        down_unpressed_label.frame = CGRect(x: 0.5*down_unpressed.frame.width-UIImage(named: "down_arrow_button.png")!.size.width/2, y: down_unpressed.frame.height/2-UIImage(named: "down_arrow_button.png")!.size.height/2, width: UIImage(named: "down_arrow_button.png")!.size.width-1, height: UIImage(named: "down_arrow_button.png")!.size.height)
        down_unpressed_label.contents = UIImage(named: "down_arrow_button.png")?.cgImage
        down_unpressed.layer.addSublayer(down_unpressed_label)*/
        
        down_unpressed.layer.shadowColor = UIColor.black.cgColor
        down_unpressed.layer.shadowOffset = CGSize(width: 0, height: 1)
        down_unpressed.layer.shadowOpacity = 0.25
        down_unpressed.layer.shadowRadius = 1
        
        let down_pressed_center = CAShapeLayer()
        down_pressed_center.bounds = down_pressed.frame
        down_pressed_center.position = down_pressed.center
        down_pressed_center.path = UIBezierPath(roundedRect: down_pressed.bounds, byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        down_pressed.layer.addSublayer(down_pressed_center)
        down_pressed_center.fillColor = UIColor(red: 68.0/255, green: 77.0/255, blue: 82.0/255, alpha: 1.0).cgColor
        
        /*let down_pressed_label = CALayer()
        down_pressed_label.frame = CGRect(x: 0.5*down_pressed.frame.width-UIImage(named: "down_arrow_button.png")!.size.width/2+0.5, y: down_pressed.frame.height/2-UIImage(named: "down_arrow_button.png")!.size.height/2, width: UIImage(named: "down_arrow_button.png")!.size.width-1, height: UIImage(named: "down_arrow_button.png")!.size.height)
        down_pressed_label.contents = UIImage(named: "down_arrow_button.png")?.cgImage
        down_pressed.layer.addSublayer(down_pressed_label)*/
        
        down_pressed.layer.shadowColor = UIColor.black.cgColor
        down_pressed.layer.shadowOffset = CGSize(width: 0, height: 1)
        down_pressed.layer.shadowOpacity = 0.0625
        down_pressed.layer.shadowRadius = 1
        


        let up_unpressed_center = CAShapeLayer()
        up_unpressed_center.bounds = up_unpressed.frame
        up_unpressed_center.position = up_unpressed.center
        up_unpressed_center.path = UIBezierPath(roundedRect: up_unpressed.bounds, byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        up_unpressed.layer.addSublayer(up_unpressed_center)
        up_unpressed_center.fillColor = UIColor(red: 68.0/255, green: 77.0/255, blue: 82.0/255, alpha: 1.0).cgColor
        
        /*let up_unpressed_label = CALayer()
        up_unpressed_label.frame = CGRect(x: 0.5*up_unpressed.frame.width-UIImage(named: "down_arrow_button_behind.png")!.size.width/2, y: up_unpressed.frame.height/2-UIImage(named: "down_arrow_button_behind.png")!.size.height/2, width: UIImage(named: "down_arrow_button_behind.png")!.size.width-1, height: UIImage(named: "down_arrow_button_behind.png")!.size.height)
        up_unpressed_label.contents = UIImage(named: "down_arrow_button_behind.png")?.cgImage
        up_unpressed.layer.addSublayer(up_unpressed_label)*/
        
        up_unpressed.layer.shadowColor = UIColor.black.cgColor
        up_unpressed.layer.shadowOffset = CGSize(width: 0, height: 1)
        up_unpressed.layer.shadowOpacity = 0.25
        up_unpressed.layer.shadowRadius = 1
        
        let up_pressed_center = CAShapeLayer()
        up_pressed_center.bounds = up_pressed.frame
        up_pressed_center.position = up_pressed.center
        up_pressed_center.path = UIBezierPath(roundedRect: up_pressed.bounds, byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        up_pressed.layer.addSublayer(up_pressed_center)
        up_pressed_center.fillColor = UIColor(red: 68.0/255, green: 77.0/255, blue: 82.0/255, alpha: 1.0).cgColor
        
        /*let up_pressed_label = CALayer()
        up_pressed_label.frame = CGRect(x: 0.5*up_pressed.frame.width-UIImage(named: "down_arrow_button_behind.png")!.size.width/2-0.5, y: up_pressed.frame.height/2-UIImage(named: "down_arrow_button_behind.png")!.size.height/2, width: UIImage(named: "down_arrow_button_behind.png")!.size.width-1, height: UIImage(named: "down_arrow_button_behind.png")!.size.height)
        up_pressed_label.contents = UIImage(named: "down_arrow_button_behind.png")?.cgImage
        up_pressed.layer.addSublayer(up_pressed_label)*/
        
        up_pressed.layer.shadowColor = UIColor.black.cgColor
        up_pressed.layer.shadowOffset = CGSize(width: 0, height: 1)
        up_pressed.layer.shadowOpacity = 0.0625
        up_pressed.layer.shadowRadius = 1
        


    
        /*arrow_unpressed.isHidden = true*/
        shared_preferences.set(savings_reference, forKey: "savings_change_key"); shared_preferences.synchronize()
    
        
        bubble_label.alpha = 0.0
        bubble_label_arrow.alpha = 0.0
        bubble_label.isHidden = true
        bubble_label_arrow.isHidden = true
        table_view.frame = CGRect(x: self.table_view.frame.origin.x, y: self.table_view.frame.origin.y, width: self.table_view.frame.width, height: 0)

        
        
        /*UIImageView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.bubble_label.alpha = 1.0
            self.bubble_label_arrow.alpha = 1.0
            
        }, completion: {
            (finished: Bool) -> Void in
            /*self.test.text = "Hello"*/
            
            /*// Fade in
             UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
             self.test.alpha = 1.0
             }, completion: nil)*/
        }
        )*/
        //step_2_background is unorthodox, so method is too
        //step_2_background.frame = CGRect(x: step_2.frame.origin.x, y: step_2.frame.origin.y, width: step_2.frame.width, height: step_2.frame.height) //shifted a little

        //no longer using iPhone 5/5s/SE, but keeping for nastalgic purposes
        
        if (view.frame.height == 568) {
            //print("You have an iPhone 5/5s/SE", terminator: "\n\n")
            
            //step_1_images.append(UIImage(named: "s1se.png")!)
            //step_1_images.append(UIImage(named: "s9se.png")!)
            //step_1_images.append(UIImage(named: "s10se.png")!)
            //step_1_images.append(UIImage(named: "s11se.png")!)
            
            //step_2_images.append(UIImage(named: "s1se_b.png")!) //skipping for now
            //step_2_images.append(UIImage(named: "s1se_b2.png")!)
            //step_2_images.append(UIImage(named: "s2se_b.png")!)
            //step_2_images.append(UIImage(named: "s2se_b2.png")!)
            //step_2_images.append(UIImage(named: "s3se_b.png")!)
            //step_2_images.append(UIImage(named: "s5se_b2.png")!)
            //step_2_images.append(UIImage(named: "s6se_b.png")!)
            
            //step_3_images.append(UIImage(named: "s1se_c.png")!)
            //step_3_images.append(UIImage(named: "s2se_c.png")!)
            //step_3_images.append(UIImage(named: "s3se_c.png")!)
            //step_3_images.append(UIImage(named: "s4se_c.png")!)
            //step_3_images.append(UIImage(named: "s4se_c2.png")!)
            //step_3_images.append(UIImage(named: "s3se_cN.png")!)
            //step_3_images.append(UIImage(named: "s2se_cN.png")!)
            //step_3_images.append(UIImage(named: "s2se_cN2.png")!)
            
            //bottom_images.append(UIImage(named: "b1se.png")!)
            //bottom_images.append(UIImage(named: "b2se.png")!)
            //bottom_images.append(UIImage(named: "b3se.png")!)
            //bottom_images.append(UIImage(named: "b2Nse.png")!)
            
            //slide_images.append(UIImage(named: "slidese.png")!)

            
        }
        else if (view.frame.height == 667) {
            //print("You have an iPhone 6/6s/7", terminator: "\n\n")
            
            //step_1_images.append(UIImage(named: "s1.png")!)
            //step_1_images.append(UIImage(named: "s9.png")!)
            //step_1_images.append(UIImage(named: "s10.png")!)
            //step_1_images.append(UIImage(named: "s11.png")!)

            //step_2_images.append(UIImage(named: "s1_b.png")!) //skipping for now
            //step_2_images.append(UIImage(named: "s1_b2.png")!)
            //step_2_images.append(UIImage(named: "s2_b.png")!)
            //step_2_images.append(UIImage(named: "s2_b2.png")!)
            //step_2_images.append(UIImage(named: "s3_b.png")!)
            //step_2_images.append(UIImage(named: "s5_b2.png")!)
            //step_2_images.append(UIImage(named: "s6_b.png")!)

            //step_3_images.append(UIImage(named: "s1_c.png")!)
            //step_3_images.append(UIImage(named: "s2_c.png")!)
            //step_3_images.append(UIImage(named: "s3_c.png")!)
            //step_3_images.append(UIImage(named: "s4_c.png")!)
            //step_3_images.append(UIImage(named: "s4_c2.png")!)
            //step_3_images.append(UIImage(named: "s3_cN.png")!)
            //step_3_images.append(UIImage(named: "s2_cN.png")!)
            //step_3_images.append(UIImage(named: "s2_cN2.png")!)
            
            //bottom_images.append(UIImage(named: "b1.png")!)
            //bottom_images.append(UIImage(named: "b2.png")!)
            //bottom_images.append(UIImage(named: "b3.png")!)
            //bottom_images.append(UIImage(named: "b2N.png")!)
 
            //slide_images.append(UIImage(named: "slide.png")!)
            
            
            
        }
        else if (view.frame.height == 736) {
            //print("You have an iPhone 6/6s/7 Plus", terminator: "\n\n")
            
            //step_1_images.append(UIImage(named: "s1p.png")!) //start with 2
            //step_1_images.append(UIImage(named: "s9p.png")!)
            //step_1_images.append(UIImage(named: "s10p.png")!)
            //step_1_images.append(UIImage(named: "s11p.png")!)
            
            //step_2_images.append(UIImage(named: "s1p_b.png")!) //skipping for now
            //step_2_images.append(UIImage(named: "s1p_b2.png")!)
            //step_2_images.append(UIImage(named: "s2p_b.png")!)
            //step_2_images.append(UIImage(named: "s2p_b2.png")!)
            //step_2_images.append(UIImage(named: "s3p_b.png")!)
            //step_2_images.append(UIImage(named: "s5p_b2.png")!)
            //step_2_images.append(UIImage(named: "s6p_b.png")!)
            
            //step_3_images.append(UIImage(named: "s1p_c.png")!)
            //step_3_images.append(UIImage(named: "s2p_c.png")!)
            //step_3_images.append(UIImage(named: "s3p_c.png")!)
            //step_3_images.append(UIImage(named: "s4p_c.png")!)
            //step_3_images.append(UIImage(named: "s4p_c2.png")!)
            //step_3_images.append(UIImage(named: "s3p_cN.png")!)
            //step_3_images.append(UIImage(named: "s2p_cN.png")!)
            //step_3_images.append(UIImage(named: "s2p_cN2.png")!)
            
            //bottom_images.append(UIImage(named: "b1p.png")!)
            //bottom_images.append(UIImage(named: "b2p.png")!)
            //bottom_images.append(UIImage(named: "b3p.png")!)
            //bottom_images.append(UIImage(named: "b2Np.png")!)
            
            //slide_images.append(UIImage(named: "slidep.png")!)

            
        }
        else {
            //do nothing
        }

        //if (view.frame.height == 568) {


        //}
        //else {
            //do nothing
        //}
        
        let messageVC = UIAlertController(title: "Caution", message: "Your device is incompatible!" , preferredStyle: .alert)
        
        let proceedAction = UIAlertAction(title:"Proceed",
                                          style: .default) //{ (action) -> Void in
        //print("You selected the submit action.")
        //}
        messageVC.addAction(proceedAction)
        
        /*switch UIDevice.current.userInterfaceIdiom {
        case .pad: present(messageVC, animated: true)
        case .phone:
            if (view.frame.height <= 568) {
                present(messageVC, animated: true)
            }
        case .unspecified: break
        case .tv: break
        case .carPlay: break
        }*/
        
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            if (view.frame.height > 568) {
                //proceed
            }
            else {
                present(messageVC, animated: true)
            }
        }
        else {
            present(messageVC, animated: true)
        }
        
        /*func Step_Main() {
            timer_step = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MyMainPage.Step_Instructions), userInfo: nil, repeats: false)
        }*/

        
        //splash_screen.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height) //for old splash screen
        //splash_screen.frame = view.bounds //for old splash screen

        //step_2.backgroundColor = UIColor(patternImage: UIImage(named: "s1_b.png")!)
        //step_3.backgroundColor = UIColor(patternImage: UIImage(named: "s1_c.png")!)

        //dim splash screen steps at the beginning
        
//        if (self.decision == true) {
//
//        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
////            self.step_1.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.85) //for old splash screen
////            self.step_2.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.85) //for old splash screen
////            self.step_2_background.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.85) //for old splash screen
////            self.step_3.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.85) //for old splash screen
////            self.step_4.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.85) //for old splash screen
//            /*self.step_1.frame = CGRect(x: self.step_1.frame.origin.x, y: self.step_1.frame.origin.y+140.5, width: self.step_1.frame.width, height: 0)*/
//        }, completion: {
//            (finished: Bool) -> Void in
//            /*print(self.splash_screen.frame.height,terminator: "\n")
//            print(self.splash_screen.frame.height-(self.step_1.frame.height),terminator: "\n")
//            print(self.splash_screen.frame.height-(self.step_1.frame.height+self.step_2.frame.height),terminator: "\n")
//            print(self.splash_screen.frame.height-(self.step_1.frame.height+self.step_2.frame.height+self.step_3.frame.height),terminator: "\n")
//            print(self.splash_screen.frame.height-(self.step_1.frame.height+self.step_2.frame.height+self.step_3.frame.height+self.step_4.frame.height),terminator: "\n")*/
//            /*print(6*(self.splash_screen.frame.height)/self.splash_screen.frame.height,terminator: "\n")
//            print(6*(self.splash_screen.frame.height-(self.step_1.frame.height))/self.splash_screen.frame.height,terminator: "\n")
//            print(6*(self.splash_screen.frame.height-(self.step_1.frame.height+self.step_2.frame.height))/self.splash_screen.frame.height,terminator: "\n")
//            print(6*(self.splash_screen.frame.height-(self.step_1.frame.height+self.step_2.frame.height+self.step_3.frame.height))/self.splash_screen.frame.height,terminator: "\n")
//            print(6*(self.splash_screen.frame.height-(self.step_1.frame.height+self.step_2.frame.height+self.step_3.frame.height+self.step_4.frame.height))/self.splash_screen.frame.height,terminator: "\n")*/
//
////        self.splash_screen.addSubview(self.disregard) //for old splash screen
////        self.splash_screen.bringSubviewToFront(self.disregard) //for old splash screen
////        self.Step_Main() //for old splash screen
//            //print(self.splash_screen.frame.height,terminator: "\n")
//            //print(self.splash_screen.frame.width,terminator: "\n")
//
//
//        })
//        }
//        else {
////            self.disregard.isHidden = true
////            self.splash_screen.isHidden = true
////            self.splash_screen_background.isHidden = true
//        }

        /*let step_dot = UIImageView()
        step_dot.backgroundColor = UIColor(red: 0.0/255, green: 255.0/255, blue: 0.0/255, alpha: 0.75)
        step_dot.frame = CGRect(x: step_2.frame.origin.x, y: step_2.frame.origin.y, width: step_2.frame.width, height: 1)
        splash_screen.addSubview(step_dot)*/

        
        
        
        /*let place = URLSessionTask()
        
        place.getNameFromProfileUrl("http://www.cnn.com") { playerName in
            // always update UI from the main thread
            OperationQueue.mainQueue().addOperationWithBlock {
                if let playerName = playerName {
                    playerNameField.text = playerName
                } else {
                    playerNameField.text = "Player Not Found"
                }
            }
        }*/

        /*let url = URL(string: "http://www.stackoverflow.com")
        
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            
            guard let data = data, error == nil else { return }
            
            print(NSString(data: data, encoding: String.Encoding.utf8.rawValue))
        }
        
        task.resume()*/
        
        /*let fullName    = "First Last"
        let fullNameArr = fullName.components(separatedBy: " ")
        
        let name    = fullNameArr[0]
        let surname = fullNameArr[1]
        print(name, surname, terminator: " ")*/
        
        



/*        let moreSimplifiedInput = simplifiedInput
 .replacingOccurrences(
 of: "\\QMyFirstHeading\\E",
 with: "",
 options: .regularExpression,
 range: nil
 )
*/
        //[>] pattern > replace with _
        //[^>] pattern > replace what precedes them with _
        //[^>]+ pattern > replace what precedes them with _ and merge
        //<[^>]+ pattern > replace what precedes them with _ and merge but not text
        //<[^>]+> pattern > replace what precedes them with _ and merge but not text
        


        /*print("step_1_images.count=",step_1_images.count,terminator: "\n")
        print("step_2_images.count=",step_2_images.count,terminator: "\n")
        print("step_3_images.count=",step_3_images.count,terminator: "\n")*/
        question.isHidden = true //optional
        
//        if (decision == false) {
        DispatchQueue.main.async
            {
                self.performSegue(withIdentifier: "myAVPlayerViewController", sender: self)
            }
//        }
//        else {
//            //no video
//        }
        //performSegue(withIdentifier: "myAVPlayerViewController", sender: nil)
        /*view.addSubview(pay_monthly_box)
        view.addSubview(up_unpressed)
        view.addSubview(up_pressed)
        view.addSubview(down_unpressed)
        view.addSubview(down_pressed)
        view.bringSubviewToFront(up_unpressed)
        view.bringSubviewToFront(up_pressed)
        view.bringSubviewToFront(down_unpressed)
        view.bringSubviewToFront(down_pressed)*/
    }
    
    /*func getNameFromProfileUrl(profileUrl: NSURL, completionHandler: @escaping (String?) -> Void) {
        let task = URLSession.shared.dataTask(with: profileUrl as URL, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                var urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as NSString!
                var urlContentArray = urlContent?.components(separatedBy: "<title>")
                var statusArray = urlContentArray?[1].componentsSeparatedByString("</title>")
                let playerName = statusArray[0] as? String
                
                completionHandler(playerName)
            } else {
                completionHandler(nil)
            }
        })
 task.res*/
}

/*extension AVPlayerViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
}*/


