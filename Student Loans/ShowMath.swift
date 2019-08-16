//
//  ShowMath.swift
//  Student Loans
//
//  Created by Ed Silkworth on 10/9/15.
//  Copyright © 2015-2019 Ed Silkworth. All rights reserved.
//

import UIKit

class ShowMath: UIViewController {

  @IBOutlet weak  var loaned: UILabel!
  @IBOutlet weak  var stack1_trailing: NSLayoutConstraint!
  @IBOutlet weak  var stack1_leading: NSLayoutConstraint!
  @IBOutlet weak  var aprstack_width: NSLayoutConstraint!
  @IBOutlet weak  var add_width: NSLayoutConstraint!
  @IBOutlet weak  var subtract_width: NSLayoutConstraint!
  @IBOutlet weak  var equals_width: NSLayoutConstraint!
  @IBOutlet weak  var nominal_rate: UILabel!
  @IBOutlet weak  var pay_monthly: UILabel!
  @IBOutlet weak  var titleof_compound: UILabel!
  @IBOutlet weak  var APR_compound_stack: UIStackView!
  @IBOutlet weak  var APR_stack: UIStackView!
  @IBOutlet weak  var compound_stack: UIStackView!
  @IBOutlet weak  var compound: UISwitch!
  @IBOutlet weak  var pay_insight_header: UIButton!
  @IBOutlet weak  var pay_insight: UIButton!
  @IBOutlet weak  var monthly_balance: UILabel!
  @IBOutlet weak  var table: UIStackView!
  @IBOutlet weak  var table_header: UIStackView!
  @IBOutlet weak  var table_height: NSLayoutConstraint!
  @IBOutlet weak  var balance_header: UITextView!
  @IBOutlet weak  var balance: UITextView!
  @IBOutlet weak  var add: UITextView!
  @IBOutlet weak  var interest_header: UITextView!
  @IBOutlet weak  var charged_interest: UITextView!
  @IBOutlet weak  var subtract: UITextView!
  @IBOutlet weak  var payment_header: UIButton!
  @IBOutlet weak  var payment: UIButton!
  @IBOutlet weak  var enlarge: UIButton!
  @IBOutlet weak  var shrink: UIButton!
  @IBOutlet weak  var equals: UITextView!
  @IBOutlet weak  var remaining: UITextView!
  @IBOutlet weak  var note_view: UIStackView!
  @IBOutlet weak  var refund: UILabel!
  @IBOutlet weak  var coffee_cup: UILabel!
  @IBOutlet weak  var note: UITextView!
  @IBOutlet weak  var note_overlap: UITextView!
  @IBOutlet weak  var note_constraint: NSLayoutConstraint!
  @IBOutlet weak  var note_right: UITextView!
  @IBOutlet weak  var years: UILabel!
  @IBOutlet weak  var months: UILabel!
  @IBOutlet weak  var total_paid: UILabel!
  @IBOutlet weak  var total_paid_min: UILabel!
  @IBOutlet weak  var savings: UILabel!
  @IBOutlet weak  var stack1: UIStackView!
  @IBOutlet weak  var stack2: UIStackView!
  @IBOutlet weak  var bottom_layout_guide: NSLayoutConstraint!
  @IBOutlet weak  var stack3: UIStackView!
  @IBOutlet weak  var headers: UIStackView!
  @IBOutlet weak  var proportion: UIStackView!
  @IBOutlet weak  var percent_interest: UILabel!
  @IBOutlet weak  var slider: UISlider!
  @IBOutlet weak  var percent_balance: UILabel!
  @IBOutlet weak  var plus_sign: UIImageView!
  @IBOutlet weak  var minus_sign: UIImageView!
  @IBOutlet weak  var equals_sign: UIImageView!
  @IBOutlet weak  var time_label: UILabel!
  @IBOutlet weak  var savings_label: UILabel!
  @IBOutlet weak  var line: UIImageView!

  var increment = Double()
  var max_percent_interest = 100.0
  var progress = 100.0
  var α = Double()
  var p = Double()
  var r = Double()
  var i = Double()
  var a = Double()
  var tenyr_indicator = Double()
  var attributedPayTitle = NSMutableAttributedString()
  var attributedPaySummary = NSMutableAttributedString()
  var insight = 0 //1 if insight bubble open, 0 if not
  var blinked = Int()
  internal var numberFormatter: NumberFormatter = NumberFormatter()

  let shared_preferences: UserDefaults = UserDefaults.standard
  let balance_shape = CAShapeLayer() //renamed principal..., in app
  let balance_shape_label = UILabel() //renamed principal..., in app
  let add_label = UILabel()
  let charged_interest_shape = CAShapeLayer()
  let charged_interest_shape_label = UILabel()
  let subtract_label = UILabel()
  let payment_shape = CAShapeLayer()
  let payment_shape_label = UILabel()
  let payment_header_shape = CAShapeLayer()
  let equals_label = UILabel()
  let remaining_label = UILabel()
  let pay_insight_shape = CAShapeLayer()
  let pay_insight_shape_label = UILabel()
  let pay_insight_header_shape = CAShapeLayer()

  //dark area behind monthly balance table
  @IBOutlet weak  var insight_shape: UIView!
    
  internal var test_array = [Double]()

  @IBAction func Switch(_ sender: UISwitch) {
    if compound.isOn {
      r = i*12*100/100 // i*12*100 is for reverting to APR(%)
      i = pow(1 + r/365.25, 365.25/12) - 1 //approximate
      var a_min = Double()
      if (tenyr_indicator == 0) {
        // if (α*(p*i)*100 - floor(α*(p*i)*100) > 0.499999)
        //     && (α*(p*i)*100 - floor(α*(p*i)*100) < 0.5) {
        //   temp = (round(α*(p*i)*100 + 1) + 1)/100
        // } else {
        //   temp = (round(α*(p*i)*100) + 1)/100
        // }
        a_min = CR(x: α*(p*i)) + 1/100
      } else {
        if (i != 0) {
          a_min = ceil(
              (α*(p*i)*pow(1+α*i, 120))
                / (pow(1+α*i, 120) - 1)*100
            )/100
          a_min += CT()
        } else {
          a_min = ceil(p/120*100)/100
        }
      }
      if (a_min >= a) {
        a = a_min
      } else { }
    } else {
      r = shared_preferences.double(forKey: "interest")/100
      i = r
        / 12 //need to convert to periodic rate in decimal form
//      a = shared_preferences.double(forKey: "pay_monthly")
    }
    var attributedPercentInterestTitle = NSMutableAttributedString()
    attributedPercentInterestTitle = NSMutableAttributedString(
      string: "Interest",
      attributes: [
        NSAttributedString.Key.font: UIFont(
          name: "CMUSerif-Roman",
          size: 16.0
        )!,
        NSAttributedString.Key.foregroundColor: UIColor.black
      ]
    )
    let attributedPercentInterestSpace = NSMutableAttributedString(
      string: " \n",
      attributes: [
        NSAttributedString.Key.font: UIFont(name: "CMUSerif-Roman", size: 3.0)!
      ]
    )
    let attributedPercentBalanceTitle = NSMutableAttributedString(
      string: "Later",
      attributes: [
        NSAttributedString.Key.font: UIFont(
          name: "CMUSerif-Roman",
          size: 16.0
        )!,
        NSAttributedString.Key.foregroundColor: UIColor.black
      ]
    )
    let attributedPercentBalanceSpace = NSMutableAttributedString(
      string: " \n",
      attributes: [
        NSAttributedString.Key.font: UIFont(name: "CMUSerif-Roman", size: 3.0)!
      ]
    )
    var attributedPercentInterest = NSMutableAttributedString()
    var attributedPercentBalance = NSMutableAttributedString()
    attributedPercentInterest = NSMutableAttributedString(
      string: String(format: "%.0f", α*100) + "%",
      attributes: [
        NSAttributedString.Key.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!
      ]
    )
    attributedPercentBalance = NSMutableAttributedString(
      string: String(format: "%.0f", 100 - α*100) + "%",
      attributes: [
        NSAttributedString.Key.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!
      ]
    )
    attributedPercentInterest.append(attributedPercentInterestSpace)
    attributedPercentInterest.append(attributedPercentInterestTitle)
    percent_interest.attributedText = attributedPercentInterest
    attributedPercentBalance.append(attributedPercentBalanceSpace)
    attributedPercentBalance.append(attributedPercentBalanceTitle)
    percent_balance.attributedText = attributedPercentBalance
    if (insight == 1) {
      payment_header_shape.path = UIBezierPath(
          roundedRect: payment_header.bounds,
          byRoundingCorners: [.topRight],
          cornerRadii: CGSize(width: 5, height: 5)
        ).cgPath
      payment_shape.path = UIBezierPath(
          roundedRect: payment.bounds,
          byRoundingCorners: [.bottomRight],
          cornerRadii: CGSize(width: 5, height: 5)
        ).cgPath
    } else {
      payment_header_shape.path = UIBezierPath(
          roundedRect: payment_header.bounds,
          byRoundingCorners: [.topLeft, .topRight],
          cornerRadii: CGSize(width: 5, height: 5)
        ).cgPath
      payment_shape.path = UIBezierPath(
          roundedRect: payment.bounds,
          byRoundingCorners: [.bottomLeft, .bottomRight],
          cornerRadii: CGSize(width: 5, height: 5)
        ).cgPath
    }
    Variables()
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
        var a_min = ceil((α*(test_array[0]*i)*pow(1+α*i, 120)) / (pow(1+α*i, 120) - 1)*100)/100
        a_min += 0.01*Double(c)
        while ( test_array[m_min-1] - (a_min - CR(x: α*(test_array[m_min-1]*i))) > 0 )
            && ( CR(x: a_min) != CR(x: α*(test_array[0]*i)) ) {
                test_array.append( CR(x: test_array[m_min-1] - ( a_min - CR(x: α*(test_array[m_min-1]*i)) )) )
                m_min += 1
        }
        test_array.append(0)
        if ( CR(x: a_min) == CR(x: α*(test_array[0]*i)) ) {
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
    
    @IBAction func pay_monthly_minimize(_ sender: UIButton) {
        var a_min = Double()
        r = shared_preferences.double(forKey: "interest")/100
        if compound.isOn {
            i = pow(1 + r/365.25, 365.25/12) - 1 //approximate
        } else {
            i = r
                / 12 //need to convert to periodic rate in decimal form
        }
            if (tenyr_indicator == 0) {
                // if (α*(p*i)*100 - floor(α*(p*i)*100) > 0.499999)
                //     && (α*(p*i)*100 - floor(α*(p*i)*100) < 0.5) {
                //     temp = (round(α*(p*i)*100 + 1) + 1)/100
                // } else {
                //     temp = (round(α*(p*i)*100) + 1)/100
                // }
                a_min = CR(x: α*(p*i)) + 1/100
            } else {
                if (i != 0) {
                    a_min = ceil(
                        (α*(p*i)*pow(1+α*i, 120))
                            / (pow(1+α*i, 120) - 1)*100
                        )/100
                    a_min += CT()
                } else {
                    a_min = ceil(p/120*100)/100
                }
            }
        a = a_min
        Variables()
    }
    

  @IBAction func Payment_Insight_Bubble(_ sender: UIButton) {
    pay_insight.isHidden = false
    pay_insight_header.isHidden = false
    plus_sign.isHidden = true
    minus_sign.isHidden = true
    pay_insight_header.addSubview(shrink)
    pay_insight_header.bringSubviewToFront(shrink)
    pay_insight.frame = CGRect(
      x: 10,
      y: pay_insight.frame.origin.y,
      width: pay_insight.frame.width,
      height: pay_insight.frame.height
    )
    pay_insight_header.frame = CGRect(
      x: 10,
      y: pay_insight_header.frame.origin.y,
      width: pay_insight_header.frame.width,
      height: pay_insight_header.frame.height
    )
    UIView.animate(
      withDuration: 0.25,
      animations: {
        self.equals_sign.isHidden = true
        self.pay_insight_shape.fillColor = UIColor(
            red: 207/255.0,
            green: 209/255.0,
            blue: 210/255.0,
            alpha: 0.95
          ).cgColor
        self.pay_insight_header_shape.fillColor = UIColor(
            red: 207/255.0,
            green: 209/255.0,
            blue: 210/255.0,
            alpha: 0.95
          ).cgColor
        self.payment_header_shape.path = UIBezierPath(
            roundedRect: self.payment_header.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 5, height: 5)
          ).cgPath
        self.payment_shape.path = UIBezierPath(
            roundedRect: self.payment.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 5, height: 5)
          ).cgPath
      },
      completion: { (finished: Bool) -> Void in
        UIView.animate(withDuration: 0.25) {
          self.equals_sign.isHidden = true
          self.pay_insight.frame = CGRect(
            x: 5,
            y: self.pay_insight.frame.origin.y,
            width: self.pay_insight.frame.width,
            height: self.pay_insight.frame.height
          )
          self.pay_insight_header.frame = CGRect(
            x: 5,
            y: self.pay_insight_header.frame.origin.y,
            width: self.pay_insight_header.frame.width,
            height: self.pay_insight_header.frame.height
          )
          self.pay_insight_shape.fillColor = UIColor(
              red: 207/255.0,
              green: 209/255.0,
              blue: 210/255.0,
              alpha: 0.95
            ).cgColor
          self.pay_insight_header_shape.fillColor = UIColor(
              red: 207/255.0,
              green: 209/255.0,
              blue: 210/255.0,
              alpha: 0.95
            ).cgColor
          self.payment_header_shape.path = UIBezierPath(
              roundedRect: self.payment_header.bounds,
              byRoundingCorners: [.topRight],
              cornerRadii: CGSize(width: 5, height: 5)
            ).cgPath
          self.payment_shape.path = UIBezierPath(
              roundedRect: self.payment.bounds,
              byRoundingCorners: [.bottomRight],
              cornerRadii: CGSize(width: 5, height: 5)
            ).cgPath
          self.remaining.textColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
      }
    )
    enlarge.isHidden = true
    shrink.isHidden = false
    insight = 1
    Variables()
    payment.isEnabled = false
    payment_header.isEnabled = false
  }

  @IBAction func Payment_Insight_Bubble_Expand(_ sender: UIButton) {
    pay_insight.isHidden = false
    pay_insight_header.isHidden = false
    plus_sign.isHidden = true
    minus_sign.isHidden = true
    pay_insight_header.addSubview(shrink)
    pay_insight_header.bringSubviewToFront(shrink)
    pay_insight.frame = CGRect(
      x: 10,
      y: pay_insight.frame.origin.y,
      width: pay_insight.frame.width,
      height: pay_insight.frame.height
    )
    pay_insight_header.frame = CGRect(
      x: 10,
      y: pay_insight_header.frame.origin.y,
      width: pay_insight_header.frame.width,
      height: pay_insight_header.frame.height
    )
    UIView.animate(
      withDuration: 0.25,
      animations: {
        self.pay_insight_shape.fillColor = UIColor(
            red: 207/255.0,
            green: 209/255.0,
            blue: 210/255.0,
            alpha: 0.95
          ).cgColor
        self.pay_insight_header_shape.fillColor = UIColor(
            red: 207/255.0,
            green: 209/255.0,
            blue: 210/255.0,
            alpha: 0.95
          ).cgColor
        self.payment_header_shape.path = UIBezierPath(
            roundedRect: self.payment_header.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 5, height: 5)
          ).cgPath
        self.payment_shape.path = UIBezierPath(
            roundedRect: self.payment.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 5, height: 5)
          ).cgPath
      },
      completion: { (finished: Bool) -> Void in
        UIView.animate(withDuration: 0.25) {
          self.equals_sign.isHidden = true
          self.pay_insight.frame = CGRect(
            x: 5,
            y: self.pay_insight.frame.origin.y,
            width: self.pay_insight.frame.width,
            height: self.pay_insight.frame.height
          )
          self.pay_insight_header.frame = CGRect(
            x: 5,
            y: self.pay_insight_header.frame.origin.y,
            width: self.pay_insight_header.frame.width,
            height: self.pay_insight_header.frame.height
          )
          self.pay_insight_shape.fillColor = UIColor(
              red: 207/255.0,
              green: 209/255.0,
              blue: 210/255.0,
              alpha: 0.95
            ).cgColor
          self.pay_insight_header_shape.fillColor = UIColor(
              red: 207/255.0,
              green: 209/255.0,
              blue: 210/255.0,
              alpha: 0.95
            ).cgColor
          self.payment_header_shape.path = UIBezierPath(
              roundedRect: self.payment_header.bounds,
              byRoundingCorners: [.topRight],
              cornerRadii: CGSize(width: 5, height: 5)
            ).cgPath
          self.payment_shape.path = UIBezierPath(
              roundedRect: self.payment.bounds,
              byRoundingCorners: [.bottomRight],
              cornerRadii: CGSize(width: 5, height: 5)
            ).cgPath
          self.remaining.textColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
      }
    )
    enlarge.isHidden = true
    shrink.isHidden = false
    insight = 1
    Variables()
    payment.isEnabled = false
    payment_header.isEnabled = false
  }

