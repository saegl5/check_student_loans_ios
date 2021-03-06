//
//  MyMainPage.swift
//  Student Loans
//
//  Created by Ed Silkworth on 10/9/15.
//  Copyright © 2015-2019 Ed Silkworth. All rights reserved.
//

import UIKit
import AVKit

class MyMainPage:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
    UITextFieldDelegate
   {

  //------------------------------------------
  //  KEEP INTEREST RATES UPDATED
  //  CONSULT: https://studentaid.ed.gov/sa/types/loans/interest-rates
  //
  //  Loan Types: Direct Subsidized Loans & Direct Unsubsidized Loans
  //  Borrower Type: Undergraduate
  internal var APR_DIRECT = 4.53 //% (if rates are ever different, pick the higher one)
  //
  //  Loan Types: Perkins Loans
  internal var APR_PERKINS = 5.00 //%
  //------------------------------------------

  //------------------------------------------
  //  SELECT DEFAULT MINIMUM MONTHLY PAYMENT
  var tenyr_indicator = 1.0 // 0.0 (absolute minimum), 1.0 (ten-year minimum)
  //------------------------------------------

  @IBOutlet var swipe: UISwipeGestureRecognizer!
  @IBOutlet weak  var loaned_title: UILabel!
  @IBOutlet weak  var loaned: UISlider!
  @IBOutlet weak  var loaned_minimum: UILabel!
  @IBOutlet weak  var loaned_maximum: UILabel!
  @IBOutlet weak  var loaned_min_input: UITextField!
  @IBOutlet weak  var loaned_max_input: UITextField!
  @IBOutlet weak  var stack_min: UIStackView!
  @IBOutlet weak  var stack_max: UIStackView!
  @IBOutlet weak  var stack_inputs: UIStackView!
  @IBOutlet weak  var even_out: UILabel!
  @IBOutlet weak  var stack_inputs_down: UIStackView!
  @IBOutlet weak  var stack_inputs_timers_down: UIStackView!
  @IBOutlet weak  var down_sign: UILabel!
  @IBOutlet weak  var down_number: UITextField!
  @IBOutlet weak  var up_sign: UILabel!
  @IBOutlet weak  var up_number: UITextField!
  @IBOutlet weak  var down_timer1: UIImageView!
  @IBOutlet weak  var down_timer2: UIImageView!
  @IBOutlet weak  var down_timer1_seconds: UITextField!
  @IBOutlet weak  var down_timer2_seconds: UITextField!
  @IBOutlet weak  var down_timer1_seconds_label: UILabel!
  @IBOutlet weak  var down_timer2_seconds_label: UILabel!
  @IBOutlet weak  var down_timer1_increment: UITextField! // decrement
  @IBOutlet weak  var down_timer2_increment: UITextField! // decrement
  @IBOutlet weak  var stack_inputs_up: UIStackView!
  @IBOutlet weak  var stack_inputs_timers_up: UIStackView!
  @IBOutlet weak  var up_timer1: UIImageView!
  @IBOutlet weak  var up_timer2: UIImageView!
  @IBOutlet weak  var up_timer1_seconds: UITextField!
  @IBOutlet weak  var up_timer2_seconds: UITextField!
  @IBOutlet weak  var up_timer1_seconds_label: UILabel!
  @IBOutlet weak  var up_timer2_seconds_label: UILabel!
  @IBOutlet weak  var up_timer1_increment: UITextField!
  @IBOutlet weak  var up_timer2_increment: UITextField!
  @IBOutlet weak  var increment_input_left_label: UILabel!
  @IBOutlet weak  var increment_input: UITextField!
  @IBOutlet weak  var increment_input_right_label: UILabel!
  @IBOutlet weak  var input_number_of_increments: UITextField!
  @IBOutlet weak  var bare_track: UIImageView!
  @IBOutlet weak  var apr_title: UILabel!
  @IBOutlet weak  var apr: UISwitch!
  @IBOutlet weak  var edit_slider: UIButton!
  @IBOutlet weak  var edit_apr: UIButton!
  @IBOutlet weak  var edit_pay: UIButton!
  @IBOutlet weak  var submit_changes: UIButton!
  @IBOutlet weak  var submit_changes_apr: UIButton!
  @IBOutlet weak  var submit_changes_pay: UIButton!
  @IBOutlet weak  var interest_rate_unpressed: UIButton!
  @IBOutlet weak  var interest_rate_unpressed_copy: UIButton!
  @IBOutlet weak  var interest_rate_pressed: UIButton!
  @IBOutlet weak  var interest_rate_pressed_copy: UIButton!
  @IBOutlet weak  var interest_rate_disabled: UIButton!
  @IBOutlet weak  var invisible: UIButton!
  @IBOutlet weak  var edit_apr_text: UIStackView!
  @IBOutlet weak  var invisible_back: UIButton!
  @IBOutlet weak  var edit_apr_text_back: UIStackView!
  @IBOutlet weak  var apr_number: UITextField!
  @IBOutlet weak  var apr_number_back: UITextField!
  @IBOutlet weak  var apr_sign: UILabel!
  @IBOutlet weak  var edit_pay_text: UIStackView!
  @IBOutlet weak  var pay_sign: UILabel!
  @IBOutlet weak  var pay_number: UITextField!
  @IBOutlet weak  var table_view: UITableView!
  @IBOutlet weak  var down_unpressed: UIButton!
  @IBOutlet weak  var down_pressed: UIButton!
  @IBOutlet weak  var pay_monthly_title: UILabel!
  @IBOutlet weak  var pay_monthly_box: UILabel!
  @IBOutlet weak  var up_unpressed: UIButton!
  @IBOutlet weak  var up_pressed: UIButton!
  @IBOutlet weak  var minimum: UILabel!
  @IBOutlet weak  var abs_10yr: UIStackView!
  @IBOutlet weak  var absolute: UIButton!
  @IBOutlet weak  var tenyr: UIButton!
  @IBOutlet weak  var time_title: UILabel!
  @IBOutlet weak  var years: UILabel!
  @IBOutlet weak  var years_text: UILabel!
  @IBOutlet weak  var months: UILabel!
  @IBOutlet weak  var months_text: UILabel!
  @IBOutlet weak  var savings_title: UILabel!
  @IBOutlet weak  var savings: UILabel!
  @IBOutlet weak  var delta: UILabel!
  @IBOutlet weak  var savings_change: UILabel!
  @IBOutlet weak  var locked: UIButton!
  @IBOutlet weak  var unlocked: UIButton!
  @IBOutlet weak  var swipe_label: UILabel! //indicates if swipe is enabled or not
  @IBOutlet weak  var swipe_note: UILabel! //just says, ``swipe''
  @IBOutlet weak  var swiping: UIButton!
  @IBOutlet weak  var stopped: UIButton!
  @IBOutlet weak  var swipe_blink: UILabel!
  @IBOutlet weak  var suggest: UILabel!
  @IBOutlet weak  var layout_interest_rate: NSLayoutConstraint!
  @IBOutlet weak  var layout_minimum: NSLayoutConstraint!
  @IBOutlet weak  var layout_savings: NSLayoutConstraint!
  @IBOutlet weak  var layout_loaned: NSLayoutConstraint!
  @IBOutlet weak  var layout_months: NSLayoutConstraint!
  @IBOutlet weak  var layout_stack_min: NSLayoutConstraint!
  @IBOutlet weak  var layout_stack_max: NSLayoutConstraint!
  @IBOutlet weak  var layout_loaned_trailing: NSLayoutConstraint!
  @IBOutlet weak  var layout_loaned_leading: NSLayoutConstraint!
  @IBOutlet weak  var loaned_height: NSLayoutConstraint!
  @IBOutlet weak  var stack_Y: NSLayoutConstraint!
  @IBOutlet weak  var loaned_Y: NSLayoutConstraint!
  @IBOutlet weak  var absmin: UILabel!
  @IBOutlet weak  var tenyrmin: UILabel!
  @IBOutlet weak  var linemin: UIImageView!

  var set_down_timer1_seconds = 2.0 //2*4=8 quarter seconds
  var set_down_timer2_seconds = 4.0 //4*4=16 quarter seconds
  var set_down_timer1_increment = 100.0 // decrement
  var set_down_timer2_increment = 1000.0 // decrement
  var set_up_timer1_seconds = 2.0 //2*4=8 quarter seconds
  var set_up_timer2_seconds = 4.0 //4*4=16 quarter seconds
  var set_up_timer1_increment = 100.0
  var set_up_timer2_increment = 1000.0
  var p_min = 2000.0
  var p_max = 10000.0
  var N = 40.0 //20 is optimal
  var unlocked_indicator = 0 //1 if locked, 0 if not
  var timer1 = Timer()
  var timer2 = Timer()
  var down_button_increment = 50.0 // decrement
  var temp_down = 50.0
  var up_button_increment = 50.0
  var temp_up = 50.0
  var timer_count = 0.0
  var bubble_label = UILabel(frame: CGRect(
    x: -30,
    y: -5,
    width: 80,
    height: -32
  ))
  lazy var ΔN = (p_max - p_min)/N
  lazy var progress = p_min
  lazy var rates = [
    String(format: "%.2f", APR_DIRECT),
    String(format: "%.2f", APR_PERKINS)
  ] //for apr_number and its number behind
  lazy var rates_text = [
    String(format: "%.2f", APR_DIRECT) + "% - Direct Loan",
    String(format: "%.2f", APR_PERKINS) + "% - Perkins Loan"
  ] //for table
  lazy var rates_reference = [
    APR_DIRECT / 100 / 12,
    APR_PERKINS / 100 / 12,
    Double()
  ] //rates_reference[2], the one cast as Double(), will store custom rate
  // internal var s_1 = 0.00
  internal var numberFormatter: NumberFormatter = NumberFormatter()
  internal lazy var p = p_min
  internal lazy var r = APR_DIRECT/100
  internal lazy var i = r
    / 12 //need to convert to periodic rate in decimal form
  // by default, interest is not compounded
  internal lazy var i_reference = r / 12
  internal lazy var a = p_min
    * r
    / 12
    + 0.01 //values are cast in viewDidLoad()
  internal lazy var a_reference = p_min
    * r
    / 12
    + 0.01 //brought back because of + - buttons
  let shared_preferences: UserDefaults = UserDefaults.standard
  let bubble_label_arrow = UILabel(frame: CGRect(
    x: 4.5,
    y: -5,
    width: 14,
    height: 7
  ))

  //dark area behind slider
  @IBOutlet weak  var edit_slider_shape: UIView!
  let edit_slider_shape_tweak = CAShapeLayer()
  //slider_outline is ``bare_track'' (see above)
  //dark area behind APR
  @IBOutlet weak  var edit_apr_shape: UIView!
  let edit_apr_shape_tweak = CAShapeLayer()
  let edit_apr_shape_tweak_trianglePath = UIBezierPath()
  let edit_apr_shape_tweak_triangleLayer = CAShapeLayer()
  let switch_outline = CAShapeLayer()
  let switch_thumb_outline = CAShapeLayer()
  let interest_rate_unpressed_outline = CAShapeLayer()
  //dark area behind pay_monthly
  @IBOutlet weak  var edit_pay_shape: UIView!
  let edit_pay_shape_tweak = CAShapeLayer()
  let down_outline = CAShapeLayer()
  let pay_outline = CAShapeLayer()
  let up_outline = CAShapeLayer()
  //dark areas at bottom
  @IBOutlet weak  var abs10yr_shape: UIView!
  @IBOutlet weak  var swipe_shape: UIView!
    
  internal var test_array = [Double]()

  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  // Get the new view controller using segue.destination.
  // Pass the selected object to the new view controller.
  }
  */
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "myAVPlayerViewController") {
      let destination = segue.destination as! AVPlayerViewController
      let url = Bundle.main.url(
        forResource: "introduction",
        withExtension: ".mov"
      )
      if let movieURL = url {
        destination.player = AVPlayer(url: movieURL as URL)
        destination.player?.play()
      }
    } else {
      return
    }
  }
  //segue to and from ShowMath.swift is constructed in the storyboard directly

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
    swipe_blink.layer.removeAllAnimations() //in case someone clicks unlocked button before blinking animation stops
    if (i == 0) {
      edit_apr.isHidden = true
    } else {
      edit_apr.isHidden = false
    }
    if swipe.isEnabled {
      swiping.isHidden = false
      stopped.isHidden = true
    } else {
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
    UIView.animate(
      withDuration: 0.25,
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
        self.swipe_blink.isHidden = false
        self.swipe_blink.text = "Relock for time and savings."
        self.swipe_blink.alpha = 0.0
        UIView.animate(
          withDuration: 0.5,
          delay: 0.5,
          options: [.repeat, .autoreverse, .curveEaseInOut],
          animations: {
            UIView.setAnimationRepeatCount(3)
            self.swipe_blink.alpha = 1.0
          },
          completion: { (finished: Bool) -> Void in
            self.swipe_blink.alpha = 0.0
            self.swipe_blink.isHidden = true
          }
        )
      }
    )
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
    if (i == 0) {
      interest_rate_unpressed.isHidden = true
      interest_rate_unpressed_copy.isHidden = true
      interest_rate_disabled.isHidden = false
      apr_sign.alpha = 0.125
    }
    time_title.alpha = 1
    savings_title.alpha = 1
    years.alpha = 1
    years_text.alpha = 1
    months.alpha = 1
    months_text.alpha = 1
    savings.alpha = 1
    savings_change.alpha = 1
    swipe_blink.layer.removeAllAnimations() //in case someone clicks locked button before blinking animation stops
  }

  //turns OFF swiping
  @IBAction func Swiping(_ sender: UIButton) {
    swipe.isEnabled = false
    stopped.isHidden = false
    swiping.isHidden = true
    swipe_note.text = "Swipe disabled."
    swipe_blink.layer.removeAllAnimations() //in case someone clicks unlocked button before blinking animation stops
  }

  //turns ON swiping
  @IBAction func Stopped(_ sender: UIButton) {
    swipe.isEnabled = true
    swiping.isHidden = false
    stopped.isHidden = true
    swipe_note.text = "Swipe enabled."
    swipe_blink.layer.removeAllAnimations() //in case someone clicks unlocked button before blinking animation stops
    if swipe.isEnabled {
      UIView.animate(
        withDuration: 0.25,
        animations: {
          self.swiping.transform = CGAffineTransform(scaleX: 1.125, y: 1.125)
        },
        completion: { (finished: Bool) -> Void in
          UIView.animate(
            withDuration: 0.25,
            animations: { self.swiping.transform = CGAffineTransform.identity },
            completion: { (finished: Bool) -> Void in
              self.swipe_blink.isHidden = false
              self.swipe_blink.text = "Swipe left."
              self.swipe_blink.alpha = 0.0
              UIView.animate(
                withDuration: 0.5,
                delay: 0.5,
                options: [.repeat, .autoreverse, .curveEaseInOut],
                animations: {
                  UIView.setAnimationRepeatCount(3)
                  self.swipe_blink.alpha = 1.0
                },
                completion: { (finished: Bool) -> Void in
                  self.swipe_blink.alpha = 0.0
                }
              )
            }
          )
        }
      )
    } else {
      swipe_blink.isHidden = true
    }
  }

  @IBAction func Loaned_Min_Input(_ sender: UITextField) {
    p_min = Double(truncating: removeFormat(string: loaned_min_input.text!))
    if (p_min - floor(p_min) > 0.499999)
        && (p_min - floor(p_min) < 0.5) {
      p_min = round(p_min + 1)
    } else {
      p_min = round(p_min)
    }
    if (p_min < 0) {
      p_min = 0
      loaned_min_input.text = String(format: "%.0f", p_min)
    } else if (p_min >= p_max) {
      p_min = p_max-1
      loaned_min_input.text = String(format: "%.0f", p_min)
    } else { }
    ΔN = (p_max - p_min)/N
    if (ΔN - floor(ΔN) == 0) {
      increment_input.text = String(format: "%.0f", ΔN)
      increment_input.textColor = UIColor(
        red: 161/255.0,
        green: 166/255.0,
        blue: 168/255.0,
        alpha: 1.0
      )
      increment_input.alpha = 0.25
      increment_input.layer.removeAllAnimations()
      even_out.isHidden = true
      submit_changes.isEnabled = true
      suggest.isHidden = true
    } else {
      even_out.isHidden = false
      submit_changes.isEnabled = false
      if (N == 0) {
        increment_input.text = "∞"
      } else {
        increment_input.text = String(format: "%.5f", ΔN)
      }
      increment_input.textColor = UIColor(
        red: 109/255.0,
        green: 129/255.0,
        blue: 158/255.0,
        alpha: 1.0
      )
      increment_input.alpha = 1.0
      UIView.animate(
        withDuration: 0.0625,
        delay: 0.0,
        options: [.repeat, .autoreverse, .curveEaseInOut],
        animations: {
          UIView.setAnimationRepeatCount(3)
          self.increment_input.alpha = 0.0
        },
        completion: { (finished: Bool) -> Void in
          self.increment_input.alpha = 1.0
        }
      )
      suggest.isHidden = false
    }
    var suggestions = [Int]()
    var tailored_suggestions = String()
    var suggestions_index = -1
    for N_suggest in 20...60 {
      let ΔN_result = (p_max - p_min)/Double(N_suggest)
      if (ΔN_result - floor(ΔN_result) == 0) {
        suggestions.append(N_suggest)
        suggestions_index += 1
      }
    }
    if (suggestions == []) {
      suggest.text = "Even out the minimum or maximum, first."
    } else {
      if (suggestions_index == 0) {
        suggest.text = "Suggestion: \(suggestions[suggestions_index]) increments"
      } else if (suggestions_index == 1) {
        //use ``or''
        suggest.text = "Suggestions: \(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
      } else {
        //use commas and ``or'' (e.g., ``20, 25 or 40'')
        for tailoring_suggestions in 0...(suggestions_index-2) {
          tailored_suggestions += "\(suggestions[tailoring_suggestions]), "
        }
        suggest.text = "Suggestions: \(tailored_suggestions)\(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
      }
    }
    if (p_min < progress) {
      var value = (progress - p_min)/ΔN
      if (value - floor(value) > 0.499999) && (value - floor(value) < 0.5) {
        value = round(value + 1)
      } else {
        value = round(value)
      }
      self.loaned.setValue(Float(value), animated: true) //figure out where it will go
    } else {
      p = Double(p_min)
      shared_preferences.set(p, forKey: "loaned")
      shared_preferences.synchronize()
      let value = 0
      self.loaned.setValue(Float(value), animated: true)
      progress = ΔN * Double(self.loaned.value) + p_min
    }
    var a_min = Double()
    if (tenyr_indicator == 0) {
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   temp = (round(p*i*100 + 1) + 1)/100
      // } else {
      //   temp = (round(p*i*100) + 1)/100
      // }
      a_min = CR(x: p*i) + 0.01 //a_min_n
    } else {
      if (i != 0) {
        a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
        a_min += CT()
      } else {
        a_min = ceil(p/120*100)/100
      }
    }
    if (a_min >= a) {
      a = a_min
      a_reference = a_min
      shared_preferences.set(a, forKey: "pay_monthly")
      shared_preferences.synchronize()
      if (a - floor(a) == 0) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".00"
      } else if ((a - floor(a))*100 < 9.99999) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".0"
          + String(format: "%.0f", (a - floor(a))*100)
      } else {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + "."
          + String(format: "%.0f", (a - floor(a))*100)
      }
      minimum.isHidden = false
      minimum.text = "Minimum"
    } else {
      minimum.isHidden = false
      minimum.text = " "
    }
    Lengthsaving()
  }
    
  //instructions for checking and rounding quantities
  func CR(x:Double) -> Double {
    if (x*100 - floor(x*100) > 0.499999)
        && (x*100 - floor(x*100) < 0.5) {
        return round(x*100 + 1)/100
    }
    else {
        return round(x*100)/100
    }
  }
  
  //instructions for building test_arrays
  func BT(c:Int) -> [Double] {
    test_array.removeAll() //reset array
    test_array.append(p)
    var m_min = 1
    var a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
    a_min += 0.01*Double(c)
    while ( test_array[m_min-1] - (a_min - CR(x: test_array[m_min-1]*i)) > 0 )
        && ( CR(x: a_min) != CR(x: test_array[0]*i) ) {
        test_array.append( CR(x: test_array[m_min-1] - ( a_min - CR(x: test_array[m_min-1]*i) )) )
        m_min += 1
    }
    test_array.append(0)
    if ( CR(x: a_min) == CR(x: test_array[0]*i) ) {
        test_array.removeAll()
    }
    return test_array
  }

  //instructions for checking test_arrays
  func CT() -> Double {
    if ( BT(c: -1).count-1 <= 120 ) {
        return -1.0/100
    }
    else if ( BT(c: 0).count-1 <= 120 ) {
        return 0.0/100
    }
    else if ( BT(c: 1).count-1 <= 120 ) {
        return 1.0/100
    }
    return 0.0/100
  }

  @IBAction func Loaned_Max_Input(_ sender: UITextField) {
    p_max = Double(truncating: removeFormat(string: loaned_max_input.text!))
    if (p_max - floor(p_max) > 0.499999)
        && (p_max - floor(p_max) < 0.5) {
      p_max = round(p_max + 1)
    } else {
      p_max = round(p_max)
    }
    if (p_max <= p_min) {
      p_max = p_min+1
      loaned_max_input.text = String(format: "%.0f", p_max)
    } else { }
    bubble_label = UILabel(frame: CGRect(
      x: -String(format: "%.0f", p_max).count*6+0,
      y: -5,
      width: String(format: "%.0f", p_max).count*12+20,
      height: -32
    ))
    ΔN = (p_max - p_min)/N
    if (ΔN - floor(ΔN) == 0) {
      increment_input.text = String(format: "%.0f", ΔN)
      increment_input.textColor = UIColor(
        red: 161/255.0,
        green: 166/255.0,
        blue: 168/255.0,
        alpha: 1.0
      )
      increment_input.alpha = 0.25
      increment_input.layer.removeAllAnimations()
      even_out.isHidden = true
      submit_changes.isEnabled = true
      suggest.isHidden = true
    } else {
      even_out.isHidden = false
      submit_changes.isEnabled = false
      if (N == 0) {
        increment_input.text = "∞"
      } else {
        increment_input.text = String(format: "%.5f", ΔN)
      }
      increment_input.textColor = UIColor(
        red: 109/255.0,
        green: 129/255.0,
        blue: 158/255.0,
        alpha: 1.0
      )
      increment_input.alpha = 1.0
      UIView.animate(
        withDuration: 0.0625,
        delay: 0.0,
        options: [.repeat, .autoreverse, .curveEaseInOut],
        animations: {
          UIView.setAnimationRepeatCount(3)
          self.increment_input.alpha = 0.0
        },
        completion: { (finished: Bool) -> Void in
          self.increment_input.alpha = 1.0
        }
      )
      suggest.isHidden = false
    }
    var suggestions = [Int]()
    var tailored_suggestions = String()
    var suggestions_index = -1
    for N_suggest in 20...60 {
      let ΔN_result = (p_max - p_min)/Double(N_suggest)
      if (ΔN_result - floor(ΔN_result) == 0) {
        suggestions.append(N_suggest)
        suggestions_index += 1
      }
    }
    if (suggestions == []) {
      suggest.text = "Even out the minimum or maximum, first."
    } else {
      if (suggestions_index == 0) {
        suggest.text = "Suggestion: \(suggestions[suggestions_index]) increments"
      } else if (suggestions_index == 1) {
        //use ``or''
        suggest.text = "Suggestions: \(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
      } else {
        //use commas and ``or'' (e.g., ``20, 25 or 40'')
        for tailoring_suggestions in 0...(suggestions_index-2) {
          tailored_suggestions += "\(suggestions[tailoring_suggestions]), "
        }
        suggest.text = "Suggestions: \(tailored_suggestions)\(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
      }
    }
    if (p_max > progress) {
      var value = (progress - p_min)/ΔN
      if (value - floor(value) > 0.499999) && (value - floor(value) < 0.5) {
        value = round(value + 1)
      } else {
        value = round(value)
      }
      self.loaned.setValue(Float(value), animated: true)
    } else {
      p = Double(p_max)
      shared_preferences.set(p, forKey: "loaned")
      shared_preferences.synchronize()
      let value = N
      self.loaned.setValue(Float(value), animated: true)
      progress = ΔN * Double(self.loaned.value) + p_min
    }
    var a_min = Double()
    if (tenyr_indicator == 0) {
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   temp = (round(p*i*100 + 1) + 1)/100
      // } else {
      //   temp = (round(p*i*100) + 1)/100
      // }
      a_min = CR(x: p*i) + 0.01 //a_min_n
    } else {
      if (i != 0) {
        a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
        a_min += CT()
      } else {
        a_min = ceil(p/120*100)/100
      }
    }
    if (a_min >= a) {
      a = a_min
      a_reference = a_min
      shared_preferences.set(a, forKey: "pay_monthly")
      shared_preferences.synchronize()
      if (a - floor(a) == 0) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".00"
      } else if ((a - floor(a))*100 < 9.99999) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".0"
          + String(format: "%.0f", (a - floor(a))*100)
      } else {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + "."
          + String(format: "%.0f", (a - floor(a))*100)
      }
      minimum.isHidden = false
      minimum.text = "Minimum"
    } else {
      minimum.isHidden = false
      minimum.text = " "
    }
    Lengthsaving()
  }

  @IBAction func Input_Number_of_Increments(_ sender: UITextField) {
    N = Double(truncating: removeFormat(
      string: input_number_of_increments.text!
    ))
    if (N - floor(N) > 0.499999)
        && (N - floor(N) < 0.5) {
      N = round(N + 1)
    } else {
      N = round(N)
    }
    if (N < 0) {
      N = 0
      input_number_of_increments.text = String(
        format: "%.0f",
        N
      )
    }
    ΔN = (p_max - p_min)/N
    self.loaned.maximumValue = Float(N)
    if (ΔN - floor(ΔN) == 0) {
      increment_input.text = String(format: "%.0f", ΔN)
      increment_input.textColor = UIColor(
        red: 161/255.0,
        green: 166/255.0,
        blue: 168/255.0,
        alpha: 1.0
      )
      increment_input.alpha = 0.25
      increment_input.layer.removeAllAnimations()
      even_out.isHidden = true
      submit_changes.isEnabled = true
      suggest.isHidden = true
    } else {
      even_out.isHidden = false
      submit_changes.isEnabled = false
      if (N == 0) {
        increment_input.text = "∞"
      } else {
        increment_input.text = String(format: "%.5f", ΔN)
      }
      increment_input.textColor = UIColor(
        red: 109/255.0,
        green: 129/255.0,
        blue: 158/255.0,
        alpha: 1.0
      )
      increment_input.alpha = 1.0
      UIView.animate(
        withDuration: 0.0625,
        delay: 0.0,
        options: [.repeat, .autoreverse, .curveEaseInOut],
        animations: {
          UIView.setAnimationRepeatCount(3)
          self.increment_input.alpha = 0.0
        },
        completion: { (finished: Bool) -> Void in
          self.increment_input.alpha = 1.0
        }
      )
      suggest.isHidden = false
    }
    var suggestions = [Int]()
    var tailored_suggestions = String()
    var suggestions_index = -1
    for N_suggest in 20...60 {
      let ΔN_result = (p_max - p_min)/Double(N_suggest)
      if (ΔN_result - floor(ΔN_result) == 0) {
        suggestions.append(N_suggest)
        suggestions_index += 1
      }
    }
    if (suggestions == []) {
      suggest.text = "Even out the minimum or maximum, first."
    } else {
      if (suggestions_index == 0) {
        suggest.text = "Suggestion: \(suggestions[suggestions_index]) increments"
      } else if (suggestions_index == 1) {
        //use ``or''
        suggest.text = "Suggestions: \(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
      } else {
        //use commas and ``or'' (e.g., ``20, 25 or 40'')
        for tailoring_suggestions in 0...(suggestions_index-2) {
          tailored_suggestions += "\(suggestions[tailoring_suggestions]), "
        }
        suggest.text = "Suggestions: \(tailored_suggestions)\(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
      }
    }
  }

  @IBAction func Apr_Number(_ sender: UITextField) {
    i = Double(truncating: removeFormat(string: apr_number.text!))
    // let temp_new = i*100 - floor(i*100)
    // if (temp_new > 0.499999) && (temp_new < 0.5) {
    //   i = round(i*100 + 1)/100 / 100 / 12
    // } else {
    //   i = round(i*100)/100 / 100 / 12
    // }
    i = CR(x: i)/100/12
    if (i <= 0) {
      i = 0.01 / 100 / 12
      apr_number.text = String(format: "%.2f", i * 12 * 100)
      apr_number_back.text = String(format: "%.2f", i * 12 * 100)
    } else { }
    rates_reference[2] = i
    shared_preferences.set(2, forKey: "position")
    shared_preferences.set(i * 12 * 100, forKey: "interest")
    shared_preferences.synchronize()
    var a_min = Double()
    if (tenyr_indicator == 0) {
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   temp = (round(p*i*100 + 1) + 1)/100
      // } else {
      //   temp = (round(p*i*100) + 1)/100
      // }
      a_min = CR(x: p*i) + 0.01 //a_min_n
    } else {
      if (i != 0) {
        a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
        a_min += CT()
      } else {
        a_min = ceil(p/120*100)/100
      }
    }
    if (a_min >= a) {
      a = a_min
      a_reference = a_min
      shared_preferences.set(a, forKey: "pay_monthly")
      shared_preferences.synchronize()
      if (a - floor(a) == 0) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".00"
      } else if ((a - floor(a))*100 < 9.99999) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".0"
          + String(format: "%.0f", (a - floor(a))*100)
      } else {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + "."
          + String(format: "%.0f", (a - floor(a))*100)
      }
      minimum.isHidden = false
      minimum.text = "Minimum"
    } else {
      minimum.isHidden = false
      minimum.text = " "
    }
    Lengthsaving()
  }

  @IBAction func Down_Number(_ sender: UITextField) {
    down_button_increment = Double(truncating: removeFormat(
      string: down_number.text!
    ))
    if (down_button_increment - floor(down_button_increment) > 0.499999)
        && (down_button_increment - floor(down_button_increment) < 0.5) {
      down_button_increment = round(down_button_increment + 1)
    } else {
      down_button_increment = round(down_button_increment)
    }
    if (down_button_increment <= 1.0) {
      down_button_increment = 1.0
      down_number.text = String(format: "%.0f", down_button_increment)
    } else if (down_button_increment > set_down_timer1_increment) {
      down_button_increment = set_down_timer1_increment
      down_number.text = String(format: "%.0f", down_button_increment)
    } else { }
  }

  @IBAction func Up_Number(_ sender: UITextField) {
    up_button_increment = Double(truncating: removeFormat(
      string: up_number.text!
    ))
    if (up_button_increment - floor(up_button_increment) > 0.499999)
        && (up_button_increment - floor(up_button_increment) < 0.5) {
      up_button_increment = round(up_button_increment + 1)
    } else {
      up_button_increment = round(up_button_increment)
    }
    if (up_button_increment <= 1.0) {
      up_button_increment = 1.0
      up_number.text = String(format: "%.0f", up_button_increment)
    } else if (up_button_increment > set_up_timer1_increment) {
      up_button_increment = set_up_timer1_increment
      up_number.text = String(format: "%.0f", up_button_increment)
    } else { }
  }

  @IBAction func Pay_Number(_ sender: UITextField) {
    a = Double(truncating: removeFormat(string: pay_number.text!))
    // let temp_new2 = a*100 - floor(a*100)
    // if (temp_new2 > 0.499999) && (temp_new2 < 0.5) {
    //   a = round(a*100 + 1)/100
    // } else {
    //   a = round(a*100)/100
    // }
    a = CR(x: a)
    var a_min = Double()
    if (tenyr_indicator == 0) {
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   temp = (round(p*i*100 + 1) + 1)/100
      // } else {
      //   temp = (round(p*i*100) + 1)/100
      // }
      a_min = CR(x: p*i) + 0.01 //a_min_n
    } else {
      if (i != 0) {
        a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
        a_min += CT()
      } else {
        a_min = ceil(p/120*100)/100
      }
    }
    if (a <= a_min) {
      a = a_min
      a_reference = a_min
      minimum.isHidden = false
      minimum.text = "Minimum"
      pay_number.text = String(format: "%.2f", a)
    } else {
      minimum.isHidden = false
      minimum.text = " "
    }
    shared_preferences.set(a, forKey: "pay_monthly")
    shared_preferences.synchronize()
    Lengthsaving()
  }

  @IBAction func Down_Timer1_Seconds(_ sender: UITextField) {
    set_down_timer1_seconds = Double(truncating: removeFormat(
      string: down_timer1_seconds.text!
    ))
    if (set_down_timer1_seconds - floor(set_down_timer1_seconds) > 0.499999)
        && (set_down_timer1_seconds - floor(set_down_timer1_seconds) < 0.5) {
      set_down_timer1_seconds = round(set_down_timer1_seconds + 1)
    } else {
      set_down_timer1_seconds = round(set_down_timer1_seconds)
    }
    if (set_down_timer1_seconds < 1.0) {
      set_down_timer1_seconds = 1.0
      down_timer1_seconds.text = String(format: "%.0f", set_down_timer1_seconds)
    } else if (set_down_timer1_seconds > set_down_timer2_seconds) {
      set_down_timer1_seconds = set_down_timer2_seconds - 1.0
      down_timer1_seconds.text = String(format: "%.0f", set_down_timer1_seconds)
    } else { }
  }

  @IBAction func Down_Timer2_Seconds(_ sender: UITextField) {
    set_down_timer2_seconds = Double(truncating: removeFormat(
      string: down_timer2_seconds.text!
    ))
    if (set_down_timer2_seconds - floor(set_down_timer2_seconds) > 0.499999)
        && (set_down_timer2_seconds - floor(set_down_timer2_seconds) < 0.5) {
      set_down_timer2_seconds = round(set_down_timer2_seconds + 1)
    } else {
      set_down_timer2_seconds = round(set_down_timer2_seconds)
    }
    if (set_down_timer2_seconds <= set_down_timer1_seconds) {
      set_down_timer2_seconds = set_down_timer1_seconds + 1.0
      down_timer2_seconds.text = String(format: "%.0f", set_down_timer2_seconds)
    } else { }
  }

  @IBAction func Up_Timer1_Seconds(_ sender: UITextField) {
    set_up_timer1_seconds = Double(truncating: removeFormat(
      string: up_timer1_seconds.text!
    ))
    if (set_up_timer1_seconds - floor(set_up_timer1_seconds) > 0.499999)
        && (set_up_timer1_seconds - floor(set_up_timer1_seconds) < 0.5) {
      set_up_timer1_seconds = round(set_up_timer1_seconds + 1)
    } else {
      set_up_timer1_seconds = round(set_up_timer1_seconds)
    }
    if (set_up_timer1_seconds < 1.0) {
      set_up_timer1_seconds = 1.0
      up_timer1_seconds.text = String(format: "%.0f", set_up_timer1_seconds)
    } else if (set_up_timer1_seconds > set_up_timer2_seconds) {
      set_up_timer1_seconds = set_up_timer2_seconds - 1.0
      up_timer1_seconds.text = String(format: "%.0f", set_up_timer1_seconds)
    } else { }
  }

  @IBAction func Up_Timer2_Seconds(_ sender: UITextField) {
    set_up_timer2_seconds = Double(truncating: removeFormat(
      string: up_timer2_seconds.text!
    ))
    if (set_up_timer2_seconds - floor(set_up_timer2_seconds) > 0.499999)
        && (set_up_timer2_seconds - floor(set_up_timer2_seconds) < 0.5) {
      set_up_timer2_seconds = round(set_up_timer2_seconds + 1)
    } else {
      set_up_timer2_seconds = round(set_up_timer2_seconds)
    }
    if (set_up_timer2_seconds <= set_up_timer1_seconds) {
      set_up_timer2_seconds = set_up_timer1_seconds + 1.0
      up_timer2_seconds.text = String(format: "%.0f", set_up_timer2_seconds)
    } else { }
  }

  @IBAction func Down_Timer1_Increment(_ sender: UITextField) {
    set_down_timer1_increment = Double(truncating: removeFormat(
      string: down_timer1_increment.text!
    ))
    if (set_down_timer1_increment - floor(set_down_timer1_increment) > 0.499999)
        && (set_down_timer1_increment
          - floor(set_down_timer1_increment)
          < 0.5) {
      set_down_timer1_increment = round(set_down_timer1_increment + 1)
    } else {
      set_down_timer1_increment = round(set_down_timer1_increment)
    }
    if (set_down_timer1_increment < down_button_increment) {
      set_down_timer1_increment = down_button_increment
      down_timer1_increment.text = String(
        format: "%.0f",
        set_down_timer1_increment
      )
    } else if (set_down_timer1_increment > set_down_timer2_increment) {
      set_down_timer1_increment = set_down_timer2_increment
      down_timer1_increment.text = String(
        format: "%.0f",
        set_down_timer1_increment
      )
    } else { }
  }

  @IBAction func Down_Timer2_Increment(_ sender: UITextField) {
    set_down_timer2_increment = Double(truncating: removeFormat(
      string: down_timer2_increment.text!
    ))
    if (set_down_timer2_increment - floor(set_down_timer2_increment) > 0.499999)
        && (set_down_timer2_increment
          - floor(set_down_timer2_increment)
          < 0.5) {
      set_down_timer2_increment = round(set_down_timer2_increment + 1)
    } else {
      set_down_timer2_increment = round(set_down_timer2_increment)
    }
    if (set_down_timer2_increment < set_down_timer1_increment) {
      set_down_timer2_increment = set_down_timer1_increment
      down_timer2_increment.text = String(
        format: "%.0f",
        set_down_timer2_increment
      )
    } else { }
  }

  @IBAction func Up_Timer1_Increment(_ sender: UITextField) {
    set_up_timer1_increment = Double(truncating: removeFormat(
      string: up_timer1_increment.text!
    ))
    if (set_up_timer1_increment - floor(set_up_timer1_increment) > 0.499999)
        && (set_up_timer1_increment - floor(set_up_timer1_increment) < 0.5) {
      set_up_timer1_increment = round(set_up_timer1_increment + 1)
    } else {
      set_up_timer1_increment = round(set_up_timer1_increment)
    }
    if (set_up_timer1_increment < up_button_increment) {
      set_up_timer1_increment = up_button_increment
      up_timer1_increment.text = String(format: "%.0f", set_up_timer1_increment)
    } else if (set_up_timer1_increment > set_up_timer2_increment) {
      set_up_timer1_increment = set_up_timer2_increment
      up_timer1_increment.text = String(format: "%.0f", set_up_timer1_increment)
    } else { }
  }

  @IBAction func Up_Timer2_Increment(_ sender: UITextField) {
    set_up_timer2_increment = Double(truncating: removeFormat(
      string: up_timer2_increment.text!
    ))
    if (set_up_timer2_increment - floor(set_up_timer2_increment) > 0.499999)
        && (set_up_timer2_increment - floor(set_up_timer2_increment) < 0.5) {
      set_up_timer2_increment = round(set_up_timer2_increment + 1)
    } else {
      set_up_timer2_increment = round(set_up_timer2_increment)
    }
    if (set_up_timer2_increment < set_up_timer1_increment) {
      set_up_timer2_increment = set_up_timer1_increment
      up_timer2_increment.text = String(format: "%.0f", set_up_timer2_increment)
    } else { }
  }

  //register input by simply pressing the return key
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  //if users input a comma, extract number from it
  func removeFormat(string: String) -> NSNumber {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.groupingSeparator = ","
    formatter.groupingSize = 3
    return formatter.number(from: string) ?? 0
  }

  @IBAction func Edit_Slider_Expand(_ sender: UIButton?) {
    //``?'' only necessary for slider
    loaned_min_input.text = String(format: "%.0f", p_min)
    loaned_max_input.text = String(format: "%.0f", p_max)
    input_number_of_increments.text = String(
      format: "%.0f",
      N
    )
    if (ΔN - floor(ΔN) == 0) {
      increment_input.text = String(format: "%.0f", ΔN)
      increment_input.textColor = UIColor(
        red: 161/255.0,
        green: 166/255.0,
        blue: 168/255.0,
        alpha: 1.0
      )
      increment_input.alpha = 0.25
      increment_input.layer.removeAllAnimations()
      even_out.isHidden = true
      submit_changes.isEnabled = true
      suggest.isHidden = true
    } else {
      even_out.isHidden = false
      submit_changes.isEnabled = false
      if (N == 0) {
        increment_input.text = "∞"
      } else {
        increment_input.text = String(format: "%.5f", ΔN)
      }
      increment_input.textColor = UIColor(
        red: 109/255.0,
        green: 129/255.0,
        blue: 158/255.0,
        alpha: 1.0
      )
      suggest.isHidden = false
    }
    var suggestions = [Int]()
    var tailored_suggestions = String()
    var suggestions_index = -1
    for N_suggest in 20...60 {
      let ΔN_result = (p_max - p_min)/Double(N_suggest)
      if (ΔN_result - floor(ΔN_result) == 0) {
        suggestions.append(N_suggest)
        suggestions_index += 1
      }
    }
    if (suggestions == []) {
      suggest.text = "Even out the minimum or maximum, first."
    } else {
      if (suggestions_index == 0) {
        suggest.text = "Suggestion: \(suggestions[suggestions_index]) increments"
      } else if (suggestions_index == 1) {
        //use ``or''
        suggest.text = "Suggestions: \(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
      } else {
        //use commas and ``or'' (e.g., ``20, 25 or 40'')
        for tailoring_suggestions in 0...(suggestions_index-2) {
          tailored_suggestions += "\(suggestions[tailoring_suggestions]), "
        }
        suggest.text = "Suggestions: \(tailored_suggestions)\(suggestions[suggestions_index-1]) or \(suggestions[suggestions_index]) increments"
      }
    }
    edit_slider.isHidden = true
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
    view.addSubview(edit_slider_shape)
    view.bringSubviewToFront(edit_slider_shape)
    view.willRemoveSubview(stack_min)
    view.addSubview(stack_max)
    edit_slider_shape.addSubview(stack_min)
    edit_slider_shape.addSubview(stack_max)
    edit_slider_shape.addSubview(stack_inputs)
    edit_slider_shape.addSubview(bare_track)
    edit_slider_shape.addSubview(even_out)
    edit_slider_shape.addSubview(submit_changes)
    edit_slider_shape.bringSubviewToFront(stack_min)
    edit_slider_shape.bringSubviewToFront(stack_max)
    edit_slider_shape.bringSubviewToFront(even_out)
    edit_slider_shape.bringSubviewToFront(submit_changes)
    edit_slider_shape.bringSubviewToFront(stack_inputs)
    edit_slider_shape.bringSubviewToFront(bare_track)
    edit_slider_shape.addSubview(loaned_title)
    edit_slider_shape.bringSubviewToFront(loaned_title)
    submit_changes.alpha = 0.0
    UIView.animate(
      withDuration: 0.0125,
      animations: {
        self.edit_slider_shape_tweak.fillColor = UIColor(
            red: 32/255.0,
            green: 36/255.0,
            blue: 38/255.0,
            alpha: 0.0
          ).cgColor
      },
      completion: { (finished: Bool) -> Void in
        UIView.animate(
          withDuration: 0.25,
          animations: {
            self.increment_input_left_label.alpha = 0.25
            self.increment_input.alpha = 0.25
            self.increment_input_right_label.alpha = 0.25
            self.loaned_minimum.alpha = 0.125
            self.loaned_maximum.alpha = 0.125
            self.loaned_title.alpha = 0.125
            self.loaned_title.font = UIFont(name: "HelveticaNeue", size: 17.0)
            self.input_number_of_increments.alpha = 1
            self.bare_track.alpha = 0.5
            self.input_number_of_increments.font = UIFont(
              name: "HelveticaNeue-Bold",
              size: 17.0
            )
            self.loaned_min_input.font = UIFont(
              name: "HelveticaNeue-Bold",
              size: 17.0
            )
            self.loaned_max_input.font = UIFont(
              name: "HelveticaNeue-Bold",
              size: 17.0
            )
            self.edit_slider_shape_tweak.fillColor = UIColor(
                red: 32/255.0,
                green: 36/255.0,
                blue: 38/255.0,
                alpha: 1.0
              ).cgColor
            self.submit_changes.alpha = 1.0
            self.loaned_min_input.backgroundColor = UIColor(
              red: 109/255.0,
              green: 129/255.0,
              blue: 158/255.0,
              alpha: 0.125
            )
            self.loaned_max_input.backgroundColor = UIColor(
              red: 109/255.0,
              green: 129/255.0,
              blue: 158/255.0,
              alpha: 0.125
            )
            self.input_number_of_increments.backgroundColor = UIColor(
              red: 109/255.0,
              green: 129/255.0,
              blue: 158/255.0,
              alpha: 0.125
            )
          },
          completion: { (finished: Bool) -> Void in
            if (self.ΔN - floor(self.ΔN) != 0) {
              self.increment_input.alpha = 1.0
              UIView.animate(
                withDuration: 0.0625,
                delay: 0.0,
                options: [.repeat, .autoreverse, .curveEaseInOut],
                animations: {
                  UIView.setAnimationRepeatCount(3)
                  self.increment_input.alpha = 0.0
                },
                completion: { (finished: Bool) -> Void in
                  self.increment_input.alpha = 1.0
                }
              )
            }
          }
        )
      }
    )
  }

  @IBAction func Edit_Slider_Close(_ sender: UIButton) {
    if (locked.isHidden == false) {
      edit_slider.isHidden = true
    } else {
      edit_slider.isHidden = false
    }
    increment_input_left_label.isHidden = true
    increment_input.isHidden = true
    increment_input_right_label.isHidden = true
    input_number_of_increments.isHidden = true
    bare_track.isHidden = true
    loaned_min_input.isUserInteractionEnabled = false
    loaned_max_input.isUserInteractionEnabled = false
    input_number_of_increments.isUserInteractionEnabled = false
    edit_slider_shape.isHidden = true
    edit_slider_shape_tweak.fillColor = UIColor(
        red: 32/255.0,
        green: 36/255.0,
        blue: 38/255.0,
        alpha: 0.0
      ).cgColor
    increment_input_left_label.alpha = 0.0
    increment_input.alpha = 0.0
    increment_input_right_label.alpha = 0.0
    input_number_of_increments.alpha = 0.0
    loaned_minimum.alpha = 1.0
    loaned_maximum.alpha = 1.0
    loaned_title.alpha = 1.0
    bare_track.alpha = 0.0
    input_number_of_increments.font = UIFont(name: "HelveticaNeue", size: 17.0)
    loaned_min_input.font = UIFont(name: "HelveticaNeue", size: 17.0)
    loaned_max_input.font = UIFont(name: "HelveticaNeue", size: 17.0)
    loaned_title.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
    submit_changes.isHidden = true
    edit_slider_shape.willRemoveSubview(stack_min)
    edit_slider_shape.willRemoveSubview(stack_max)
    view.addSubview(stack_min)
    view.addSubview(stack_max)
    edit_slider_shape.willRemoveSubview(loaned_title)
    view.addSubview(loaned_title)
    loaned_min_input.text = numberFormatter.string(from: NSNumber(
        value: p_min
      ))! //otherwise won't show real value
    loaned_max_input.text = numberFormatter.string(from: NSNumber(
        value: p_max
      ))! //otherwise won't show real value
    loaned_min_input.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    loaned_max_input.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    input_number_of_increments.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    loaned.isHidden = false
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
    submit_changes_apr.alpha = 0.0
    UIView.animate(
      withDuration: 0.0125,
      animations: {
        self.interest_rate_unpressed_outline.borderColor = UIColor(
            red: 235.0/255,
            green: 235.0/255,
            blue: 255.0/255,
            alpha: 0.0
          ).cgColor
        self.edit_apr_shape_tweak_triangleLayer.strokeColor = UIColor(
            red: 235.0/255,
            green: 235.0/255,
            blue: 255.0/255,
            alpha: 0.0
          ).cgColor
        self.edit_apr_shape_tweak.fillColor = UIColor(
            red: 32/255.0,
            green: 36/255.0,
            blue: 38/255.0,
            alpha: 0.0
          ).cgColor
        self.switch_outline.borderColor = UIColor(
            red: 235.0/255,
            green: 235.0/255,
            blue: 255.0/255,
            alpha: 0.0
          ).cgColor
        self.switch_thumb_outline.borderColor = UIColor(
            red: 235.0/255,
            green: 235.0/255,
            blue: 255.0/255,
            alpha: 0.0
          ).cgColor
      },
      completion: { (finished: Bool) -> Void in
        UIView.animate(withDuration: 0.25) {
          //otherwise increment_input wouldn't blend
          self.apr_sign.alpha = 0.125
          self.interest_rate_unpressed_outline.borderColor = UIColor(
              red: 235.0/255,
              green: 235.0/255,
              blue: 255.0/255,
              alpha: 0.5
            ).cgColor
          self.edit_apr_shape_tweak_triangleLayer.strokeColor = UIColor(
              red: 235.0/255,
              green: 235.0/255,
              blue: 255.0/255,
              alpha: 0.125
            ).cgColor
          self.apr_number.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
          self.edit_apr_shape_tweak.fillColor = UIColor(
              red: 32/255.0,
              green: 36/255.0,
              blue: 38/255.0,
              alpha: 1.0
            ).cgColor
          self.table_view.alpha = 0.0
          self.switch_outline.borderColor = UIColor(
              red: 235.0/255,
              green: 235.0/255,
              blue: 255.0/255,
              alpha: 0.5
            ).cgColor
          self.switch_thumb_outline.borderColor = UIColor(
              red: 235.0/255,
              green: 235.0/255,
              blue: 255.0/255,
              alpha: 0.5
            ).cgColor
          self.apr_title.alpha = 0.125
          self.apr_title.font = UIFont(name: "HelveticaNeue", size: 17.0)
          self.submit_changes_apr.alpha = 1.0
          self.apr_number.backgroundColor = UIColor(
            red: 109/255.0,
            green: 129/255.0,
            blue: 158/255.0,
            alpha: 0.125
          )
        }
      }
    )
  }

  @IBAction func Edit_Apr_Close(_ sender: UIButton) {
    edit_apr.isHidden = false
    apr_number.isUserInteractionEnabled = false
    edit_apr_shape.isHidden = true
    edit_apr_shape_tweak.fillColor = UIColor(
        red: 32/255.0,
        green: 36/255.0,
        blue: 38/255.0,
        alpha: 0.0
      ).cgColor
    apr_sign.alpha = 1.0
    interest_rate_unpressed_outline.borderColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
    edit_apr_shape_tweak_triangleLayer.strokeColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
    switch_outline.borderColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
    switch_thumb_outline.borderColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
    apr_number.font = UIFont(name: "HelveticaNeue", size: 17.0)
    submit_changes_apr.isHidden = true
    edit_apr_shape.willRemoveSubview(edit_apr_text)
    view.addSubview(edit_apr_text)
    edit_apr_shape.willRemoveSubview(apr_title)
    view.addSubview(apr_title)
    apr_title.alpha = 1.0
    apr_title.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
    interest_rate_unpressed_copy.isHidden = true
    interest_rate_unpressed.isHidden = false
    apr_number.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    apr_number.text = String(format: "%.2f", i * 12 * 100)
    apr_number_back.text = String(format: "%.2f", i * 12 * 100)
  }

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
    down_timer1_increment.text = String(
      format: "%.0f",
      set_down_timer1_increment
    )
    down_timer2_increment.text = String(
      format: "%.0f",
      set_down_timer2_increment
    )
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
    submit_changes_pay.alpha = 0.0
    UIView.animate(
      withDuration: 0.0125,
      animations: {
        self.down_outline.borderColor = UIColor(
            red: 235.0/255,
            green: 235.0/255,
            blue: 255.0/255,
            alpha: 0.0
          ).cgColor
        self.pay_outline.borderColor = UIColor(
            red: 235.0/255,
            green: 235.0/255,
            blue: 255.0/255,
            alpha: 0.0
          ).cgColor
        self.up_outline.borderColor = UIColor(
            red: 235.0/255,
            green: 235.0/255,
            blue: 255.0/255,
            alpha: 0.0
          ).cgColor
        self.edit_pay_shape_tweak.fillColor = UIColor(
            red: 32/255.0,
            green: 36/255.0,
            blue: 38/255.0,
            alpha: 0.0
          ).cgColor
        self.pay_monthly_title.alpha = 1.0
        self.minimum.textColor = UIColor(
          red: 109/255.0,
          green: 130/255.0,
          blue: 159/255.0,
          alpha: 1.0
        )
      },
      completion: { (finished: Bool) -> Void in
        UIView.animate(withDuration: 0.25) {
          //otherwise increment_input wouldn't blend
          self.pay_sign.alpha = 0.125
          self.down_outline.borderColor = UIColor(
              red: 235.0/255,
              green: 235.0/255,
              blue: 255.0/255,
              alpha: 0.5
            ).cgColor
          self.pay_outline.borderColor = UIColor(
              red: 235.0/255,
              green: 235.0/255,
              blue: 255.0/255,
              alpha: 0.5
            ).cgColor
          self.up_outline.borderColor = UIColor(
              red: 235.0/255,
              green: 235.0/255,
              blue: 255.0/255,
              alpha: 0.5
            ).cgColor
          self.down_number.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
          self.pay_number.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
          self.up_number.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
          self.down_timer1_seconds.font = UIFont(
            name: "HelveticaNeue-Bold",
            size: 17.0
          )
          self.down_timer2_seconds.font = UIFont(
            name: "HelveticaNeue-Bold",
            size: 17.0
          )
          self.down_timer1_increment.font = UIFont(
            name: "HelveticaNeue-Bold",
            size: 17.0
          )
          self.down_timer2_increment.font = UIFont(
            name: "HelveticaNeue-Bold",
            size: 17.0
          )
          self.up_timer1_seconds.font = UIFont(
            name: "HelveticaNeue-Bold",
            size: 17.0
          )
          self.up_timer2_seconds.font = UIFont(
            name: "HelveticaNeue-Bold",
            size: 17.0
          )
          self.up_timer1_increment.font = UIFont(
            name: "HelveticaNeue-Bold",
            size: 17.0
          )
          self.up_timer2_increment.font = UIFont(
            name: "HelveticaNeue-Bold",
            size: 17.0
          )
          self.edit_pay_shape_tweak.fillColor = UIColor(
              red: 32/255.0,
              green: 36/255.0,
              blue: 38/255.0,
              alpha: 1.0
            ).cgColor
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
          self.minimum.textColor = UIColor(
            red: 255/255.0,
            green: 255/255.0,
            blue: 255/255.0,
            alpha: 0.03125
          )
          self.pay_monthly_title.font = UIFont(
            name: "HelveticaNeue",
            size: 17.0
          )
          self.view.bringSubviewToFront(self.table_view) //in case someone wants to open table_view
          self.submit_changes_pay.alpha = 1.0
          self.down_number.backgroundColor = UIColor(
            red: 109/255.0,
            green: 129/255.0,
            blue: 158/255.0,
            alpha: 0.125
          )
          self.pay_number.backgroundColor = UIColor(
            red: 109/255.0,
            green: 129/255.0,
            blue: 158/255.0,
            alpha: 0.125
          )
          self.up_number.backgroundColor = UIColor(
            red: 109/255.0,
            green: 129/255.0,
            blue: 158/255.0,
            alpha: 0.125
          )
          self.down_timer1_seconds.backgroundColor = UIColor(
            red: 109/255.0,
            green: 129/255.0,
            blue: 158/255.0,
            alpha: 0.125
          )
          self.down_timer2_seconds.backgroundColor = UIColor(
            red: 109/255.0,
            green: 129/255.0,
            blue: 158/255.0,
            alpha: 0.125
          )
          self.down_timer1_increment.backgroundColor = UIColor(
            red: 109/255.0,
            green: 129/255.0,
            blue: 158/255.0,
            alpha: 0.125
          )
          self.down_timer2_increment.backgroundColor = UIColor(
            red: 109/255.0,
            green: 129/255.0,
            blue: 158/255.0,
            alpha: 0.125
          )
          self.up_timer1_seconds.backgroundColor = UIColor(
            red: 109/255.0,
            green: 129/255.0,
            blue: 158/255.0,
            alpha: 0.125
          )
          self.up_timer2_seconds.backgroundColor = UIColor(
            red: 109/255.0,
            green: 129/255.0,
            blue: 158/255.0,
            alpha: 0.125
          )
          self.up_timer1_increment.backgroundColor = UIColor(
            red: 109/255.0,
            green: 129/255.0,
            blue: 158/255.0,
            alpha: 0.125
          )
          self.up_timer2_increment.backgroundColor = UIColor(
            red: 109/255.0,
            green: 129/255.0,
            blue: 158/255.0,
            alpha: 0.125
          )
        }
      }
    )
  }

  @IBAction func Edit_Pay_Close(_ sender: UIButton) {
    edit_pay.isHidden = false
    down_sign.isHidden = true
    down_number.isHidden = true
    up_sign.isHidden = true
    up_number.isHidden = true
    stack_inputs_timers_down.isHidden = true
    stack_inputs_timers_up.isHidden = true
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
    edit_pay_shape_tweak.fillColor = UIColor(
        red: 32/255.0,
        green: 36/255.0,
        blue: 38/255.0,
        alpha: 0.0
      ).cgColor
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
    down_outline.borderColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
    pay_outline.borderColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
    up_outline.borderColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
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
    view.addSubview(edit_pay_text)
    edit_pay_shape.willRemoveSubview(pay_monthly_title)
    view.addSubview(pay_monthly_title)
    view.bringSubviewToFront(table_view)
    pay_monthly_title.alpha = 1.0
    minimum.textColor = UIColor(
      red: 109/255.0,
      green: 130/255.0,
      blue: 159/255.0,
      alpha: 1.0
    )
    pay_monthly_title.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
    down_number.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    pay_number.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    up_number.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    down_timer1_seconds.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    down_timer2_seconds.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    down_timer1_increment.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    down_timer2_increment.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    up_timer1_seconds.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    up_timer2_seconds.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    up_timer1_increment.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    up_timer2_increment.backgroundColor = UIColor(
      red: 109/255.0,
      green: 129/255.0,
      blue: 158/255.0,
      alpha: 0
    )
    down_number.text = numberFormatter.string(from: NSNumber(
        value: down_button_increment
      ))!
    if (a - floor(a) == 0) {
      pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
        + ".00"
    } else if ((a - floor(a))*100 < 9.99999) {
      pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
        + ".0"
        + String(format: "%.0f", (a - floor(a))*100)
    } else {
      pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
        + "."
        + String(format: "%.0f", (a - floor(a))*100)
    }
    up_number.text = numberFormatter.string(from: NSNumber(
        value: up_button_increment
      ))!
    down_timer1_seconds.text = numberFormatter.string(from: NSNumber(
        value: set_down_timer1_seconds
      ))!
    down_timer2_seconds.text = numberFormatter.string(from: NSNumber(
        value: set_down_timer2_seconds
      ))!
    down_timer1_increment.text = numberFormatter.string(from: NSNumber(
        value: set_down_timer1_increment
      ))!
    down_timer2_increment.text = numberFormatter.string(from: NSNumber(
        value: set_down_timer2_increment
      ))!
    up_timer1_seconds.text = numberFormatter.string(from: NSNumber(
        value: set_up_timer1_seconds
      ))!
    up_timer2_seconds.text = numberFormatter.string(from: NSNumber(
        value: set_up_timer2_seconds
      ))!
    up_timer1_increment.text = numberFormatter.string(from: NSNumber(
        value: set_up_timer1_increment
      ))!
    up_timer2_increment.text = numberFormatter.string(from: NSNumber(
        value: set_up_timer2_increment
      ))!
  }

  @IBAction func Absolute_Clicked(_ sender: UIButton) {
    absolute.setImage(UIImage(named: "Submit"), for: .normal)
    tenyr.setImage(UIImage(named: "Off"), for: .normal)
    UIView.animate(
      withDuration: 0.25,
      animations: {
        self.absolute.transform = CGAffineTransform(scaleX: 1.125, y: 1.125)
      },
      completion: { (finished: Bool) -> Void in
        UIView.animate(
          withDuration: 0.25,
          animations: { self.absolute.transform = CGAffineTransform.identity },
          completion: { (finished: Bool) -> Void in }
        )
      }
    )
    tenyr_indicator = 0.0
    shared_preferences.set(tenyr_indicator, forKey: "tenyr")
    shared_preferences.synchronize()
    var a_min = Double()
    // if (p*i*100 - floor(p*i*100) > 0.499999)
    //     && (p*i*100 - floor(p*i*100) < 0.5) {
    //   temp = (round(p*i*100 + 1) + 1)/100
    // } else {
    //   temp = (round(p*i*100) + 1)/100
    // }
    a_min = CR(x: p*i) + 0.01 //a_min_n
    if (a_min >= a) {
      a = a_min
      a_reference = a_min
      shared_preferences.set(a, forKey: "pay_monthly")
      shared_preferences.synchronize()
      if (a - floor(a) == 0) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".00"
      } else if ((a - floor(a))*100 < 9.99999) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".0"
          + String(format: "%.0f", (a - floor(a))*100)
      } else {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + "."
          + String(format: "%.0f", (a - floor(a))*100)
      }
      minimum.isHidden = false
      minimum.text = "Minimum"
    } else {
      minimum.isHidden = false
      minimum.text = " "
    }
    Lengthsaving()
  }

  @IBAction func TenYr_Clicked(_ sender: UIButton) {
    tenyr.setImage(UIImage(named: "Submit"), for: .normal)
    absolute.setImage(UIImage(named: "Off"), for: .normal)
    UIView.animate(
      withDuration: 0.25,
      animations: {
        self.tenyr.transform = CGAffineTransform(scaleX: 1.125, y: 1.125)
      },
      completion: { (finished: Bool) -> Void in
        UIView.animate(
          withDuration: 0.25,
          animations: { self.tenyr.transform = CGAffineTransform.identity },
          completion: { (finished: Bool) -> Void in }
        )
      }
    )
    tenyr_indicator = 1.0
    shared_preferences.set(tenyr_indicator, forKey: "tenyr")
    shared_preferences.synchronize()
    var a_min = Double()
    if (i != 0) {
      a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
      a_min += CT()
    } else {
      a_min = ceil(p/120*100)/100
    }
    if (a_min >= a) {
      a = a_min
      a_reference = a_min
      shared_preferences.set(a, forKey: "pay_monthly")
      shared_preferences.synchronize()
      if (a - floor(a) == 0) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".00"
      } else if ((a - floor(a))*100 < 9.99999) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".0"
          + String(format: "%.0f", (a - floor(a))*100)
      } else {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + "."
          + String(format: "%.0f", (a - floor(a))*100)
      }
      minimum.isHidden = false
      minimum.text = "Minimum"
    } else {
      minimum.isHidden = false
      minimum.text = " "
    }
    Lengthsaving()
  }

  @IBAction func Slider(_ sender: UISlider) {
    if (sender.value - floor(sender.value) > 0.99999) {
      sender.value = roundf(sender.value + 1)
    } else {
      sender.value = roundf(sender.value)
    }
    progress = ΔN * Double(sender.value) + p_min
    view.addSubview(loaned)
    //subview slider thumb bubble, so it moves with thumb
    if let thumb_bubble = loaned.subviews.last as? UIImageView {
      bubble_label.backgroundColor = UIColor(
        red: 161.0/255,
        green: 166.0/255,
        blue: 168.0/255,
        alpha: 1.0
      )
      bubble_label.textColor = UIColor(
        red: 64.0/255,
        green: 73.0/255,
        blue: 77.0/255,
        alpha: 1.0
      )
      bubble_label.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
      bubble_label.textAlignment = .center
      bubble_label.layer.masksToBounds = true
      bubble_label.layer.cornerRadius = 5
      let trianglePath = UIBezierPath()
      trianglePath.move(to: CGPoint(x: 0, y: 0))
      trianglePath.addLine(to: CGPoint(x: 14, y: 0))
      trianglePath.addLine(to: CGPoint(x: 7, y: 7))
      trianglePath.close()
      let triangleLayer = CAShapeLayer()
      triangleLayer.path = trianglePath.cgPath
      triangleLayer.fillColor = UIColor(
          red: 161.0/255,
          green: 166.0/255,
          blue: 168.0/255,
          alpha: 1.0
        ).cgColor
      bubble_label_arrow.layer.addSublayer(triangleLayer)
      thumb_bubble.addSubview(bubble_label)
      thumb_bubble.addSubview(bubble_label_arrow)
      thumb_bubble.bringSubviewToFront(bubble_label_arrow)
      thumb_bubble.bringSubviewToFront(bubble_label)
      bubble_label.text = "$"
        + numberFormatter.string(from: NSNumber(value: progress))!
      var previous_subviews = loaned.subviews
      previous_subviews.removeAll()
    }
    if (Double(progress) != p) {
      p = Double(progress)
      var a_min = Double()
      if (tenyr_indicator == 0) {
        // if (p*i*100 - floor(p*i*100) > 0.499999)
        //     && (p*i*100 - floor(p*i*100) < 0.5) {
        //   temp = (round(p*i*100 + 1) + 1)/100
        // } else {
        //   temp = (round(p*i*100) + 1)/100
        // }
        a_min = CR(x: p*i) + 0.01 //a_min_n
      } else {
        if (i != 0) {
          a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
          a_min += CT()
        } else {
          a_min = ceil(p/120*100)/100
        }
      }
      if (a_min >= a) {
        a = a_min
        a_reference = a_min
        shared_preferences.set(a, forKey: "pay_monthly")
        shared_preferences.synchronize()
        if (a - floor(a) == 0) {
          pay_number.text = numberFormatter.string(from: NSNumber(value: Int(
              a
            )))!
            + ".00"
        } else if ((a - floor(a))*100 < 9.99999) {
          pay_number.text = numberFormatter.string(from: NSNumber(value: Int(
              a
            )))!
            + ".0"
            + String(format: "%.0f", (a - floor(a))*100)
        } else {
          pay_number.text = numberFormatter.string(from: NSNumber(value: Int(
              a
            )))!
            + "."
            + String(format: "%.0f", (a - floor(a))*100)
        }
        minimum.isHidden = false
        minimum.text = "Minimum"
      } else {
        minimum.isHidden = false
        minimum.text = " "
      }
      Lengthsaving()
      shared_preferences.set(p, forKey: "loaned")
      shared_preferences.synchronize()
    } else { }
    view.willRemoveSubview(loaned)
  }

  @IBAction func Slider_Touch_Down(_ sender: UISlider) {
    bubble_label.isHidden = false
    bubble_label_arrow.isHidden = false
    UIView.animate(
      withDuration: 0.125,
      delay: 0.0,
      options: UIView.AnimationOptions.curveEaseOut,
      animations: {
        self.bubble_label.alpha = 1.0
        self.bubble_label_arrow.alpha = 1.0
      },
      completion: { (finished: Bool) -> Void in }
    )
  }

  @IBAction func Slider_Touch_Up(_ sender: UISlider) {
    UIView.animate(
      withDuration: 0.125,
      delay: 0.0,
      options: UIView.AnimationOptions.curveEaseOut,
      animations: {
        self.bubble_label.alpha = 0.0
        self.bubble_label_arrow.alpha = 0.0
      },
      completion: nil
    )
    bubble_label.isHidden = true
    bubble_label_arrow.isHidden = true
  }

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
    } else {
      i_reference = rates_reference[shared_preferences.integer(
          forKey: "position"
        )]
      i = 0
      apr_number.text = String(format: "%.2f", i * 12 * 100)
      apr_number_back.text = String(format: "%.2f", i * 12 * 100)
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
      self.table_view.alpha = 0.0
    }
    var a_min = Double()
    if (tenyr_indicator == 0) {
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   temp = (round(p*i*100 + 1) + 1)/100
      // } else {
      //   temp = (round(p*i*100) + 1)/100
      // }
      a_min = CR(x: p*i) + 0.01 //a_min_n
    } else {
      if (i != 0) {
        a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
        a_min += CT()
      } else {
        a_min = ceil(p/120*100)/100
      }
    }
    if (a_min >= a) {
      a = a_min
      a_reference = a_min
      shared_preferences.set(a, forKey: "pay_monthly")
      shared_preferences.synchronize()
      if (a - floor(a) == 0) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".00"
      } else if ((a - floor(a))*100 < 9.99999) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".0"
          + String(format: "%.0f", (a - floor(a))*100)
      } else {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + "."
          + String(format: "%.0f", (a - floor(a))*100)
      }
      minimum.isHidden = false
      minimum.text = "Minimum"
    } else {
      minimum.isHidden = false
      minimum.text = " "
    }
    Lengthsaving()
    shared_preferences.set(i * 12 * 100, forKey: "interest")
    shared_preferences.synchronize()
  }

  @IBAction func Interest_Rate_Unpressed(_ sender: UIButton) {
    interest_rate_unpressed_copy.isHidden = false
    interest_rate_pressed.isHidden = true
    edit_apr_text.isHidden = false
    edit_apr_text_back.isHidden = true
    invisible.isHidden = true
    invisible_back.isHidden = false
    table_view.alpha = 1.0
    table_view.frame = CGRect(
      x: table_view.frame.origin.x,
      y: table_view.frame.origin.y,
      width: table_view.frame.width,
      height: 0
    )
    UIView.animate(
      withDuration: 0.25,
      delay: 0.0,
      options: UIView.AnimationOptions.curveEaseOut,
      animations: {
        self.table_view.frame = CGRect(
          x: self.table_view.frame.origin.x,
          y: self.table_view.frame.origin.y,
          width: self.table_view.frame.width,
          height: 100
        )
      },
      completion: nil
    )
  }

  @IBAction func Interest_Rate_Unpressed_Copy(_ sender: UIButton) {
    var a_min = Double()
    if (tenyr_indicator == 0) {
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   temp = (round(p*i*100 + 1) + 1)/100
      // } else {
      //   temp = (round(p*i*100) + 1)/100
      // }
      a_min = CR(x: p*i) + 0.01 //a_min_n
    } else {
      if (i != 0) {
        a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
        a_min += CT()
      } else {
        a_min = ceil(p/120*100)/100
      }
    }
    if (a_min == a) {
      minimum.isHidden = false
    } else {
      minimum.isHidden = true
    }
    interest_rate_pressed_copy.isHidden = true
    interest_rate_unpressed.isHidden = false
    edit_apr_text.isHidden = false
    edit_apr_text_back.isHidden = true
    invisible.isHidden = false
    invisible_back.isHidden = true
    self.table_view.alpha = 0.0
  }

  @IBAction func Interest_Rate_Pressed(_ sender: UIButton) {
    interest_rate_unpressed.isHidden = true
    interest_rate_pressed.isHidden = false
    edit_apr_text.isHidden = true
    edit_apr_text_back.isHidden = false
  }

  @IBAction func Interest_Rate_Pressed_Copy(_ sender: UIButton) {
    interest_rate_unpressed_copy.isHidden = true
    interest_rate_pressed_copy.isHidden = false
    edit_apr_text.isHidden = true
    edit_apr_text_back.isHidden = false
  }

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return rates.count
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell: UITableViewCell! = self.table_view.dequeueReusableCell(
      withIdentifier: "cell"
    )
    cell.textLabel!.text = self.rates_text[(indexPath as NSIndexPath).row]
    cell.textLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
    cell.textLabel!.textColor = UIColor(
      red: 64.0/255,
      green: 73.0/255,
      blue: 77.0/255,
      alpha: 1.0
    )
    cell.indentationLevel = 2
    table_view.backgroundColor = UIColor.clear
    if (indexPath.row == 0) {
      cell.backgroundColor = UIColor(
        red: 161.0/255,
        green: 166.0/255,
        blue: 168.0/255,
        alpha: 1.0
      )
    } else {
      cell.backgroundColor = UIColor(
        red: 161.0/255,
        green: 166.0/255,
        blue: 168.0/255,
        alpha: 1.0
      )
      let custom_background = CAShapeLayer()
      custom_background.frame = cell.bounds
      custom_background.path = UIBezierPath(
          roundedRect: CGRect(
            x: 0,
            y: 0,
            width: table_view.frame.width,
            height: cell.frame.height
          ),
          byRoundingCorners: [.bottomLeft, .bottomRight],
          cornerRadii: CGSize(width: 5, height: 5)
        ).cgPath
      cell.layer.mask = custom_background
    }
    table_view.rowHeight = 48
    cell.layoutMargins = UIEdgeInsets.zero
    cell.selectionStyle = .none
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
    view.bringSubviewToFront(edit_apr) //or else edit_apr_shape starts out behind interest_rate_unpressed
    view.bringSubviewToFront(invisible)
    view.bringSubviewToFront(invisible_back)
    return cell
  }

  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    UIView.setAnimationsEnabled(false)
    CATransaction.begin()
    CATransaction.setCompletionBlock { () -> Void in //didn't want text to blink when changed
      UIView.setAnimationsEnabled(true)
    }
    table_view.reloadData() //fixes potential bug
    i = rates_reference[(indexPath as NSIndexPath).row]
    interest_rate_unpressed_copy.isHidden = true
    interest_rate_unpressed.isHidden = false
    invisible.isHidden = false
    invisible_back.isHidden = true
    apr_number.text = String(rates[(indexPath as NSIndexPath).row])
    apr_number_back.text = String(rates[(indexPath as NSIndexPath).row])
    var a_min = Double()
    if (tenyr_indicator == 0) {
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   temp = (round(p*i*100 + 1) + 1)/100
      // } else {
      //   temp = (round(p*i*100) + 1)/100
      // }
      a_min = CR(x: p*i) + 0.01 //a_min_n
    } else {
      if (i != 0) {
        a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
        a_min += CT()
      } else {
        a_min = ceil(p/120*100)/100
      }
    }
    if (a_min >= a) {
      a = a_min
      a_reference = a_min
      shared_preferences.set(a, forKey: "pay_monthly")
      shared_preferences.synchronize()
      if (a - floor(a) == 0) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".00"
      } else if ((a - floor(a))*100 < 9.99999) {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + ".0"
          + String(format: "%.0f", (a - floor(a))*100)
      } else {
        pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
          + "."
          + String(format: "%.0f", (a - floor(a))*100)
      }
      minimum.isHidden = false
      minimum.text = "Minimum"
    } else {
      minimum.isHidden = false
      minimum.text = " "
    }
    Lengthsaving()
    shared_preferences.set(i * 12 * 100, forKey: "interest")
    shared_preferences.set((indexPath as NSIndexPath).row, forKey: "position")
    shared_preferences.synchronize()
    CATransaction.commit()
    self.table_view.alpha = 0.0
  }

  @IBAction func Down_Start_Timer(_ sender: UIButton) {
    // prettier parser unable to parse this:
    timer1 = Timer.scheduledTimer(
      timeInterval: 0,
      target: self,
      selector: #selector(MyMainPage.Down),
      userInfo: nil,
      repeats: false
    )
    timer1 = Timer.scheduledTimer(
      timeInterval: 0.25,
      target: self,
      selector: #selector(MyMainPage.Down),
      userInfo: nil,
      repeats: true
    )
    // -------------------------------------
    down_unpressed.isHidden = true
    down_pressed.isHidden = false
  }

  @IBAction func Down_Stop_Timer(_ sender: UIButton) {
    timer1.invalidate()
    down_unpressed.isHidden = false
    down_pressed.isHidden = true
    timer_count = 0
    var a_min = Double()
    if (tenyr_indicator == 0) {
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   temp = (round(p*i*100 + 1) + 1)/100
      // } else {
      //   temp = (round(p*i*100) + 1)/100
      // }
      a_min = CR(x: p*i) + 0.01 //a_min_n
    } else {
      if (i != 0) {
        a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
        a_min += CT()
      } else {
        a_min = ceil(p/120*100)/100
      }
    }
    if (a == a_min) {
      minimum.isHidden = false
    } else {
      minimum.isHidden = true
    }
  }

  @objc func Down() {
    temp_down = down_button_increment
    if (timer_count < set_down_timer1_seconds*4) {
      if (timer_count > 0) {
        minimum.text = "↓ \(numberFormatter.string(from: NSNumber(value: temp_down))!)"
        minimum.isHidden = false
      }
    } else if (timer_count < set_down_timer2_seconds*4) {
      temp_down = set_down_timer1_increment
      minimum.text = "↓ \(numberFormatter.string(from: NSNumber(value: temp_down))!)"
    } else {
      temp_down = set_down_timer2_increment
      minimum.text = "↓ \(numberFormatter.string(from: NSNumber(value: temp_down))!)"
    }
    var a_min = Double()
    if (tenyr_indicator == 0) {
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   temp = (round(p*i*100 + 1) + 1)/100
      // } else {
      //   temp = (round(p*i*100) + 1)/100
      // }
      a_min = CR(x: p*i) + 0.01 //a_min_n
    } else {
      if (i != 0) {
        a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
        a_min += CT()
      } else {
        a_min = ceil(p/120*100)/100
      }
    }
    if (a == a_reference) && (a - floor(a) > 0) {
      //latter condition is in case ``a'' has no remainder, or else will get stuck in loop
      if (floor(a / down_button_increment)*down_button_increment <= a_min) {
        a = a_min
        a_reference = a_min
        if (a - floor(a) == 0) {
          pay_number.text = numberFormatter.string(from: NSNumber(value: Int(
              a
            )))!
            + ".00"
        } else if ((a - floor(a))*100 < 9.99999) {
          pay_number.text = numberFormatter.string(from: NSNumber(value: Int(
              a
            )))!
            + ".0"
            + String(format: "%.0f", (a - floor(a))*100)
        } else {
          pay_number.text = numberFormatter.string(from: NSNumber(value: Int(
              a
            )))!
            + "."
            + String(format: "%.0f", (a - floor(a))*100)
        }
        minimum.text = "Minimum"
      } else {
        a = floor(a / down_button_increment)*down_button_increment
        timer_count += 1
        pay_number.text = "\(numberFormatter.string(from: NSNumber(value: a))!)"
      }
    } else {
      if (a - temp_down <= a_min) {
        a = a_min
        a_reference = a_min
        if (a - floor(a) == 0) {
          pay_number.text = numberFormatter.string(from: NSNumber(value: Int(
              a
            )))!
            + ".00"
        } else if ((a - floor(a))*100 < 9.99999) {
          pay_number.text = numberFormatter.string(from: NSNumber(value: Int(
              a
            )))!
            + ".0"
            + String(format: "%.0f", (a - floor(a))*100)
        } else {
          pay_number.text = numberFormatter.string(from: NSNumber(value: Int(
              a
            )))!
            + "."
            + String(format: "%.0f", (a - floor(a))*100)
        }
        minimum.text = "Minimum"
      } else {
        a -= temp_down
        timer_count += 1
        pay_number.text = "\(numberFormatter.string(from: NSNumber(value: a))!)"
      }
    }
    Lengthsaving()
    shared_preferences.set(a, forKey: "pay_monthly")
    shared_preferences.synchronize()
  }

  @IBAction func Up_Start_Timer(_ sender: UIButton) {
    // prettier parser unable to parse this:
    timer2 = Timer.scheduledTimer(
      timeInterval: 0,
      target: self,
      selector: #selector(MyMainPage.Up),
      userInfo: nil,
      repeats: false
    )
    timer2 = Timer.scheduledTimer(
      timeInterval: 0.25,
      target: self,
      selector: #selector(MyMainPage.Up),
      userInfo: nil,
      repeats: true
    )
    // -------------------------------------
    up_unpressed.isHidden = true
    up_pressed.isHidden = false
  }

  @IBAction func Up_Stop_Timer(_ sender: UIButton) {
    timer2.invalidate()
    up_unpressed.isHidden = false
    up_pressed.isHidden = true
    timer_count = 0
    minimum.isHidden = true
  }

  @objc func Up() {
    minimum.isHidden = true
    temp_up = up_button_increment
    if (timer_count < set_up_timer1_seconds*4) {
      if (timer_count > 0) {
        minimum.text = "↑ \(numberFormatter.string(from: NSNumber(value: temp_up))!)"
        minimum.isHidden = false
      }
    } else if (timer_count < set_up_timer2_seconds*4) {
      temp_up = set_up_timer1_increment
      minimum.text = "↑ \(numberFormatter.string(from: NSNumber(value: temp_up))!)"
      minimum.isHidden = false
    } else {
      temp_up = set_up_timer2_increment
      minimum.text = "↑ \(numberFormatter.string(from: NSNumber(value: temp_up))!)"
      minimum.isHidden = false
    }
    if (a == a_reference) || (a - floor(a) > 0) {
      if (up_button_increment < a) {
        a = ceil(a / up_button_increment)*up_button_increment
        timer_count += 1
      } else if (a < up_button_increment) {
        a = up_button_increment
        timer_count += 1
      } else {
        a += temp_up
        timer_count += 1
      }
    } else {
      a += temp_up
      timer_count += 1
    }
    // var interest_owed = Double() //for interest, not pay
    // if (p*i*100 - floor(p*i*100) > 0.499999)
    //     && (p*i*100 - floor(p*i*100) < 0.5) {
    //   temp = (round(p*i*100 + 1))/100
    // } else {
    //   temp = (round(p*i*100))/100
    // }
    // interest_owed = CR(x: p*i)
    if (a > p + CR(x: p*i)) {
      minimum.text = "Overpaying!"
    }
    Lengthsaving()
    shared_preferences.set(a, forKey: "pay_monthly")
    shared_preferences.synchronize()
    pay_number.text = "\(numberFormatter.string(from: NSNumber(value: a))!)"
  }
    
  //instructions for calculating time and savings
  func Lengthsaving() {
    var B = [Double]()
    var B_min = [Double]()
    B.append(p) //monthly principal balance, =B_0
    //by default, all interest is paid, so there is no monthly outstanding interest
    B_min.append(p) // =B_0 for B_min
    var m = 1
    var m_min = 1
    var n = Int()
    var n_min = Int()
    // var interest_owed = Double() //by default, interest_paid = interest_owed
    // if (B*i*100 - floor(B*i*100) > 0.499999)
    //     && (B*i*100 - floor(B*i*100) < 0.5) {
    //   interest_owed = (round(B*i*100 + 1))/100
    // } else {
    //   interest_owed = (round(B*i*100))/100
    // }
    // interest_owed = CR(x: B[m-1]*i)
    // var interest_owed_min = Double() //by default, interest_paid_min = interest_owed_min
    // if (B_min*i*100
    //       - floor(B_min*i*100)
    //       > 0.499999)
    //     && (B_min*i*100
    //       - floor(B_min*i*100)
    //       < 0.5) {
    //   interest_owed_min = (round(B_min*i*100 + 1))/100
    // } else {
    //   interest_owed_min = (round(B_min*i*100))/100
    // }
    // interest_owed_min = CR(x: B_min[m_min-1]*i)
    var a_min = Double() //this one is for T_max
    if (tenyr_indicator == 0) {
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   a_min = (round(p*i*100 + 1) + 1)/100
      // } else {
      //   a_min = (round(p*i*100) + 1)/100
      // }
      a_min = CR(x: p*i) + 0.01 //a_min_n
    } else {
      if (i != 0) {
        a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
        a_min += CT()
      } else {
        a_min = ceil(p/120*100)/100
      }
    }
    // let temp_pay_first = temp_pay
    while ( B[m-1] - (a - CR(x: B[m-1]*i)) > 0 ) { //do
      B.append( B[m-1] - (a - CR(x: B[m-1]*i)) ) // =B_m
      // let temp_new3 = B*100 - floor(B*100)
      // if (temp_new3 > 0.499999) && (temp_new3 < 0.5) {
      //   B = round(B*100 + 1)/100
      // } else {
      //   B = round(B*100)/100
      // }
      B[m] = CR(x: B[m])
      // if (B*i*100 - floor(B*i*100) > 0.499999)
      //     && (B*i*100 - floor(B*i*100) < 0.5) {
      //   interest_owed = (round(B*i*100 + 1))/100
      // } else {
      //   interest_owed = (round(B*i*100))/100
      // }
      // interest_owed = CR(x: B[m]*i)
      m += 1
    }
    n = m
    while ( B_min[m_min-1] - (a_min - CR(x: B_min[m_min-1]*i) ) > 0 ) { //do
      B_min.append( B_min[m_min-1] - (a_min - CR(x: B_min[m_min-1]*i)) ) // =B_m for B_min
      // let temp_new4 = B_min*100
      //   - floor(B_min*100)
      // if (temp_new4 > 0.499999) && (temp_new4 < 0.5) {
      //   B_min = round(
      //       B_min*100 + 1
      //     )/100
      // } else {
      //   B_min = round(
      //       B_min*100
      //     )/100
      // }
      B_min[m_min] = CR(x: B_min[m_min])
      // if (B_min*i*100
      //       - floor(B_min*i*100)
      //       > 0.499999)
      //     && (B_min*i*100
      //       - floor(B_min*i*100)
      //       < 0.5) {
      //   interest_owed_min = (round(
      //       B_min*i*100 + 1
      //     ))/100
      // } else {
      //   interest_owed_min = (round(B_min*i*100))/100
      // }
      // interest_owed_min = CR(x: B_min[m_min]*i)
//      if (tenyr_indicator == 0) {
//        if (p*i*100 - floor(p*i*100) > 0.499999)
//            && (p*i*100 - floor(p*i*100) < 0.5) {
//          a_min = (round(p*i*100 + 1) + 1)/100
//        } else {
//          a_min = (round(p*i*100) + 1)/100
//        }
//      } else {
//        if (i != 0) {
//          a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
//          a_min += CT()
//        } else {
//          a_min = ceil(p/120*100)/100
//        }
//      }
      m_min += 1
    }
    n_min = m_min
    var l_y = Int()
    if (Double(n / 12) - floor(Double(n / 12)) > 0.99999) {
      l_y = Int(floor(Double(n / 12) + 1))
    } else {
      l_y = Int(floor(Double(n / 12)))
    }
    years.text = numberFormatter.string(from: NSNumber(value: l_y))!
    if (l_y == 1) {
      years_text.text = "year"
    } else {
      years_text.text = "years"
    }
    let l_m = n - 12 * l_y
    months.text = String(l_m)
    if (l_m == 1) {
      months_text.text = "month"
    } else {
      months_text.text = "months"
    }
    // if (B_min*i*100
    //       - floor(B_min*i*100)
    //       > 0.499999)
    //     && (B_min*i*100
    //       - floor(B_min*i*100)
    //       < 0.5) {
    //   interest_owed_min = (round(B_min*i*100 + 1))/100
    // } else {
    //   interest_owed_min = (round(B_min*i*100))/100
    // }
    // interest_owed_min = CR(x: B_min[n_min-1]*i)
    // let temp_interest_last_min = interest_owed_min
    // let total_repay_minimum_fromloop = Double(n_min-1) * a_min
    // let total_repay_minimum_finalmonth = remainingbalance_repay_minimum
    //   + temp_interest_last_min
    // if (B*i*100 - floor(B*i*100) > 0.499999)
    //     && (B*i*100 - floor(B*i*100) < 0.5) {
    //   interest_owed = (round(B*i*100 + 1))/100
    // } else {
    //   interest_owed = (round(B*i*100))/100
    // }
    // interest_owed = CR(x: B[n-1]*i)
    // let temp_interest_last_amount = interest_owed
    let a_f = B[n-1] + CR(x: B[n-1]*i)
    //B.append( B[n-1] - (a_f - CR(x: B[n-1]*i)) ) = 0
    //O.append(0.00)
    var T = Double(n-1) * a + a_f //T(a)
    T = CR(x: T)

    let a_f_min = B_min[n_min-1] + CR(x: B_min[n_min-1]*i)
    //B_min.append( B_min[n_min-1] - (a_f_min - CR(x: B_min[n_min-1]*i)) ) = 0
    //O_min.append(0.00)
    var T_max = Double(n_min-1)*a_min + a_f_min
    T_max = CR(x: T_max)

    var s_1 = shared_preferences.double(forKey: "savings_change_key") //T_max - T(a_1)
    var s_2 = T_max - T //T_max - T(a_2)
    // if (s_1 - floor(s_1) > 0.499999)
    //     && (s_1 - floor(s_1) < 0.5) {
    //   s_1 = (round(s_1 + 1)) // /100
    // } else {
    //   s_1 = round(s_1)
    // }
    s_1 = CR(x: s_1)
    s_2 = CR(x: s_2)
    var Δs = Double()
    if (s_2 <= 0) {
      savings.text = "$" + numberFormatter.string(from: 0)!
      Δs = 0-s_1
      if (Δs) < 0 {
        //rounding error is insignificant
        savings_change.text = "↓ $"
          + numberFormatter.string(from: NSNumber(value: CR(x: abs(Δs)/100)*100))!
      } else if (Δs) == 0 {
        savings_change.text = "no change"
      } else {
        savings_change.text = "↑ $"
          + numberFormatter.string(from: NSNumber(value: CR(x: (Δs)/100)*100))!
      }
    } else {
      // if (s_2 - floor(s_2) > 0.499999) && (s_2 - floor(s_2) < 0.5) {
      //   s_2 = (round(s_2 + 1)) // /100
      // } else {
      //   s_2 = round(s_2)
      // }
      savings.text = "$" + numberFormatter.string(from: NSNumber(value: CR(x: s_2/100)*100))!
      Δs = s_2-s_1
      if (Δs) < 0 {
        savings_change.text = "↓ $"
          + numberFormatter.string(from: NSNumber(value: CR(x: abs(Δs)/100)*100))!
      } else if (Δs) == 0 {
        savings_change.text = "no change"
      } else {
        savings_change.text = "↑ $"
          + numberFormatter.string(from: NSNumber(value: CR(x: (Δs)/100)*100))!
      }
    }
    shared_preferences.set(s_2, forKey: "savings_change_key") // s_2 will become s_1
    shared_preferences.synchronize()
  }

  override func viewDidLoad() {
    //what users see first, when app loads
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    abs10yr_shape.isHidden = true
    swipe_shape.isHidden = true
    delta.isHidden = true
    unlocked.alpha = 1.0
    absmin.alpha = 1.0
    absolute.alpha = 1.0
    linemin.alpha = 0.0625
    tenyrmin.alpha = 1.0
    tenyr.alpha = 1.0
    years.alpha = 1.0
    months.alpha = 1.0
    minimum.alpha = 1.0
    edit_slider_shape.alpha = 1.0
    edit_slider_shape.backgroundColor = UIColor.clear
    edit_apr_shape.alpha = 1.0
    edit_apr_shape.backgroundColor = UIColor.clear
    edit_pay_shape.alpha = 1.0
    edit_pay_shape.backgroundColor = UIColor.clear
      //reset frames, or else calayers won't conform to them
    edit_slider_shape.frame = CGRect(
      x: view.frame.origin.x+5,
      y: edit_slider_shape.frame.origin.y,
      width: view.frame.width-10,
      height: edit_slider_shape.frame.height
    )
    edit_apr_shape.frame = CGRect(
      x: view.frame.origin.x+5,
      y: edit_apr_shape.frame.origin.y,
      width: view.frame.width-10,
      height: edit_apr_shape.frame.height
    )
    edit_pay_shape.frame = CGRect(
      x: view.frame.origin.x+5,
      y: edit_pay_shape.frame.origin.y,
      width: view.frame.width-10,
      height: edit_pay_shape.frame.height
    )
    view.addSubview(stack_min)
    view.addSubview(stack_max)
    locked.isHidden = false
    swipe_note.isHidden = false
    swipe.isEnabled = false
    // keep the APR as is
    time_title.text = "Time"
    savings_title.text = "Savings"
    //don't change layout constraints
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
    swipe_note.text = "Swipe disabled."
    swipe_blink.isHidden = true
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
    edit_slider_shape.isHidden = true
    edit_apr_shape.isHidden = true
    edit_pay_shape.isHidden = true
    submit_changes.isHidden = true
    submit_changes_apr.isHidden = true
    submit_changes_pay.isHidden = true
    stack_inputs_timers_down.isHidden = true
    stack_inputs_timers_up.isHidden = true
    increment_input_left_label.isHidden = true
    increment_input.isHidden = true
    increment_input_right_label.isHidden = true
    input_number_of_increments.isHidden = true
    bare_track.isHidden = true
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
    down_timer1_seconds.isUserInteractionEnabled = false
    down_timer2_seconds.isUserInteractionEnabled = false
    down_timer1_increment.isUserInteractionEnabled = false
    down_timer2_increment.isUserInteractionEnabled = false
    up_timer1_seconds.isUserInteractionEnabled = false
    up_timer2_seconds.isUserInteractionEnabled = false
    up_timer1_increment.isUserInteractionEnabled = false
    up_timer2_increment.isUserInteractionEnabled = false
    submit_changes.adjustsImageWhenHighlighted = false
    submit_changes_apr.adjustsImageWhenHighlighted = false
    submit_changes_pay.adjustsImageWhenHighlighted = false
    swiping.adjustsImageWhenHighlighted = false
    stopped.adjustsImageWhenHighlighted = false
    absolute.adjustsImageWhenHighlighted = false
    tenyr.adjustsImageWhenHighlighted = false
    //calayer has awkward behavior for plus models, had to tweak code
    edit_slider_shape_tweak.bounds = edit_slider_shape.frame
    edit_slider_shape_tweak.position = edit_slider_shape.center
    edit_slider_shape_tweak.path = UIBezierPath(
        roundedRect: edit_slider_shape.bounds,
        byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    edit_slider_shape_tweak.fillColor = UIColor(
        red: 32/255.0,
        green: 36/255.0,
        blue: 38/255.0,
        alpha: 0.0
      ).cgColor
    edit_apr_shape_tweak.bounds = edit_apr_shape.frame
    edit_apr_shape_tweak.position = edit_apr_shape.center
    edit_apr_shape_tweak.path = UIBezierPath(
        roundedRect: edit_apr_shape.bounds,
        byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    edit_apr_shape_tweak.fillColor = UIColor(
        red: 32/255.0,
        green: 36/255.0,
        blue: 38/255.0,
        alpha: 0.0
      ).cgColor
    edit_apr_shape_tweak_trianglePath.move(to: CGPoint(x: 0, y: 0))
    edit_apr_shape_tweak_trianglePath.addLine(to: CGPoint(x: 17, y: 0))
    edit_apr_shape_tweak_trianglePath.addLine(to: CGPoint(x: 8.5, y: 12))
    edit_apr_shape_tweak_trianglePath.close()
    edit_apr_shape_tweak_triangleLayer.path = edit_apr_shape_tweak_trianglePath.cgPath
    let CGPoint_xtemp = ((edit_apr_shape.frame.width-interest_rate_unpressed.frame.width)/2)+(0.75*interest_rate_unpressed.frame.width-8.5)
    let CGPoint_ytemp1 = (edit_apr_shape.frame.height-interest_rate_unpressed.frame.height-10)
    let CGPoint_ytemp2 = (interest_rate_unpressed.frame.height/2-6)
    edit_apr_shape_tweak_triangleLayer.position = CGPoint(
      x: CGPoint_xtemp,
      y: CGPoint_ytemp1 + CGPoint_ytemp2
    )
    edit_apr_shape_tweak_triangleLayer.fillColor = UIColor.clear.cgColor
    edit_apr_shape_tweak_triangleLayer.borderWidth = 0.25
    edit_pay_shape_tweak.bounds = edit_pay_shape.frame
    edit_pay_shape_tweak.position = edit_pay_shape.center
    edit_pay_shape_tweak.path = UIBezierPath(
        roundedRect: edit_pay_shape.bounds,
        byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    edit_pay_shape_tweak.fillColor = UIColor(
        red: 32/255.0,
        green: 36/255.0,
        blue: 38/255.0,
        alpha: 0.0
      ).cgColor
    interest_rate_unpressed_outline.frame = CGRect(
      x: (edit_apr_shape.frame.width-interest_rate_unpressed.frame.width)/2,
      y: edit_apr_shape.frame.height-interest_rate_unpressed.frame.height-10,
      width: interest_rate_unpressed.frame.width,
      height: interest_rate_unpressed.frame.height
    )
    interest_rate_unpressed_outline.fillColor = UIColor.clear.cgColor
    interest_rate_unpressed_outline.borderWidth = 0.25
    interest_rate_unpressed_outline.cornerRadius = 5
    switch_outline.frame = CGRect(
      x: edit_apr_shape.frame.width/2+2,
      y: 10,
      width: apr.frame.width,
      height: apr.frame.height
    )
    switch_outline.fillColor = UIColor.clear.cgColor
    switch_outline.borderWidth = 0.25
    switch_outline.cornerRadius = apr.frame.height/2
    switch_thumb_outline.frame = CGRect(
      x: edit_apr_shape.frame.width/2+apr.frame.width/2-2,
      y: 10+2,
      width: apr.frame.height-3,
      height: apr.frame.height-4
    )
    switch_thumb_outline.fillColor = UIColor.clear.cgColor
    switch_thumb_outline.borderWidth = 0.25
    switch_thumb_outline.cornerRadius = apr.frame.height/2
    let CGRect_xtemp = (edit_pay_shape.frame.width)/2-down_unpressed.frame.width-(pay_monthly_box.frame.width)/2+5
    let CGRect_ytemp = edit_pay_shape.frame.height
      - 65
      - down_unpressed.frame.height-1
    down_outline.frame = CGRect(
      x: CGRect_xtemp,
      y: CGRect_ytemp,
      width: down_unpressed.frame.width,
      height: down_unpressed.frame.height
    )
    down_outline.fillColor = UIColor.clear.cgColor
    down_outline.borderWidth = 0.25
    down_outline.cornerRadius = 5
    pay_outline.frame = CGRect(
      x: (edit_pay_shape.frame.width-down_unpressed.frame.width*2-pay_monthly_box.frame.width)/2+down_unpressed.frame.width,
      y: edit_pay_shape.frame.height - 65 - up_unpressed.frame.height,
      width: pay_monthly_box.frame.width,
      height: pay_monthly_box.frame.height
    )
    pay_outline.fillColor = UIColor.clear.cgColor
    pay_outline.borderWidth = 0.25
    let CGRect_xtemp2pre = (edit_pay_shape.frame.width)/2-up_unpressed.frame.width-(pay_monthly_box.frame.width)/2
    let CGRect_xtemp2 = CGRect_xtemp2pre+down_unpressed.frame.width+pay_monthly_box.frame.width-5
    let CGRect_ytemp2 = edit_pay_shape.frame.height
      - 65
      - up_unpressed.frame.height-1
    up_outline.frame = CGRect(
      x: CGRect_xtemp2,
      y: CGRect_ytemp2,
      width: up_unpressed.frame.width,
      height: up_unpressed.frame.height
    )
    up_outline.fillColor = UIColor.clear.cgColor
    up_outline.borderWidth = 0.25
    up_outline.cornerRadius = 5
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
    interest_rate_unpressed_outline.borderColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
    down_outline.borderColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
    pay_outline.borderColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
    up_outline.borderColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
    edit_apr_shape_tweak_triangleLayer.strokeColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
    switch_outline.borderColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
    switch_thumb_outline.borderColor = UIColor(
        red: 235.0/255,
        green: 235.0/255,
        blue: 255.0/255,
        alpha: 0.0
      ).cgColor
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
    edit_apr_text_back.isHidden = true
    numberFormatter.usesGroupingSeparator = true
    numberFormatter.groupingSeparator = ","
    numberFormatter.groupingSize = 3
    loaned_min_input.text = numberFormatter.string(from: NSNumber(
        value: p_min
      ))!
    loaned_max_input.text = numberFormatter.string(from: NSNumber(
        value: p_max
      ))!
    apr_number.text = String(format: "%.2f", i * 12 * 100)
    apr_number_back.text = String(format: "%.2f", i * 12 * 100)
    shared_preferences.set(p, forKey: "loaned")
    shared_preferences.set(i * 12 * 100, forKey: "interest")
    shared_preferences.synchronize()
    var a_min = Double()
    if (tenyr_indicator == 0) {
        absolute.setImage(UIImage(named: "Submit"), for: .normal)
        tenyr.setImage(UIImage(named: "Off"), for: .normal)
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   temp = (round(p*i*100 + 1) + 1)/100
      // } else {
      //   temp = (round(p*i*100) + 1)/100
      // }
      a_min = CR(x: p*i) + 0.01 //a_min_n
    } else {
        absolute.setImage(UIImage(named: "Off"), for: .normal)
        tenyr.setImage(UIImage(named: "Submit"), for: .normal)
      if (i != 0) {
        a_min = ceil((p*i*pow(1+i, 120)) / (pow(1+i, 120) - 1)*100)/100
        a_min += CT()
      } else {
        a_min = ceil(p/120*100)/100
      }
    }
    a = a_min
    a_reference = a_min
    shared_preferences.set(a, forKey: "pay_monthly")
    shared_preferences.set(tenyr_indicator, forKey: "tenyr")
    shared_preferences.synchronize()
    if (a - floor(a) == 0) {
      pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
        + ".00"
    } else if ((a - floor(a))*100 < 9.99999) {
      pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
        + ".0"
        + String(format: "%.0f", (a - floor(a))*100)
    } else {
      pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))!
        + "."
        + String(format: "%.0f", (a - floor(a))*100)
    }
    Lengthsaving()
    self.table_view.register(
      UITableViewCell.self,
      forCellReuseIdentifier: "cell"
    )
    table_view.delegate = self
    table_view.dataSource = self
    table_view.alpha = 0.0
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
    self.table_view.separatorColor = UIColor(
      red: 151.0/255,
      green: 156.0/255,
      blue: 158.0/255,
      alpha: 1.0
    )
    apr.layer.cornerRadius = 16
    interest_rate_disabled.isHidden = true
    //leave extra room around image that is background color, or else inset (though it should be zero) will be color of foreground
    loaned.setMinimumTrackImage(
      UIImage(named: "MinTrack")!.resizableImage(
        withCapInsets: .zero,
        resizingMode: .tile
      ),
      for: .normal
    )
    loaned.setMaximumTrackImage(
      UIImage(named: "MaxTrack")!.resizableImage(
        withCapInsets: .zero,
        resizingMode: .tile
      ),
      for: .normal
    )
    if (ΔN - floor(ΔN) != 0) {
      loaned.isHidden = true
      Edit_Slider_Expand(nil)
    } else { }
    //interest_rate_unpressed
    let interest_rate_unpressed_center = CAShapeLayer()
    interest_rate_unpressed_center.bounds = interest_rate_unpressed.frame
    interest_rate_unpressed_center.position = interest_rate_unpressed.center
    interest_rate_unpressed_center.path = UIBezierPath(
        roundedRect: interest_rate_unpressed.bounds,
        byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    interest_rate_unpressed.layer.addSublayer(interest_rate_unpressed_center)
    interest_rate_unpressed_center.fillColor = UIColor(
        red: 68.0/255,
        green: 77.0/255,
        blue: 82.0/255,
        alpha: 1.0
      ).cgColor
    let interest_rate_unpressed_trianglePath = UIBezierPath()
    interest_rate_unpressed_trianglePath.move(to: CGPoint(x: 0, y: 0))
    interest_rate_unpressed_trianglePath.addLine(to: CGPoint(x: 17, y: 0))
    interest_rate_unpressed_trianglePath.addLine(to: CGPoint(x: 8.5, y: 12))
    interest_rate_unpressed_trianglePath.close()
    let interest_rate_unpressed_triangleLayer = CAShapeLayer()
    interest_rate_unpressed_triangleLayer.path = interest_rate_unpressed_trianglePath.cgPath
    interest_rate_unpressed_triangleLayer.position = CGPoint(
      x: 0.75*interest_rate_unpressed.frame.width-8.5,
      y: interest_rate_unpressed.frame.height/2-6
    )
    interest_rate_unpressed_triangleLayer.fillColor = UIColor(
        red: 161.0/255,
        green: 166.0/255,
        blue: 168.0/255,
        alpha: 1.0
      ).cgColor
    interest_rate_unpressed.layer.addSublayer(
      interest_rate_unpressed_triangleLayer
    )
    interest_rate_unpressed.titleEdgeInsets = UIEdgeInsets(
      top: 0.0,
      left: 0.25*interest_rate_unpressed.frame.width,
      bottom: 0.0,
      right: 0.0
    )
    interest_rate_unpressed.layer.shadowColor = UIColor.black.cgColor
    interest_rate_unpressed.layer.shadowOffset = CGSize(width: 0, height: 1)
    interest_rate_unpressed.layer.shadowOpacity = 0.25
    interest_rate_unpressed.layer.shadowRadius = 1
    //interest_rate_pressed
    let interest_rate_pressed_center = CAShapeLayer()
    interest_rate_pressed_center.bounds = interest_rate_pressed.frame
    interest_rate_pressed_center.position = interest_rate_pressed.center
    interest_rate_pressed_center.path = UIBezierPath(
        roundedRect: interest_rate_pressed.bounds,
        byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    interest_rate_pressed.layer.addSublayer(interest_rate_pressed_center)
    interest_rate_pressed_center.fillColor = UIColor(
        red: 68.0/255,
        green: 77.0/255,
        blue: 82.0/255,
        alpha: 1.0
      ).cgColor
    let arrow_pressed_trianglePath = UIBezierPath()
    arrow_pressed_trianglePath.move(to: CGPoint(x: 0, y: 0))
    arrow_pressed_trianglePath.addLine(to: CGPoint(x: 17, y: 0))
    arrow_pressed_trianglePath.addLine(to: CGPoint(x: 8.5, y: 12))
    arrow_pressed_trianglePath.close()
    let arrow_pressed_triangleLayer = CAShapeLayer()
    arrow_pressed_triangleLayer.path = arrow_pressed_trianglePath.cgPath
    arrow_pressed_triangleLayer.position = CGPoint(
      x: 0.75*interest_rate_pressed.frame.width-8.5,
      y: interest_rate_pressed.frame.height/2-6
    )
    arrow_pressed_triangleLayer.fillColor = UIColor(
        red: 161.0/255,
        green: 166.0/255,
        blue: 168.0/255,
        alpha: 1.0
      ).cgColor
    interest_rate_pressed.layer.addSublayer(arrow_pressed_triangleLayer)
    interest_rate_pressed.titleEdgeInsets = UIEdgeInsets(
      top: 0,
      left: 0.25*interest_rate_pressed.frame.width,
      bottom: 0.0,
      right: 0.0
    )
    interest_rate_pressed.layer.shadowColor = UIColor.black.cgColor
    interest_rate_pressed.layer.shadowOffset = CGSize(width: 0, height: 0.5)
    interest_rate_pressed.layer.shadowOpacity = 0.0625
    interest_rate_pressed.layer.shadowRadius = 0
    //interest_rate_unpressed_copy
    let interest_rate_unpressed_copy_center = CAShapeLayer()
    interest_rate_unpressed_copy_center.bounds = interest_rate_unpressed_copy.frame
    interest_rate_unpressed_copy_center.position = interest_rate_unpressed_copy.center
    interest_rate_unpressed_copy_center.path = UIBezierPath(
        roundedRect: interest_rate_unpressed_copy.bounds,
        byRoundingCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    interest_rate_unpressed_copy.layer.addSublayer(
      interest_rate_unpressed_copy_center
    )
    interest_rate_unpressed_copy_center.fillColor = UIColor(
        red: 68.0/255,
        green: 77.0/255,
        blue: 82.0/255,
        alpha: 1.0
      ).cgColor
    let interest_rate_unpressed_copy_trianglePath = UIBezierPath()
    interest_rate_unpressed_copy_trianglePath.move(to: CGPoint(x: 17, y: 12))
    interest_rate_unpressed_copy_trianglePath.addLine(to: CGPoint(x: 8.5, y: 0))
    interest_rate_unpressed_copy_trianglePath.addLine(to: CGPoint(x: 0, y: 12))
    interest_rate_unpressed_copy_trianglePath.close()
    let interest_rate_unpressed_copy_triangleLayer = CAShapeLayer()
    interest_rate_unpressed_copy_triangleLayer.path = interest_rate_unpressed_copy_trianglePath.cgPath
    interest_rate_unpressed_copy_triangleLayer.position = CGPoint(
      x: 0.75*interest_rate_unpressed_copy.frame.width-8.5,
      y: interest_rate_unpressed_copy.frame.height/2-6
    )
    interest_rate_unpressed_copy_triangleLayer.fillColor = UIColor(
        red: 161.0/255,
        green: 166.0/255,
        blue: 168.0/255,
        alpha: 1.0
      ).cgColor
    interest_rate_unpressed_copy.layer.addSublayer(
      interest_rate_unpressed_copy_triangleLayer
    )
    interest_rate_unpressed_copy.titleEdgeInsets = UIEdgeInsets(
      top: 0.0,
      left: 0.25*interest_rate_unpressed_copy.frame.width,
      bottom: 0.0,
      right: 0.0
    )
    interest_rate_unpressed_copy.layer.shadowColor = UIColor.black.cgColor
    interest_rate_unpressed_copy.layer.shadowOffset = CGSize(
      width: 0,
      height: 1
    )
    interest_rate_unpressed_copy.layer.shadowOpacity = 0.25
    interest_rate_unpressed_copy.layer.shadowRadius = 1
    //interest_rate_pressed_copy
    let interest_rate_pressed_copy_center = CAShapeLayer()
    interest_rate_pressed_copy_center.bounds = interest_rate_pressed_copy.frame
    interest_rate_pressed_copy_center.position = interest_rate_pressed_copy.center
    interest_rate_pressed_copy_center.path = UIBezierPath(
        roundedRect: interest_rate_pressed_copy.bounds,
        byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    interest_rate_pressed_copy.layer.addSublayer(
      interest_rate_pressed_copy_center
    )
    interest_rate_pressed_copy_center.fillColor = UIColor(
        red: 68.0/255,
        green: 77.0/255,
        blue: 82.0/255,
        alpha: 1.0
      ).cgColor
    let arrow_pressed_copy_trianglePath = UIBezierPath()
    arrow_pressed_copy_trianglePath.move(to: CGPoint(x: 17, y: 12))
    arrow_pressed_copy_trianglePath.addLine(to: CGPoint(x: 8.5, y: 0))
    arrow_pressed_copy_trianglePath.addLine(to: CGPoint(x: 0, y: 12))
    arrow_pressed_copy_trianglePath.close()
    let arrow_pressed_copy_triangleLayer = CAShapeLayer()
    arrow_pressed_copy_triangleLayer.path = arrow_pressed_copy_trianglePath.cgPath
    arrow_pressed_copy_triangleLayer.position = CGPoint(
      x: 0.75*interest_rate_pressed_copy.frame.width-8.5,
      y: interest_rate_pressed_copy.frame.height/2-6
    )
    arrow_pressed_copy_triangleLayer.fillColor = UIColor(
        red: 161.0/255,
        green: 166.0/255,
        blue: 168.0/255,
        alpha: 1.0
      ).cgColor
    interest_rate_pressed_copy.layer.addSublayer(
      arrow_pressed_copy_triangleLayer
    )
    interest_rate_pressed_copy.titleEdgeInsets = UIEdgeInsets(
      top: 0.0,
      left: 0.25*interest_rate_pressed_copy.frame.width,
      bottom: 0.0,
      right: 0.0
    )
    interest_rate_pressed_copy.layer.shadowColor = UIColor.black.cgColor
    interest_rate_pressed_copy.layer.shadowOffset = CGSize(
      width: 0,
      height: 0.5
    )
    interest_rate_pressed_copy.layer.shadowOpacity = 0.0625
    interest_rate_pressed_copy.layer.shadowRadius = 0
    //interest_rate_disabled
    let interest_rate_disabled_center = CAShapeLayer()
    interest_rate_disabled_center.bounds = interest_rate_disabled.frame
    interest_rate_disabled_center.position = interest_rate_disabled.center
    interest_rate_disabled_center.path = UIBezierPath(
        roundedRect: interest_rate_disabled.bounds,
        byRoundingCorners: [.bottomLeft, .topLeft, .bottomRight, .topRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    interest_rate_disabled.layer.addSublayer(interest_rate_disabled_center)
    interest_rate_disabled_center.fillColor = UIColor(
        red: 68.0/255,
        green: 77.0/255,
        blue: 82.0/255,
        alpha: 1.0
      ).cgColor
    let interest_rate_disabled_trianglePath = UIBezierPath()
    interest_rate_disabled_trianglePath.move(to: CGPoint(x: 0, y: 0))
    interest_rate_disabled_trianglePath.addLine(to: CGPoint(x: 17, y: 0))
    interest_rate_disabled_trianglePath.addLine(to: CGPoint(x: 8.5, y: 12))
    interest_rate_disabled_trianglePath.close()
    let interest_rate_disabled_triangleLayer = CAShapeLayer()
    interest_rate_disabled_triangleLayer.path = interest_rate_disabled_trianglePath.cgPath
    interest_rate_disabled_triangleLayer.position = CGPoint(
      x: 0.75*interest_rate_disabled.frame.width-8.5,
      y: interest_rate_disabled.frame.height/2-6
    )
    interest_rate_disabled_triangleLayer.fillColor = UIColor(
        red: 161.0/255,
        green: 166.0/255,
        blue: 168.0/255,
        alpha: 1.0
      ).cgColor
    interest_rate_disabled.layer.addSublayer(
      interest_rate_disabled_triangleLayer
    )
    interest_rate_disabled.titleEdgeInsets = UIEdgeInsets(
      top: 0.0,
      left: 0.25*interest_rate_disabled.frame.width,
      bottom: 0.0,
      right: 0.0
    )
    interest_rate_disabled.layer.shadowColor = UIColor.black.cgColor
    interest_rate_disabled.layer.shadowOffset = CGSize(width: 0, height: 1)
    interest_rate_disabled.layer.shadowOpacity = 0.0625
    interest_rate_disabled.layer.shadowRadius = 1
    //pay
    let down_unpressed_center = CAShapeLayer()
    down_unpressed_center.bounds = down_unpressed.frame
    down_unpressed_center.position = down_unpressed.center
    down_unpressed_center.path = UIBezierPath(
        roundedRect: down_unpressed.bounds,
        byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    down_unpressed.layer.addSublayer(down_unpressed_center)
    down_unpressed_center.fillColor = UIColor(
        red: 68.0/255,
        green: 77.0/255,
        blue: 82.0/255,
        alpha: 1.0
      ).cgColor
    down_unpressed.layer.shadowColor = UIColor.black.cgColor
    down_unpressed.layer.shadowOffset = CGSize(width: 0, height: 1)
    down_unpressed.layer.shadowOpacity = 0.25
    down_unpressed.layer.shadowRadius = 1
    let down_pressed_center = CAShapeLayer()
    down_pressed_center.bounds = down_pressed.frame
    down_pressed_center.position = down_pressed.center
    down_pressed_center.path = UIBezierPath(
        roundedRect: down_pressed.bounds,
        byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    down_pressed.layer.addSublayer(down_pressed_center)
    down_pressed_center.fillColor = UIColor(
        red: 68.0/255,
        green: 77.0/255,
        blue: 82.0/255,
        alpha: 1.0
      ).cgColor
    down_pressed.layer.shadowColor = UIColor.black.cgColor
    down_pressed.layer.shadowOffset = CGSize(width: 0, height: 1)
    down_pressed.layer.shadowOpacity = 0.0625
    down_pressed.layer.shadowRadius = 1
    let up_unpressed_center = CAShapeLayer()
    up_unpressed_center.bounds = up_unpressed.frame
    up_unpressed_center.position = up_unpressed.center
    up_unpressed_center.path = UIBezierPath(
        roundedRect: up_unpressed.bounds,
        byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    up_unpressed.layer.addSublayer(up_unpressed_center)
    up_unpressed_center.fillColor = UIColor(
        red: 68.0/255,
        green: 77.0/255,
        blue: 82.0/255,
        alpha: 1.0
      ).cgColor
    up_unpressed.layer.shadowColor = UIColor.black.cgColor
    up_unpressed.layer.shadowOffset = CGSize(width: 0, height: 1)
    up_unpressed.layer.shadowOpacity = 0.25
    up_unpressed.layer.shadowRadius = 1
    let up_pressed_center = CAShapeLayer()
    up_pressed_center.bounds = up_pressed.frame
    up_pressed_center.position = up_pressed.center
    up_pressed_center.path = UIBezierPath(
        roundedRect: up_pressed.bounds,
        byRoundingCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    up_pressed.layer.addSublayer(up_pressed_center)
    up_pressed_center.fillColor = UIColor(
        red: 68.0/255,
        green: 77.0/255,
        blue: 82.0/255,
        alpha: 1.0
      ).cgColor
    up_pressed.layer.shadowColor = UIColor.black.cgColor
    up_pressed.layer.shadowOffset = CGSize(width: 0, height: 1)
    up_pressed.layer.shadowOpacity = 0.0625
    up_pressed.layer.shadowRadius = 1
    shared_preferences.set(0.00, forKey: "savings_change_key")
    shared_preferences.synchronize()
    bubble_label.alpha = 0.0
    bubble_label_arrow.alpha = 0.0
    bubble_label.isHidden = true
    bubble_label_arrow.isHidden = true
    table_view.frame = CGRect(
      x: self.table_view.frame.origin.x,
      y: self.table_view.frame.origin.y,
      width: self.table_view.frame.width,
      height: 0
    )
    //check compatibility
    let messageVC = UIAlertController(
      title: "Caution",
      message: "Your device is incompatible!",
      preferredStyle: .alert
    )
    let proceedAction = UIAlertAction(title: "Proceed", style: .default)
    messageVC.addAction(proceedAction)
    if (UIDevice.current.userInterfaceIdiom == .phone) {
      if (view.frame.height > 568) { } else {
        present(messageVC, animated: true)
      }
    } else {
      present(messageVC, animated: true)
    }
    //myAVPlayerViewController
    DispatchQueue.main.async {
      self.performSegue(
        withIdentifier: "myAVPlayerViewController",
        sender: self
      )
    }
    
  }
    
}