  @IBAction func Payment_Insight_Bubble_Header_Close(_ sender: UIButton) {
    pay_insight_header.isHidden = true
    pay_insight.isHidden = true
    enlarge.isHidden = false
    shrink.isHidden = true
    pay_insight_shape.fillColor = UIColor(
        red: 207/255.0,
        green: 209/255.0,
        blue: 210/255.0,
        alpha: 0.95
      ).cgColor
    pay_insight_header_shape.fillColor = UIColor(
        red: 207/255.0,
        green: 209/255.0,
        blue: 210/255.0,
        alpha: 0.95
      ).cgColor
    payment_header_shape.path = UIBezierPath(
        roundedRect: payment_header.bounds,
        byRoundingCorners: [.topLeft, .topRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    payment_shape.path = UIBezierPath(
        roundedRect: payment.bounds,
        byRoundingCorners: [.bottomLeft, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    pay_insight.frame = CGRect(
      x: 10,
      y: pay_insight.frame.origin.y,
      width: pay_insight.frame.width,
      height: pay_insight.frame.height
    )
    pay_insight_header.frame = CGRect(
      x: 10,
      y: pay_insight_header.frame.origin.y,
      width: pay_insight_header.frame.width,
      height: pay_insight_header.frame.height
    )
    plus_sign.isHidden = false
    minus_sign.isHidden = false
    equals_sign.isHidden = false
    remaining.textColor = UIColor.black
    insight = 0
    Variables()
    payment.isEnabled = true
    payment_header.isEnabled = true
  }

  @IBAction func Payment_Insight_Bubble_Close(_ sender: UIButton) {
    pay_insight_header.isHidden = true
    pay_insight.isHidden = true
    enlarge.isHidden = false
    shrink.isHidden = true
    pay_insight_shape.fillColor = UIColor(
        red: 207/255.0,
        green: 209/255.0,
        blue: 210/255.0,
        alpha: 0.95
      ).cgColor
    pay_insight_header_shape.fillColor = UIColor(
        red: 207/255.0,
        green: 209/255.0,
        blue: 210/255.0,
        alpha: 0.95
      ).cgColor
    payment_header_shape.path = UIBezierPath(
        roundedRect: payment_header.bounds,
        byRoundingCorners: [.topLeft, .topRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    payment_shape.path = UIBezierPath(
        roundedRect: payment.bounds,
        byRoundingCorners: [.bottomLeft, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    pay_insight.frame = CGRect(
      x: 10,
      y: pay_insight.frame.origin.y,
      width: pay_insight.frame.width,
      height: pay_insight.frame.height
    )
    pay_insight_header.frame = CGRect(
      x: 10,
      y: pay_insight_header.frame.origin.y,
      width: pay_insight_header.frame.width,
      height: pay_insight_header.frame.height
    )
    plus_sign.isHidden = false
    minus_sign.isHidden = false
    equals_sign.isHidden = false
    remaining.textColor = UIColor.black
    insight = 0
    Variables()
    payment.isEnabled = true
    payment_header.isEnabled = true
  }

  @IBAction func Payment_Insight_Bubble_Shrink(_ sender: UIButton) {
    pay_insight_header.isHidden = true
    pay_insight.isHidden = true
    enlarge.isHidden = false
    shrink.isHidden = true
    pay_insight_shape.fillColor = UIColor(
        red: 207/255.0,
        green: 209/255.0,
        blue: 210/255.0,
        alpha: 0.95
      ).cgColor
    pay_insight_header_shape.fillColor = UIColor(
        red: 207/255.0,
        green: 209/255.0,
        blue: 210/255.0,
        alpha: 0.95
      ).cgColor
    payment_header_shape.path = UIBezierPath(
        roundedRect: payment_header.bounds,
        byRoundingCorners: [.topLeft, .topRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    payment_shape.path = UIBezierPath(
        roundedRect: payment.bounds,
        byRoundingCorners: [.bottomLeft, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    pay_insight.frame = CGRect(
      x: 10,
      y: pay_insight.frame.origin.y,
      width: pay_insight.frame.width,
      height: pay_insight.frame.height
    )
    pay_insight_header.frame = CGRect(
      x: 10,
      y: pay_insight_header.frame.origin.y,
      width: pay_insight_header.frame.width,
      height: pay_insight_header.frame.height
    )
    plus_sign.isHidden = false
    minus_sign.isHidden = false
    equals_sign.isHidden = false
    remaining.textColor = UIColor.black
    insight = 0
    Variables()
    payment.isEnabled = true
    payment_header.isEnabled = true
  }

  @IBAction func Blink(_ sender: UISlider) {
    if (insight == 0) && (progress < 100) && (blinked == 0) {
      enlarge.alpha = 1.0
      UIView.animate(
        withDuration: 0.5,
        delay: 0.0,
        options: [.repeat, .autoreverse, .curveEaseInOut],
        animations: {
          UIView.setAnimationRepeatCount(3)
          self.enlarge.alpha = 0.0
        },
        completion: { (finished: Bool) -> Void in self.enlarge.alpha = 1.0 }
      )
    } else { }
    blinked = 1 //don't blink again, unless you reswipe, reduces annoyance
  }

  @IBAction func Proportion_Slider(_ sender: UISlider) {
    increment = 1.0
    if (sender.value - floor(sender.value) > 0.99999) {
      sender.value = roundf(sender.value + 1)
    } else {
      sender.value = roundf(sender.value)
    }
    progress = increment
      * Double(sender.value)
      /*
         m = (y2-y1)/(x2-x1)
         = (0-max_percent_interest)/(100-0)
         = -max_percent_interest/100
         y = y1 + m(x-x1)
         = max_percent_interest + -max_percent_interest/100(x-0)
         = max_percent_interest - max_percent_interest/100(x)
         */
    let scale = max_percent_interest/100
    /*
         y = ( max_percent_interest - scale(x) )/100
         α = y
         max_percent_interest - progress = x
         */
    α = ( max_percent_interest - scale*(max_percent_interest - progress) )/100
    // if (α*100 - floor(α*100) > 0.499999)
    //     && (α*100 - floor(α*100) < 0.5) {
    //     α = round(α*100 + 1)/100
    // } else {
    //     α = round(α*100)/100
    // }
    α = CR(x: α)
    var a_min = Double()
    if (tenyr_indicator == 0) {
      // if (α*(p*i)*100 - floor(α*(p*i)*100) > 0.499999)
      //     && (α*(p*i)*100 - floor(α*(p*i)*100) < 0.5) {
      //   temp = (round(α*(p*i)*100 + 1) + 1)/100
      // } else {
      //   temp = (round(α*(p*i)*100) + 1)/100
      // }
      a_min = CR(x: α*(p*i)) + 1/100
    } else {
      if (i != 0) {
        a_min = ceil(
            (α*(p*i)*pow(1+α*i, 120))
              / (pow(1+α*i, 120) - 1)*100
          )/100
        a_min += CT()
      } else {
        a_min = ceil(p/120*100)/100
      }
    }
    if (a_min >= a) {
      a = a_min
    } else { }
    var attributedPercentInterestTitle = NSMutableAttributedString()
    attributedPercentInterestTitle = NSMutableAttributedString(
      string: "Interest",
      attributes: [
        NSAttributedString.Key.font: UIFont(
          name: "CMUSerif-Roman",
          size: 16.0
        )!,
        NSAttributedString.Key.foregroundColor: UIColor.black
      ]
    )
    let attributedPercentInterestSpace = NSMutableAttributedString(
      string: " \n",
      attributes: [
        NSAttributedString.Key.font: UIFont(name: "CMUSerif-Roman", size: 3.0)!
      ]
    )
    let attributedPercentBalanceTitle = NSMutableAttributedString(
      string: "Later",
      attributes: [
        NSAttributedString.Key.font: UIFont(
          name: "CMUSerif-Roman",
          size: 16.0
        )!,
        NSAttributedString.Key.foregroundColor: UIColor.black
      ]
    )
    let attributedPercentBalanceSpace = NSMutableAttributedString(
      string: " \n",
      attributes: [
        NSAttributedString.Key.font: UIFont(name: "CMUSerif-Roman", size: 3.0)!
      ]
    )
    var attributedPercentInterest = NSMutableAttributedString()
    var attributedPercentBalance = NSMutableAttributedString()
    attributedPercentInterest = NSMutableAttributedString(
      string: String(format: "%.0f", α*100) + "%",
      attributes: [
        NSAttributedString.Key.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!
      ]
    )
    attributedPercentBalance = NSMutableAttributedString(
      string: String(format: "%.0f", 100 - α*100) + "%",
      attributes: [
        NSAttributedString.Key.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!
      ]
    )
    attributedPercentInterest.append(attributedPercentInterestSpace)
    attributedPercentInterest.append(attributedPercentInterestTitle)
    percent_interest.attributedText = attributedPercentInterest
    attributedPercentBalance.append(attributedPercentBalanceSpace)
    attributedPercentBalance.append(attributedPercentBalanceTitle)
    percent_balance.attributedText = attributedPercentBalance
    Variables()
  }

  override func viewDidLoad() {
    //what users see first, when they swipe leftward
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    insight_shape.isHidden = true
    enlarge.alpha = 1.0
    shrink.alpha = 1.0
    charged_interest.text = ""
    pay_insight_header.alpha = 1.0
    balance_header.backgroundColor = UIColor.clear
    interest_header.backgroundColor = UIColor.clear
    payment_header.backgroundColor = UIColor.clear
    balance.backgroundColor = UIColor.clear
    charged_interest.backgroundColor = UIColor.clear
    payment.backgroundColor = UIColor.clear
    compound.isHidden = false
    titleof_compound.isHidden = false
    percent_interest.isHidden = false
    slider.isHidden = false
    percent_balance.isHidden = false
    time_label.text = "Time"
    savings_label.text = "Savings"
    line.isHidden = false
    //no extra space
    aprstack_width.isActive = true
    //no extra width
    compound_stack.isHidden = false
    table_header.isHidden = false
    enlarge.isHidden = false
    //keep spacing as is
    note_constraint.isActive = true
    note_right.isHidden = false
    //keep note where it is
    plus_sign.isHidden = false
    minus_sign.isHidden = false
    equals_sign.isHidden = false
    //leave constraint as is
    //keep view color as is
    //leave constraints as they are
    blinked = 0
    numberFormatter.usesGroupingSeparator = true
    numberFormatter.groupingSeparator = ","
    numberFormatter.groupingSize = 3
    enlarge.adjustsImageWhenHighlighted = false
    shrink.adjustsImageWhenHighlighted = false
    pay_insight_header.isHidden = true
    pay_insight.isHidden = true
    compound.layer.cornerRadius = 16
    shrink.isHidden = true
    view.addSubview(pay_insight)
    view.bringSubviewToFront(pay_insight)
    pay_insight.frame = CGRect(
      x: 10,
      y: pay_insight.frame.origin.y,
      width: pay_insight.frame.width,
      height: pay_insight.frame.height
    )
    pay_insight_header.frame = CGRect(
      x: 10,
      y: pay_insight_header.frame.origin.y,
      width: pay_insight_header.frame.width,
      height: pay_insight_header.frame.height
    )
    pay_insight_shape.fillColor = UIColor(
        red: 207/255.0,
        green: 209/255.0,
        blue: 210/255.0,
        alpha: 0.95
      ).cgColor
    pay_insight_header_shape.fillColor = UIColor(
        red: 207/255.0,
        green: 209/255.0,
        blue: 210/255.0,
        alpha: 0.95
      ).cgColor
    slider.setThumbImage(UIImage(named: "Thumb"), for: .normal)
    slider.setMinimumTrackImage(
      UIImage(named: "Math_MinTrack")!.resizableImage(
        withCapInsets: .zero,
        resizingMode: .stretch
      ),
      for: .normal
    )
    slider.setMaximumTrackImage(
      UIImage(named: "Math_MaxTrack")!.resizableImage(
        withCapInsets: .zero,
        resizingMode: .stretch
      ),
      for: .normal
    )
    p = shared_preferences.double(forKey: "loaned")
    r = shared_preferences.double(forKey: "interest")/100
    a = shared_preferences.double(forKey: "pay_monthly")
    tenyr_indicator = shared_preferences.double(forKey: "tenyr")
    i = r
      / 12 //need to convert to periodic rate in decimal form
    let attributedLoanedTitle = NSMutableAttributedString(
      string: "Loaned",
      attributes: [
        NSAttributedString.Key.font: UIFont(name: "CMUSerif-Bold", size: 18.0)!
      ]
    )
    var attributedLoanedSummary = NSMutableAttributedString()
    attributedLoanedSummary = NSMutableAttributedString(
      string: " $" + numberFormatter.string(from: NSNumber(value: p))!,
      attributes: [
        NSAttributedString.Key.font: UIFont(name: "CMUSerif-Roman", size: 18.0)!
      ]
    )
    attributedLoanedTitle.append(attributedLoanedSummary)
    loaned.attributedText = attributedLoanedTitle
    let attributedAPRTitle = NSMutableAttributedString(
      string: "APR",
      attributes: [
        NSAttributedString.Key.font: UIFont(name: "CMUSerif-Bold", size: 18.0)!
      ]
    )
    var attributedAPRSummary = NSMutableAttributedString()
    var attributedAPRDecimalEquivalent = NSMutableAttributedString()
    var attributedAPRPeriodic = NSMutableAttributedString()
    var temp_dec = Int() //don't want it rounding, unless remainder has repeated 9s at one hundred thousandths place onward
    if (i*12*10000 - floor(i*12*10000) > 0.99999) {
        temp_dec = Int(i*12*10000)+1
    } else {
        temp_dec = Int(i*12*10000)
    }
    var temp_peri = Int() //don't want it rounding, unless remainder has repeated 9s at one millionths place onward
    if (i*100000 - floor(i*100000) > 0.99999) {
        temp_peri = Int(i*100000)+1
    } else {
        temp_peri = Int(i*100000)
    }
    if (i == 0) {
      attributedAPRSummary = NSMutableAttributedString(
        string: " " + String(format: "%.0f", i * 12 * 100) + "%",
        attributes: [
          NSAttributedString.Key.font: UIFont(
            name: "CMUSerif-Roman",
            size: 18.0
          )!
        ]
      )
      attributedAPRDecimalEquivalent = NSMutableAttributedString(
        string: "\n" + "÷ 100 = 0.0" + String(temp_dec) + "0...",
        attributes: [
          NSAttributedString.Key.font: UIFont(
            name: "CMUSerif-Roman",
            size: 18.0
          )!,
          NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(
            0.5
          )
        ]
      )
      attributedAPRPeriodic = NSMutableAttributedString(
        string: "\n" + "÷ 12 = 0.0" + String(temp_peri) + "0... monthly",
        attributes: [
          NSAttributedString.Key.font: UIFont(
            name: "CMUSerif-Roman",
            size: 18.0
          )!,
          NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(
            0.5
          )
        ]
      )
    } else {
      attributedAPRSummary = NSMutableAttributedString(
        string: " " + String(format: "%.2f", i * 12 * 100) + "%",
        attributes: [
          NSAttributedString.Key.font: UIFont(
            name: "CMUSerif-Roman",
            size: 18.0
          )!
        ]
      )
      var remainder_dec = String(".") //resetting the string
      if (String(temp_dec).count < 4) {
        for _ in 1...(4-String(temp_dec).count) {
          remainder_dec.append("0")
        }
      }
      attributedAPRDecimalEquivalent = NSMutableAttributedString(
        string: "\n" + "÷ 100 = 0" + remainder_dec + String(temp_dec) + "...",
        attributes: [
          NSAttributedString.Key.font: UIFont(
            name: "CMUSerif-Roman",
            size: 18.0
          )!
        ]
      )
      var remainder_peri = String(".") //resetting the string
      if (String(temp_peri).count < 5) {
        for _ in 1...(5-String(temp_peri).count) {
          remainder_peri.append("0")
        }
      }
      attributedAPRPeriodic = NSMutableAttributedString(
        string: "\n" + "÷ 12 = 0" + remainder_peri + String(temp_peri) + "... monthly",
        attributes: [
          NSAttributedString.Key.font: UIFont(
            name: "CMUSerif-Roman",
            size: 18.0
          )!
        ]
      )
    }
    attributedAPRTitle.append(attributedAPRSummary)
    attributedAPRTitle.append(attributedAPRDecimalEquivalent)
    attributedAPRTitle.append(attributedAPRPeriodic)
    nominal_rate.attributedText = attributedAPRTitle
    if (i == 0) {
      compound.isEnabled = false
      titleof_compound.textColor = UIColor.lightGray.withAlphaComponent(0.5)
    } else {
      compound.isEnabled = true
    }
    var a_min = Double()
    // if (p*i*100 - floor(p*i*100) > 0.499999)
    //     && (p*i*100 - floor(p*i*100) < 0.5) {
    //   tempx = (round(p*i*100 + 1)+1)/100
    // } else {
    //   tempx = (round(p*i*100)+1)/100
    // }
    a_min = CR(x: p*i) + 1/100
    attributedPayTitle = NSMutableAttributedString(
      string: "Pay Monthly",
      attributes: [
        NSAttributedString.Key.font: UIFont(name: "CMUSerif-Bold", size: 18.0)!
      ]
    )
    if (a == a_min) {
      attributedPaySummary = NSMutableAttributedString(
        string: " $" + String(format: "%.2f", a),
        attributes: [
          NSAttributedString.Key.font: UIFont(
            name: "CMUSerif-Roman",
            size: 18.0
          )!
        ]
      )
    } else if (i == 0) {
      let check = a
      if (check - floor(check) > 0) {
        attributedPaySummary = NSMutableAttributedString(
          string: " $" + String(format: "%.2f", a),
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 18.0
            )!
          ]
        )
      } else {
        attributedPaySummary = NSMutableAttributedString(
          string: " $" + String(format: "%.0f", a),
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 18.0
            )!
          ]
        )
      }
    } else {
      let check = a
      if (check - floor(check) > 0) {
        attributedPaySummary = NSMutableAttributedString(
          string: " $" + String(format: "%.2f", a),
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 18.0
            )!
          ]
        )
      } else {
        attributedPaySummary = NSMutableAttributedString(
          string: " $" + numberFormatter.string(from: NSNumber(value: a))!,
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 18.0
            )!
          ]
        )
      }
    }
    attributedPayTitle.append(attributedPaySummary)
    pay_monthly.attributedText = attributedPayTitle
    //Shape of balance header---------------------
    let balance_header_shape = CAShapeLayer()
    balance_header_shape.bounds = balance_header.frame
    balance_header_shape.position = balance_header.center
    balance_header_shape.path = UIBezierPath(
        roundedRect: balance_header.bounds,
        byRoundingCorners: [.topLeft, .topRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    balance_header_shape.strokeColor = UIColor(
        red: 161/255.0,
        green: 166/255.0,
        blue: 168/255.0,
        alpha: 0.125
      ).cgColor
    balance_header_shape.fillColor = UIColor(
        red: 161/255.0,
        green: 166/255.0,
        blue: 168/255.0,
        alpha: 0.25+0.125
      ).cgColor
    balance_header_shape.lineWidth = 0
    let balance_header_shape_label = UILabel()
    balance_header_shape_label.frame = CGRect(
      x: 0,
      y: 0,
      width: balance_header.frame.width,
      height: balance_header.frame.height
    )
    balance_header_shape_label.bounds = balance_header.frame
    balance_header_shape_label.text = "Principal"
    balance_header_shape_label.textAlignment = .center
    balance_header_shape_label.numberOfLines = 0
    balance_header_shape_label.textColor = UIColor.white
    balance_header_shape_label.font = UIFont(
      name: "HelveticaNeue-Bold",
      size: 12.0
    )
    balance_header.layer.addSublayer(balance_header_shape)
    balance_header.addSubview(balance_header_shape_label)
    //Shape of interest header---------------------
    let interest_header_shape = CAShapeLayer()
    interest_header_shape.bounds = interest_header.frame
    interest_header_shape.position = interest_header.center
    interest_header_shape.path = UIBezierPath(
        roundedRect: interest_header.bounds,
        byRoundingCorners: [.topLeft, .topRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    if (i == 0) {
      interest_header_shape.fillColor = UIColor(
          red: 161/255.0,
          green: 166/255.0,
          blue: 168/255.0,
          alpha: 0.0625
        ).cgColor
      interest_header_shape.strokeColor = UIColor(
          red: 161/255.0,
          green: 166/255.0,
          blue: 168/255.0,
          alpha: 0.020
        ).cgColor
      plus_sign.alpha = 0.125
    } else {
      interest_header_shape.fillColor = UIColor(
          red: 161/255.0,
          green: 166/255.0,
          blue: 168/255.0,
          alpha: 0.25+0.125
        ).cgColor
      interest_header_shape.strokeColor = UIColor(
          red: 161/255.0,
          green: 166/255.0,
          blue: 168/255.0,
          alpha: 0.125
        ).cgColor
      plus_sign.alpha = 1.0
    }
    interest_header_shape.lineWidth = 0
    let interest_header_shape_label = UILabel()
    interest_header_shape_label.frame = CGRect(
      x: 0,
      y: 0,
      width: interest_header.frame.width,
      height: interest_header.frame.height
    )
    interest_header_shape_label.bounds = interest_header.frame
    interest_header_shape_label.text = "Interest"
    interest_header_shape_label.textAlignment = .center
    interest_header_shape_label.numberOfLines = 0
    if (i == 0) {
      interest_header_shape_label.textColor = UIColor.white.withAlphaComponent(
        0.5
      )
    } else {
      interest_header_shape_label.textColor = UIColor.white
    }
    interest_header_shape_label.font = UIFont(
      name: "HelveticaNeue-Bold",
      size: 12.0
    )
    interest_header.layer.addSublayer(interest_header_shape)
    interest_header.addSubview(interest_header_shape_label)
    //Shape of payment header-----------------------------
    payment_header_shape.bounds = payment_header.frame
    payment_header_shape.position = payment_header.center
    payment_header_shape.path = UIBezierPath(
        roundedRect: payment_header.bounds,
        byRoundingCorners: [.topLeft, .topRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    payment_header_shape.strokeColor = UIColor(
        red: 161/255.0,
        green: 166/255.0,
        blue: 168/255.0,
        alpha: 0.125
      ).cgColor
    payment_header_shape.fillColor = UIColor(
        red: 161/255.0,
        green: 166/255.0,
        blue: 168/255.0,
        alpha: 0.25+0.125
      ).cgColor
    payment_header_shape.lineWidth = 0
    payment_shape.path = UIBezierPath(
        roundedRect: payment.bounds,
        byRoundingCorners: [.bottomLeft, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath //define here, or else - if alter switch with insight open - bottom-left edge will show
    let payment_header_shape_label = UILabel()
    payment_header_shape_label.frame = CGRect(
      x: 0,
      y: 0,
      width: payment_header.frame.width,
      height: payment_header.frame.height
    )
    payment_header_shape_label.bounds = payment_header.frame
    payment_header_shape_label.text = "Pay"
    payment_header_shape_label.textAlignment = .center
    payment_header_shape_label.numberOfLines = 0
    payment_header_shape_label.textColor = UIColor.white
    payment_header_shape_label.font = UIFont(
      name: "HelveticaNeue-Bold",
      size: 12.0
    )
    payment_header.layer.addSublayer(payment_header_shape)
    payment_header.addSubview(payment_header_shape_label)
    //only show if click on pay
    pay_insight_shape.borderColor = UIColor(
        red: 207/255.0,
        green: 209/255.0,
        blue: 210/255.0,
        alpha: 0.95
      ).cgColor
    pay_insight_shape.borderWidth = 0
    pay_insight_header.layer.addSublayer(pay_insight_header_shape)
    //Proportion
    let proportion_shape = CAShapeLayer()
    proportion_shape.bounds = proportion.frame
    proportion_shape.position = proportion.center
    proportion_shape.path = UIBezierPath(
        roundedRect: proportion.bounds,
        byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    if (i == 0) {
      proportion_shape.fillColor = UIColor(
          red: 161/255.0,
          green: 166/255.0,
          blue: 168/255.0,
          alpha: 0.0
        ).cgColor
    } else {
      proportion_shape.fillColor = UIColor(
          red: 161/255.0,
          green: 166/255.0,
          blue: 168/255.0,
          alpha: 0.0
        ).cgColor
    }
    proportion.layer.addSublayer(proportion_shape)
    proportion.bringSubviewToFront(percent_interest)
    proportion.bringSubviewToFront(slider)
    proportion.bringSubviewToFront(percent_balance)
    let scale = max_percent_interest/100
    α = ( max_percent_interest
      - scale*(max_percent_interest - Double(progress)) )/100
    // if (α*100 - floor(α*100) > 0.499999)
    //     && (α*100 - floor(α*100) < 0.5) {
    //   α = round(α*100 + 1)/100
    // } else {
    //   α = round(α*100)/100
    // }
    α = CR(x: α)
    var attributedPercentInterestTitle = NSMutableAttributedString()
    var attributedPercentBalanceTitle = NSMutableAttributedString()
    if (i == 0) {
      attributedPercentInterestTitle = NSMutableAttributedString(
        string: "Interest",
        attributes: [
          NSAttributedString.Key.font: UIFont(
            name: "CMUSerif-Roman",
            size: 16.0
          )!,
          NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(
            0.5
          )
        ]
      )
      attributedPercentBalanceTitle = NSMutableAttributedString(
        string: "Later",
        attributes: [
          NSAttributedString.Key.font: UIFont(
            name: "CMUSerif-Roman",
            size: 16.0
          )!,
          NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(
            0.5
          )
        ]
      )
    } else {
      attributedPercentInterestTitle = NSMutableAttributedString(
        string: "Interest",
        attributes: [
          NSAttributedString.Key.font: UIFont(
            name: "CMUSerif-Roman",
            size: 16.0
          )!,
          NSAttributedString.Key.foregroundColor: UIColor.black
        ]
      )
      attributedPercentBalanceTitle = NSMutableAttributedString(
        string: "Later",
        attributes: [
          NSAttributedString.Key.font: UIFont(
            name: "CMUSerif-Roman",
            size: 16.0
          )!,
          NSAttributedString.Key.foregroundColor: UIColor.black
        ]
      )
    }
    let attributedPercentInterestSpace = NSMutableAttributedString(
      string: " \n",
      attributes: [
        NSAttributedString.Key.font: UIFont(
          name: "HelveticaNeue-Bold",
          size: 3.0
        )!
      ]
    )
    let attributedPercentBalanceSpace = NSMutableAttributedString(
      string: " \n",
      attributes: [
        NSAttributedString.Key.font: UIFont(
          name: "HelveticaNeue-Bold",
          size: 3.0
        )!
      ]
    )
    var attributedPercentInterest = NSMutableAttributedString()
    var attributedPercentBalance = NSMutableAttributedString()
    if (i == 0) {
      slider.isEnabled = false
      attributedPercentInterest = NSMutableAttributedString(
        string: String(format: "%.0f", α*100) + "%",
        attributes: [
          NSAttributedString.Key.font: UIFont(
            name: "CMUSerif-Roman",
            size: 16.0
          )!,
          NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(
            0.5
          )
        ]
      )
      attributedPercentBalance = NSMutableAttributedString(
        string: String(format: "%.0f", 100 - α*100) + "%",
        attributes: [
          NSAttributedString.Key.font: UIFont(
            name: "CMUSerif-Roman",
            size: 16.0
          )!,
          NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(
            0.5
          )
        ]
      )
    } else {
      slider.isEnabled = true
      let px = α*100
      if (px - floor(px) > 0.99999) {
        α = Double(Int(α*100)+1)/100
      } else {
        α = Double(Int(α*100))/100
      }
      // var tempx = Double()
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   tempx = (round(p*i*100 + 1)+1)/100
      // } else {
      //   tempx = (round(p*i*100)+1)/100
      // }
      // tempx = CR(x: p*i) + 1/100
      //simplifying percentages:
      if (α*100 - floor(α*100) == 0) {
        attributedPercentInterest = NSMutableAttributedString(
          string: String(format: "%.0f", α*100) + "%",
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 16.0
            )!
          ]
        )
        attributedPercentBalance = NSMutableAttributedString(
          string: String(format: "%.0f", 100 - α*100) + "%",
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 16.0
            )!
          ]
        )
      } else if (α*100*10 - floor(α*100*10) == 0) {
        attributedPercentInterest = NSMutableAttributedString(
          string: String(format: "%.1f", α*100) + "%",
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 16.0
            )!
          ]
        )
        attributedPercentBalance = NSMutableAttributedString(
          string: String(format: "%.1f", 100 - α*100) + "%",
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 16.0
            )!
          ]
        )
      } else //arbitrary:
      if (progress != 100) && (a == a_min) {
        attributedPercentInterest = NSMutableAttributedString(
          string: String(format: "%.0f", α*100) + "%",
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 16.0
            )!
          ]
        )
        attributedPercentBalance = NSMutableAttributedString(
          string: String(format: "%.0f", 100 - α*100) + "%",
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 16.0
            )!
          ]
        )
      } else {
        attributedPercentInterest = NSMutableAttributedString(
          string: String(format: "%.2f", α*100) + "%",
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 16.0
            )!
          ]
        )
        attributedPercentBalance = NSMutableAttributedString(
          string: String(format: "%.2f", 100 - α*100) + "%",
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 16.0
            )!
          ]
        )
      }
    }
    attributedPercentInterest.append(attributedPercentInterestSpace)
    attributedPercentInterest.append(attributedPercentInterestTitle)
    percent_interest.attributedText = attributedPercentInterest
    attributedPercentBalance.append(attributedPercentBalanceSpace)
    attributedPercentBalance.append(attributedPercentBalanceTitle)
    percent_balance.attributedText = attributedPercentBalance
    balance.layer.addSublayer(balance_shape)
    balance.addSubview(balance_shape_label)
    add.addSubview(add_label)
    charged_interest.layer.addSublayer(charged_interest_shape)
    charged_interest.addSubview(charged_interest_shape_label)
    subtract.addSubview(subtract_label)
    payment.layer.addSublayer(payment_shape)
    payment.addSubview(payment_shape_label)
    equals.addSubview(equals_label)
    remaining.addSubview(remaining_label)
    pay_insight.layer.addSublayer(pay_insight_shape)
    pay_insight.addSubview(pay_insight_shape_label)
    note.sizeToFit()
    //allow users to magnify the table, if numbers within the table are too small
    balance.tintColor = .clear
    balance.isEditable = true //potential bug: should be isSelectable, but isSelectable only highlights first line
    balance.inputView = UIView() //prevents keyboard
    if (i != 0) {
      charged_interest.tintColor = .clear
      charged_interest.isEditable = true
      charged_interest.inputView = UIView()
    } else { }
    remaining.tintColor = .clear
    remaining.isEditable = true
    remaining.inputView = UIView()
    Variables()
    payment_shape.path = UIBezierPath(
        roundedRect: payment.bounds,
        byRoundingCorners: [.bottomLeft, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    
  }

  func Variables() {
    if (i == 0) {
      payment.isEnabled = false
      payment_header.isEnabled = false
      enlarge.isHidden = true
    } else {
      payment.isEnabled = true
      payment_header.isEnabled = true
    }
    var m = 1 //defined here in order to simplify the rest
    var n = Int()
    var B = p //monthly principal balance, defined here in order to simplify the rest too
    var O = 0.00 //monthly outstanding interest
    var interest_owed = Double()
    // if (B*i*100 - floor(B*i*100) > 0.499999)
    //     && (B*i*100 - floor(B*i*100) < 0.5) {
    //   interest_owed = round(B*i*100 + 1)/100
    // } else {
    //   interest_owed = round(B*i*100)/100
    // }
    interest_owed = CR(x: B*i)
    var interest_paid = Double()
    // var x = α*(B*i)
    // if (x*100 - floor(x*100) > 0.499999) && (x*100 - floor(x*100) < 0.5) {
    //   interest_paid = round(x*100 + 1)/100
    // } else {
    //   interest_paid = round(x*100)/100
    // }
    interest_paid = CR(x: α*(B*i))
    // var tempx = Double()
    // if (p*i*100 - floor(p*i*100) > 0.499999)
    //     && (p*i*100 - floor(p*i*100) < 0.5) {
    //   tempx = (round(p*i*100 + 1)+1)/100
    // } else {
    //   tempx = (round(p*i*100)+1)/100
    // }
    // var principal_pay = Double()
    // if (a == tempx) {
    //   if (progress == 100) {
    //     principal_pay = a - interest_pay
    //   } else {
    //     principal_pay = a - interest_pay
    //   }
    // } else {
    //   principal_pay = a - interest_pay
    // }
    // principal_pay = a - interest_pay
    while (B - (a - interest_paid) > 0) {
      B = B - (a - interest_paid)
      // if (B*100 - floor(B*100) > 0.499999)
      //     && (B*100 - floor(B*100) < 0.5) {
      //   B = round(B*100 + 1)/100
      // } else {
      //   B = round(B*100)/100
      // }
      B = CR(x: B)
      O = O + (interest_owed - interest_paid)
      // if (O*100 - floor(O*100) > 0.499999)
      //     && (O*100 - floor(O*100) < 0.5) {
      //   O = round(O*100 + 1)/100
      // } else {
      //   O = round(O*100)/100
      // }
      O = CR(x: O)
      // if (B*i*100 - floor(B*i*100) > 0.499999)
      //     && (B*i*100 - floor(B*i*100) < 0.5) {
      //   interest_owed = round(B*i*100 + 1)/100
      // } else {
      //   interest_owed = round(B*i*100)/100
      // }
      interest_owed = CR(x: B*i)
      // x = α*(B*i)
      // if (x*100 - floor(x*100) > 0.499999) && (x*100 - floor(x*100) < 0.5) {
      //   interest_paid = round(x*100 + 1)/100
      // } else {
      //   interest_paid = round(x*100)/100
      // }
      interest_paid = CR(x: α*(B*i))
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   tempx = (round(p*i*100 + 1)+1)/100
      // } else {
      //   tempx = (round(p*i*100)+1)/100
      // }
      // if (a == tempx) {
      //   if (progress == 100) {
      //     principal_pay = a - interest_pay
      //   } else {
      //     principal_pay = a - interest_pay
      //   }
      // } else {
      //   principal_pay = a - interest_pay
      // }
      // principal_pay = a - interest_pay
      m += 1
    }
    n = m
    //redo pay title
    var a_min = Double()
    // if (p*i*100 - floor(p*i*100) > 0.499999)
    //     && (p*i*100 - floor(p*i*100) < 0.5) {
    //   tempx_x = (round(p*i*100 + 1)+1)/100
    // } else {
    //   tempx_x = (round(p*i*100)+1)/100
    // }
    a_min = CR(x: p*i) + 1/100 //initial value
    attributedPayTitle = NSMutableAttributedString(
      string: "Pay Monthly",
      attributes: [
        NSAttributedString.Key.font: UIFont(name: "CMUSerif-Bold", size: 18.0)!
      ]
    )
    if (a == a_min) {
      if (progress == 100) {
        attributedPaySummary = NSMutableAttributedString(
          string: " $" + String(format: "%.2f", a),
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 18.0
            )!
          ]
        )
      } else {
        attributedPaySummary = NSMutableAttributedString(
          string: " $" + String(format: "%.2f", a),
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 18.0
            )!
          ]
        )
      }
    } else if (i == 0) {
      let check = a
      if (check - floor(check) > 0) {
        attributedPaySummary = NSMutableAttributedString(
          string: " $" + String(format: "%.2f", a),
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 18.0
            )!
          ]
        )
      } else {
        attributedPaySummary = NSMutableAttributedString(
          string: " $" + String(format: "%.0f", a),
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 18.0
            )!
          ]
        )
      }
    } else {
      let check = a
      if (check - floor(check) > 0) {
        attributedPaySummary = NSMutableAttributedString(
          string: " $" + String(format: "%.2f", a),
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 18.0
            )!
          ]
        )
      } else {
        attributedPaySummary = NSMutableAttributedString(
          string: " $" + numberFormatter.string(from: NSNumber(value: a))!,
          attributes: [
            NSAttributedString.Key.font: UIFont(
              name: "CMUSerif-Roman",
              size: 18.0
            )!
          ]
        )
      }
    }
    attributedPayTitle.append(attributedPaySummary)
    pay_monthly.attributedText = attributedPayTitle

    /* ------------------ MONTHLY BALANCE TABLE ------------------ */
    //remaining frame or remaining label shifts after pressing switch or moving thumb, not an issue if set constraints visually
    if (n-1 > 4) {
      table_height.constant = CGFloat(132)
      balance.frame = CGRect(
        x: Int(balance.frame.origin.x),
        y: 0,
        width: Int(balance.frame.width),
        height: 132
      )
      add.frame = CGRect(
        x: Int(add.frame.origin.x),
        y: 0,
        width: Int(add.frame.width),
        height: 132
      )
      charged_interest.frame = CGRect(
        x: Int(charged_interest.frame.origin.x),
        y: 0,
        width: Int(charged_interest.frame.width),
        height: 132
      )
      subtract.frame = CGRect(
        x: Int(subtract.frame.origin.x),
        y: 0,
        width: Int(subtract.frame.width),
        height: 132
      )
      payment.frame = CGRect(
        x: Int(payment.frame.origin.x),
        y: 0,
        width: Int(payment.frame.width),
        height: 132
      )
      equals.frame = CGRect(
        x: Int(equals.frame.origin.x),
        y: 0,
        width: Int(equals.frame.width),
        height: 132
      )
      remaining.frame = CGRect(
        x: Int(remaining.frame.origin.x),
        y: 0,
        width: Int(
            table.frame.width-balance.frame.width-add.frame.width-charged_interest.frame.width
          )-Int(subtract.frame.width+payment.frame.width+equals.frame.width),
        height: 132
      )
      pay_insight.frame = CGRect(
        x: 10,
        y: 0,
        width: Int(pay_insight.frame.width),
        height: 132
      )
    } else {
      table_height.constant = CGFloat(22*n)
      table.heightAnchor.constraint(equalToConstant: CGFloat(22*n))
      balance.frame = CGRect(
        x: Int(balance.frame.origin.x),
        y: 0,
        width: Int(balance.frame.width),
        height: 22*n
      )
      add.frame = CGRect(
        x: Int(add.frame.origin.x),
        y: 0,
        width: Int(add.frame.width),
        height: 22*n
      )
      charged_interest.frame = CGRect(
        x: Int(charged_interest.frame.origin.x),
        y: 0,
        width: Int(charged_interest.frame.width),
        height: 22*n
      )
      subtract.frame = CGRect(
        x: Int(subtract.frame.origin.x),
        y: 0,
        width: Int(subtract.frame.width),
        height: 22*n
      )
      payment.frame = CGRect(
        x: Int(payment.frame.origin.x),
        y: 0,
        width: Int(payment.frame.width),
        height: 22*n
      )
      equals.frame = CGRect(
        x: Int(equals.frame.origin.x),
        y: 0,
        width: Int(equals.frame.width),
        height: 22*n
      )
      let CGRect_widthtemp = Int(
          table.frame.width-balance.frame.width-add.frame.width-charged_interest.frame.width
        )-Int(subtract.frame.width+payment.frame.width+equals.frame.width)
      remaining.frame = CGRect(
        x: Int(remaining.frame.origin.x),
        y: 0,
        width: CGRect_widthtemp,
        height: 22*n
      )
      pay_insight.frame = CGRect(
        x: 10,
        y: 0,
        width: Int(pay_insight.frame.width),
        height: 22*n
      )
    }
    //Shape of balance body---------------------
    balance_shape.bounds = balance.frame
    balance_shape.position = balance.center
    balance_shape.path = UIBezierPath(
        roundedRect: balance.bounds,
        byRoundingCorners: [.bottomLeft, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    balance_shape.strokeColor = UIColor(
        red: 161/255.0,
        green: 166/255.0,
        blue: 168/255.0,
        alpha: 0.125
      ).cgColor
    balance_shape.fillColor = UIColor(
        red: 161/255.0,
        green: 166/255.0,
        blue: 168/255.0,
        alpha: 0.25+0.125
      ).cgColor
    balance_shape.lineWidth = 0
    //Shape of interest body---------------------
    charged_interest_shape.bounds = charged_interest.frame
    charged_interest_shape.position = charged_interest.center
    charged_interest_shape.path = UIBezierPath(
        roundedRect: charged_interest.bounds,
        byRoundingCorners: [.bottomLeft, .bottomRight],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    if (i == 0) {
      charged_interest_shape.fillColor = UIColor(
          red: 161/255.0,
          green: 166/255.0,
          blue: 168/255.0,
          alpha: 0.0625
        ).cgColor
      charged_interest_shape.strokeColor = UIColor(
          red: 161/255.0,
          green: 166/255.0,
          blue: 168/255.0,
          alpha: 0.020
        ).cgColor
    } else {
      charged_interest_shape.fillColor = UIColor(
          red: 161/255.0,
          green: 166/255.0,
          blue: 168/255.0,
          alpha: 0.25+0.125
        ).cgColor
      charged_interest_shape.strokeColor = UIColor(
          red: 161/255.0,
          green: 166/255.0,
          blue: 168/255.0,
          alpha: 0.125
        ).cgColor
    }
    charged_interest_shape.lineWidth = 0
    //Shape of payment body---------------------
    payment_shape.bounds = payment.frame
    payment_shape.position = payment.center
      //define in viewdidload BUT after Variables(): (or else will change path if switch or slider altered)
    payment_shape.strokeColor = UIColor(
        red: 161/255.0,
        green: 166/255.0,
        blue: 168/255.0,
        alpha: 0.125
      ).cgColor
    payment_shape.fillColor = UIColor(
        red: 161/255.0,
        green: 166/255.0,
        blue: 168/255.0,
        alpha: 0.25+0.125
      ).cgColor
    payment_shape.lineWidth = 0
    if (insight == 1) {
      payment_shape.path = UIBezierPath(
          roundedRect: payment.bounds,
          byRoundingCorners: [.bottomRight],
          cornerRadii: CGSize(width: 5, height: 5)
        ).cgPath
    } else {
      payment_shape.path = UIBezierPath(
          roundedRect: payment.bounds,
          byRoundingCorners: [.bottomLeft, .bottomRight],
          cornerRadii: CGSize(width: 5, height: 5)
        ).cgPath
    }
    pay_insight.frame = CGRect(
      x: 10,
      y: pay_insight.frame.origin.y,
      width: pay_insight.frame.width,
      height: pay_insight.frame.height
    )
    pay_insight_header.frame = CGRect(
      x: 10,
      y: pay_insight_header.frame.origin.y,
      width: pay_insight_header.frame.width,
      height: pay_insight_header.frame.height
    )
    var temp1 = Double()
    var temp2 = Double()
    var temp3 = Double()
    var temp4 = Double()
    var interest_pay1 = Double()
    var interest_pay2 = Double()
    var interest_pay3 = Double()
    var interest_pay4 = Double()
    var principal_pay1 = Double()
    var principal_pay2 = Double()
    var principal_pay3 = Double()
    var principal_pay4 = Double()
    //temp1---------------------------------------------
    // var x1 = α*(p*i)
    // if (x1*100 - floor(x1*100) > 0.499999) && (x1*100 - floor(x1*100) < 0.5) {
    //   interest_pay1 = round(x1*100 + 1)/100
    // } else {
    //   interest_pay1 = round(x1*100)/100
    // }
    interest_pay1 = CR(x: α*(p*i))
    // var tempxx = Double()
    // if (p*i*100 - floor(p*i*100) > 0.499999)
    //     && (p*i*100 - floor(p*i*100) < 0.5) {
    //   tempxx = (round(p*i*100 + 1)+1)/100
    // } else {
    //   tempxx = (round(p*i*100)+1)/100
    // }
    // tempxx = CR(x: p*i) + 1/100
    if (a == a_min) {
      if (progress == 100) {
        principal_pay1 = a - interest_pay1
      } else {
        principal_pay1 = a - interest_pay1
      }
    } else {
      principal_pay1 = a - interest_pay1
    }
    temp1 = p - principal_pay1
    //temp2---------------------------------------------
    // x1 = α*(temp1*i)
    // if (x1*100 - floor(x1*100) > 0.499999) && (x1*100 - floor(x1*100) < 0.5) {
    //   interest_pay2 = round(x1*100 + 1)/100
    // } else {
    //   interest_pay2 = round(x1*100)/100
    // }
    interest_pay2 = CR(x: α*(temp1*i))
    if (a == a_min) {
      if (progress == 100) {
        principal_pay2 = a - interest_pay2
      } else {
        principal_pay2 = a - interest_pay2
      }
    } else {
      principal_pay2 = a - interest_pay2
    }
    temp2 = temp1 - principal_pay2
    //temp3------------------------------------------------
    // x1 = α*(temp2*i)
    // if (x1*100 - floor(x1*100) > 0.499999) && (x1*100 - floor(x1*100) < 0.5) {
    //   interest_pay3 = round(x1*100 + 1)/100
    // } else {
    //   interest_pay3 = round(x1*100)/100
    // }
    interest_pay3 = CR(x: α*(temp2*i))
    if (a == a_min) {
      if (progress == 100) {
        principal_pay3 = a - interest_pay3
      } else {
        principal_pay3 = a - interest_pay3
      }
    } else {
      principal_pay3 = a - interest_pay3
    }
    temp3 = temp2 - principal_pay3
    //temp4------------------------------------------------
    // x1 = α*(temp3*i)
    // if (x1*100 - floor(x1*100) > 0.499999) && (x1*100 - floor(x1*100) < 0.5) {
    //   interest_pay4 = round(x1*100 + 1)/100
    // } else {
    //   interest_pay4 = round(x1*100)/100
    // }
    interest_pay4 = CR(x: α*(temp3*i))
    if (a == a_min) {
      if (progress == 100) {
        principal_pay4 = a - interest_pay4
      } else {
        principal_pay4 = a - interest_pay4
      }
    } else {
      principal_pay4 = a - interest_pay4
    }
    temp4 = temp3 - principal_pay4
    if (i == 0) {
      note_view.isHidden = true
    } else {
      note_view.isHidden = false
    }
    //Text of balance body------------------------------
    if (n-1 > 0) {
      refund.isHidden = true
      coffee_cup.isHidden = true
    } else {
      refund.isHidden = false
      coffee_cup.isHidden = false
    }
    if (n-1 > 4) {
      let balance_shape_label_jg4 = NSMutableAttributedString(
        string: String(format: "%.2f", p)
          + "\n"
          + String(format: "%.2f", temp1)
          + "\n"
          + String(format: "%.2f", temp2)
          + "\n"
          + String(format: "%.2f", temp3)
          + "\n",
        attributes: [:]
      )
      var etc = NSMutableAttributedString()
      etc = NSMutableAttributedString(
        string: "︙\n",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
      )
      let remains = NSMutableAttributedString(
        string: String(format: "%.2f", B),
        attributes: [:]
      )
      balance_shape_label_jg4.append(etc)
      balance_shape_label_jg4.append(remains)
      balance_shape_label.attributedText = balance_shape_label_jg4
    } else if (n-1 == 4) {
      balance_shape_label.text = String(format: "%.2f", p)
        + "\n"
        + String(format: "%.2f", temp1)
        + "\n"
        + String(format: "%.2f", temp2)
        + "\n"
        + String(format: "%.2f", temp3)
        + "\n"
        + String(format: "%.2f", B)
    } else if (n-1 == 3) {
      balance_shape_label.text = String(format: "%.2f", p)
        + "\n"
        + String(format: "%.2f", temp1)
        + "\n"
        + String(format: "%.2f", temp2)
        + "\n"
        + String(format: "%.2f", B)
    } else if (n-1 == 2) {
      balance_shape_label.text = String(format: "%.2f", p)
        + "\n"
        + String(format: "%.2f", temp1)
        + "\n"
        + String(format: "%.2f", B)
    } else if (n-1 == 1) {
      balance_shape_label.text = String(format: "%.2f", p)
        + "\n"
        + String(format: "%.2f", B)
    } else {
      balance_shape_label.text = String(format: "%.2f", B)
    }
    balance_shape_label.textAlignment = .center
    balance_shape_label.numberOfLines = 0
    balance_shape_label.font = UIFont(name: "CMUSerif-Roman", size: 16.0)
    balance_shape_label.adjustsFontSizeToFitWidth = true
    //Text of interest body----------------------
    var temp_peri = Int() //don't want it rounding, unless remainder has repeated 9s at one millionths place onward
    if (i*100000 - floor(i*100000) > 0.99999) {
      temp_peri = Int(i*100000)+1
    } else {
      temp_peri = Int(i*100000)
    }
    var remainder_peri = String(".") //resetting the string
    if (String(temp_peri).count < 5) {
      for _ in 1...(5-String(temp_peri).count) {
        remainder_peri.append("0")
      }
    }
    var charged_interest_max_string_count = Int()
    if (n-1 > 4) {
      let paragraph_charged_interest = NSMutableParagraphStyle()
      paragraph_charged_interest.alignment = .right
      let paragraph_charged_interest_ellipse = NSMutableParagraphStyle()
      paragraph_charged_interest_ellipse.alignment = .center
      let charged_interest_shape_label_jg4 = NSMutableAttributedString(
        string: String(format: "%.2f", p)
          + " · 0" + remainder_peri
          + String(temp_peri)
          + "...\n"
          + String(format: "%.2f", temp1)
          + " · 0" + remainder_peri
          + String(temp_peri)
          + "...\n"
          + String(format: "%.2f", temp2)
          + " · 0" + remainder_peri
          + String(temp_peri)
          + "...\n"
          + String(format: "%.2f", temp3)
          + " · 0" + remainder_peri
          + String(temp_peri)
          + "...\n",
        attributes: [
          NSAttributedString.Key.paragraphStyle: paragraph_charged_interest
        ]
      )
      var etc = NSMutableAttributedString()
      etc = NSMutableAttributedString(
        string: "︙\n",
        attributes: [
          NSAttributedString.Key.foregroundColor: UIColor.lightGray,
          NSAttributedString.Key.paragraphStyle: paragraph_charged_interest_ellipse
        ]
      )
      let remains = NSMutableAttributedString(
        string: String(format: "%.2f", B)
          + " · 0" + remainder_peri
          + String(temp_peri)
          + "...",
        attributes: [
          NSAttributedString.Key.paragraphStyle: paragraph_charged_interest
        ]
      )
      if (i == 0) {
        charged_interest_shape_label_jg4.setAttributes(
          [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(
              0.5
            ),
            NSAttributedString.Key.paragraphStyle: paragraph_charged_interest
          ],
          range: NSRange(
            location: 0,
            length: charged_interest_shape_label_jg4.length
          )
        )
        etc.setAttributes(
          [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(
              0.125
            ),
            NSAttributedString.Key.paragraphStyle: paragraph_charged_interest_ellipse
          ],
          range: NSRange(location: 0, length: etc.length)
        )
        remains.setAttributes(
          [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(
              0.5
            ),
            NSAttributedString.Key.paragraphStyle: paragraph_charged_interest
          ],
          range: NSRange(location: 0, length: remains.length)
        )
      } else { }
      charged_interest_shape_label_jg4.append(etc)
      charged_interest_shape_label_jg4.append(remains)
      charged_interest_shape_label.attributedText = charged_interest_shape_label_jg4
      charged_interest_max_string_count = (String(format: "%.2f", p)
          + " · 0" + remainder_peri
          + String(temp_peri)
          + "...").count //used for right inset
    } else if (n-1 == 4) {
      charged_interest_shape_label.text = String(format: "%.2f", p)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "...\n"
        + String(format: "%.2f", temp1)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "...\n"
        + String(format: "%.2f", temp2)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "...\n"
        + String(format: "%.2f", temp3)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "...\n"
        + String(format: "%.2f", B)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "..."
      charged_interest_shape_label.textAlignment = .right
      if (i == 0) {
        charged_interest_shape_label.textColor = UIColor.lightGray.withAlphaComponent(
          0.5
        )
      } else { }
      charged_interest_max_string_count = (String(format: "%.2f", p)
          + " · 0" + remainder_peri
          + String(temp_peri)
          + "...").count //used for right inset
    } else if (n-1 == 3) {
      charged_interest_shape_label.text = String(format: "%.2f", p)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "...\n"
        + String(format: "%.2f", temp1)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "...\n"
        + String(format: "%.2f", temp2)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "...\n"
        + String(format: "%.2f", B)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "..."
      charged_interest_shape_label.textAlignment = .right
      if (i == 0) {
        charged_interest_shape_label.textColor = UIColor.lightGray.withAlphaComponent(
          0.5
        )
      } else { }
      charged_interest_max_string_count = (String(format: "%.2f", p)
          + " · 0" + remainder_peri
          + String(temp_peri)
          + "...").count //used for right inset
    } else if (n-1 == 2) {
      charged_interest_shape_label.text = String(format: "%.2f", p)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "...\n"
        + String(format: "%.2f", temp1)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "...\n"
        + String(format: "%.2f", B)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "..."
      charged_interest_shape_label.textAlignment = .right
      if (i == 0) {
        charged_interest_shape_label.textColor = UIColor.lightGray.withAlphaComponent(
          0.5
        )
      } else { }
      charged_interest_max_string_count = (String(format: "%.2f", p)
          + " · 0" + remainder_peri
          + String(temp_peri)
          + "...").count //used for right inset
    } else if (n-1 == 1) {
      charged_interest_shape_label.text = String(format: "%.2f", p)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "...\n"
        + String(format: "%.2f", B)
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "..."
      charged_interest_shape_label.textAlignment = .right
      if (i == 0) {
        charged_interest_shape_label.textColor = UIColor.lightGray.withAlphaComponent(
          0.5
        )
      } else { }
      charged_interest_max_string_count = (String(format: "%.2f", p)
          + " · 0" + remainder_peri
          + String(temp_peri)
          + "...").count //used for right inset
    } else {
      charged_interest_shape_label.text = String(
          format: "%.2f",
          B
        )
        + " · 0" + remainder_peri
        + String(temp_peri)
        + "..."
      charged_interest_shape_label.textAlignment = .right
      if (i == 0) {
        charged_interest_shape_label.textColor = UIColor.lightGray.withAlphaComponent(
          0.5
        )
      } else { }
      charged_interest_max_string_count = (String(
            format: "%.2f",
            B
          )
          + " · 0" + remainder_peri
          + String(temp_peri)
          + "...").count //used for right inset
    }
    charged_interest_shape_label.numberOfLines = 0
    charged_interest_shape_label.font = UIFont(
      name: "CMUSerif-Roman",
      size: 16.0
    )
    charged_interest_shape_label.adjustsFontSizeToFitWidth = true
    //Text of payment body--------------------------------------------
    // var remaining_interest = Double()
    // if (B*i*100 - floor(B*i*100) > 0.499999)
    //     && (B*i*100 - floor(B*i*100) < 0.5) {
    //   remaining_interest = round(B*i*100 + 1)/100
    // } else {
    //   remaining_interest = round(B*i*100)/100
    // }
    interest_owed = CR(x: B*i)
    // var a_min = Double()
    // if (p*i*100 - floor(p*i*100) > 0.499999)
    //     && (p*i*100 - floor(p*i*100) < 0.5) {
    //   tempx = (round(p*i*100 + 1)+1)/100
    // } else {
    //   tempx = (round(p*i*100)+1)/100
    // }
    // a_min = CR(x: p*i) + 1/100
    if (n-1 > 4) { //a lot of this seems redundant
      var payment_shape_label_jg4 = NSMutableAttributedString()
      var etc = NSMutableAttributedString()
      var remains = NSMutableAttributedString()
      if (a == a_min) {
        if (progress == 100) {
          payment_shape_label_jg4 = NSMutableAttributedString(
            string: String(format: "%.2f", a)
              + "\n"
              + String(format: "%.2f", a)
              + "\n"
              + String(format: "%.2f", a)
              + "\n"
              + String(format: "%.2f", a)
              + "\n",
            attributes: [:]
          )
          etc = NSMutableAttributedString(
            string: "︙\n",
            attributes: [
              NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ]
          )
          remains = NSMutableAttributedString(
            string: String(
              format: "%.2f",
              B + interest_owed + O
            ),
            attributes: [:]
          )
        } else {
          payment_shape_label_jg4 = NSMutableAttributedString(
            string: String(format: "%.2f", a)
              + "\n"
              + String(format: "%.2f", a)
              + "\n"
              + String(format: "%.2f", a)
              + "\n"
              + String(format: "%.2f", a)
              + "\n",
            attributes: [:]
          )
          etc = NSMutableAttributedString(
            string: "︙\n",
            attributes: [
              NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ]
          )
          remains = NSMutableAttributedString(
            string: String(
              format: "%.2f",
              B + interest_owed + O
            ),
            attributes: [:]
          )
        }
      } else {
        payment_shape_label_jg4 = NSMutableAttributedString(
          string: String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n",
          attributes: [:]
        )
        etc = NSMutableAttributedString(
          string: "︙\n",
          attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
          ]
        )
        remains = NSMutableAttributedString(
          string: String(
            format: "%.2f",
            B + interest_owed + O
          ),
          attributes: [:]
        )
      }
      payment_shape_label_jg4.append(etc)
      payment_shape_label_jg4.append(remains)
      payment_shape_label.attributedText = payment_shape_label_jg4
    } else if (n-1 == 4) {
      if (a == a_min) {
        if (progress == 100) {
          payment_shape_label.text = String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(
              format: "%.2f",
              B + interest_owed + O
            )
        } else {
          payment_shape_label.text = String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(
              format: "%.2f",
              B + interest_owed + O
            )
        }
      } else {
        payment_shape_label.text = String(format: "%.2f", a)
          + "\n"
          + String(format: "%.2f", a)
          + "\n"
          + String(format: "%.2f", a)
          + "\n"
          + String(format: "%.2f", a)
          + "\n"
          + String(
            format: "%.2f",
            B + interest_owed + O
          )
      }
    } else if (n-1 == 3) {
      if (a == a_min) {
        if (progress == 100) {
          payment_shape_label.text = String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(
              format: "%.2f",
              B + interest_owed + O
            )
        } else {
          payment_shape_label.text = String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(
              format: "%.2f",
              B + interest_owed + O
            )
        }
      } else {
        payment_shape_label.text = String(format: "%.2f", a)
          + "\n"
          + String(format: "%.2f", a)
          + "\n"
          + String(format: "%.2f", a)
          + "\n"
          + String(
            format: "%.2f",
            B + interest_owed + O
          )
      }
    } else if (n-1 == 2) {
      if (a == a_min) {
        if (progress == 100) {
          payment_shape_label.text = String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(
              format: "%.2f",
              B + interest_owed + O
            )
        } else {
          payment_shape_label.text = String(format: "%.2f", a)
            + "\n"
            + String(format: "%.2f", a)
            + "\n"
            + String(
              format: "%.2f",
              B + interest_owed + O
            )
        }
      } else {
        payment_shape_label.text = String(format: "%.2f", a)
          + "\n"
          + String(format: "%.2f", a)
          + "\n"
          + String(
            format: "%.2f",
            B + interest_owed + O
          )
      }
    } else if (n-1 == 1) {
      if (a == a_min) {
        if (progress == 100) {
          payment_shape_label.text = String(format: "%.2f", a)
            + "\n"
            + String(
              format: "%.2f",
              B + interest_owed + O
            )
        } else {
          payment_shape_label.text = String(format: "%.2f", a)
            + "\n"
            + String(
              format: "%.2f",
              B + interest_owed + O
            )
        }
      } else {
        payment_shape_label.text = String(format: "%.2f", a)
          + "\n"
          + String(
            format: "%.2f",
            B + interest_owed + O
          )
      }
    } else {
      payment_shape_label.text = String(
        format: "%.2f",
        B + interest_owed + O
      )
    }
    payment_shape_label.textAlignment = .center
    payment_shape_label.numberOfLines = 0
    payment_shape_label.font = UIFont(name: "CMUSerif-Roman", size: 16.0)
    payment_shape_label.adjustsFontSizeToFitWidth = true
    //REMAINING------------------------------------------------------------
    if (n-1 > 4) {
      let remaining_label_jg4 = NSMutableAttributedString(
        string: String(format: "%.2f", temp1)
          + "\n"
          + String(format: "%.2f", temp2)
          + "\n"
          + String(format: "%.2f", temp3)
          + "\n"
          + String(format: "%.2f", temp4)
          + "\n",
        attributes: [:]
      )
      var etc = NSMutableAttributedString()
      etc = NSMutableAttributedString(
        string: "︙\n",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
      )
      let remains = NSMutableAttributedString(string: "0.00", attributes: [:])
      if (insight == 1) {
        remaining_label_jg4.setAttributes(
          [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(
              0.5
            )
          ],
          range: NSRange(location: 0, length: remaining_label_jg4.length)
        )
        etc.setAttributes(
          [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(
              0.125
            )
          ],
          range: NSRange(location: 0, length: etc.length)
        )
        remains.setAttributes(
          [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(
              0.5
            )
          ],
          range: NSRange(location: 0, length: remains.length)
        )
      } else {
        remaining_label_jg4.setAttributes(
          [NSAttributedString.Key.foregroundColor: UIColor.black],
          range: NSRange(location: 0, length: remaining_label_jg4.length)
        )
        etc.setAttributes(
          [NSAttributedString.Key.foregroundColor: UIColor.lightGray],
          range: NSRange(location: 0, length: etc.length)
        )
        remains.setAttributes(
          [NSAttributedString.Key.foregroundColor: UIColor.black],
          range: NSRange(location: 0, length: remains.length)
        )
      }
      remaining_label_jg4.append(etc)
      remaining_label_jg4.append(remains)
      remaining_label.attributedText = remaining_label_jg4
    } else if (n-1 == 4) {
      remaining_label.text = String(format: "%.2f", temp1)
        + "\n"
        + String(format: "%.2f", temp2)
        + "\n"
        + String(format: "%.2f", temp3)
        + "\n"
        + String(format: "%.2f", temp4)
        + "\n"
        + "0.00"
      if (insight == 1) {
        remaining_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
      } else {
        remaining_label.textColor = UIColor.black
      }
    } else if (n-1 == 3) {
      remaining_label.text = String(format: "%.2f", temp1)
        + "\n"
        + String(format: "%.2f", temp2)
        + "\n"
        + String(format: "%.2f", temp3)
        + "\n"
        + "0.00"
      if (insight == 1) {
        remaining_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
      } else {
        remaining_label.textColor = UIColor.black
      }
    } else if (n-1 == 2) {
      remaining_label.text = String(format: "%.2f", temp1)
        + "\n"
        + String(format: "%.2f", temp2)
        + "\n"
        + "0.00"
      if (insight == 1) {
        remaining_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
      } else {
        remaining_label.textColor = UIColor.black
      }
    } else if (n-1 == 1) {
      remaining_label.text = String(format: "%.2f", temp1) + "\n" + "0.00"
      if (insight == 1) {
        remaining_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
      } else {
        remaining_label.textColor = UIColor.black
      }
    } else {
      remaining_label.text = "0.00"
      if (insight == 1) {
        remaining_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
      } else {
        remaining_label.textColor = UIColor.black
      }
    }
    remaining_label.textAlignment = .center
    remaining_label.numberOfLines = 0
    remaining_label.font = UIFont(name: "CMUSerif-Roman", size: 16.0)
    remaining_label.adjustsFontSizeToFitWidth = true
    //Text of payment_insight--------------------------------------------
    var pay_insight_max_string_count_1 = Int()
    var pay_insight_max_string_count_2 = Int()
    if (n-1 > 4) {
      let paragraph_pay_insight = NSMutableParagraphStyle()
      paragraph_pay_insight.alignment = .right
      let paragraph_pay_insight_ellipse = NSMutableParagraphStyle()
      paragraph_pay_insight_ellipse.alignment = .center
      var payment_insight_shape_label_jg4 = NSMutableAttributedString()
      var etc = NSMutableAttributedString()
      var remains = NSMutableAttributedString()
      payment_insight_shape_label_jg4 = NSMutableAttributedString(
        string: String(format: "%.2f", principal_pay1)
          + " Prin.  + "
          + String(format: "%.2f", interest_pay1)
          + " Int. =\n"
          + String(format: "%.2f", principal_pay2)
          + " Prin.  + "
          + String(format: "%.2f", interest_pay2)
          + " Int. =\n"
          + String(format: "%.2f", principal_pay3)
          + " Prin.  + "
          + String(format: "%.2f", interest_pay3)
          + " Int. =\n"
          + String(format: "%.2f", principal_pay4)
          + " Prin.  + "
          + String(format: "%.2f", interest_pay4)
          + " Int. =\n",
        attributes: [
          NSAttributedString.Key.paragraphStyle: paragraph_pay_insight
        ]
      )
      etc = NSMutableAttributedString(
        string: "\n",
        attributes: [
          NSAttributedString.Key.foregroundColor: UIColor.lightGray,
          NSAttributedString.Key.paragraphStyle: paragraph_pay_insight_ellipse
        ]
      )
      remains = NSMutableAttributedString(
        string: String(format: "%.2f", B)
          + " Prin.  + "
          + String(format: "%.2f", interest_owed + O)
          + " Int. =",
        attributes: [
          NSAttributedString.Key.paragraphStyle: paragraph_pay_insight
        ]
      )
      payment_insight_shape_label_jg4.append(etc)
      payment_insight_shape_label_jg4.append(remains)
      pay_insight_shape_label.attributedText = payment_insight_shape_label_jg4
      pay_insight_max_string_count_1 = (String(format: "%.2f", a - interest_paid)
          + " Prin.  + "
          + String(format: "%.2f", interest_paid)
          + " Int. =").count //used for right inset
      pay_insight_max_string_count_2 = (String(format: "%.2f", B)
          + " Prin.  + "
          + String(format: "%.2f", interest_owed + O)
          + " Int. =").count //used for right inset
    } else if (n-1 == 4) {
      pay_insight_shape_label.text = String(format: "%.2f", principal_pay1)
        + " Prin.  + "
        + String(format: "%.2f", interest_pay1)
        + " Int. =\n"
        + String(format: "%.2f", principal_pay2)
        + " Prin.  + "
        + String(format: "%.2f", interest_pay2)
        + " Int. =\n"
        + String(format: "%.2f", principal_pay3)
        + " Prin.  + "
        + String(format: "%.2f", interest_pay3)
        + " Int. =\n"
        + String(format: "%.2f", principal_pay4)
        + " Prin.  + "
        + String(format: "%.2f", interest_pay4)
        + " Int. =\n"
        + String(format: "%.2f", B)
        + " Prin.  + "
        + String(format: "%.2f", interest_owed + O)
        + " Int. ="
      pay_insight_shape_label.textAlignment = .right
      pay_insight_max_string_count_1 = (String(format: "%.2f", a - interest_paid)
          + " Prin.  + "
          + String(format: "%.2f", interest_paid)
          + " Int. =").count //used for right inset
      pay_insight_max_string_count_2 = (String(format: "%.2f", B)
          + " Prin.  + "
          + String(format: "%.2f", interest_owed + O)
          + " Int. =").count //used for right inset
    } else if (n-1 == 3) {
      pay_insight_shape_label.text = String(format: "%.2f", principal_pay1)
        + " Prin.  + "
        + String(format: "%.2f", interest_pay1)
        + " Int. =\n"
        + String(format: "%.2f", principal_pay2)
        + " Prin.  + "
        + String(format: "%.2f", interest_pay2)
        + " Int. =\n"
        + String(format: "%.2f", principal_pay3)
        + " Prin.  + "
        + String(format: "%.2f", interest_pay3)
        + " Int. =\n"
        + String(format: "%.2f", B)
        + " Prin.  + "
        + String(format: "%.2f", interest_owed + O)
        + " Int. ="
      pay_insight_shape_label.textAlignment = .right
      pay_insight_max_string_count_1 = (String(format: "%.2f", a - interest_paid)
          + " Prin.  + "
          + String(format: "%.2f", interest_paid)
          + " Int. =").count //used for right inset
      pay_insight_max_string_count_2 = (String(format: "%.2f", B)
          + " Prin.  + "
          + String(format: "%.2f", interest_owed + O)
          + " Int. =").count //used for right inset
    } else if (n-1 == 2) {
      pay_insight_shape_label.text = String(format: "%.2f", principal_pay1)
        + " Prin.  + "
        + String(format: "%.2f", interest_pay1)
        + " Int. =\n"
        + String(format: "%.2f", principal_pay2)
        + " Prin.  + "
        + String(format: "%.2f", interest_pay2)
        + " Int. =\n"
        + String(format: "%.2f", B)
        + " Prin.  + "
        + String(format: "%.2f", interest_owed + O)
        + " Int. ="
      pay_insight_shape_label.textAlignment = .right
      pay_insight_max_string_count_1 = (String(format: "%.2f", a - interest_paid)
          + " Prin.  + "
          + String(format: "%.2f", interest_paid)
          + " Int. =").count //used for right inset
      pay_insight_max_string_count_2 = (String(format: "%.2f", B)
          + " Prin.  + "
          + String(format: "%.2f", interest_owed + O)
          + " Int. =").count //used for right inset
    } else if (n-1 == 1) {
      pay_insight_shape_label.text = String(format: "%.2f", principal_pay1)
        + " Prin.  + "
        + String(format: "%.2f", interest_pay1)
        + " Int. =\n"
        + String(format: "%.2f", B)
        + " Prin.  + "
        + String(format: "%.2f", interest_owed + O)
        + " Int. ="
      pay_insight_shape_label.textAlignment = .right
      pay_insight_max_string_count_1 = (String(format: "%.2f", a - interest_paid)
          + " Prin.  + "
          + String(format: "%.2f", interest_paid)
          + " Int. =").count //used for right inset
      pay_insight_max_string_count_2 = (String(format: "%.2f", B)
          + " Prin.  + "
          + String(format: "%.2f", interest_owed + O)
          + " Int. =").count //used for right inset
    } else {
      pay_insight_shape_label.text = String(format: "%.2f", B)
        + " Prin.  + "
        + String(format: "%.2f", interest_owed + O)
        + " Int. ="
      pay_insight_shape_label.textAlignment = .right
      pay_insight_max_string_count_1 = 0 //used for right inset
      pay_insight_max_string_count_2 = (String(format: "%.2f", B)
          + " Prin.  + "
          + String(format: "%.2f", interest_owed + O)
          + " Int. =").count //used for right inset
    }
    if (insight == 1) {
      note.text = "Last Month Charged Interest: "
        + String(format: "%.2f", interest_owed)
        + "\n"
        + "Outstanding Interest: "
        + String(format: "%.2f", O)
    } else {
      note.text = ""
    }
    let pay_insight_max_string_count = max(
      pay_insight_max_string_count_1,
      pay_insight_max_string_count_2
    )
    let textRect_balance_shape_label = CGRect(
      x: 0,
      y: 0,
      width: balance.frame.width,
      height: balance.frame.height
    )
    let insets_balance_shape_label = UIEdgeInsets(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0
    )
    balance_shape_label.frame = textRect_balance_shape_label.inset(
      by: insets_balance_shape_label
    )
    balance_shape_label.bounds = balance.frame
    add_label.frame = CGRect(
      x: 0,
      y: 0,
      width: add.frame.width,
      height: add.frame.height
    )
    add_label.bounds = add.frame
    let character_length = charged_interest.frame.width/23 //reference, counted 23 spaces myself
    let textRect_charged_interest = CGRect(
      x: 0,
      y: 0,
      width: charged_interest.frame.width,
      height: charged_interest.frame.height
    )
    let insets_charged_interest = UIEdgeInsets(
      top: 0,
      left: 0,
      bottom: 0,
      right: (charged_interest.frame.width
          - CGFloat(charged_interest_max_string_count)*character_length)/2
    )
    charged_interest_shape_label.frame = textRect_charged_interest.inset(
      by: insets_charged_interest
    )
    charged_interest_shape_label.bounds = charged_interest.frame
    subtract_label.frame = CGRect(
      x: 0,
      y: 0,
      width: subtract.frame.width,
      height: subtract.frame.height
    )
    subtract_label.bounds = subtract.frame
    payment_shape_label.frame = CGRect(
      x: 0,
      y: 0,
      width: payment.frame.width,
      height: payment.frame.height
    )
    payment_shape_label.bounds = payment.frame
    equals_label.frame = CGRect(
      x: 0,
      y: 0,
      width: equals.frame.width,
      height: equals.frame.height
    )
    equals_label.bounds = equals.frame
    let textRect_remaining_label = CGRect(
      x: 0,
      y: 0,
      width: remaining.frame.width,
      height: remaining.frame.height
    )
    let insets_remaining_label = UIEdgeInsets(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0
    )
    remaining_label.frame = textRect_remaining_label.inset(
      by: insets_remaining_label
    )
    remaining_label.bounds = remaining.frame
    pay_insight_shape.bounds = pay_insight.frame
    pay_insight_shape.position = pay_insight.center
    pay_insight_shape.path = UIBezierPath(
        roundedRect: pay_insight.bounds,
        byRoundingCorners: [.bottomLeft],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    pay_insight_header_shape.bounds = pay_insight_header.frame
    pay_insight_header_shape.position = pay_insight_header.center
    pay_insight_header_shape.path = UIBezierPath(
        roundedRect: pay_insight_header.bounds,
        byRoundingCorners: [.topLeft],
        cornerRadii: CGSize(width: 5, height: 5)
      ).cgPath
    pay_insight_shape.borderColor = UIColor(
        red: 207/255.0,
        green: 209/255.0,
        blue: 210/255.0,
        alpha: 0.95
      ).cgColor
    pay_insight_shape.borderWidth = 0
    let textRect_pay_insight = CGRect(
      x: 0,
      y: 0,
      width: pay_insight.frame.width,
      height: pay_insight.frame.height
    )
    let insets_pay_insight = UIEdgeInsets(
      top: 0,
      left: 0,
      bottom: 0,
      right: ((balance.frame.width+add.frame.width+charged_interest.frame.width+subtract.frame.width)
          - CGFloat(pay_insight_max_string_count)*character_length)/2
    )
    pay_insight_shape_label.frame = textRect_pay_insight.inset(
      by: insets_pay_insight
    )
    pay_insight_shape_label.bounds = pay_insight.frame
    pay_insight_shape_label.numberOfLines = 0
    pay_insight_shape_label.font = UIFont(name: "CMUSerif-Roman", size: 16.0)
    /* ------------------ END OF MONTHLY BALANCE TABLE ------------------ */

    if (n == 1)
        && (a
          - (B + interest_owed + O) != 0) {
      // var pt1 = Double()
      var refund_string = NSMutableAttributedString()
      if (a
          - (B + interest_owed + O)
          > 0) {
        refund_string = NSMutableAttributedString(
          string: "Refunded $",
          attributes: [:]
        )
        // pt1 = a - (B + interest_owed + O)
      } else {
        refund_string = NSMutableAttributedString(
          string: "Pay Extra $",
          attributes: [:]
        )
        // pt1 = abs(
        //   a - (B + interest_owed + O)
        // )
        refund.isHidden = false
      }
      // if (pt1*100 - floor(pt1*100) > 0.499999)
      //     && (pt1*100 - floor(pt1*100) < 0.5) {
      //   pt1 = round(pt1*100 + 1)/100
      // } else {
      //   pt1 = round(pt1*100)/100
      // }
      let pt1 = CR(x: abs(a - (B + interest_owed + O)))
      let pt2 = pt1 - floor(pt1)
      let pt3 = pt2*100
      var pt4 = Int()
      if (pt3 - floor(pt3) > 0.99999) {
        pt4 = Int(pt3 + 1)
      } else {
        pt4 = Int(pt3)
      }
      let refund_amount = NSMutableAttributedString(
        string: numberFormatter.string(from: NSNumber(value: floor(pt1)))!
      )
      var refund_amount_decimal_part = NSMutableAttributedString()
      if (pt3 < 100) && (pt3 >= 10) {
        refund_amount_decimal_part = NSMutableAttributedString(
          string: "." + String(pt4),
          attributes: [:]
        )
      } else if (pt3 < 10) && (pt3 >= 1) {
        refund_amount_decimal_part = NSMutableAttributedString(
          string: ".0" + String(pt4),
          attributes: [:]
        )
      } else {
        refund_amount_decimal_part = NSMutableAttributedString(
          string: "",
          attributes: [:]
        )
      }
      refund_string.append(refund_amount)
      refund_string.append(refund_amount_decimal_part)
      refund.attributedText = refund_string
      if (floor(pt1) >= 5)
          && (a
            - (B + interest_owed + O)
            > 0) {
        //arbitrary
        coffee_cup.text = "☕︎"
      } else {
        coffee_cup.text = ""
      }
    } else {
      refund.text = ""
      coffee_cup.text = ""
    }
    UserDefaults.standard.setValue(
      true,
      forKey: "_UIConstraintBasedLayoutLogUnsatisfiable"
    )
    var temp5 = Int()
    if (Double(n / 12) - floor(Double(n / 12)) > 0.99999) {
      //seems like too much
      temp5 = Int(floor(Double(n / 12) + 1))
    } else {
      temp5 = Int(floor(Double(n / 12)))
    }
    let t1 = Double(n) / 12
    let t2 = t1 - floor(t1)
    let t3 = t2*1000
    var t4 = Int()
    if (t3 - floor(t3) > 0.99999) {
      t4 = Int(t3 + 1)
    } else {
      t4 = Int(t3)
    }
    let years_string = NSMutableAttributedString(
      string: numberFormatter.string(from: NSNumber(value: n))!
    )
    var months_label = NSMutableAttributedString()
    if (n == 1) {
      months_label = NSMutableAttributedString(
        string: " month",
        attributes: [:]
      )
    } else {
      months_label = NSMutableAttributedString(
        string: " total months",
        attributes: [:]
      )
    }
    let years_amount = NSMutableAttributedString(
      string: " ÷ 12 = "
        + numberFormatter.string(from: NSNumber(value: temp5))!,
      attributes: [:]
    )
    var years_amount_decimal_part = NSMutableAttributedString()
    if (t3 < 1000) && (t3 >= 100) {
      years_amount_decimal_part = NSMutableAttributedString(
        string: "." + String(t4),
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
      )
    } else if (t3 < 100) && (t3 >= 10) {
      years_amount_decimal_part = NSMutableAttributedString(
        string: ".0" + String(t4),
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
      )
    } else if (t3 < 10) && (t3 >= 1) {
      years_amount_decimal_part = NSMutableAttributedString(
        string: ".00" + String(t4),
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
      )
    } else {
      years_amount_decimal_part = NSMutableAttributedString(
        string: "",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
      )
    }
    var years_amount_label = NSMutableAttributedString()
    if (temp5 == 1) {
      years_amount_label = NSMutableAttributedString(
        string: " year",
        attributes: [:]
      )
    } else {
      years_amount_label = NSMutableAttributedString(
        string: " years",
        attributes: [:]
      )
    }
    years_string.append(months_label)
    years_string.append(years_amount)
    years_string.append(years_amount_decimal_part)
    years_string.append(years_amount_label)
    months.text = numberFormatter.string(from: NSNumber(value: n))!
      + " – (12 · "
      + numberFormatter.string(from: NSNumber(value: temp5))!
      + ") = "
    if (n - 12 * temp5 == 1) {
      months.text! += String(n - 12 * temp5) + " month"
    } else {
      months.text! += String(n - 12 * temp5) + " months"
    }
    if (temp5 == 0) {
      years.text = "0 years"
      if (n == 1) {
        months.text = String(n) + " month"
      } else {
        months.text = String(n) + " months"
      }
    } else {
      if (n - 12 * temp5 == 0) {
        years.attributedText = years_string
        months.text = "0 months"
      } else {
        years.attributedText = years_string
        months.text = months.text!
      }
    }
    years.adjustsFontSizeToFitWidth = true
    months.adjustsFontSizeToFitWidth = true
    var T = Double() //T(a)
    // var tempxxx = Double()
    // if (p*i*100 - floor(p*i*100) > 0.499999)
    //     && (p*i*100 - floor(p*i*100) < 0.5) {
    //   tempxxx = (round(p*i*100 + 1)+1)/100
    // } else {
    //   tempxxx = (round(p*i*100)+1)/100
    // }
    // tempxxx = CR(x: p*i) + 1/100
    if (a == a_min) {
      if (progress == 100) {
        T = Double(n-1)
          * a
          + B
          + interest_owed
          + O
      } else {
        T = Double(n-1)
          * a
          + B
          + interest_owed
          + O
      }
    } else {
      T = Double(n-1)
        * a
        + B
        + interest_owed
        + O
    }
    // if (T*100 - floor(T*100) > 0.499999)
    //     && (T*100 - floor(T*100) < 0.5) {
    //   T = round(T*100 + 1)/100
    // } else {
    //   T = round(T*100)/100
    // }
    T = CR(x: T)
    let ppt2 = T - floor(T)
    let ppt3 = ppt2*100
    var ppt4 = Int()
    if (ppt3 - floor(ppt3) > 0.99999) {
      ppt4 = Int(ppt3 + 1)
    } else {
      ppt4 = Int(ppt3)
    }
    let total_paid_string = NSMutableAttributedString()
    var total_paid_expression = NSMutableAttributedString()
    if (a == a_min) {
      if (progress == 100) {
        total_paid_expression = NSMutableAttributedString(
          string: "("
            + numberFormatter.string(from: NSNumber(value: n-1))!
            + " · "
            + String(format: "%.2f", a)
            + ") + "
            + String(
              format: "%.2f",
              B + interest_owed + O
            )
            + " = ",
          attributes: [:]
        )
      } else {
        total_paid_expression = NSMutableAttributedString(
          string: "("
            + numberFormatter.string(from: NSNumber(value: n-1))!
            + " · "
            + String(format: "%.2f", a)
            + ") + "
            + String(
              format: "%.2f",
              B + interest_owed + O
            )
            + " = ",
          attributes: [:]
        )
      }
    } else {
      total_paid_expression = NSMutableAttributedString(
        string: "("
          + numberFormatter.string(from: NSNumber(value: n-1))!
          + " · "
          + String(format: "%.2f", a)
          + ") + "
          + String(
            format: "%.2f",
            B + interest_owed + O
          )
          + " = ",
        attributes: [:]
      )
    }
    let total_paid_amount = NSMutableAttributedString(
      string: numberFormatter.string(from: NSNumber(value: floor(T)))!
    )
    var total_paid_amount_decimal_part = NSMutableAttributedString()
    if (ppt3 < 100) && (ppt3 >= 10) {
      total_paid_amount_decimal_part = NSMutableAttributedString(
        string: "." + String(ppt4),
        attributes: [:]
      )
    } else if (ppt3 < 10) && (ppt3 >= 1) {
      total_paid_amount_decimal_part = NSMutableAttributedString(
        string: ".0" + String(ppt4),
        attributes: [:]
      )
    } else {
      total_paid_amount_decimal_part = NSMutableAttributedString(
        string: "",
        attributes: [:]
      )
    }
    var total_paid_amount_decimal_part_label = NSMutableAttributedString()
    total_paid_amount_decimal_part_label = NSMutableAttributedString(
      string: " paid"
    )
    if (n-1 == 0) { } else {
      total_paid_string.append(total_paid_expression)
    }
    total_paid_string.append(NSMutableAttributedString(string: "$"))
    total_paid_string.append(total_paid_amount)
    total_paid_string.append(total_paid_amount_decimal_part)
    total_paid_string.append(total_paid_amount_decimal_part_label)
    total_paid.attributedText = total_paid_string
    var m_min = 1 //defined here in order to simplify the rest
    var n_min = Int()
    var B_min = p //defined here in order to simplify the rest too
    var O_min = 0.00
    var interest_owed_min = Double()
    // if (B_min*i*100
    //       - floor(B_min*i*100)
    //       > 0.499999)
    //     && (B_min*i*100
    //       - floor(B_min*i*100)
    //       < 0.5) {
    //   interest_owed_min = round(B_min*i*100 + 1)/100
    // } else {
    //   interest_owed_min = round(B_min*i*100)/100
    // }
    interest_owed_min = CR(x: B_min*i)
    var interest_paid_min = Double()
    // var xxx = α*(B_min*i)
    // if (xxx*100 - floor(xxx*100) > 0.499999)
    //     && (xxx*100 - floor(xxx*100) < 0.5) {
    //   interest_paid_min = round(xxx*100 + 1)/100
    // } else {
    //   interest_paid_min = round(xxx*100)/100
    // }
    interest_paid_min = CR(x: α*(B_min*i))
    // var a_min = Double()
    // var temp_pay = Double()
    if (tenyr_indicator == 0) {
      // if (p*i*100 - floor(p*i*100) > 0.499999)
      //     && (p*i*100 - floor(p*i*100) < 0.5) {
      //   temp_pay = (round(p*i*100 + 1))/100
      // } else {
      //   temp_pay = (round(p*i*100))/100
      // }
      // let xx = α*(p*i)
      // if (xx*100 - floor(xx*100) > 0.499999) && (xx*100 - floor(xx*100) < 0.5) {
      //   a_min = (round(xx*100 + 1)+1)/100
      // } else {
      //   a_min = (round(xx*100) + 1)/100
      // }
      a_min = CR(x: α*(p*i)) + 1/100
      // temp_pay = a_min - interest_pay_min
//      if (temp_pay*100 - floor(temp_pay*100) > 0.499999)
//          && (temp_pay*100 - floor(temp_pay*100) < 0.5) {
//        temp_pay = round(temp_pay*100 + 1)/100
//      } else {
//        temp_pay = round(temp_pay*100)/100
//      }
    } else {
      if (i != 0) {
        if (progress != 0) {
          a_min = ceil(
              (α*(p*i)*pow(1+α*i, 120))
                / (pow(1+α*i, 120) - 1)*100
            )/100
          a_min += CT()
          // a_min = temp_pay
          // temp_pay = a_min - interest_pay_min
//          if (temp_pay*100 - floor(temp_pay*100) > 0.499999)
//              && (temp_pay*100 - floor(temp_pay*100) < 0.5) {
//            temp_pay = round(temp_pay*100 + 1)/100
//          } else {
//            temp_pay = round(temp_pay*100)/100
//          }
        } else {
          a_min = ceil(p/120*100)/100
          // temp_pay = a_min
        }
      } else {
        a_min = ceil(p/120*100)/100
        // temp_pay = a_min
      }
    }
    while (B_min - (a_min - interest_paid_min) > 0) {
      B_min = B_min - (a_min - interest_paid_min)
      // if (B_min*100
      //       - floor(B_min*100)
      //       > 0.499999)
      //     && (B_min*100
      //       - floor(B_min*100)
      //       < 0.5) {
      //   B_min = round(
      //       B_min*100 + 1
      //     )/100
      // } else {
      //   B_min = round(
      //       B_min*100
      //     )/100
      // }
      B_min = CR(x: B_min)
      O_min = O_min + (interest_owed_min - interest_paid_min)
      // if (O_min*100 - floor(O_min*100) > 0.499999)
      //     && (O_min*100 - floor(O_min*100) < 0.5) {
      //     O_min = round(O_min*100 + 1)/100
      // } else {
      //     O_min = round(O_min*100)/100
      // }
      O_min = CR(x: O_min)
      // if (B_min*i*100
      //       - floor(B_min*i*100)
      //       > 0.499999)
      //     && (B_min*i*100
      //       - floor(B_min*i*100)
      //       < 0.5) {
      //   interest_owed_min = round(B_min*i*100 + 1)/100
      // } else {
      //   interest_owed_min = round(B_min*i*100)/100
      // }
      interest_owed_min = CR(x: B_min*i)
      // xxx = α*(B_min*i)
      // if (xxx*100 - floor(xxx*100) > 0.499999)
      //     && (xxx*100 - floor(xxx*100) < 0.5) {
      //   interest_paid_min = round(xxx*100 + 1)/100
      // } else {
      //   interest_paid_min = round(xxx*100)/100
      // }
      interest_paid_min = CR(x: α*(B_min*i))
      // if (tenyr_indicator == 0) {
        // if (p*i*100 - floor(p*i*100) > 0.499999)
        //     && (p*i*100 - floor(p*i*100) < 0.5) {
        //   temp_pay = (round(p*i*100 + 1))/100
        // } else {
        //   temp_pay = (round(p*i*100))/100
        // }
        // let xx = α*(p*i)
        // if (xx*100 - floor(xx*100) > 0.499999)
        //     && (xx*100 - floor(xx*100) < 0.5) {
        //   temp_pay = (round(xx*100 + 1)+1)/100 - interest_pay_min
        // } else {
        //   temp_pay = (round(xx*100) + 1)/100 - interest_pay_min
        // }
        // temp_pay = a_min - interest_pay_min
      //  if (temp_pay*100 - floor(temp_pay*100) > 0.499999)
      //      && (temp_pay*100 - floor(temp_pay*100) < 0.5) {
      //    temp_pay = round(temp_pay*100 + 1)/100
      //  } else {
      //    temp_pay = round(temp_pay*100)/100
      //  }
      // } else {
        // if (i != 0) {
          // if (progress != 0) {
            // a_min = ceil(
            //     (α*(p*i)*pow(1+α*i, 120))
            //       / (pow(1+α*i, 120) - 1)*100
            //   )/100
            // a_min += CT()
            // temp_pay = a_min - interest_pay_min
//            if (temp_pay*100 - floor(temp_pay*100) > 0.499999)
//                && (temp_pay*100 - floor(temp_pay*100) < 0.5) {
//              temp_pay = round(temp_pay*100 + 1)/100
//            } else {
//              temp_pay = round(temp_pay*100)/100
//            }
          // } else {
            // temp_pay = ceil(p/120*100)/100
            // temp_pay = a_min
            // temp_pay_first = temp_pay
          // }
        // } else {
          // temp_pay = ceil(p/120*100)/100
          // temp_pay = a_min
        // }
      // }
      m_min += 1
    }
    n_min = m_min
    // if (B_min*i*100
    //       - floor(B_min*i*100)
    //       > 0.499999)
    //     && (B_min*i*100
    //       - floor(B_min*i*100)
    //       < 0.5) {
    //   interest_owed_min = round(B_min*i*100 + 1)/100
    // } else {
    //   interest_owed_min = round(B_min*i*100)/100
    // }
    interest_owed_min = CR(x: B_min*i)
    let temp_interest_last_min = interest_owed_min
    // let total_repay_minimum_fromloop = Double(n_min-1) * a_min
    // let total_repay_minimum_finalmonth = remainingbalance_repay_minimum
    //   + temp_interest_last_min
    //   + outstandingbalance_min
    var T_max = Double(n_min-1)*a_min
      + B_min
      + temp_interest_last_min
      + O_min
    //appended to total paid
    // var pppt1 = T_max
    // if (T_max*100 - floor(T_max*100) > 0.499999)
    //     && (T_max*100 - floor(T_max*100) < 0.5) {
    //   T_max = round(T_max*100 + 1)/100
    // } else {
    //   T_max = round(T_max*100)/100
    // }
    T_max = CR(x: T_max)
    let pppt2 = T_max - floor(T_max)
    let pppt3 = pppt2*100
    var pppt4 = Int()
    if (pppt3 - floor(pppt3) > 0.99999) {
      pppt4 = Int(pppt3 + 1)
    } else {
      pppt4 = Int(pppt3)
    }
    let total_paid_string_if_min = NSMutableAttributedString()
    var total_paid_expression_if_min = NSMutableAttributedString()
    // let T = ppt1
    if (round(T_max-T) == 0.0) {
      //bizzare that cannot use T_max-T <= 0.0
      total_paid_expression_if_min = NSMutableAttributedString(
        string: "",
        attributes: [:]
      )
    } else {
      total_paid_expression_if_min = NSMutableAttributedString(
        string: "("
          + numberFormatter.string(from: NSNumber(value: n_min-1))!
          + " · "
          + String(format: "%.2f", a_min)
          + ") + "
          + String(format: "%.2f", B_min + temp_interest_last_min + O_min)
          + " = ",
        attributes: [:]
      )
    }
    var total_paid_amount_if_min = NSMutableAttributedString()
    total_paid_amount_if_min = NSMutableAttributedString(
      string: "$" + numberFormatter.string(from: NSNumber(value: floor(T_max)))!
    )
    var total_paid_amount_decimal_part_if_min = NSMutableAttributedString()
    if (pppt3 < 100) && (pppt3 >= 10) {
      total_paid_amount_decimal_part_if_min = NSMutableAttributedString(
        string: "." + String(pppt4),
        attributes: [:]
      )
    } else if (pppt3 < 10) && (pppt3 >= 1) {
      total_paid_amount_decimal_part_if_min = NSMutableAttributedString(
        string: ".0" + String(pppt4),
        attributes: [:]
      )
    } else {
      total_paid_amount_decimal_part_if_min = NSMutableAttributedString(
        string: "",
        attributes: [:]
      )
    }
    let total_paid_amount_if_min_label = NSMutableAttributedString(
      string: " max"
    )
    total_paid_string_if_min.append(total_paid_string_if_min)
    total_paid_string_if_min.append(total_paid_expression_if_min)
    total_paid_string_if_min.append(total_paid_amount_if_min)
    total_paid_string_if_min.append(total_paid_amount_decimal_part_if_min)
    total_paid_string_if_min.append(total_paid_amount_if_min_label)
    total_paid_min.attributedText = total_paid_string_if_min
    total_paid_min.isHidden = false
    var s = T_max-T //T_max - T(a)
    // if (s*100 - floor(s*100) > 0.499999)
    //     && (s*100 - floor(s*100) < 0.5) {
    //   s = round(s*100 + 1)/100
    // } else {
    //   s = round(s*100)/100
    // }
    s = CR(x: s)
    let ppppt2 = s - floor(s)
    let ppppt3 = ppppt2*100
    var ppppt4 = Int()
    if (ppppt3 - floor(ppppt3) > 0.99999) {
      ppppt4 = Int(ppppt3 + 1)
    } else {
      ppppt4 = Int(ppppt3)
    }
    // let saved = ppppt1
    let savings_string = NSMutableAttributedString()
    var savings_string_subtract = NSMutableAttributedString()
    savings_string_subtract = NSMutableAttributedString(
      string: " – ",
      attributes: [:]
    )
    let savings_string_equals = NSMutableAttributedString(
      string: " = $",
      attributes: [:]
    )
    var savings_string_equals_amount = NSMutableAttributedString()
    var savings_string_equals_amount_decimal_part = NSMutableAttributedString()
    if (s <= 0) {
      savings_string_equals_amount = NSMutableAttributedString(string: "0")
      savings_string_equals_amount_decimal_part = NSMutableAttributedString(
        string: ""
      )
    } else {
      savings_string_equals_amount = NSMutableAttributedString(
        string: numberFormatter.string(from: NSNumber(value: floor(s)))!
      )
      if (ppppt3 < 100) && (ppppt3 >= 10) {
        savings_string_equals_amount_decimal_part = NSMutableAttributedString(
          string: "." + String(ppppt4),
          attributes: [:]
        )
      } else if (ppppt3 < 10) && (ppppt3 >= 1) {
        savings_string_equals_amount_decimal_part = NSMutableAttributedString(
          string: ".0" + String(ppppt4),
          attributes: [:]
        )
      } else {
        savings_string_equals_amount_decimal_part = NSMutableAttributedString(
          string: "",
          attributes: [:]
        )
      }
    }
    savings_string.append(total_paid_amount_if_min)
    savings_string.append(total_paid_amount_decimal_part_if_min)
    savings_string.append(savings_string_subtract)
    savings_string.append(NSMutableAttributedString(string: "$"))
    savings_string.append(total_paid_amount)
    savings_string.append(total_paid_amount_decimal_part)
    savings_string.append(savings_string_equals)
    savings_string.append(savings_string_equals_amount)
    savings_string.append(savings_string_equals_amount_decimal_part)
    savings.attributedText = savings_string
    savings.adjustsFontSizeToFitWidth = true
  }
    
}

//disable copy, paste, delete, etc.
extension UITextView {
  open override func canPerformAction(
    _ action: Selector,
    withSender sender: Any?
  ) -> Bool {
    return false
  }
}

