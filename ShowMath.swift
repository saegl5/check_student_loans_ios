import UIKit

class ShowMath: UIViewController {
    
    // Do you want to revert to old math screen?
    //let decision = true // false = No, true = Yes, default is false
    var decision = Bool()

    
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var loaned: UILabel!
    
    @IBOutlet weak var stack1_trailing: NSLayoutConstraint!
    @IBOutlet weak var stack1_leading: NSLayoutConstraint!
    @IBOutlet weak var aprstack_width: NSLayoutConstraint!
    @IBOutlet weak var add_width: NSLayoutConstraint!
    @IBOutlet weak var subtract_width: NSLayoutConstraint!
    @IBOutlet weak var equals_width: NSLayoutConstraint!
    
    
    @IBOutlet weak var nominal_rate: UILabel!
    //@IBOutlet weak var periodic_rate: UILabel!
    //@IBOutlet weak var decimal_equivalent: UILabel!
    @IBOutlet weak var pay_monthly: UILabel!
    //@IBOutlet weak var heading: UILabel!
    //@IBOutlet weak var headers: UIStackView!
    //@IBOutlet weak var pay_insight: UIView!
    
    @IBOutlet weak var titleof_compound: UILabel!
    @IBOutlet weak var APR_compound_stack: UIStackView!
    @IBOutlet weak var APR_stack: UIStackView!
    @IBOutlet weak var compound_stack: UIStackView!
    @IBOutlet weak var compound: UISwitch!
    @IBOutlet weak var pay_insight_header: UIButton!
    @IBOutlet weak var pay_insight: UIButton!
    
    @IBOutlet weak var monthly_balance: UILabel!
    @IBOutlet weak var table: UIStackView!
    @IBOutlet weak var table_header: UIStackView!
    @IBOutlet weak var table_height: NSLayoutConstraint!
    @IBOutlet weak var balance_header: UITextView!
    @IBOutlet weak var balance: UITextView!
    @IBOutlet weak var add: UITextView!
    @IBOutlet weak var interest_header: UITextView!
    @IBOutlet weak var charged_interest: UITextView!
    @IBOutlet weak var subtract: UITextView!
    @IBOutlet weak var payment_header: UIButton!
    //@IBOutlet weak var payment_header: UITextView!
    @IBOutlet weak var payment: UIButton!
    @IBOutlet weak var enlarge: UIButton!
    @IBOutlet weak var shrink: UIButton!
    
    //@IBOutlet weak var payment: UITextView!
    @IBOutlet weak var equals: UITextView!
    @IBOutlet weak var remaining: UITextView!
    @IBOutlet weak var note_view: UIStackView!
    //@IBOutlet weak var month1: UILabel!
    //@IBOutlet weak var month2: UILabel!
    //@IBOutlet weak var month3: UILabel!
    //@IBOutlet weak var month4: UILabel!
    //@IBOutlet weak var keep_going_until: UILabel!
    //@IBOutlet weak var monthmax: UILabel!
    @IBOutlet weak var refund: UILabel!
    @IBOutlet weak var coffee_cup: UILabel!
    @IBOutlet weak var note: UITextView! //mixed up with "outstanding"
    @IBOutlet weak var note_overlap: UITextView!
    @IBOutlet weak var note_constraint: NSLayoutConstraint!
    @IBOutlet weak var note_right: UITextView!
    @IBOutlet weak var years: UILabel!
    @IBOutlet weak var months: UILabel!
    @IBOutlet weak var total_paid: UILabel!
    @IBOutlet weak var total_paid_min: UILabel!
    @IBOutlet weak var savings: UILabel!
    let shared_preferences: UserDefaults = UserDefaults.standard
    internal var numberFormatter:NumberFormatter = NumberFormatter()
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var stack2: UIStackView!
    @IBOutlet weak var bottom_layout_guide: NSLayoutConstraint!
    @IBOutlet weak var stack3: UIStackView!
    @IBOutlet weak var headers: UIStackView!
    @IBOutlet weak var proportion: UIStackView!
    @IBOutlet weak var percent_interest: UILabel!
    @IBOutlet weak var slider_header: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var percent_balance: UILabel!
    @IBOutlet weak var plus_sign: UIImageView!
    @IBOutlet weak var minus_sign: UIImageView!
    @IBOutlet weak var equals_sign: UIImageView!
    @IBOutlet weak var outstanding: UITextView!
    @IBOutlet weak var time_label: UILabel!
    @IBOutlet weak var savings_label: UILabel!
    @IBOutlet weak var line: UIImageView!
    
    var increment = Double()
    var max_percent_interest = 100.0
    //var max_percent_interest = Double()
    //var max_percent_interest_calculations = 100.0
    var progress = 100.0
    var percentage = Double()
    //var percentage_calculations = Double()
    //internal var progress = Int()
    var p = Double()
    var i = Double()
    var a = Double()
    var tenyr_indicator = Double()
    
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

    //var c = 1.0
    var insight = 0 //1 if insight bubble open, 0 if not
    var blinked = Int()
    
    var attributedPayTitle = NSMutableAttributedString()
    var attributedPaySummary = NSMutableAttributedString()
    
    
    @IBAction func Switch(_ sender: UISwitch) {
        if compound.isOn {
            //c = 1.0
            i = pow(1 + i*12*100/365.25/100,365.25/12) - 1
            //print(i)
            var temp = Double()
            if (tenyr_indicator == 0) {
                if (percentage/100*p*i*100 - floor(percentage/100*p*i*100) > 0.499999) && (percentage/100*p*i*100 - floor(percentage/100*p*i*100) < 0.5)
                { temp = (round(percentage/100*p*i*100 + 1) + 1)/100}
                else { temp = (round(percentage/100*p*i*100) + 1)/100 }
            }
            else {
                if (i != 0) {
                    //temp = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
                    temp = ceil((percentage/100*i*p*pow(1+percentage/100*i,120)) / (pow(1+percentage/100*i,120) - 1)*100)/100
                }
                else {
                    temp = ceil(p/120*100)/100
                }
            }
            
            
            if (temp >= a)
            {
                a = temp
                //a_reference = temp
                //shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
                /*if (a - floor(a) == 0) {
                    pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
                }
                else if ((a - floor(a))*100 < 9.99999) {
                    pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
                }
                else {
                    pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
                }
                
                minimum.isHidden = false
                minimum.text = "Minimum"*/
            }
            else
            {
                //minimum.isHidden = false
                //minimum.text = " "
            }
            //Lengthsaving()

        }
        else {
            //c = 0.0
            i = shared_preferences.double(forKey: "interest")
            i = i / 12 / 100 //need to convert to periodic rate in decimal form
            a = shared_preferences.double(forKey: "pay_monthly")
        }
        
        
        var attributedPercentInterestTitle = NSMutableAttributedString()
        attributedPercentInterestTitle = NSMutableAttributedString(string: "Interest", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        let attributedPercentInterestSpace = NSMutableAttributedString(string: " \n", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 3.0)! ])
        let attributedPercentBalanceTitle = NSMutableAttributedString(string: "Later", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        let attributedPercentBalanceSpace = NSMutableAttributedString(string: " \n", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 3.0)! ])
        var attributedPercentInterest = NSMutableAttributedString()
        var attributedPercentBalance = NSMutableAttributedString()
        attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.0f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
        /*if compound.isOn && (progress != 100) {
            attributedPercentBalance = NSMutableAttributedString(string: "Rest", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
        }
        else {*/
            attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.0f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
        //}
        attributedPercentInterest.append(attributedPercentInterestSpace)
        attributedPercentInterest.append(attributedPercentInterestTitle)
        percent_interest.attributedText = attributedPercentInterest
        
        attributedPercentBalance.append(attributedPercentBalanceSpace)
        attributedPercentBalance.append(attributedPercentBalanceTitle)
        percent_balance.attributedText = attributedPercentBalance
        
        if (insight == 1) {
            payment_header_shape.path = UIBezierPath(roundedRect: payment_header.bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
            payment_shape.path = UIBezierPath(roundedRect: payment.bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        }
        else {
            payment_header_shape.path = UIBezierPath(roundedRect: payment_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
            payment_shape.path = UIBezierPath(roundedRect: payment.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        }


        
        Variables()

    }
    
    @IBAction func Payment_Insight_Bubble(_ sender: UIButton) {
        pay_insight.isHidden = false
        pay_insight_header.isHidden = false
        plus_sign.isHidden = true
        minus_sign.isHidden = true
        pay_insight_header.addSubview(shrink)
        pay_insight_header.bringSubview(toFront: shrink)
        pay_insight.frame = CGRect(x: 10, y: pay_insight.frame.origin.y, width: pay_insight.frame.width, height: pay_insight.frame.height)
        pay_insight_header.frame = CGRect(x: 10, y: pay_insight_header.frame.origin.y, width: pay_insight_header.frame.width, height: pay_insight_header.frame.height)
        UIView.animate(withDuration: 0.25, animations: {
            self.equals_sign.isHidden = true
            //self.pay_insight.transform = CGAffineTransform(scaleX: 1.0625, y: 1.0625)
            //let translation = CGAffineTransform(translationX: CGFloat(0), y: CGFloat(-4))
            //let scale = CGAffineTransform(scaleX: 1.0625, y: 1.0625)
            //self.pay_insight_header.transform = translation.concatenating(scale)
            self.pay_insight_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
            self.pay_insight_header_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
            self.payment_header_shape.path = UIBezierPath(roundedRect: self.payment_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
            self.payment_shape.path = UIBezierPath(roundedRect: self.payment.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
            //self.pay_insight_header.frame = CGRect(x: self.pay_insight_header.frame.origin.x, y: self.pay_insight_header.frame.origin.y, width: self.pay_insight_header.frame.width, height: self.pay_insight_header.frame.height)
            //print("before -> x:",self.pay_insight.frame.origin.x,"y:",self.pay_insight.frame.origin.y,"width:",self.pay_insight.frame.width,"height:",self.pay_insight.frame.height)

        },
        completion: {
            (finished: Bool) -> Void in
                UIView.animate(withDuration: 0.25) {
                    self.equals_sign.isHidden = true
                //self.pay_insight.transform = CGAffineTransform.identity
                //self.pay_insight_header.transform = CGAffineTransform.identity
                //self.pay_insight_header.frame = CGRect(x: self.pay_insight_header.frame.origin.x, y: self.pay_insight_header.frame.origin.y, width: self.pay_insight_header.frame.width, height: self.pay_insight_header.frame.height) //might be redundant, same in next function
                self.pay_insight.frame = CGRect(x: 5, y: self.pay_insight.frame.origin.y, width: self.pay_insight.frame.width, height: self.pay_insight.frame.height)
                self.pay_insight_header.frame = CGRect(x: 5, y: self.pay_insight_header.frame.origin.y, width: self.pay_insight_header.frame.width, height: self.pay_insight_header.frame.height)
                self.pay_insight_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
                self.pay_insight_header_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
                self.payment_header_shape.path = UIBezierPath(roundedRect: self.payment_header.bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
                self.payment_shape.path = UIBezierPath(roundedRect: self.payment.bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
                self.remaining.textColor = UIColor.lightGray.withAlphaComponent(0.5)
                }
            //print("after -> x:",self.pay_insight.frame.origin.x,"y:",self.pay_insight.frame.origin.y,"width:",self.pay_insight.frame.width,"height:",self.pay_insight.frame.height)

        })

        
        
        /*UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.pay_insight.frame = CGRect(x: self.pay_insight.frame.origin.x, y: self.pay_insight.frame.origin.y+200, width: self.pay_insight.frame.width, height: self.pay_insight.frame.height-200)
            //self.step_3.frame = CGRect(x: self.step_3.frame.origin.x, y: self.step_3.frame.origin.y+self.step_3.frame.height, width: self.step_3.frame.width, height: 0)
        }, completion: {
            (finished: Bool) -> Void in
            //self.tip_3.isHidden = false
            
            //self.step_2_background.addSubview(self.tip_3)
            //self.step_2_background.bringSubview(toFront: self.tip_3)
            //self.Step_Main()
            //self.splash_timer_count += 1
            self.pay_insight.frame = CGRect(x: self.pay_insight.frame.origin.x, y: self.pay_insight.frame.origin.y, width: self.pay_insight.frame.width, height: self.pay_insight.frame.height)
            //self.step_3.frame = CGRect(x: self.step_3.frame.origin.x, y: self.step_3.frame.origin.y-frame_height_temp, width: self.step_3.frame.width, height: frame_height_temp)
            //self.step_3.backgroundColor = UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 0.0)
        })*/

        
        
        
        
        
        enlarge.isHidden = true
        shrink.isHidden = false
        insight = 1
        Variables()
        payment.isEnabled = false
        payment_header.isEnabled = false
        //enlarge.isEnabled = false
        //enlarge.setImage(UIImage(named: "Shrink"), for: .normal)
        //enlarge_shrink.setImage(UIImage(named: "Enlarge"), for: .normal)
    }
    @IBAction func Payment_Insight_Bubble_Expand(_ sender: UIButton) {
        pay_insight.isHidden = false
        pay_insight_header.isHidden = false
        plus_sign.isHidden = true
        minus_sign.isHidden = true
        //pay_insight.bounds = pay_insight.frame
        //pay_insight.layer.addSublayer(pay_insight_shape)
        //pay_insight_header.layer.addSublayer(pay_insight_header_shape)
        pay_insight_header.addSubview(shrink)
        pay_insight_header.bringSubview(toFront: shrink)
        pay_insight.frame = CGRect(x: 10, y: pay_insight.frame.origin.y, width: pay_insight.frame.width, height: pay_insight.frame.height)
        pay_insight_header.frame = CGRect(x: 10, y: pay_insight_header.frame.origin.y, width: pay_insight_header.frame.width, height: pay_insight_header.frame.height)
        UIView.animate(withDuration: 0.25, animations: {
            //self.pay_insight.transform = CGAffineTransform(scaleX: 1.0625, y: 1.0625)
            //let translation = CGAffineTransform(translationX: CGFloat(0), y: CGFloat(-4))
            //let scale = CGAffineTransform(scaleX: 1.0625, y: 1.0625)
            //self.pay_insight_header.transform = translation.concatenating(scale)
            self.pay_insight_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
            self.pay_insight_header_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
            self.payment_header_shape.path = UIBezierPath(roundedRect: self.payment_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
            self.payment_shape.path = UIBezierPath(roundedRect: self.payment.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
            //self.pay_insight_header.frame = CGRect(x: self.pay_insight_header.frame.origin.x, y: self.pay_insight_header.frame.origin.y, width: self.pay_insight_header.frame.width, height: self.pay_insight_header.frame.height)
        },
                       completion: {
                        (finished: Bool) -> Void in
                        UIView.animate(withDuration: 0.25) {
                            self.equals_sign.isHidden = true
                            //self.pay_insight.transform = CGAffineTransform.identity
                            //self.pay_insight_header.transform = CGAffineTransform.identity
                            //self.pay_insight_header.frame = CGRect(x: self.pay_insight_header.frame.origin.x, y: self.pay_insight_header.frame.origin.y, width: self.pay_insight_header.frame.width, height: self.pay_insight_header.frame.height)
                            self.pay_insight.frame = CGRect(x: 5, y: self.pay_insight.frame.origin.y, width: self.pay_insight.frame.width, height: self.pay_insight.frame.height)
                            self.pay_insight_header.frame = CGRect(x: 5, y: self.pay_insight_header.frame.origin.y, width: self.pay_insight_header.frame.width, height: self.pay_insight_header.frame.height)
                            self.pay_insight_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
                            self.pay_insight_header_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
                            self.payment_header_shape.path = UIBezierPath(roundedRect: self.payment_header.bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
                            self.payment_shape.path = UIBezierPath(roundedRect: self.payment.bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
                            self.remaining.textColor = UIColor.lightGray.withAlphaComponent(0.5)
                        }
        })

        
        enlarge.isHidden = true
        shrink.isHidden = false
        insight = 1
        Variables()
        payment.isEnabled = false
        payment_header.isEnabled = false
        //enlarge.isEnabled = false
        //enlarge.setImage(UIImage(named: "Shrink"), for: .normal)
        //enlarge_shrink.setImage(UIImage(named: "Enlarge"), for: .normal)
    }
    
    @IBAction func Payment_Insight_Bubble_Header_Close(_ sender: UIButton) {
        pay_insight_header.isHidden = true
        pay_insight.isHidden = true
        enlarge.isHidden = false
        shrink.isHidden = true
        pay_insight_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
        pay_insight_header_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
        payment_header_shape.path = UIBezierPath(roundedRect: payment_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        payment_shape.path = UIBezierPath(roundedRect: payment.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //pay_insight.bounds = pay_insight.frame
        //pay_insight_header.bounds = pay_insight_header.frame
        pay_insight.frame = CGRect(x: 10, y: pay_insight.frame.origin.y, width: pay_insight.frame.width, height: pay_insight.frame.height)
        pay_insight_header.frame = CGRect(x: 10, y: pay_insight_header.frame.origin.y, width: pay_insight_header.frame.width, height: pay_insight_header.frame.height)
        plus_sign.isHidden = false
        minus_sign.isHidden = false
        equals_sign.isHidden = false
        remaining.textColor = UIColor.black
        insight = 0
        Variables()
        payment.isEnabled = true
        payment_header.isEnabled = true
        //enlarge.isEnabled = true
    }
    
    @IBAction func Payment_Insight_Bubble_Close(_ sender: UIButton) {
        pay_insight_header.isHidden = true
        pay_insight.isHidden = true
        enlarge.isHidden = false
        shrink.isHidden = true
        pay_insight_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
        pay_insight_header_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
        payment_header_shape.path = UIBezierPath(roundedRect: payment_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        payment_shape.path = UIBezierPath(roundedRect: payment.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //pay_insight.bounds = pay_insight.frame
        //pay_insight_header.bounds = pay_insight_header.frame
        pay_insight.frame = CGRect(x: 10, y: pay_insight.frame.origin.y, width: pay_insight.frame.width, height: pay_insight.frame.height)
        pay_insight_header.frame = CGRect(x: 10, y: pay_insight_header.frame.origin.y, width: pay_insight_header.frame.width, height: pay_insight_header.frame.height)
        plus_sign.isHidden = false
        minus_sign.isHidden = false
        equals_sign.isHidden = false
        remaining.textColor = UIColor.black
        insight = 0
        Variables()
        payment.isEnabled = true
        payment_header.isEnabled = true
        //enlarge.isEnabled = true
    }
    
    @IBAction func Payment_Insight_Bubble_Shrink(_ sender: UIButton) {
        pay_insight_header.isHidden = true
        pay_insight.isHidden = true
        enlarge.isHidden = false
        shrink.isHidden = true
        pay_insight_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
        pay_insight_header_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
        payment_header_shape.path = UIBezierPath(roundedRect: payment_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        payment_shape.path = UIBezierPath(roundedRect: payment.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //pay_insight.bounds = pay_insight.frame
        //pay_insight_header.bounds = pay_insight_header.frame
        pay_insight.frame = CGRect(x: 10, y: pay_insight.frame.origin.y, width: pay_insight.frame.width, height: pay_insight.frame.height)
        pay_insight_header.frame = CGRect(x: 10, y: pay_insight_header.frame.origin.y, width: pay_insight_header.frame.width, height: pay_insight_header.frame.height)
        plus_sign.isHidden = false
        minus_sign.isHidden = false
        equals_sign.isHidden = false
        remaining.textColor = UIColor.black
        insight = 0
        Variables()
        payment.isEnabled = true
        payment_header.isEnabled = true
        //enlarge.isEnabled = true
    }
    @IBAction func Blink(_ sender: UISlider) {
        //if compound.isOn && (insight == 0) && (progress < 100) && (blinked == 0) {
        if (insight == 0) && (progress < 100) && (blinked == 0) {
            //enlarge.isHidden = false
            enlarge.alpha = 1.0
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse, .curveEaseInOut], animations:
                {
                    UIView.setAnimationRepeatCount(3)
                    self.enlarge.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                self.enlarge.alpha = 1.0
            })
            
        }
        else {
            //enlarge.alpha = 0.0
        }
        blinked = 1 //don't blink again, unless you reswipe, reduces annoyance
    }
    
    
    @IBAction func Proportion_Slider(_ sender: UISlider) {
        //p = shared_preferences.double(forKey: "loaned")
        //i = shared_preferences.double(forKey: "interest")
        //a = shared_preferences.double(forKey: "pay_monthly")
        //i = i / 12 / 100 //need to convert to periodic rate in decimal form
        increment = 1.0
        
        if (sender.value - floor(sender.value) > 0.99999)
        { sender.value = roundf(sender.value + 1) }
        else { sender.value = roundf(sender.value) }
        //sender.value = roundf(sender.value)
        //print(sender.value)
        
        //progress = Int(sender.value)
        //progress = Double(sender.value)
        progress = increment * Double(sender.value)
        
        //might these have rounding issue, too?
        /*if (a == ceil(Double(Int(p*i*100)+1))/100) {
            max_percent_interest = (ceil(Double(Int(p*i*100)))/100)/(ceil(Double(Int(p*i*100)+1))/100)*100
        }
        else {
            max_percent_interest = (ceil(Double(Int(p*i*100)))/100)/a*100
        }*/

        
        //will show correctly, but since don't need extra penny when progress != 0, later on will adjust some more

        //m = (y2-y1)/(x2-x1)
        //= (0-max_percent_interest)/(100-0)
        //= -max_percent_interest/100
        //y = y1 + m(x-x1)
        //= max_percent_interest + -max_percent_interest/100(x-0)
        //= max_percent_interest - max_percent_interest/100(x)
        let scale = max_percent_interest/100
        //y = max_percent_interest - scale(x)
        //progress = x
        percentage = max_percent_interest - scale*(max_percent_interest - progress)
        //percentage = max_percent_interest - scale*Double(progress)
        //percentage_calculations = max_percent_interest_calculations - Double(progress)

        /*if (i == 0) {
            //sender.value = 4
            //slider.isEnabled = false
            //percent_interest.text = String(format: "%.0f", percentage) + "%\nInterest"
            //percent_interest.textColor = UIColor.lightGray.withAlphaComponent(0.5)
            //percent_balance.text = String(format: "%.0f", 100 - percentage) + "%\nBalance"
        }
        else {
            //slider.isEnabled = true
            if (progress == 0) {
                //percent_interest.text = String(format: "%.2f", percentage) + "%\nInterest"
                //percent_balance.text = String(format: "%.2f", 100 - percentage) + "%\nBalance"
            }
            else {
                //percent_interest.text = String(format: "%.0f", percentage) + "%\nInterest"
                //percent_balance.text = String(format: "%.0f", 100 - percentage) + "%\nBalance"
            }
        }*/
        var temp = Double()
        if (tenyr_indicator == 0) {
            if (percentage/100*p*i*100 - floor(percentage/100*p*i*100) > 0.499999) && (percentage/100*p*i*100 - floor(percentage/100*p*i*100) < 0.5)
            { temp = (round(percentage/100*p*i*100 + 1) + 1)/100}
            else { temp = (round(percentage/100*p*i*100) + 1)/100 }
        }
        else {
            if (i != 0) {
                //temp = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
                temp = ceil((percentage/100*i*p*pow(1+percentage/100*i,120)) / (pow(1+percentage/100*i,120) - 1)*100)/100
            }
            else {
                temp = ceil(p/120*100)/100
            }
        }
        
        
        if (temp >= a)
        {
            a = temp
            //a_reference = temp
            //shared_preferences.set(a, forKey: "pay_monthly"); shared_preferences.synchronize()
            /*if (a - floor(a) == 0) {
             pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".00"//
             }
             else if ((a - floor(a))*100 < 9.99999) {
             pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + ".0" + String(format: "%.0f", (a - floor(a))*100)//
             }
             else {
             pay_number.text = numberFormatter.string(from: NSNumber(value: Int(a)))! + "." + String(format: "%.0f", (a - floor(a))*100)//
             }
             
             minimum.isHidden = false
             minimum.text = "Minimum"*/
        }
        else
        {
            //minimum.isHidden = false
            //minimum.text = " "
        }
        //Lengthsaving()
        
    //}
    /*else {
    //c = 0.0
    i = shared_preferences.double(forKey: "interest")
    i = i / 12 / 100 //need to convert to periodic rate in decimal form
    a = shared_preferences.double(forKey: "pay_monthly")
    }*/

    
        //some of this may be redundant
        var attributedPercentInterestTitle = NSMutableAttributedString()
        /*if (i == 0) {
            attributedPercentInterestTitle = NSMutableAttributedString(string: "Interest", attributes: [ NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 12.0)!, NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        }
        else {*/
            attributedPercentInterestTitle = NSMutableAttributedString(string: "Interest", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        //}
        let attributedPercentInterestSpace = NSMutableAttributedString(string: " \n", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 3.0)! ])
        let attributedPercentBalanceTitle = NSMutableAttributedString(string: "Later", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        let attributedPercentBalanceSpace = NSMutableAttributedString(string: " \n", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 3.0)! ])
        var attributedPercentInterest = NSMutableAttributedString()
        var attributedPercentBalance = NSMutableAttributedString()
        /*if (i == 0) {
            attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.0f", 100-percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!, NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5) ])
            attributedPercentBalance = NSMutableAttributedString(string: "entire", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!, NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5) ])
        }*/
        //else {
            /*var percentage_post = Double()
            let x = round(percentage)*100
            if (x - floor(x) > 0.99999) {
                percentage_post = Double(Int(round(percentage*100))/100*p*i*100)+1)/100
            }
            else {
                percentage_post = Double(Int(round(percentage*100))/100*p*i*100))/100
            }*/
            /*//for consistency: <-- because rounded interest down everywhere else
            let px = percentage*100
            if (px - floor(px) > 0.99999) {
                percentage = Double(Int(percentage*100)+1)/100
            }
            else {
                percentage = Double(Int(percentage*100))/100
            }
            //simplifying percentages:
            if (percentage - floor(percentage) == 0) {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.0f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.0f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
            }
            else if (percentage*10 - floor(percentage*10) == 0) {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.1f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.1f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
            }
            //arbitrary:
            else if (progress != 0) && (a == ceil(Double(Int(p*i*100)+1))/100) {
                    attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.0f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                    attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.0f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
            }
            else {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.2f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.2f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
            }*/
            attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.0f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
        /*if compound.isOn && (progress != 100) {
            attributedPercentBalance = NSMutableAttributedString(string: "Rest", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
        }
        else {*/
            attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.0f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
        //}

            //for consistency: <-- because rounded interest down everywhere else
            /*if (progress == 0) {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.0f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                attributedPercentBalance = NSMutableAttributedString(string: "1¢", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
            }
            else if (progress == 100) {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.0f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                attributedPercentBalance = NSMutableAttributedString(string: "entire", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
            }
            else {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.0f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                attributedPercentBalance = NSMutableAttributedString(string: "remains", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
            }*/

            /*
            if (percentage - floor(percentage) == 0) {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.0f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.0f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
            }
            else if (percentage*10 - floor(percentage*10) == 0) {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.1f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.1f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
            }
                //arbitrary:
            else if (progress != 0) && (a == ceil(Double(Int(p*i*100)+1))/100) {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.0f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.0f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
            }
            else {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.2f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.2f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
            }*/

        //}
        attributedPercentInterest.append(attributedPercentInterestSpace)
        attributedPercentInterest.append(attributedPercentInterestTitle)
        percent_interest.attributedText = attributedPercentInterest
        
        attributedPercentBalance.append(attributedPercentBalanceSpace)
        attributedPercentBalance.append(attributedPercentBalanceTitle)
        percent_balance.attributedText = attributedPercentBalance
        //print(percentage)
        //print(percentage*100 - floor(percentage*100))
        //print(floor((percentage*10 - floor(percentage*10))*10))
        //print(floor((percentage*100 - floor(percentage*100))*10))

        

        //balance_shape_label.adjustsFontSizeToFitWidth = true



        //percent_balance.text = String(format: "%.2f",(ceil(Double(1))/100)/(ceil(Double(Int(p*i*100)+1))/100)*100) + "%\nBalance"
        //var previous_subviews = balance.subviews
        //previous_subviews.removeAll()
        
        /*if (insight == 1) {
            //payment_header_shape.path = UIBezierPath(roundedRect: payment_header.bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
            payment_shape.path = UIBezierPath(roundedRect: payment.bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        }
        else {
            //payment_header_shape.path = UIBezierPath(roundedRect: payment_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
            payment_shape.path = UIBezierPath(roundedRect: payment.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        }*/


        Variables()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decision = shared_preferences.bool(forKey: "decision")

        if (decision == true) {
            compound.isHidden = true //redundant if compound_stack hidden
            titleof_compound.isHidden = true //redundant if compound_stack hidden
            percent_interest.isHidden = true
            slider.isHidden = true
            percent_balance.isHidden = true
            time_label.text = "Estimated Payoff Time"
            savings_label.text = "Estimated Savings"
            //line.isHidden = true
            line.image = UIImage(named: "")
            view.addConstraint(line.heightAnchor.constraint(equalToConstant: 30))
            aprstack_width.isActive = false
            //view.addConstraint(APR_stack.widthAnchor.constraint(equalToConstant: APR_compound_stack.frame.width))
            //APR_stack.alignment = .center
            //APR_stack.alignment = .center
            compound_stack.isHidden = true
            table_header.isHidden = true
            enlarge.isHidden = true
            view.addConstraint(NSLayoutConstraint(item: monthly_balance, attribute: .bottom, relatedBy: .equal, toItem: table, attribute: .top, multiplier: 1, constant: 0))
            note_constraint.isActive = false
            note_right.isHidden = true
            view.addConstraint(note.widthAnchor.constraint(equalToConstant: stack2.frame.width))
            plus_sign.isHidden = true
            minus_sign.isHidden = true
            equals_sign.isHidden = true
            bottom_layout_guide.isActive = false
            view.addConstraint(NSLayoutConstraint(item: bottomLayoutGuide, attribute: .top, relatedBy: .equal, toItem: stack2, attribute: .centerY, multiplier: 2.2, constant: 0))
            view.backgroundColor = UIColor.white
            blur.isHidden = false
            stack1_leading.isActive = false
            stack1_trailing.isActive = false
            view.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: stack1, attribute: .trailing, multiplier: 1, constant: 50))
            view.addConstraint(NSLayoutConstraint(item: stack1, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 50))
        }
        else { //may be redundant
            compound.isHidden = false //redundant if compound_stack unhidden
            titleof_compound.isHidden = false //redundant if compound_stack unhidden
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
            blur.isHidden = true
            //leave constraints as they are
        }
        
        blinked = 0
        if (decision == false) {
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.groupingSeparator = ","
            numberFormatter.groupingSize = 3
        }
        else {
            numberFormatter.usesGroupingSeparator = false
            //numberFormatter.groupingSeparator = ","
            //numberFormatter.groupingSize = 3
        }
        enlarge.adjustsImageWhenHighlighted = false
        shrink.adjustsImageWhenHighlighted = false
        
        pay_insight_header.isHidden = true
        pay_insight.isHidden = true
        compound.layer.cornerRadius = 16
        shrink.isHidden = true
        
        
        view.addSubview(pay_insight)
        view.bringSubview(toFront: pay_insight)
        //view.addSubview(pay_insight_header)
        //view.bringSubview(toFront: pay_insight_header)

        
        pay_insight.frame = CGRect(x: 10, y: pay_insight.frame.origin.y, width: pay_insight.frame.width, height: pay_insight.frame.height)
        pay_insight_header.frame = CGRect(x: 10, y: pay_insight_header.frame.origin.y, width: pay_insight_header.frame.width, height: pay_insight_header.frame.height)
        pay_insight_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
        pay_insight_header_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
        //pay_insight_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
        //pay_insight_header_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor


        
        //enlarge_shrink.sizeThatFits(CGSize(width: 2, height: 2))
        
        slider.setThumbImage(UIImage(named: "Thumb"), for: .normal)
        slider.setMinimumTrackImage(UIImage(named: "Math_MinTrack")!.resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .normal)//reversed because liked reversed colors
        slider.setMaximumTrackImage(UIImage(named: "Math_MaxTrack")!.resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .normal)

        //pay_insight.backgroundColor = UIColor.init(red:216/255.0, green:218/255.0, blue:218/255.0, alpha: 1.0)
        //pay_insight.titleLabel?.lineBreakMode = .byWordWrapping
        //pay_insight.titleLabel?.numberOfLines = 0
        //pay_insight.titleEdgeInsets.right = 12
        //pay_insight.titleEdgeInsets.top = 0
        //pay_insight.titleEdgeInsets.left = 5
        //pay_insight.titleEdgeInsets.bottom = 0


        
        p = shared_preferences.double(forKey: "loaned")
        i = shared_preferences.double(forKey: "interest")
        a = shared_preferences.double(forKey: "pay_monthly")
        tenyr_indicator = shared_preferences.double(forKey: "tenyr")
        
        i = i / 12 / 100 //need to convert to periodic rate in decimal form
        
        /*remaining.layer.borderWidth = 1
         remaining.layer.borderColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 1.0).cgColor*/
        
        /*let loanedTitle = UITextView()
         let loanedSummary = UITextView()*/
        /*loanedTitle.font = UIFont(name: "CMUSerif-Bold", size: 18.0)
         loanedTitle.text = "Loaned"
         loanedSummary.text = "= $" + String(format: "%.2f", p)*/
        
        let attributedLoanedTitle = NSMutableAttributedString(string: "Loaned", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Bold", size: 18.0)! ])
        var attributedLoanedSummary = NSMutableAttributedString()
        if (decision == false) {
            attributedLoanedSummary = NSMutableAttributedString(string: " $" + numberFormatter.string(from: NSNumber(value: p))!, attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)!])
        }
        else {
            attributedLoanedSummary = NSMutableAttributedString(string: " $" + numberFormatter.string(from: NSNumber(value: p))!+".00", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)!])
        }
        attributedLoanedTitle.append(attributedLoanedSummary)
        loaned.attributedText = attributedLoanedTitle
        
        
        
        /*loaned.text = String(format: UIFont.boldSystemFont(ofSize: 17.0), "Loaned") + "= $" + String(format: "%.2f", p)*/
        
        /*nominal_rate.text = "APR = " + String(format: "%.2f", i * 12 * 100) + "%"*/
        
        let attributedAPRTitle = NSMutableAttributedString(string: "APR", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Bold", size: 18.0)! ])
        var attributedAPRSummary = NSMutableAttributedString()
        var attributedAPRPeriodic = NSMutableAttributedString()
        var attributedAPRDecimalEquivalent = NSMutableAttributedString()
        
        var temp = Int() //don't want it rounding, unless remainder has repeated 9s
        if (i*100*1000 - floor(i*100*1000) > 0.99999) {
            temp = Int(i*100*1000)+1
        }
        else {
            temp = Int(i*100*1000)
        }
        
        if (i == 0) {
            //attributedAPRSummary = NSMutableAttributedString(string: " 0%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
            
            if (decision == false) {
                attributedAPRSummary = NSMutableAttributedString(string: " " + String(format: "%.0f", i * 12 * 100) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
                attributedAPRPeriodic = NSMutableAttributedString(string: "\n" + "÷ 12 = 0." + String(temp) + "00...% monthly", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)!, NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5) ])
                    attributedAPRDecimalEquivalent = NSMutableAttributedString(string: "\n" + "÷ 100 = 0.00" + String(temp) + "...", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)!, NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5) ])
            }
            else {
                attributedAPRSummary = NSMutableAttributedString(string: " " + String(format: "%.2f", i * 12 * 100) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
                attributedAPRPeriodic = NSMutableAttributedString(string: "\n" + "÷ 12 = 0." + String(temp) + "00...% monthly", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)!, NSAttributedStringKey.foregroundColor: UIColor.black ])
                attributedAPRDecimalEquivalent = NSMutableAttributedString(string: "\n" + "÷ 100 = 0.00" + String(temp) + "... of balance", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)!, NSAttributedStringKey.foregroundColor: UIColor.black ])
            }
        }
        else {
            attributedAPRSummary = NSMutableAttributedString(string: " " + String(format: "%.2f", i * 12 * 100) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
            attributedAPRPeriodic = NSMutableAttributedString(string: "\n" + "÷ 12 = 0." + String(temp) + "...% monthly", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
            if (decision == false) {
                attributedAPRDecimalEquivalent = NSMutableAttributedString(string: "\n" + "÷ 100 = 0.00" + String(temp) + "...", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
            }
            else {
                attributedAPRDecimalEquivalent = NSMutableAttributedString(string: "\n" + "÷ 100 = 0.00" + String(temp) + "... of balance", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
            }
        }
        attributedAPRTitle.append(attributedAPRSummary)
        attributedAPRTitle.append(attributedAPRPeriodic)
        attributedAPRTitle.append(attributedAPRDecimalEquivalent)
        nominal_rate.attributedText = attributedAPRTitle //"nominal_rate" should be renamed
        
        if (decision == true) {
            nominal_rate.textAlignment = .center
            //APR_stack.backgroundColor = UIColor.red
        }
        else {
            //keep as is
        }
        if (i == 0) {
            //self.slider.value = 4
            compound.isEnabled = false
            titleof_compound.textColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
        else {
            compound.isEnabled = true
        }

        

        /*pay_monthly.text = "Pay = $" + String(format: "%.2f", a) + " monthly"*/
        var tempx = Double()
        if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
        { tempx = (round(p*i*100 + 1)+1)/100}
        else { tempx = (round(p*i*100)+1)/100 }
        
        attributedPayTitle = NSMutableAttributedString(string: "Pay Monthly", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Bold", size: 18.0)! ])
        //if (decision == false) {
            if (a == tempx) {
                attributedPaySummary = NSMutableAttributedString(string: " $" + String(format: "%.2f", a), attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
            }
            else if (i == 0) {
                let check = a
                if (check - floor(check) > 0) {
                    attributedPaySummary = NSMutableAttributedString(string: " $" + String(format: "%.2f", a), attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
                }
                else {
                    attributedPaySummary = NSMutableAttributedString(string: " $" + String(format: "%.0f", a), attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
                }
            }
            else {
                let check = a
                if (check - floor(check) > 0) {
                    attributedPaySummary = NSMutableAttributedString(string: " $" + String(format: "%.2f", a), attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
                }
                else {
                    attributedPaySummary = NSMutableAttributedString(string: " $" + numberFormatter.string(from: NSNumber(value: a))!, attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
                }

            }
        /*}
        else {
            attributedPaySummary = NSMutableAttributedString(string: " $" + String(format: "%.2f", a), attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
        }*/
            
        //print(i)
        //print(a)
        
        attributedPayTitle.append(attributedPaySummary)
        pay_monthly.attributedText = attributedPayTitle
        /*heading.text = String("Balance") +
         
         " + Interest Charged" +
         " – " + "Payment" +
         " ≈ " + "Remaining"
         //heading.textColor(color: UIColor.blue, forText: "Balance")*/
        
        //Shape of balance header---------------------
        let balance_header_shape = CAShapeLayer()
        balance_header_shape.bounds = balance_header.frame
        balance_header_shape.position = balance_header.center
        balance_header_shape.path = UIBezierPath(roundedRect: balance_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        balance_header_shape.strokeColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.125).cgColor
        balance_header_shape.fillColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.25+0.125).cgColor
        balance_header_shape.lineWidth = 0
        
        let balance_header_shape_label = UILabel()
        balance_header_shape_label.frame = CGRect(x: 0, y: 0, width: balance_header.frame.width, height: balance_header.frame.height)
        balance_header_shape_label.bounds = balance_header.frame
        balance_header_shape_label.text = "Principal"
        balance_header_shape_label.textAlignment = .center
        balance_header_shape_label.numberOfLines = 0
        balance_header_shape_label.textColor = UIColor.white
        balance_header_shape_label.font = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        
        balance_header.layer.addSublayer(balance_header_shape)
        balance_header.addSubview(balance_header_shape_label)
        
        //Shape of interest header---------------------
        let interest_header_shape = CAShapeLayer()
        interest_header_shape.bounds = interest_header.frame
        interest_header_shape.position = interest_header.center
        interest_header_shape.path = UIBezierPath(roundedRect: interest_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        if (i == 0) {
            interest_header_shape.fillColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.0625).cgColor
            interest_header_shape.strokeColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.020).cgColor
            plus_sign.alpha = 0.125
        }
        else {
            interest_header_shape.fillColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.25+0.125).cgColor
            interest_header_shape.strokeColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.125).cgColor
            plus_sign.alpha = 1.0
        }
        interest_header_shape.lineWidth = 0
        
        let interest_header_shape_label = UILabel()
        interest_header_shape_label.frame = CGRect(x: 0, y: 0, width: interest_header.frame.width, height: interest_header.frame.height)
        interest_header_shape_label.bounds = interest_header.frame
        interest_header_shape_label.text = "Interest"
        interest_header_shape_label.textAlignment = .center
        interest_header_shape_label.numberOfLines = 0
        if (i == 0) {
            interest_header_shape_label.textColor = UIColor.white.withAlphaComponent(0.5)
        }
        else {
            interest_header_shape_label.textColor = UIColor.white
        }
        interest_header_shape_label.font = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        
        interest_header.layer.addSublayer(interest_header_shape)
        interest_header.addSubview(interest_header_shape_label)
        
        //Shape of payment header-----------------------------
        payment_header_shape.bounds = payment_header.frame
        payment_header_shape.position = payment_header.center
        payment_header_shape.path = UIBezierPath(roundedRect: payment_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        payment_header_shape.strokeColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.125).cgColor
        payment_header_shape.fillColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.25+0.125).cgColor
        payment_header_shape.lineWidth = 0
        payment_shape.path = UIBezierPath(roundedRect: payment.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath //define here, or else - if alter switch with insight open - bottomleft edge will show
        
        let payment_header_shape_label = UILabel()
        payment_header_shape_label.frame = CGRect(x: 0, y: 0, width: payment_header.frame.width, height: payment_header.frame.height)
        payment_header_shape_label.bounds = payment_header.frame
        payment_header_shape_label.text = "Pay"
        payment_header_shape_label.textAlignment = .center
        payment_header_shape_label.numberOfLines = 0
        payment_header_shape_label.textColor = UIColor.white
        payment_header_shape_label.font = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        
        payment_header.layer.addSublayer(payment_header_shape)
        payment_header.addSubview(payment_header_shape_label)
        
        //only show if click on pay
        //pay_insight_header_shape.bounds = pay_insight_header.frame
        //pay_insight_header_shape.position = pay_insight_header.center
        //pay_insight_header_shape.path = UIBezierPath(roundedRect: pay_insight_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //pay_insight_header_shape.path = UIBezierPath(roundedRect: pay_insight_header.bounds, byRoundingCorners: [.topLeft], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //pay_insight_header_shape.path = UIBezierPath(roundedRect: pay_insight_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //pay_insight_header_shape.fillColor = UIColor(red:216/255.0, green:218/255.0, blue:218/255.0, alpha: 0.9).cgColor <-- coloring earlier
        //pay_insight_shape.borderColor = UIColor.black.cgColor
        pay_insight_shape.borderColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
        pay_insight_shape.borderWidth = 0
        //table_header.layer.addSublayer(pay_insight_header_shape)
        pay_insight_header.layer.addSublayer(pay_insight_header_shape)

        /*let pay_insight_header_shape = CAShapeLayer()
        pay_insight_header_shape.frame = CGRect(x: charged_interest.frame.width, y: 0, width: interest_header.frame.width+subtract.frame.width+payment.frame.width, height: interest_header.frame.height)

        //pay_insight_header_shape.bounds = interest_header.frame
        //pay_insight_header_shape.position = interest_header.center
        pay_insight_header_shape.path = UIBezierPath(roundedRect: pay_insight_header_shape.frame, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //payment_header_shape.strokeColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.25).cgColor
        pay_insight_header_shape.fillColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.25).cgColor
        //payment_header_shape.lineWidth = 2
        
        let pay_insight_header_shape_label = UILabel()
        pay_insight_header_shape_label.frame = CGRect(x: 0, y: 0, width: interest_header.frame.width+subtract.frame.width+payment.frame.width, height: interest_header.frame.height)
        //pay_insight_header_shape_label.bounds = CGRect(x: 0, y: 0, width: interest_header.frame.width+add.frame.width+payment.frame.width, height: interest_header.frame.height)//
        //pay_insight_header_shape_label.bounds = interest_header.frame
        pay_insight_header_shape_label.text = "Breakdown of Pay"
        pay_insight_header_shape_label.textAlignment = .center
        pay_insight_header_shape_label.numberOfLines = 0
        pay_insight_header_shape_label.textColor = UIColor.white
        pay_insight_header_shape_label.font = UIFont(name: "HelveticaNeue-Bold", size: 12.0)

        //Int(equals.frame.origin.x)
        headers.layer.addSublayer(pay_insight_header_shape)
        interest_header.addSubview(pay_insight_header_shape_label)*/

        //interest_header.layer.addSublayer(interest_header_shape)
        //pay_insight.addSubview(pay_insight_header_shape_label)
        
        //let textRect_pay_insight = CGRect(x: 0, y: 0, width: pay_insight.frame.width, height: pay_insight.frame.height)
        //let insets_pay_insight = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //let insets_pay_insight = UIEdgeInsets(top: 0, left: 0.02*pay_insight.frame.width, bottom: 0, right: 2*2*0.02*pay_insight.frame.width)
        //pay_insight_shape_label.frame = UIEdgeInsetsInsetRect(textRect_pay_insight, insets_pay_insight)


        
        
        
        
        
        
        //Proportion
        let proportion_shape = CAShapeLayer()
        proportion_shape.bounds = proportion.frame
        proportion_shape.position = proportion.center
        proportion_shape.path = UIBezierPath(roundedRect: proportion.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //balance_header_shape.strokeColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.25).cgColor
        
        if (i == 0) {
            proportion_shape.fillColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.0).cgColor
        }
        else {
            proportion_shape.fillColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.0).cgColor
        }

        //balance_header_shape.lineWidth = 2
        
        /*let balance_header_shape_label = UILabel()
         balance_header_shape_label.frame = CGRect(x: 0, y: 0, width: balance_header.frame.width, height: balance_header.frame.height)
         balance_header_shape_label.bounds = balance_header.frame
         balance_header_shape_label.text = "Balance"
         balance_header_shape_label.textAlignment = .center
         balance_header_shape_label.numberOfLines = 0
         balance_header_shape_label.textColor = UIColor.white
         balance_header_shape_label.font = UIFont(name: "HelveticaNeue-Bold", size: 12.0)*/
        
        proportion.layer.addSublayer(proportion_shape)
        proportion.bringSubview(toFront: percent_interest)
        proportion.bringSubview(toFront: slider)
        proportion.bringSubview(toFront: percent_balance)
        //balance_header.addSubview(balance_header_shape_label)
        /*if (a == ceil(Double(Int(p*i*100)+1))/100) {
            max_percent_interest = (ceil(Double(Int(p*i*100)))/100)/(ceil(Double(Int(p*i*100)+1))/100)*100
        }
        else {
            max_percent_interest = (ceil(Double(Int(p*i*100)))/100)/a*100
        }*/
        let scale = max_percent_interest/100
        percentage = max_percent_interest - scale*(max_percent_interest - Double(progress))
        if (percentage - floor(percentage) > 0.499999) && (percentage - floor(percentage) < 0.5) //being consistant
        { percentage = round(percentage + 1) }
        else { percentage = round(percentage) }

        //max_percent_interest = (ceil(Double(Int(p*i*100)))/100)/(ceil(Double(Int(p*i*100)+1))/100)*100
        //simplified:
        
        /*if (i == 0) {
            self.slider.value = 4
            slider.isEnabled = false
            percent_interest.text = String(format: "%.0f", percentage) + "%\nInterest"
            percent_interest.textColor = UIColor.lightGray.withAlphaComponent(0.5)
            percent_balance.text = String(format: "%.0f", 100 - percentage) + "%\nBalance"
        }
        else {
            slider.isEnabled = true
            percent_interest.text = String(format: "%.2f", max_percent_interest) + "%\nInterest"
            percent_balance.text = String(format: "%.2f", 100 - max_percent_interest) + "%\nBalance"
        }*/
        var attributedPercentInterestTitle = NSMutableAttributedString()
        var attributedPercentBalanceTitle = NSMutableAttributedString()
        if (i == 0) {
            if (decision == false) {
                slider_header.alpha = 0.25
            }
            else {
                //ignore header
            }
            attributedPercentInterestTitle = NSMutableAttributedString(string: "Interest", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!, NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5)])
            attributedPercentBalanceTitle = NSMutableAttributedString(string: "Later", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!, NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5)])
        }
        else {
            attributedPercentInterestTitle = NSMutableAttributedString(string: "Interest", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!, NSAttributedStringKey.foregroundColor: UIColor.black])
            attributedPercentBalanceTitle = NSMutableAttributedString(string: "Later", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!, NSAttributedStringKey.foregroundColor: UIColor.black])
        }
        let attributedPercentInterestSpace = NSMutableAttributedString(string: " \n", attributes: [ NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 3.0)! ])
        let attributedPercentBalanceSpace = NSMutableAttributedString(string: " \n", attributes: [ NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 3.0)! ])
        var attributedPercentInterest = NSMutableAttributedString()
        var attributedPercentBalance = NSMutableAttributedString()
        if (i == 0) {
            //self.slider.value = 4
            slider.isEnabled = false
            attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.0f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!, NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5) ])
            //attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.0f", max_percent_interest) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
            attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.0f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)!, NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5) ])
        }
        else {
            slider.isEnabled = true
            //for consistency: <-- because rounded interest down everywhere else
            let px = percentage*100
            if (px - floor(px) > 0.99999) {
                percentage = Double(Int(percentage*100)+1)/100
            }
            else {
                percentage = Double(Int(percentage*100))/100
            }
            
            var tempx = Double()
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { tempx = (round(p*i*100 + 1)+1)/100}
            else { tempx = (round(p*i*100)+1)/100 }
            
            //simplifying percentages:
            if (percentage - floor(percentage) == 0) {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.0f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                /*if compound.isOn && (progress != 100) {
                    attributedPercentBalance = NSMutableAttributedString(string: "Rest", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                }
                else {*/
                    attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.0f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                //}
            }
            else if (percentage*10 - floor(percentage*10) == 0) {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.1f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                /*if compound.isOn && (progress != 100) {
                    attributedPercentBalance = NSMutableAttributedString(string: "Rest", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                }
                else {*/
                    attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.1f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                //}
            }
                //arbitrary:
            else if (progress != 100) && (a == tempx) {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.0f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                /*if compound.isOn && (progress != 100) {
                    attributedPercentBalance = NSMutableAttributedString(string: "Rest", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                }
                else {*/
                    attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.0f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                //}
            }
            else {
                attributedPercentInterest = NSMutableAttributedString(string: String(format: "%.2f", percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                /*if compound.isOn && (progress != 100) {
                    attributedPercentBalance = NSMutableAttributedString(string: "Rest", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                }
                else {*/
                    attributedPercentBalance = NSMutableAttributedString(string: String(format: "%.2f", 100 - percentage) + "%", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 16.0)! ])
                //}
            }
        }
        /*attributedPercentInterestTitle.append(attributedPercentInterestSpace)
        attributedPercentInterestTitle.append(attributedPercentInterest)
        percent_interest.attributedText = attributedPercentInterestTitle
        
        attributedPercentBalanceTitle.append(attributedPercentBalanceSpace)
        attributedPercentBalanceTitle.append(attributedPercentBalance)
        percent_balance.attributedText = attributedPercentBalanceTitle*/

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
        
        //allow users to magnify the table, if the table is too small
        balance.tintColor = .clear
        balance.isEditable = true //bug, should be isSelectable, but isSelectable only highlights first line
        if (i != 0) {
            charged_interest.tintColor = .clear
            charged_interest.isEditable = true //bug, should be isSelectable, but isSelectable only highlights first line
        }
        else {
            //don't
        }
        remaining.tintColor = .clear
        remaining.isEditable = true //bug, should be isSelectable, but isSelectable only highlights first line

        /*if (view.frame.width == 414) {
            view.addConstraint(add.widthAnchor.constraint(equalToConstant: 18))
            view.addConstraint(subtract.widthAnchor.constraint(equalToConstant: 18))
            view.addConstraint(equals.widthAnchor.constraint(equalToConstant: 18))
            //NSLayoutConstraint.activate([add.widthAnchor.constraint(equalToConstant: CGFloat(18))])
            //NSLayoutConstraint.activate([subtract.widthAnchor.constraint(equalToConstant: CGFloat(18))])
            //NSLayoutConstraint.activate([equals.widthAnchor.constraint(equalToConstant: CGFloat(18))])
        }
        else {
            view.addConstraint(add.widthAnchor.constraint(equalToConstant: 6))
            view.addConstraint(subtract.widthAnchor.constraint(equalToConstant: 6))
            view.addConstraint(equals.widthAnchor.constraint(equalToConstant: 6))
            //NSLayoutConstraint.activate([add.widthAnchor.constraint(equalToConstant: CGFloat(6))])
            //NSLayoutConstraint.activate([subtract.widthAnchor.constraint(equalToConstant: CGFloat(6))])
            //NSLayoutConstraint.activate([equals.widthAnchor.constraint(equalToConstant: CGFloat(6))])
        }*/
        //NSLayoutConstraint.activate([remaining.widthAnchor.constraint(equalToConstant: table.frame.width-balance.frame.width-add.frame.width-charged_interest.frame.width-subtract.frame.width-payment.frame.width-equals.frame.width)])
        //remaining_label.frame = CGRect(x: remaining.frame.origin.x, y: 0, width: table.frame.width-balance.frame.width-add.frame.width-charged_interest.frame.width-subtract.frame.width-payment.frame.width-equals.frame.width, height: remaining.frame.height)


        Variables()
        if (decision == false) {
            //proceed
        }
        else {
            payment.isEnabled = false
        }

        //remaining_label.frame = CGRect(x: 0, y: 0, width: remaining.frame.width, height: remaining.frame.height)
        //remaining_label.frame = CGRect(x: remaining.frame.origin.x, y: 0, width: remaining.frame.width, height: remaining.frame.height)

        payment_shape.path = UIBezierPath(roundedRect: payment.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //table_header.layer.borderWidth = 0
        //table.layer.borderWidth = 0
        
        //give slightly creamy (i.e., blurry) background, tried below but got warnings so did it visually, doesn't like alpha
        
        /*blur.addSubview(stack1)
         blur.addSubview(stack2)
         blur.addSubview(stack3)
         blur.addSubview(stack4)*/
        
        
        //let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        //let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //blurEffectView.frame = view.bounds
        //blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //view.addSubview(blurEffectView)
        //blurEffectView.alpha = 0.125

    }
    
    

    func Variables() {
        if (i == 0) {
            payment.isEnabled = false
            //pay_insight.isEnabled = false
            //pay_insight_header.isEnabled = false
            payment_header.isEnabled = false
            enlarge.isHidden = true
        }
        else {
            payment.isEnabled = true
            payment_header.isEnabled = true
            //enlarge.isHidden = false
        }

        var j = 0 //defined here in order to simplify the rest too
        var remainingbalance = p //defined here in order to simplify the rest
        //let c = 0.0 //set to 0.0, if do not compound
        //var pre_outstandingbalance = 0.00
        var outstandingbalance = 0.00
        //if (i != 0) {
            /*if (progress == 100) {
                //compound interest
                while (remainingbalance + ceil(Double(Int(remainingbalance*i*100)))/100 > a) {
                    remainingbalance = remainingbalance + ceil(Double(Int(remainingbalance*i*100)))/100 - a
                    j += 1
                }
            }
            else {*/
                //don't compound interest, yet <-- coming up
            
            var interest = Double()
            if (remainingbalance*i*100 - floor(remainingbalance*i*100) > 0.499999) && (remainingbalance*i*100 - floor(remainingbalance*i*100) < 0.5)
            { interest = round(remainingbalance*i*100 + 1)/100}
            else { interest = round(remainingbalance*i*100)/100 }

            //print(interest)

          //var interest_pay = round(round(percentage)/100*remainingbalance*i*100)/100
            var interest_pay = Double()
            //var x = percentage/100*interest
            var x = percentage/100*remainingbalance*i
            if (x*100 - floor(x*100) > 0.499999) && (x*100 - floor(x*100) < 0.5)
            { interest_pay = round(x*100 + 1)/100}
            else { interest_pay = round(x*100)/100 }
            //print(interest_pay)
        
            var tempx = Double()
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { tempx = (round(p*i*100 + 1)+1)/100}
            else { tempx = (round(p*i*100)+1)/100 }
            
            var principal_pay = Double()
            if (a == tempx) {
                if (progress == 100) { principal_pay = a - interest_pay }
                else { principal_pay = a - interest_pay } //won't need 0.01, if interest not compounded
            }
            else { principal_pay = a - interest_pay }
            //print(principal_pay)

            /*var interest_not_pay = Double()
            let x1 = remainingbalance*i*100
            if (x1 - floor(x1) > 0.99999) {
                interest_not_pay = ceil(Double(Int(remainingbalance*i*100)+1))/100 - interest_pay
            }
            else {
                interest_not_pay = ceil(Double(Int(remainingbalance*i*100)))/100 - interest_pay
            }*/
            
            //print(remainingbalance + c*interest)
            //print(c*interest_pay + principal_pay)
            /*remainingbalance = remainingbalance + c*interest - (c*interest_pay + principal_pay)
            x = remainingbalance*i*100
            if (x - floor(x) > 0.99999) {
                interest = Double(Int(remainingbalance*i*100)+1)/100 }
            else { interest = Double(Int(remainingbalance*i*100))/100 }
            //print("x:",x,floor(x),x-floor(x))
            x2 = round(percentage)/100*remainingbalance*i*100
            if (x2 - floor(x2) > 0.99999) {
                interest_pay = Double(Int(round(percentage)/100*remainingbalance*i*100)+1)/100 }
            else { interest_pay = Double(Int(round(percentage)/100*remainingbalance*i*100))/100 }
            
            if (a == ceil(Double(Int(remainingbalance*i*100)+1))/100) {
                if (progress == 100) { principal_pay = a - interest_pay }
                else { principal_pay = a - (1.0-c)*0.01 - interest_pay } //won't need 0.01, if interest not compounded
            }
            else { principal_pay = a - interest_pay }
            //print("y:",x2,floor(x2),x2-floor(x2))
            remainingbalance = remainingbalance + c*interest - (c*interest_pay + principal_pay)
            x = remainingbalance*i*100
            if (x - floor(x) > 0.99999) {
                interest = Double(Int(remainingbalance*i*100)+1)/100 }
            else { interest = Double(Int(remainingbalance*i*100))/100 }
            //print("x:",x,floor(x),x-floor(x))
            x2 = round(percentage)/100*remainingbalance*i*100
            if (x2 - floor(x2) > 0.99999) {
                interest_pay = Double(Int(round(percentage)/100*remainingbalance*i*100)+1)/100 }
            else { interest_pay = Double(Int(round(percentage)/100*remainingbalance*i*100))/100 }
            
            if (a == ceil(Double(Int(p*i*100)+1))/100) {
                if (progress == 100) { principal_pay = a - interest_pay }
                else { principal_pay = a - (1.0-c)*0.01 - interest_pay } //won't need 0.01, if interest not compounded
            }
            else { principal_pay = a - interest_pay }
            //print("y:",x2,floor(x2),x2-floor(x2))
            print(a)
            print("interest",interest,"interest_pay",interest_pay,"principal_pay",principal_pay,"remainingbalance",remainingbalance)
            */
        //print(remainingbalance - principal_pay)
        //print(a)
        while (remainingbalance - principal_pay > 0) {
            //while (remainingbalance + c*interest > c*interest_pay + principal_pay) {// >= because if c=0 and not paying interest yet, then final month will merge with interest owed
            //while (remainingbalance + c*interest >= c*interest_pay + principal_pay) {// >= because if c=0 and not paying interest yet, then final month will merge with interest owed
                //remainingbalance = remainingbalance + c*interest - (c*interest_pay + principal_pay)
                //print(remainingbalance)
                remainingbalance = remainingbalance - principal_pay

                if (remainingbalance*100 - floor(remainingbalance*100) > 0.499999) && (remainingbalance*100 - floor(remainingbalance*100) < 0.5)
                { remainingbalance = round(remainingbalance*100 + 1)/100}
                else { remainingbalance = round(remainingbalance*100)/100 }

                //outstandingbalance = outstandingbalance + (1.0-c)*interest - (1.0-c)*interest_pay
                outstandingbalance = outstandingbalance + interest - interest_pay
            
                if (outstandingbalance*100 - floor(outstandingbalance*100) > 0.499999) && (outstandingbalance*100 - floor(outstandingbalance*100) < 0.5)
                { outstandingbalance = round(outstandingbalance*100 + 1)/100}
                else { outstandingbalance = round(outstandingbalance*100)/100 }

                //outstandingbalance = round(outstandingbalance*100)/100 //or else it starts collecting errors
                //recompute
                if (remainingbalance*i*100 - floor(remainingbalance*i*100) > 0.499999) && (remainingbalance*i*100 - floor(remainingbalance*i*100) < 0.5)
                { interest = round(remainingbalance*i*100 + 1)/100}
                else { interest = round(remainingbalance*i*100)/100 }
                //interest_pay = round(round(percentage)/100*remainingbalance*i*100)/100
                
                //x = percentage/100*interest
                x = percentage/100*remainingbalance*i
                if (x*100 - floor(x*100) > 0.499999) && (x*100 - floor(x*100) < 0.5)
                { interest_pay = round(x*100 + 1)/100}
                else { interest_pay = round(x*100)/100 }

                if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
                { tempx = (round(p*i*100 + 1)+1)/100}
                else { tempx = (round(p*i*100)+1)/100 }

                if (a == tempx) {
                    if (progress == 100) { principal_pay = a - interest_pay }
                    else { principal_pay = a - interest_pay } //won't need 0.01, if interest not compounded
                }
                else { principal_pay = a - interest_pay } //may lose some precision
                
                j += 1
                
                //print(remainingbalance,"+",interest,"-(",interest_pay,"+",principal_pay,")")
//                print(outstandingbalance,"=",outstandingbalance,"+",interest,"-",interest_pay)
                //print("remainingbalance:",remainingbalance)
                //print("outstandingbalance:",outstandingbalance)
                //print(remainingbalance,"+",interest,"- (",interest_pay,"+",principal_pay,") =",remainingbalance+interest-(interest_pay+principal_pay))
                }
            //}
        //}
        //print(j)
        
            

            


            
            
            
            
            
            
            
            
                //print(pay)
                //let interest_temp = round(percentage)/100*ceil(Double(Int(p*i*100)))/100
                //let payment_temp = (100-round(percentage))/100*(a-0.01)
                //rounding interest consistently downward, so rounding payment upward
                //let round_interest = ceil(Double(Int(interest_temp*100)))/100
                //et round_payment = ceil(payment_temp*100)/100
                
                //could probably simplify this
                /*var interest_temp2 = Double()
                
                while (remainingbalance > pay) {
                    
                    //let y = round(percentage_calculations)/100*remainingbalance*i*100
                    let y = round(percentage)/100*remainingbalance*i*100
                    /*print("y:",y)
                    print("floor(y):",floor(y))
                    print("y-floor(y):",y - floor(y))*/
                    if (y - floor(y) > 0.99999) {
                        interest_temp2 = Double(Int(round(percentage)/100*remainingbalance*i*100)+1)/100
                    }
                    else {
                        interest_temp2 = Double(Int(round(percentage)/100*remainingbalance*i*100))/100
                    }
                    let z = remainingbalance*i*100
                    if (z - floor(z) > 0.99999) {
                        pre_outstandingbalance = ceil(Double(Int(remainingbalance*i*100)+1))/100
                    }
                    else {
                        pre_outstandingbalance = ceil(Double(Int(remainingbalance*i*100)))/100
                    }
                    //"pre" is interest charged, it's just that I had to increment it
                    //print("z:",z)
                    //print("floor(z):",floor(z))
                    //print("z-floor(z):",z - floor(z))


                    if (pre_outstandingbalance - interest_temp2 > 0) {
                        outstandingbalance += pre_outstandingbalance - interest_temp2
                        //print(Int(remainingbalance*i*100))
                        //print("remaining balance:",remainingbalance)
                        //print("z - floor(z):",z - floor(z))
                        //print("interest charged:",ceil(Double(Int(remainingbalance*i*100)))/100)
                        //print("interest paid:",interest_temp2)
                        //print("interest pre_outstanding:",pre_outstandingbalance)
                        //print("interest outstanding:",outstandingbalance)
                        //print("still owe:",pre_outstandingbalance - interest_temp2)
                    }
                    if (a == ceil(Double(Int(p*i*100)+1))/100) {
                        pay = a - 0.01 - interest_temp2
                    }
                    else {
                        pay = a - interest_temp2
                    }

                    remainingbalance = remainingbalance - pay
                    j += 1
                    //print("interest outstanding:",outstandingbalance)
                }*/
            //breaking it up like this may not matter for months 1-4 part, but did so anyway to be consistent
            //originally, a = interest + 0.01, now we assume interest doesn't compound, and extra penny is not necessary - BASED ON FIRST MONTH!!!!!! and am not considering larger cases, yet
        /*else {
            if (ceil((p / a) - 1) - floor(ceil((p / a) - 1)) > 0.99999)
            { j = Int(ceil((p / a) - 1) + 1) }
            else { j = Int(ceil((p / a) - 1)) }
            
            remainingbalance = p - a * Double(j)
        }*/
        
        
        //redo pay title
        var tempx_x = Double()
        if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
        { tempx_x = (round(p*i*100 + 1)+1)/100}
        else { tempx_x = (round(p*i*100)+1)/100 }
        
        attributedPayTitle = NSMutableAttributedString(string: "Pay Monthly", attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Bold", size: 18.0)! ])
        if (decision == false) {
            if (a == tempx_x) {
                if (progress == 100) {
                    attributedPaySummary = NSMutableAttributedString(string: " $" + String(format: "%.2f", a), attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
                }
                else {
                    attributedPaySummary = NSMutableAttributedString(string: " $" + String(format: "%.2f", a), attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
                }
            }
            else if (i == 0) {
                let check = a
                if (check - floor(check) > 0) {
                    attributedPaySummary = NSMutableAttributedString(string: " $" + String(format: "%.2f", a), attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
                }
                else {
                    attributedPaySummary = NSMutableAttributedString(string: " $" + String(format: "%.0f", a), attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
                }
            }
            else {
                let check = a
                if (check - floor(check) > 0) {
                    attributedPaySummary = NSMutableAttributedString(string: " $" + String(format: "%.2f", a), attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
                }
                else {
                    attributedPaySummary = NSMutableAttributedString(string: " $" + numberFormatter.string(from: NSNumber(value: a))!, attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
                }
            }
        }
        else {
            attributedPaySummary = NSMutableAttributedString(string: " $" + String(format: "%.2f", a), attributes: [ NSAttributedStringKey.font: UIFont(name: "CMUSerif-Roman", size: 18.0)! ])
        }
        attributedPayTitle.append(attributedPaySummary)
        pay_monthly.attributedText = attributedPayTitle
        
        //spread some table columns out more, if iphone is a plus model
        /*NSLayoutConstraint.deactivate([add.widthAnchor.constraint(equalToConstant: add.frame.width)])
        NSLayoutConstraint.deactivate([subtract.widthAnchor.constraint(equalToConstant: subtract.frame.width)])
         NSLayoutConstraint.deactivate([equals.widthAnchor.constraint(equalToConstant: equals.frame.width)])*/
        //view.addConstraint(add.widthAnchor.constraint(equalToConstant: 6))
        //iew.addConstraint(subtract.widthAnchor.constraint(equalToConstant: 6))
        //view.addConstraint(equals.widthAnchor.constraint(equalToConstant: 6))

        //remaining frame or remaining label shifts after pressing switch or moving thumb, non issue if set constraints visually
        if (decision == true) {
            add.frame.size.width = 12
            add_width.constant = CGFloat(12)
            add.widthAnchor.constraint(equalToConstant: CGFloat(12))
            //subtract.frame.size.width = 6
            //subtract_width.constant = CGFloat(6)
            //subtract.widthAnchor.constraint(equalToConstant: CGFloat(6))
            equals.frame.size.width = 8
            equals_width.constant = CGFloat(8)
            equals.widthAnchor.constraint(equalToConstant: CGFloat(8))

            
            //subtract.frame.size.width = 7
            //equals.frame.size.width = 8
            //view.addConstraint(add.widthAnchor.constraint(equalToConstant: 11))
            //view.addConstraint(subtract.widthAnchor.constraint(equalToConstant: 7))
            //view.addConstraint(equals.widthAnchor.constraint(equalToConstant: 8))
        }
        else {
            //proceed
        }
        if (j > 4) {
            //NSLayoutConstraint.deactivate([table.heightAnchor.constraint(equalToConstant: CGFloat(22*(j+1)))])
            //NSLayoutConstraint.activate([table.heightAnchor.constraint(equalToConstant: 132)])
            table_height.constant = CGFloat(132)
            balance.frame = CGRect(x: Int(balance.frame.origin.x), y: 0, width: Int(balance.frame.width), height: 132)
            add.frame = CGRect(x: Int(add.frame.origin.x), y: 0, width: Int(add.frame.width), height: 132)
            charged_interest.frame = CGRect(x: Int(charged_interest.frame.origin.x), y: 0, width: Int(charged_interest.frame.width), height: 132)
            subtract.frame = CGRect(x: Int(subtract.frame.origin.x), y: 0, width: Int(subtract.frame.width), height: 132)
            payment.frame = CGRect(x: Int(payment.frame.origin.x), y: 0, width: Int(payment.frame.width), height: 132)
            equals.frame = CGRect(x: Int(equals.frame.origin.x), y: 0, width: Int(equals.frame.width), height: 132)
            remaining.frame = CGRect(x: Int(remaining.frame.origin.x), y: 0, width: Int(table.frame.width-balance.frame.width-add.frame.width-charged_interest.frame.width)-Int(subtract.frame.width+payment.frame.width+equals.frame.width), height: 132)
            //remaining.frame = CGRect(x: Int(remaining.frame.origin.x), y: 0, width: Int(table.frame.width-balance.frame.width-add.frame.width-charged_interest.frame.width-subtract.frame.width-payment.frame.width-equals.frame.width), height: 132)
            pay_insight.frame = CGRect(x: 10, y: 0, width: Int(pay_insight.frame.width), height: 132)

        }
        else {
            //NSLayoutConstraint.deactivate([table.heightAnchor.constraint(equalToConstant: 132)])
            //NSLayoutConstraint.activate([table.heightAnchor.constraint(equalToConstant: CGFloat(22*(j+1)))])
            table_height.constant = CGFloat(22*(j+1))
            table.heightAnchor.constraint(equalToConstant: CGFloat(22*(j+1)))
            balance.frame = CGRect(x: Int(balance.frame.origin.x), y: 0, width: Int(balance.frame.width), height: 22*(j+1))
            add.frame = CGRect(x: Int(add.frame.origin.x), y: 0, width: Int(add.frame.width), height: 22*(j+1))
            charged_interest.frame = CGRect(x: Int(charged_interest.frame.origin.x), y: 0, width: Int(charged_interest.frame.width), height: 22*(j+1))
            subtract.frame = CGRect(x: Int(subtract.frame.origin.x), y: 0, width: Int(subtract.frame.width), height: 22*(j+1))
            payment.frame = CGRect(x: Int(payment.frame.origin.x), y: 0, width: Int(payment.frame.width), height: 22*(j+1))
            equals.frame = CGRect(x: Int(equals.frame.origin.x), y: 0, width: Int(equals.frame.width), height: 22*(j+1))
            let CGRect_widthtemp = Int(table.frame.width-balance.frame.width-add.frame.width-charged_interest.frame.width)-Int(subtract.frame.width-payment.frame.width-equals.frame.width)
            remaining.frame = CGRect(x: Int(remaining.frame.origin.x), y: 0, width: CGRect_widthtemp, height: 22*(j+1))
            //remaining.frame = CGRect(x: Int(remaining.frame.origin.x), y: 0, width: Int(table.frame.width-balance.frame.width-add.frame.width-charged_interest.frame.width-subtract.frame.width-payment.frame.width-equals.frame.width), height: 132)

            pay_insight.frame = CGRect(x: 10, y: 0, width: Int(pay_insight.frame.width), height: 22*(j+1))
        }
        //remaining_label.frame = CGRect(x: 0, y: 0, width: remaining.frame.width, height: remaining.frame.height)

        //remaining.backgroundColor = UIColor.red

        //Shape of balance body---------------------
        balance_shape.bounds = balance.frame
        balance_shape.position = balance.center
        balance_shape.path = UIBezierPath(roundedRect: balance.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        if (decision == false) {
            balance_shape.strokeColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.125).cgColor
            balance_shape.fillColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.25+0.125).cgColor
        }
        else {
            balance_shape.strokeColor = UIColor.clear.cgColor
            balance_shape.fillColor = UIColor.clear.cgColor
        }
        balance_shape.lineWidth = 0

        //Shape of interest body---------------------
        charged_interest_shape.bounds = charged_interest.frame
        charged_interest_shape.position = charged_interest.center
        charged_interest_shape.path = UIBezierPath(roundedRect: charged_interest.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        if (decision == false) {
            if (i == 0) {
                charged_interest_shape.fillColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.0625).cgColor
                charged_interest_shape.strokeColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.020).cgColor
            }
            else {
                charged_interest_shape.fillColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.25+0.125).cgColor
                charged_interest_shape.strokeColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.125).cgColor
            }
        }
        else {
                charged_interest_shape.fillColor = UIColor.clear.cgColor
                charged_interest_shape.strokeColor = UIColor.clear.cgColor
        }
        charged_interest_shape.lineWidth = 0

        //Shape of payment body---------------------
        payment_shape.bounds = payment.frame
        payment_shape.position = payment.center
        //define in viewdidload BUT after Variables(): (or else will change path if switch or slider move)
        //payment_shape.path = UIBezierPath(roundedRect: payment.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        if (decision == false) {
            payment_shape.strokeColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.125).cgColor
            payment_shape.fillColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.25+0.125).cgColor
        }
        else {
            payment_shape.strokeColor = UIColor.clear.cgColor
            payment_shape.fillColor = UIColor.clear.cgColor
        }
        payment_shape.lineWidth = 0
        
        if (insight == 1) {
            //payment_header_shape.path = UIBezierPath(roundedRect: payment_header.bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
            payment_shape.path = UIBezierPath(roundedRect: payment.bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        }
        else {
            //payment_header_shape.path = UIBezierPath(roundedRect: payment_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
            payment_shape.path = UIBezierPath(roundedRect: payment.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        }

        
        pay_insight.frame = CGRect(x: 10, y: pay_insight.frame.origin.y, width: pay_insight.frame.width, height: pay_insight.frame.height)
        pay_insight_header.frame = CGRect(x: 10, y: pay_insight_header.frame.origin.y, width: pay_insight_header.frame.width, height: pay_insight_header.frame.height)

        
        var temp1 = Double()
        var temp2 = Double()
        var temp3 = Double()
        var temp4 = Double()
        /*var interest_temp3 = Double()
        var interest_temp4 = Double()
        var interest_temp5 = Double()
        var interest_temp6 = Double()*/
        /*var interest1 = Double()
        var interest2 = Double()
        var interest3 = Double()
        var interest4 = Double()*/
        var interest_pay1 = Double()
        var interest_pay2 = Double()
        var interest_pay3 = Double()
        var interest_pay4 = Double()
        var principal_pay1 = Double()
        var principal_pay2 = Double()
        var principal_pay3 = Double()
        var principal_pay4 = Double()

        //temp1---------------------------------------------
        /*if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
        { interest1 = round(p*i*100 + 1)/100}
        else { interest1 = round(p*i*100)/100 }*/
                    //interest_pay = round(round(percentage)/100*p*i*100)/100
        
        //var x1 = percentage/100*interest1
        var x1 = percentage/100*p*i
        if (x1*100 - floor(x1*100) > 0.499999) && (x1*100 - floor(x1*100) < 0.5)
        { interest_pay1 = round(x1*100 + 1)/100}
        else { interest_pay1 = round(x1*100)/100 }
        
        var tempxx = Double()
        if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
        { tempxx = (round(p*i*100 + 1)+1)/100}
        else { tempxx = (round(p*i*100)+1)/100 }
        
        if (a == tempxx) {
            if (progress == 100) { principal_pay1 = a - interest_pay1 }
            else { principal_pay1 = a - interest_pay1 } //won't need 0.01, if interest not compounded
        }
        else { principal_pay1 = a - interest_pay1 }
        
        //temp1 = p + c*interest1 - (c*interest_pay1 + principal_pay1)
        temp1 = p - principal_pay1

        //temp2---------------------------------------------
        /*if (temp1*i*100 - floor(temp1*i*100) > 0.499999) && (temp1*i*100 - floor(temp1*i*100) < 0.5)
        { interest2 = round(temp1*i*100 + 1)/100}
        else { interest2 = round(temp1*i*100)/100 }*/

        //x1 = percentage/100*interest2
        x1 = percentage/100*temp1*i
        if (x1*100 - floor(x1*100) > 0.499999) && (x1*100 - floor(x1*100) < 0.5)
        { interest_pay2 = round(x1*100 + 1)/100}
        else { interest_pay2 = round(x1*100)/100 }

        if (a == tempxx) {
            if (progress == 100) { principal_pay2 = a - interest_pay2 }
            else { principal_pay2 = a - interest_pay2 } //won't need 0.01, if interest not compounded
        }
        else { principal_pay2 = a - interest_pay2 }

        //temp2 = temp1 + c*interest2 - (c*interest_pay2 + principal_pay2)
        temp2 = temp1 - principal_pay2
        
        //temp3------------------------------------------------
        /*if (temp2*i*100 - floor(temp2*i*100) > 0.499999) && (temp2*i*100 - floor(temp2*i*100) < 0.5)
        { interest3 = round(temp2*i*100 + 1)/100}
        else { interest3 = round(temp2*i*100)/100 }*/

        //x1 = percentage/100*interest3
        x1 = percentage/100*temp2*i
        if (x1*100 - floor(x1*100) > 0.499999) && (x1*100 - floor(x1*100) < 0.5)
        { interest_pay3 = round(x1*100 + 1)/100}
        else { interest_pay3 = round(x1*100)/100 }

        if (a == tempxx) {
            if (progress == 100) { principal_pay3 = a - interest_pay3 }
            else { principal_pay3 = a - interest_pay3 } //won't need 0.01, if interest not compounded
        }
        else { principal_pay3 = a - interest_pay3 }
        
        //temp3 = temp2 + c*interest3 - (c*interest_pay3 + principal_pay3)
        temp3 = temp2 - principal_pay3

        //temp4------------------------------------------------
        /*if (temp3*i*100 - floor(temp3*i*100) > 0.499999) && (temp3*i*100 - floor(temp3*i*100) < 0.5)
        { interest4 = round(temp3*i*100 + 1)/100}
        else { interest4 = round(temp3*i*100)/100 }*/
        
        //x1 = percentage/100*interest4
        x1 = percentage/100*temp3*i
        if (x1*100 - floor(x1*100) > 0.499999) && (x1*100 - floor(x1*100) < 0.5)
        { interest_pay4 = round(x1*100 + 1)/100}
        else { interest_pay4 = round(x1*100)/100 }

        if (a == tempxx) {
            if (progress == 100) { principal_pay4 = a - interest_pay4 }
            else { principal_pay4 = a - interest_pay4 } //won't need 0.01, if interest not compounded
        }
        else { principal_pay4 = a - interest_pay4 }

        //temp4 = temp3 + c*interest4 - (c*interest_pay4 + principal_pay4)
        temp4 = temp3 - principal_pay4



        
        //if (progress == 100) {
            //temp1 = p + ceil(Double(Int(p*i*100)))/100 - a
            //temp2 = temp1 + ceil(Double(Int(temp1*i*100)))/100 - a
            //temp3 = temp2 + ceil(Double(Int(temp2*i*100)))/100 - a
            //temp4 = temp3 + ceil(Double(Int(temp3*i*100)))/100 - a
        //}
        //else {
            //let interest_temp = floor(round(percentage)/100*p*i*100)/100
            //let w = round(percentage_calculations)/100*p*i*100
            /*let w = round(percentage)/100*p*i*100
            if (w - floor(w) > 0.99999) { interest_temp3 = Double(Int(round(percentage)/100*p*i*100)+1)/100 }
            else { interest_temp3 = Double(Int(round(percentage)/100*p*i*100))/100 }
            if (a == ceil(Double(Int(p*i*100)+1))/100) { temp1 = p - (a - 0.01 - interest_temp3) }
            else { temp1 = p - (a - interest_temp3) }
            
            let w2 = round(percentage)/100*temp1*i*100
            if (w2 - floor(w2) > 0.99999) { interest_temp4 = Double(Int(round(percentage)/100*temp1*i*100)+1)/100 }
            else { interest_temp4 = Double(Int(round(percentage)/100*temp1*i*100))/100 }
            if (a == ceil(Double(Int(p*i*100)+1))/100) { temp2 = temp1 - (a - 0.01 - interest_temp4) }
            else { temp2 = temp1 - (a - interest_temp4) }
            
            let w3 = round(percentage)/100*temp2*i*100
            if (w3 - floor(w3) > 0.99999) { interest_temp5 = Double(Int(round(percentage)/100*temp2*i*100)+1)/100 }
            else { interest_temp5 = Double(Int(round(percentage)/100*temp2*i*100))/100 }
            if (a == ceil(Double(Int(p*i*100)+1))/100) { temp3 = temp2 - (a - 0.01 - interest_temp5) }
            else { temp3 = temp2 - (a - interest_temp5) }

            let w4 = round(percentage)/100*temp3*i*100
            if (w4 - floor(w4) > 0.99999) { interest_temp6 = Double(Int(round(percentage)/100*temp3*i*100)+1)/100 }
            else { interest_temp6 = Double(Int(round(percentage)/100*temp3*i*100))/100 }
            if (a == ceil(Double(Int(p*i*100)+1))/100) { temp4 = temp3 - (a - 0.01 - interest_temp6) }
            else { temp4 = temp3 - (a - interest_temp6) }*/

            /*var interest_temp = Double()
            let x = round(percentage)/100*p*i*100
            if (x - floor(x) > 0.99999) {
                interest_temp = Double(Int(round(percentage)/100*p*i*100)+1)/100
            }
            else {
                interest_temp = Double(Int(round(percentage)/100*p*i*100))/100
            }*/

            //let interest_temp = floor(round(percentage)/100*p*i*100)/100
            //let interest_temp = round(percentage)/100*ceil(Double(Int(p*i*100)))/100
            //let payment_temp = (100-round(percentage))/100*(a-0.01)
            //rounding interest consistently downward
            //let round_interest = ceil(Double(Int(interest_temp*100)))/100
            /*if (a == ceil(Double(Int(p*i*100)+1))/100) {
                pay = a - 0.01 - interest_temp2
            }
            else {
                pay = a - interest_temp2
            }*/

            //var pay = Double()
            

            
            
            //print("interest_temp:",interest_temp,"\nround_interest:",round_interest,"\npay:",pay)
            //let round_payment = ceil(payment_temp*100)/100
            //breaking it up like this may not matter for months 1-4 part, but did so anyway to be consistent
            //originally, a = interest + 0.01, now we assume interest doesn't compound, and extra penny is not necessary - BASED ON FIRST MONTH!!!!!! and am not considering larger cases, yet

            //print("-------")
            //print(round(percentage))
            //print(Int(round(percentage)))
            //print(Double(Int(round(percentage))))
            //print(Double(Int(round(percentage)))/100*p*i)
            //print(Double(Int(round(percentage)))/100*p*i*100)
            //let something = Double(Int(round(percentage)))/100*p*i*1000
            //let that = something.rounded(.down)
            //print(Int(Double(Int(round(percentage)))/100*p*i*1000))
            //print(that)
            //print(p)
            //print(i)
            //print(p*i)
            //print(round(percentage)/100*p*i)
            //print(round(percentage)/100*p*i*100)//deceiving when decimal is ...999999999
            //let x = round(percentage)/100*p*i*100
            //if (x - floor(x) > 0.99999) {
            //    print(Double(Int(round(percentage)/100*p*i*100)+1)/100)
            //}
            //else {
            //    print(Double(Int(round(percentage)/100*p*i*100))/100)
            //}
            //print(x-floor(x))
            //print(round(round(percentage)/100*p*i*100))
            //print(Int(round(round(percentage)/100*p*i*100)))

            //let something = floor(round(percentage)/100*p*i*100)
            //let that = round(percentage)/100*p*i*100 - something
            //print(round(percentage)/100*p*i*100 - that)
            //print(floor(round(percentage)/100*p*i*1000000000000))
            //print(Int(Double(Int(round(percentage)))/100*p*i*100))
            //print(Double(Int(Double(Int(round(percentage)))/100*p*i*100)))
            //print(ceil(Double(Int(Double(Int(round(percentage)))/100*p*i*100)))/100)


            //print((round(percentage)/100*p*i*100)/100)
            //print(floor(round(percentage)/100*p*i*100)/100)
            //print(ceil(floor(round(percentage)/100*p*i*100)/100))
            //print(interest_temp,"\n",pay,"\n",temp1)
            //print(p," ",temp1," ",temp2," ",temp3)
            //print(round_interest," ",round_payment)
        //}
        /*if (decision == true) {
            note_view.isHidden = false
            note.text = "Rounded interest ↓\n"
        }
        else {
            //proceed
        }*/
        if (i == 0) { //<--- old code
            note_view.isHidden = true
            //payment.isEnabled = false
            //payment_header.isEnabled = false
            //note.isHidden = true
        }
        else {
            note_view.isHidden = false
            //payment.isEnabled = true
            //payment_header.isEnabled = true
            //note.isHidden = false
        }
        
        /*let ellipse = UILabel()
         //ellipse.frame = CGRect(x: 0, y: 0, width: interest_header.frame.width, height: interest_header.frame.height)
         //ellipse.bounds = interest_header.frame
         ellipse.text = "︙"
         //ellipse.textAlignment = .center
         //ellipse.numberOfLines = 0
         ellipse.textColor = UIColor.gray
         ellipse.font = UIFont(name: "CMUSerif-Roman", size: 16.0)*/
        
        
        //Text of balance body------------------------------
        
        //let textRect = CGRect(x: 0.2*balance.frame.width, y: 0, width: balance.frame.width-2*0.2*balance.frame.width, height: balance.frame.height)
        //let textRect_balance = CGRect(x: 0, y: 0, width: balance.frame.width, height: balance.frame.height)
        //let insets_balance = UIEdgeInsets(top: 0, left: 0.03*balance.frame.width, bottom: 0, right: 2*0.05*balance.frame.width)
        //balance_shape_label.frame = UIEdgeInsetsInsetRect(textRect_balance, insets_balance)
        //titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.25, bottom: 0.0, right: 0.0)
        //let array = [String(format: "%.2f", p), String(format: "%.2f", temp1), String(format: "%.2f", temp2), String(format: "%.2f", temp3), String(format: "%.2f", remainingbalance)]
        /*balance_shape_label.text = array[0] + "\n" +
         array[1] + "\n" +
         array[2] + "\n" +
         array[3] + "\n" +
         "\n" +
         array[4]*/
        if (j > 0) {
            refund.isHidden = true
            coffee_cup.isHidden = true
        }
        else {
            refund.isHidden = false
            coffee_cup.isHidden = false
        }
        
        
        if (j > 4) {
            //let paragraph_principal = NSMutableParagraphStyle()
            //paragraph_principal.alignment = .right
            //let paragraph_principal_ellipse = NSMutableParagraphStyle()
            //paragraph_principal_ellipse.alignment = .center
            let balance_shape_label_jg4 = NSMutableAttributedString(string: String(format: "%.2f", p) + "\n" +
                String(format: "%.2f", temp1) + "\n" +
                String(format: "%.2f", temp2) + "\n" +
                String(format: "%.2f", temp3) + "\n", attributes: [ :])
            var etc = NSMutableAttributedString()
            if (decision == false) {
                etc = NSMutableAttributedString(string:
                    "︙\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray])
            }
            else {
                etc = NSMutableAttributedString(string:
                    "\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray])
            }
            let remains = NSMutableAttributedString(string:
                String(format: "%.2f", remainingbalance), attributes: [ :])
            balance_shape_label_jg4.append(etc)
            balance_shape_label_jg4.append(remains)
            balance_shape_label.attributedText = balance_shape_label_jg4
        }
        else if (j == 4) {
            balance_shape_label.text = String(format: "%.2f", p) + "\n" +
                String(format: "%.2f", temp1) + "\n" +
                String(format: "%.2f", temp2) + "\n" +
                String(format: "%.2f", temp3) + "\n" +
                String(format: "%.2f", remainingbalance)
            //balance_shape_label.textAlignment = .right
        }
        else if (j == 3) {
            balance_shape_label.text = String(format: "%.2f", p) + "\n" +
                String(format: "%.2f", temp1) + "\n" +
                String(format: "%.2f", temp2) + "\n" +
                String(format: "%.2f", remainingbalance)
            //balance_shape_label.textAlignment = .right
        }
        else if (j == 2) {
            balance_shape_label.text = String(format: "%.2f", p) + "\n" +
                String(format: "%.2f", temp1) + "\n" +
                String(format: "%.2f", remainingbalance)
            //balance_shape_label.textAlignment = .right
        }
        else if (j == 1) {
            balance_shape_label.text = String(format: "%.2f", p) + "\n" +
                String(format: "%.2f", remainingbalance)
            //balance_shape_label.textAlignment = .right
        }
        else {
            balance_shape_label.text = String(format: "%.2f", remainingbalance)
            //balance_shape_label.textAlignment = .right
        }
        if (decision == false) {
            balance_shape_label.textAlignment = .center
        }
        else {
            balance_shape_label.textAlignment = .center
            //balance_shape_label.textAlignment = .right
        }
        balance_shape_label.numberOfLines = 0
        //balance_shape_label.textColor = UIColor.white
        balance_shape_label.font = UIFont(name: "CMUSerif-Roman", size: 16.0)
        balance_shape_label.adjustsFontSizeToFitWidth = true

        
        //balance.textAlignment = .right
        //balance.text = "hello\nagain"
        
        //ADD--------------------------------------------
        if (decision == true) {
            if (j > 4) {
                add_label.text = "+" + "\n" +
                    "+" + "\n" +
                    "+" + "\n" +
                    "+" + "\n" +
                    "\n" +
                "+"
            }
            else if (j == 4) {
                add_label.text = "+" + "\n" +
                    "+" + "\n" +
                    "+" + "\n" +
                    "+" + "\n" +
                "+"
            }
            else if (j == 3) {
                add_label.text = "+" + "\n" +
                    "+" + "\n" +
                    "+" + "\n" +
                "+"
            }
            else if (j == 2) {
                add_label.text = "+" + "\n" +
                    "+" + "\n" +
                "+"
            }
            else if (j == 1) {
                add_label.text = "+" + "\n" +
                "+"
            }
            else {
                add_label.text = "+"
            }
            add_label.textAlignment = .center
            add_label.numberOfLines = 0
            add_label.textColor = UIColor.gray
            add_label.font = UIFont(name: "CMUSerif-Roman", size: 16.0)
            add_label.adjustsFontSizeToFitWidth = true
            //add_label.backgroundColor = UIColor.red

        }
        else {
            //don't display plus signs
        }
        
        
        //Text of interest body----------------------
        
        var temp = Int() //don't want it rounding, unless remainder has repeated 9s
        if (i*100*1000 - floor(i*100*1000) > 0.99999) {
            temp = Int(i*100*1000)+1
        }
        else {
            temp = Int(i*100*1000)
        }
        
        var charged_interest_max_string_count = Int()
        if (decision == false) {
            if (j > 4) {
                let paragraph_charged_interest = NSMutableParagraphStyle()
                paragraph_charged_interest.alignment = .right
                let paragraph_charged_interest_ellipse = NSMutableParagraphStyle()
                paragraph_charged_interest_ellipse.alignment = .center
                let charged_interest_shape_label_jg4 = NSMutableAttributedString(string: String(format: "%.2f", p) + " · 0.00" + String(temp) + "...\n" +
                    String(format: "%.2f", temp1) + " · 0.00" + String(temp) + "...\n" +
                    String(format: "%.2f", temp2) + " · 0.00" + String(temp) + "...\n" +
                    String(format: "%.2f", temp3) + " · 0.00" + String(temp) + "...\n", attributes: [NSAttributedStringKey.paragraphStyle: paragraph_charged_interest])
                var etc = NSMutableAttributedString()
                if (decision == false) {
                    etc = NSMutableAttributedString(string:
                        "︙\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.paragraphStyle: paragraph_charged_interest_ellipse ])
                }
                else {
                    etc = NSMutableAttributedString(string:
                        "           ︙\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.paragraphStyle: paragraph_charged_interest_ellipse ])
                }
                let remains = NSMutableAttributedString(string:
                    String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "...", attributes: [NSAttributedStringKey.paragraphStyle: paragraph_charged_interest])
                
                if (i == 0) {
                    charged_interest_shape_label_jg4.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5), NSAttributedStringKey.paragraphStyle: paragraph_charged_interest], range: NSRange(location:0,length: charged_interest_shape_label_jg4.length))
                    etc.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.125), NSAttributedStringKey.paragraphStyle: paragraph_charged_interest_ellipse], range: NSRange(location:0,length: etc.length))
                    remains.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5), NSAttributedStringKey.paragraphStyle: paragraph_charged_interest], range: NSRange(location:0,length: remains.length))
                }
                else {
                    //do nothing
                }
                charged_interest_shape_label_jg4.append(etc)
                charged_interest_shape_label_jg4.append(remains)
                charged_interest_shape_label.attributedText = charged_interest_shape_label_jg4
                
                charged_interest_max_string_count = (String(format: "%.2f", p) + " · 0.00" + String(temp) + "...").count //used for right inset
                //print((String(format: "%.2f", p) + " · 0.00" + String(temp) + "...").count)
            }
                
            else if (j == 4) {
                charged_interest_shape_label.text = String(format: "%.2f", p) + " · 0.00" + String(temp) + "...\n" +
                    String(format: "%.2f", temp1) + " · 0.00" + String(temp) + "...\n" +
                    String(format: "%.2f", temp2) + " · 0.00" + String(temp) + "...\n" +
                    String(format: "%.2f", temp3) + " · 0.00" + String(temp) + "...\n" +
                    String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "..."
                charged_interest_shape_label.textAlignment = .right
                if (i == 0) {
                    charged_interest_shape_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
                }
                else {
                    //do nothing
                }
                charged_interest_max_string_count = (String(format: "%.2f", p) + " · 0.00" + String(temp) + "...").count //used for right inset
            }
            else if (j == 3) {
                charged_interest_shape_label.text = String(format: "%.2f", p) + " · 0.00" + String(temp) + "...\n" +
                    String(format: "%.2f", temp1) + " · 0.00" + String(temp) + "...\n" +
                    String(format: "%.2f", temp2) + " · 0.00" + String(temp) + "...\n" +
                    String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "..."
                charged_interest_shape_label.textAlignment = .right
                if (i == 0) {
                    charged_interest_shape_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
                }
                else {
                    //do nothing
                }
                charged_interest_max_string_count = (String(format: "%.2f", p) + " · 0.00" + String(temp) + "...").count //used for right inset
            }
            else if (j == 2) {
                charged_interest_shape_label.text = String(format: "%.2f", p) + " · 0.00" + String(temp) + "...\n" +
                    String(format: "%.2f", temp1) + " · 0.00" + String(temp) + "...\n" +
                    String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "..."
                charged_interest_shape_label.textAlignment = .right
                if (i == 0) {
                    charged_interest_shape_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
                }
                else {
                    //do nothing
                }
                charged_interest_max_string_count = (String(format: "%.2f", p) + " · 0.00" + String(temp) + "...").count //used for right inset
            }
            else if (j == 1) {
                charged_interest_shape_label.text = String(format: "%.2f", p) + " · 0.00" + String(temp) + "...\n" +
                    String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "..."
                charged_interest_shape_label.textAlignment = .right
                if (i == 0) {
                    charged_interest_shape_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
                }
                else {
                    //do nothing
                }
                charged_interest_max_string_count = (String(format: "%.2f", p) + " · 0.00" + String(temp) + "...").count //used for right inset
            }
            else {
                charged_interest_shape_label.text = String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "..."
                charged_interest_shape_label.textAlignment = .right
                if (i == 0) {
                    charged_interest_shape_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
                }
                else {
                    //do nothing
                }
                charged_interest_max_string_count = (String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "...").count //used for right inset
            }
        }
        else {
            if (j > 4) {
                let paragraph_charged_interest = NSMutableParagraphStyle()
                paragraph_charged_interest.alignment = .right
                let paragraph_charged_interest_ellipse = NSMutableParagraphStyle()
                paragraph_charged_interest_ellipse.alignment = .center
                let charged_interest_shape_label_jg4 = NSMutableAttributedString(string: "(" + String(format: "%.2f", p) + " · 0.00" + String(temp) + "...)\n(" +
                    String(format: "%.2f", temp1) + " · 0.00" + String(temp) + "...)\n(" +
                    String(format: "%.2f", temp2) + " · 0.00" + String(temp) + "...)\n(" +
                    String(format: "%.2f", temp3) + " · 0.00" + String(temp) + "...)\n", attributes: [NSAttributedStringKey.paragraphStyle: paragraph_charged_interest])
                var etc = NSMutableAttributedString()
                if (decision == false) {
                    etc = NSMutableAttributedString(string:
                        "︙\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.paragraphStyle: paragraph_charged_interest_ellipse ])
                }
                else {
                    etc = NSMutableAttributedString(string:
                        "           ︙\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.paragraphStyle: paragraph_charged_interest_ellipse ])
                }
                let remains = NSMutableAttributedString(string: "(" +
                    String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "...)", attributes: [NSAttributedStringKey.paragraphStyle: paragraph_charged_interest])
                
                if (i == 0) {
                    charged_interest_shape_label_jg4.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.paragraphStyle: paragraph_charged_interest], range: NSRange(location:0,length: charged_interest_shape_label_jg4.length))
                    etc.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.paragraphStyle: paragraph_charged_interest_ellipse], range: NSRange(location:0,length: etc.length))
                    remains.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.paragraphStyle: paragraph_charged_interest], range: NSRange(location:0,length: remains.length))
                    
                }
                else {
                    //do nothing
                }
                charged_interest_shape_label_jg4.append(etc)
                charged_interest_shape_label_jg4.append(remains)
                charged_interest_shape_label.attributedText = charged_interest_shape_label_jg4
                
                charged_interest_max_string_count = ("(" + String(format: "%.2f", p) + " · 0.00" + String(temp) + "...)").count //used for right inset
                //print((String(format: "%.2f", p) + " · 0.00" + String(temp) + "...").count)
            }
                
            else if (j == 4) {
                charged_interest_shape_label.text = "(" + String(format: "%.2f", p) + " · 0.00" + String(temp) + "...)\n(" +
                    String(format: "%.2f", temp1) + " · 0.00" + String(temp) + "...)\n(" +
                    String(format: "%.2f", temp2) + " · 0.00" + String(temp) + "...)\n(" +
                    String(format: "%.2f", temp3) + " · 0.00" + String(temp) + "...)\n(" +
                    String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "...)"
                charged_interest_shape_label.textAlignment = .right
                if (i == 0) {
                    charged_interest_shape_label.textColor = UIColor.black
                }
                else {
                    //do nothing
                }
                charged_interest_max_string_count = ("(" + String(format: "%.2f", p) + " · 0.00" + String(temp) + "...)").count //used for right inset
            }
            else if (j == 3) {
                charged_interest_shape_label.text = "(" + String(format: "%.2f", p) + " · 0.00" + String(temp) + "...)\n(" +
                    String(format: "%.2f", temp1) + " · 0.00" + String(temp) + "...)\n(" +
                    String(format: "%.2f", temp2) + " · 0.00" + String(temp) + "...)\n(" +
                    String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "...)"
                charged_interest_shape_label.textAlignment = .right
                if (i == 0) {
                    charged_interest_shape_label.textColor = UIColor.black
                }
                else {
                    //do nothing
                }
                charged_interest_max_string_count = ("(" + String(format: "%.2f", p) + " · 0.00" + String(temp) + "...)").count //used for right inset
            }
            else if (j == 2) {
                charged_interest_shape_label.text = "(" + String(format: "%.2f", p) + " · 0.00" + String(temp) + "...)\n(" +
                    String(format: "%.2f", temp1) + " · 0.00" + String(temp) + "...)\n(" +
                    String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "...)"
                charged_interest_shape_label.textAlignment = .right
                if (i == 0) {
                    charged_interest_shape_label.textColor = UIColor.black
                }
                else {
                    //do nothing
                }
                charged_interest_max_string_count = ("(" + String(format: "%.2f", p) + " · 0.00" + String(temp) + "...)").count //used for right inset
            }
            else if (j == 1) {
                charged_interest_shape_label.text = "(" + String(format: "%.2f", p) + " · 0.00" + String(temp) + "...)\n(" +
                    String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "...)"
                charged_interest_shape_label.textAlignment = .right
                if (i == 0) {
                    charged_interest_shape_label.textColor = UIColor.black
                }
                else {
                    //do nothing
                }
                charged_interest_max_string_count = ("(" + String(format: "%.2f", p) + " · 0.00" + String(temp) + "...)").count //used for right inset
            }
            else {
                charged_interest_shape_label.text = "(" + String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "...)"
                charged_interest_shape_label.textAlignment = .right
                if (i == 0) {
                    charged_interest_shape_label.textColor = UIColor.black
                }
                else {
                    //do nothing
                }
                charged_interest_max_string_count = ("(" + String(format: "%.2f", remainingbalance) + " · 0.00" + String(temp) + "...)").count //used for right inset
            }
        }
        if (decision == false) {
            //keep
        }
        else {
            //charged_interest_shape_label.textAlignment = .center
        }
        charged_interest_shape_label.numberOfLines = 0
        //charged_interest_shape_label = UIColor.white
        charged_interest_shape_label.font = UIFont(name: "CMUSerif-Roman", size: 16.0)
        charged_interest_shape_label.adjustsFontSizeToFitWidth = true
        
        
        //SUBTRACT--------------------------------------------
        if (decision == true) {
            if (j > 4) {
                subtract_label.text = "-" + "\n" +
                    "-" + "\n" +
                    "-" + "\n" +
                    "-" + "\n" +
                    "\n" +
                "-"
            }
            else if (j == 4) {
                subtract_label.text = "-" + "\n" +
                    "-" + "\n" +
                    "-" + "\n" +
                    "-" + "\n" +
                "-"
            }
            else if (j == 3) {
                subtract_label.text = "-" + "\n" +
                    "-" + "\n" +
                    "-" + "\n" +
                "-"
            }
            else if (j == 2) {
                subtract_label.text = "-" + "\n" +
                    "-" + "\n" +
                "-"
            }
            else if (j == 1) {
                subtract_label.text = "-" + "\n" +
                "-"
            }
            else {
                subtract_label.text = "-"
            }
            subtract_label.textAlignment = .center
            subtract_label.numberOfLines = 0
            subtract_label.textColor = UIColor.lightGray
            subtract_label.font = UIFont(name: "CMUSerif-Roman", size: 16.0)
            subtract_label.adjustsFontSizeToFitWidth = true
            //subtract_label.backgroundColor = UIColor.red

        }
        else {
            //don't display minus signs
        }
        
        //Text of payment body--------------------------------------------
        
        var remaining_interest = Double()
        if (remainingbalance*i*100 - floor(remainingbalance*i*100) > 0.499999) && (remainingbalance*i*100 - floor(remainingbalance*i*100) < 0.5)
        { remaining_interest = round(remainingbalance*i*100 + 1)/100}
        else { remaining_interest = round(remainingbalance*i*100)/100 }
        
        //print(remaining_interest)
        
        
        
        if (j > 4) {
            var payment_shape_label_jg4 = NSMutableAttributedString()
            var etc = NSMutableAttributedString()
            var remains = NSMutableAttributedString()
            
            var tempx = Double()
            if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
            { tempx = (round(p*i*100 + 1)+1)/100}
            else { tempx = (round(p*i*100)+1)/100 }
            
            if (a == tempx) {
                if (progress == 100) {
                    payment_shape_label_jg4 = NSMutableAttributedString(string: String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n", attributes: [ :])
                    if (decision == false) {
                        etc = NSMutableAttributedString(string:
                            "︙\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
                    }
                    else {
                        etc = NSMutableAttributedString(string:
                            "\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
                    }
                    remains = NSMutableAttributedString(string:
                        String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance), attributes: [ :])
                }
                else {
                    payment_shape_label_jg4 = NSMutableAttributedString(string: String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n", attributes: [ :])
                    if (decision == false) {
                        etc = NSMutableAttributedString(string:
                            "︙\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
                    }
                    else {
                        etc = NSMutableAttributedString(string:
                            "\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
                    }
                    remains = NSMutableAttributedString(string:
                        String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance), attributes: [ :])
                }
            }
            else {
                payment_shape_label_jg4 = NSMutableAttributedString(string: String(format: "%.2f", a) + "\n" +
                    String(format: "%.2f", a) + "\n" +
                    String(format: "%.2f", a) + "\n" +
                    String(format: "%.2f", a) + "\n", attributes: [ :])
                if (decision == false) {
                    etc = NSMutableAttributedString(string:
                        "︙\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
                }
                else {
                    etc = NSMutableAttributedString(string:
                        "\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
                }
                remains = NSMutableAttributedString(string:
                    String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance), attributes: [ :])
            }
            payment_shape_label_jg4.append(etc)
            payment_shape_label_jg4.append(remains)
            payment_shape_label.attributedText = payment_shape_label_jg4
            //CALCULATIONS//
            
            //print(remainingbalance)
            //print(ceil(Double(Int(remainingbalance*i*100)))/100)
            //print(outstandingbalance)
            //print(remainingbalance + ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance)
        }
        else if (j == 4) {
            if (a == tempx) {
                if (progress == 100) {
                    payment_shape_label.text = String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance)
                }
                else {
                    payment_shape_label.text = String(format: "%.2f", a) + "\n" + //won't need 0.01, if interest not compounded
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance)
                }
            }
            else {
                payment_shape_label.text = String(format: "%.2f", a) + "\n" +
                    String(format: "%.2f", a) + "\n" +
                    String(format: "%.2f", a) + "\n" +
                    String(format: "%.2f", a) + "\n" +
                    String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance)
            }
        }
        else if (j == 3) {
            if (a == tempx) {
                if (progress == 100) {
                    payment_shape_label.text = String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance)
                }
                else {
                    payment_shape_label.text = String(format: "%.2f", a) + "\n" + //won't need 0.01, if interest not compounded
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance)
                }
            }
            else {
                payment_shape_label.text = String(format: "%.2f", a) + "\n" +
                    String(format: "%.2f", a) + "\n" +
                    String(format: "%.2f", a) + "\n" +
                    String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance)
            }
        }
        else if (j == 2) {
            if (a == tempx) {
                if (progress == 100) {
                    payment_shape_label.text = String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance)
                }
                else {
                    payment_shape_label.text = String(format: "%.2f", a) + "\n" + //won't need 0.01, if interest not compounded
                        String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance)
                }
            }
            else {
                payment_shape_label.text = String(format: "%.2f", a) + "\n" +
                    String(format: "%.2f", a) + "\n" +
                    String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance)
            }
        }
        else if (j == 1) {
            if (a == tempx) {
                if (progress == 100) {
                    payment_shape_label.text = String(format: "%.2f", a) + "\n" +
                        String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance)
                }
                else {
                    payment_shape_label.text = String(format: "%.2f", a) + "\n" + //won't need 0.01, if interest not compounded
                        String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance)
                }
            }
            else {
                payment_shape_label.text = String(format: "%.2f", a) + "\n" +
                    String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance)
            }
        }
        else {
            payment_shape_label.text = String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance)
        }
        //if (decision == false) {
            payment_shape_label.textAlignment = .center
        //}
        //else {
        //    payment_shape_label.textAlignment = .left
        //}
        payment_shape_label.numberOfLines = 0
        //payment_shape_label.textColor = UIColor.white
        payment_shape_label.font = UIFont(name: "CMUSerif-Roman", size: 16.0)
        payment_shape_label.adjustsFontSizeToFitWidth = true
        
        //EQUALS--------------------------------------------
        if (decision == true) {
            if (j > 4) {
                equals_label.text = "≈" + "\n" +
                    "≈" + "\n" +
                    "≈" + "\n" +
                    "≈" + "\n" +
                    "\n" +
                "≈"
            }
            else if (j == 4) {
                equals_label.text = "≈" + "\n" +
                    "≈" + "\n" +
                    "≈" + "\n" +
                    "≈" + "\n" +
                "≈"
            }
            else if (j == 3) {
                equals_label.text = "≈" + "\n" +
                    "≈" + "\n" +
                    "≈" + "\n" +
                "≈"
            }
            else if (j == 2) {
                equals_label.text = "≈" + "\n" +
                    "≈" + "\n" +
                "≈"
            }
            else if (j == 1) {
                equals_label.text = "≈" + "\n" +
                "≈"
            }
            else {
                equals_label.text = "≈"
            }
            equals_label.textAlignment = .center
            equals_label.numberOfLines = 0
            equals_label.textColor = UIColor.gray
            equals_label.font = UIFont(name: "CMUSerif-Roman", size: 16.0)
            equals_label.adjustsFontSizeToFitWidth = true
            //equals_label.backgroundColor = UIColor.red

        }
        else {
            //don't display equal signs
        }
        
        //REMAINING------------------------------------------------------------
        /*let remaining_shape = CAShapeLayer()
         remaining_shape.frame = remaining.bounds
         remaining_shape.position = remaining.center
         remaining_shape.path = UIBezierPath(roundedRect: remaining.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
         remaining_shape.strokeColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.25).cgColor
         remaining_shape.fillColor = UIColor(red:161/255.0, green:166/255.0, blue:168/255.0, alpha: 0.125).cgColor
         remaining_shape.lineWidth = 2*/
        
        
        if (j > 4) {
            let remaining_label_jg4 = NSMutableAttributedString(string: String(format: "%.2f", temp1) + "\n" +
                String(format: "%.2f", temp2) + "\n" +
                String(format: "%.2f", temp3) + "\n" +
                String(format: "%.2f", temp4) + "\n", attributes: [ :])
            var etc = NSMutableAttributedString()
            if (decision == false) {
                etc = NSMutableAttributedString(string:
                    "︙\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
            }
            else {
                etc = NSMutableAttributedString(string:
                    "\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
            }
            let remains = NSMutableAttributedString(string:
                "0.00", attributes: [ :])
            if (insight == 1) {
                remaining_label_jg4.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5)], range: NSRange(location:0,length: remaining_label_jg4.length))
                etc.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.125)], range: NSRange(location:0,length: etc.length))
                remains.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5)], range: NSRange(location:0,length: remains.length))
            
            }
            else {
                remaining_label_jg4.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], range: NSRange(location:0,length: remaining_label_jg4.length))
                etc.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray], range: NSRange(location:0,length: etc.length))
                remains.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], range: NSRange(location:0,length: remains.length))
            }
            remaining_label_jg4.append(etc)
            remaining_label_jg4.append(remains)
            remaining_label.attributedText = remaining_label_jg4
            //remaining_label.frame = CGRect(x: remaining.frame.origin.x+10, y: 5, width: remaining.frame.width, height: remaining.frame.height)

        }
        else if (j == 4) {
            remaining_label.text = String(format: "%.2f", temp1) + "\n" +
                String(format: "%.2f", temp2) + "\n" +
                String(format: "%.2f", temp3) + "\n" +
                String(format: "%.2f", temp4) + "\n" +
            "0.00"
            if (insight == 1) {
                remaining_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
            }
            else {
                remaining_label.textColor = UIColor.black
            }

            //remaining_label.frame = CGRect(x: remaining.frame.origin.x+10, y: 4, width: remaining.frame.width, height: remaining.frame.height)
        }
        else if (j == 3) {
            remaining_label.text = String(format: "%.2f", temp1) + "\n" +
                String(format: "%.2f", temp2) + "\n" +
                String(format: "%.2f", temp3) + "\n" +
            "0.00"
            if (insight == 1) {
                remaining_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
            }
            else {
                remaining_label.textColor = UIColor.black
            }

            //remaining_label.frame = CGRect(x: remaining.frame.origin.x+10, y: 3, width: remaining.frame.width, height: remaining.frame.height)
        }
        else if (j == 2) {
            remaining_label.text = String(format: "%.2f", temp1) + "\n" +
                String(format: "%.2f", temp2) + "\n" +
            "0.00"
            if (insight == 1) {
                remaining_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
            }
            else {
                remaining_label.textColor = UIColor.black
            }

            //remaining_label.frame = CGRect(x: remaining.frame.origin.x+10, y: 2, width: remaining.frame.width, height: remaining.frame.height)
        }
        else if (j == 1) {
            remaining_label.text = String(format: "%.2f", temp1) + "\n" +
            "0.00"
            if (insight == 1) {
                remaining_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
            }
            else {
                remaining_label.textColor = UIColor.black
            }

            //remaining_label.frame = CGRect(x: remaining.frame.origin.x+10, y: 1, width: remaining.frame.width, height: remaining.frame.height)
        }
        else {
            remaining_label.text = "0.00"
            if (insight == 1) {
                remaining_label.textColor = UIColor.lightGray.withAlphaComponent(0.5)
            }
            else {
                remaining_label.textColor = UIColor.black
            }
            //remaining_label.frame = CGRect(x: remaining.frame.origin.x+10, y: 0, width: remaining.frame.width, height: remaining.frame.height)
        }
        if (decision == false) {
            remaining_label.textAlignment = .center
        }
        else {
            remaining_label.textAlignment = .center
            //remaining_label.textAlignment = .left
        }
        remaining_label.numberOfLines = 0
        //remaining_label.sizeToFit()
        //remaining_label.layoutMargins = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)

        remaining_label.font = UIFont(name: "CMUSerif-Roman", size: 16.0)
        remaining_label.adjustsFontSizeToFitWidth = true
        
            
        //remaining.layer.addSublayer(remaining_shape)
        
        
        
        
        
        //payment_header.layer.addSublayer(payment_header_shape)


        
        //Text of payment_insight--------------------------------------------
        
        var pay_insight_max_string_count_1 = Int()
        var pay_insight_max_string_count_2 = Int()

        if (j > 4) {
            let paragraph_pay_insight = NSMutableParagraphStyle()
            paragraph_pay_insight.alignment = .right
            let paragraph_pay_insight_ellipse = NSMutableParagraphStyle()
            paragraph_pay_insight_ellipse.alignment = .center
            var payment_insight_shape_label_jg4 = NSMutableAttributedString()
            var etc = NSMutableAttributedString()
            var remains = NSMutableAttributedString()
            
            //if (a == ceil(Double(Int(p*i*100)+1))/100) {
                //if (progress == 100) {
                    payment_insight_shape_label_jg4 = NSMutableAttributedString(string: String(format: "%.2f", principal_pay1) + " Prin.  + " + String(format: "%.2f", interest_pay1) + " Int. =\n" +
                        String(format: "%.2f", principal_pay2) + " Prin.  + " + String(format: "%.2f", interest_pay2) + " Int. =\n" +
                        String(format: "%.2f", principal_pay3) + " Prin.  + " + String(format: "%.2f", interest_pay3) + " Int. =\n" +
                        String(format: "%.2f", principal_pay4) + " Prin.  + " + String(format: "%.2f", interest_pay4) + " Int. =\n", attributes: [NSAttributedStringKey.paragraphStyle: paragraph_pay_insight])
                    etc = NSMutableAttributedString(string:
                        "\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.paragraphStyle: paragraph_pay_insight_ellipse ])
                    remains = NSMutableAttributedString(string:
                        String(format: "%.2f", remainingbalance) + " Prin.  + " + String(format: "%.2f", remaining_interest + outstandingbalance) + " Int. =", attributes: [NSAttributedStringKey.paragraphStyle: paragraph_pay_insight])
            //if (progress == 100) {
                //payment_insight_shape_label_jg4 = NSMutableAttributedString(string: "Breakdown of Pay\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 12.0)! ])
            //}
            /*else {
                if (a > ceil(Double(Int(p*i*100)+1))/100) {
                    payment_insight_shape_label_jg4 = NSMutableAttributedString(string: String(format: "%.2f", interest_temp3) + " Prin.  + " + String(format: "%.2f", a - interest_temp3) + " Int. =\n" +
                        String(format: "%.2f", interest_temp4) + " Prin.  + " + String(format: "%.2f", a - interest_temp4) + " Int. =\n" +
                        String(format: "%.2f", interest_temp5) + " Prin.  + " + String(format: "%.2f", a - interest_temp5) + " Int. =\n" +
                        String(format: "%.2f", interest_temp6) + " Prin.  + " + String(format: "%.2f", a - interest_temp6) + " Int. =\n", attributes: [ :])
                    etc = NSMutableAttributedString(string:
                        "︙\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
                    remains = NSMutableAttributedString(string:
                        String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = ", attributes: [ :])
                }
                else {
                    payment_insight_shape_label_jg4 = NSMutableAttributedString(string: String(format: "%.2f", interest_temp3) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp3) + " Int. =\n" +
                        String(format: "%.2f", interest_temp4) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp4) + " Int. =\n" +
                        String(format: "%.2f", interest_temp5) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp5) + " Int. =\n" +
                        String(format: "%.2f", interest_temp6) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp6) + " Int. =\n", attributes: [ :])
                    etc = NSMutableAttributedString(string:
                        "︙\n", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
                    remains = NSMutableAttributedString(string:
                        String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = ", attributes: [ :])
                }
            }*/
            //payment_insight_shape_label_jg4.append(breakdown)
            payment_insight_shape_label_jg4.append(etc)
            payment_insight_shape_label_jg4.append(remains)
            pay_insight_shape_label.attributedText = payment_insight_shape_label_jg4
            pay_insight_max_string_count_1 = (String(format: "%.2f", principal_pay) + " Prin.  + " + String(format: "%.2f", interest_pay) + " Int. =").count //used for right inset
            pay_insight_max_string_count_2 = (String(format: "%.2f", remainingbalance) + " Prin.  + " + String(format: "%.2f", remaining_interest + outstandingbalance) + " Int. =").count //used for right inset
        }
        else if (j == 4) {
            pay_insight_shape_label.text = String(format: "%.2f", principal_pay1) + " Prin.  + " + String(format: "%.2f", interest_pay1) + " Int. =\n" +
                String(format: "%.2f", principal_pay2) + " Prin.  + " + String(format: "%.2f", interest_pay2) + " Int. =\n" +
                String(format: "%.2f", principal_pay3) + " Prin.  + " + String(format: "%.2f", interest_pay3) + " Int. =\n" +
                String(format: "%.2f", principal_pay4) + " Prin.  + " + String(format: "%.2f", interest_pay4) + " Int. =\n" +
                String(format: "%.2f", remainingbalance) + " Prin.  + " + String(format: "%.2f", remaining_interest + outstandingbalance) + " Int. ="

            /*if (progress == 100) {
                pay_insight_shape_label.text = String(format: "%.2f", ceil(Double(Int(p*i*100)))/100) + " Prin.  + " + String(format: "%.2f", a - ceil(Double(Int(p*i*100)))/100) + " Int. =\n" +
                    String(format: "%.2f", ceil(Double(Int(temp1*i*100)))/100) + " Prin.  + " + String(format: "%.2f", a - ceil(Double(Int(temp1*i*100)))/100) + " Int. =\n" +
                    String(format: "%.2f", ceil(Double(Int(temp2*i*100)))/100) + " Prin.  + " + String(format: "%.2f", a - ceil(Double(Int(temp2*i*100)))/100) + " Int. =\n" +
                    String(format: "%.2f", ceil(Double(Int(temp3*i*100)))/100) + " Prin.  + " + String(format: "%.2f", a - ceil(Double(Int(temp3*i*100)))/100) + " Int. =\n" +
                    String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = "
            }
            else {
                if (a > ceil(Double(Int(p*i*100)+1))/100) {
                    pay_insight_shape_label.text = String(format: "%.2f", interest_temp3) + " Prin.  + " + String(format: "%.2f", a - interest_temp3) + " Int. =\n" +
                        String(format: "%.2f", interest_temp4) + " Prin.  + " + String(format: "%.2f", a - interest_temp4) + " Int. =\n" +
                        String(format: "%.2f", interest_temp5) + " Prin.  + " + String(format: "%.2f", a - interest_temp5) + " Int. =\n" +
                        String(format: "%.2f", interest_temp6) + " Prin.  + " + String(format: "%.2f", a - interest_temp6) + " Int. =\n" +
                        String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = "
                }
                else {
                    pay_insight_shape_label.text = String(format: "%.2f", interest_temp3) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp3) + " Int. =\n" +
                        String(format: "%.2f", interest_temp4) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp4) + " Int. =\n" +
                        String(format: "%.2f", interest_temp5) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp5) + " Int. =\n" +
                        String(format: "%.2f", interest_temp6) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp6) + " Int. =\n" +
                        String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = "
                }
            }*/
            pay_insight_shape_label.textAlignment = .right
            pay_insight_max_string_count_1 = (String(format: "%.2f", principal_pay) + " Prin.  + " + String(format: "%.2f", interest_pay) + " Int. =").count //used for right inset
            pay_insight_max_string_count_2 = (String(format: "%.2f", remainingbalance) + " Prin.  + " + String(format: "%.2f", remaining_interest + outstandingbalance) + " Int. =").count //used for right inset
        }
        else if (j == 3) {
            pay_insight_shape_label.text = String(format: "%.2f", principal_pay1) + " Prin.  + " + String(format: "%.2f", interest_pay1) + " Int. =\n" +
                String(format: "%.2f", principal_pay2) + " Prin.  + " + String(format: "%.2f", interest_pay2) + " Int. =\n" +
                String(format: "%.2f", principal_pay3) + " Prin.  + " + String(format: "%.2f", interest_pay3) + " Int. =\n" +
                String(format: "%.2f", remainingbalance) + " Prin.  + " + String(format: "%.2f", remaining_interest + outstandingbalance) + " Int. ="

            /*if (progress == 100) {
                pay_insight_shape_label.text = String(format: "%.2f", ceil(Double(Int(p*i*100)))/100) + " Prin.  + " + String(format: "%.2f", a - ceil(Double(Int(p*i*100)))/100) + " Int. =\n" +
                    String(format: "%.2f", ceil(Double(Int(temp1*i*100)))/100) + " Prin.  + " + String(format: "%.2f", a - ceil(Double(Int(temp1*i*100)))/100) + " Int. =\n" +
                    String(format: "%.2f", ceil(Double(Int(temp2*i*100)))/100) + " Prin.  + " + String(format: "%.2f", a - ceil(Double(Int(temp2*i*100)))/100) + " Int. =\n" +
                    String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = "
            }
            else {
                if (a > ceil(Double(Int(p*i*100)+1))/100) {
                    pay_insight_shape_label.text = String(format: "%.2f", interest_temp3) + " Prin.  + " + String(format: "%.2f", a - interest_temp3) + " Int. =\n" +
                        String(format: "%.2f", interest_temp4) + " Prin.  + " + String(format: "%.2f", a - interest_temp4) + " Int. =\n" +
                        String(format: "%.2f", interest_temp5) + " Prin.  + " + String(format: "%.2f", a - interest_temp5) + " Int. =\n" +
                        String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = "
                }
                else {
                    pay_insight_shape_label.text = String(format: "%.2f", interest_temp3) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp3) + " Int. =\n" +
                        String(format: "%.2f", interest_temp4) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp4) + " Int. =\n" +
                        String(format: "%.2f", interest_temp5) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp5) + " Int. =\n" +
                        String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = "
                }
            }*/
            pay_insight_shape_label.textAlignment = .right
            pay_insight_max_string_count_1 = (String(format: "%.2f", principal_pay) + " Prin.  + " + String(format: "%.2f", interest_pay) + " Int. =").count //used for right inset
            pay_insight_max_string_count_2 = (String(format: "%.2f", remainingbalance) + " Prin.  + " + String(format: "%.2f", remaining_interest + outstandingbalance) + " Int. =").count //used for right inset
        }
            
        else if (j == 2) {
            pay_insight_shape_label.text = String(format: "%.2f", principal_pay1) + " Prin.  + " + String(format: "%.2f", interest_pay1) + " Int. =\n" +
                String(format: "%.2f", principal_pay2) + " Prin.  + " + String(format: "%.2f", interest_pay2) + " Int. =\n" +
                String(format: "%.2f", remainingbalance) + " Prin.  + " + String(format: "%.2f", remaining_interest + outstandingbalance) + " Int. ="

            /*if (progress == 100) {
                pay_insight_shape_label.text = String(format: "%.2f", ceil(Double(Int(p*i*100)))/100) + " Prin.  + " + String(format: "%.2f", a - ceil(Double(Int(p*i*100)))/100) + " Int. =\n" +
                    String(format: "%.2f", ceil(Double(Int(temp1*i*100)))/100) + " Prin.  + " + String(format: "%.2f", a - ceil(Double(Int(temp1*i*100)))/100) + " Int. =\n" +
                    String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = "
            }
            else {
                if (a > ceil(Double(Int(p*i*100)+1))/100) {
                    pay_insight_shape_label.text = String(format: "%.2f", interest_temp3) + " Prin.  + " + String(format: "%.2f", a - interest_temp3) + " Int. =\n" +
                        String(format: "%.2f", interest_temp4) + " Prin.  + " + String(format: "%.2f", a - interest_temp4) + " Int. =\n" +
                        String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = "
                }
                else {
                    pay_insight_shape_label.text = String(format: "%.2f", interest_temp3) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp3) + " Int. =\n" +
                        String(format: "%.2f", interest_temp4) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp4) + " Int. =\n" +
                        String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = "
                }
            }*/
            pay_insight_shape_label.textAlignment = .right
            pay_insight_max_string_count_1 = (String(format: "%.2f", principal_pay) + " Prin.  + " + String(format: "%.2f", interest_pay) + " Int. =").count //used for right inset
            pay_insight_max_string_count_2 = (String(format: "%.2f", remainingbalance) + " Prin.  + " + String(format: "%.2f", remaining_interest + outstandingbalance) + " Int. =").count //used for right inset
        }
        else if (j == 1) {
            pay_insight_shape_label.text = String(format: "%.2f", principal_pay1) + " Prin.  + " + String(format: "%.2f", interest_pay1) + " Int. =\n" +
                String(format: "%.2f", remainingbalance) + " Prin.  + " + String(format: "%.2f", remaining_interest + outstandingbalance) + " Int. ="

            /*if (progress == 100) {
                pay_insight_shape_label.text = String(format: "%.2f", ceil(Double(Int(p*i*100)))/100) + " Prin.  + " + String(format: "%.2f", a - ceil(Double(Int(p*i*100)))/100) + " Int. =\n" +
                    String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = "
            }
            else {
                if (a > ceil(Double(Int(p*i*100)+1))/100) {
                    pay_insight_shape_label.text = String(format: "%.2f", interest_temp3) + " Prin.  + " + String(format: "%.2f", a - interest_temp3) + " Int. =\n" +
                        String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = "
                }
                else {
                    pay_insight_shape_label.text = String(format: "%.2f", interest_temp3) + " Prin.  + " + String(format: "%.2f", a - 0.01 - interest_temp3) + " Int. =\n" +
                        String(format: "%.2f", ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) + " Prin.  + " + String(format: "%.2f", remainingbalance) + " Int.  = "
                }
            }*/
            pay_insight_shape_label.textAlignment = .right
            pay_insight_max_string_count_1 = (String(format: "%.2f", principal_pay) + " Prin.  + " + String(format: "%.2f", interest_pay) + " Int. =").count //used for right inset
            pay_insight_max_string_count_2 = (String(format: "%.2f", remainingbalance) + " Prin.  + " + String(format: "%.2f", remaining_interest + outstandingbalance) + " Int. =").count //used for right inset
        }
        else {
            pay_insight_shape_label.text = String(format: "%.2f", remainingbalance) + " Prin.  + " + String(format: "%.2f", remaining_interest + outstandingbalance) + " Int. ="
            pay_insight_shape_label.textAlignment = .right
            pay_insight_max_string_count_1 = 0 //used for right inset
            pay_insight_max_string_count_2 = (String(format: "%.2f", remainingbalance) + " Prin.  + " + String(format: "%.2f", remaining_interest + outstandingbalance) + " Int. =").count //used for right inset
        }
        
        //if (insight == 1) && (compound.isOn == false) {
        if (insight == 1) {
            outstanding.text = "Last Month Charged Interest: " + String(format: "%.2f", remaining_interest) + "\n" +
                "Outstanding Interest: " + String(format: "%.2f", outstandingbalance)
        }
        /*else if (insight == 1) {
            outstanding.text = "Unpaid interest becomes outstanding and must be paid later."
        }*/
        else {
            if (decision == false) {
                note_overlap.text = ""
            }
            else {
                note_overlap.text = ""
                //note_overlap.text = "Rounded interest ↓\nRounded balance ↑"
            }
        }
        //outstanding.backgroundColor = UIColor.blue
        let pay_insight_max_string_count = max(pay_insight_max_string_count_1,pay_insight_max_string_count_2)
        //print(pay_insight_max_string_count)
        /*outstanding.contentInset = UIEdgeInsetsMake(0,0,0,0)
        outstanding.textContainer.lineFragmentPadding = 0
        note.contentInset = UIEdgeInsetsMake(0,0,0,0)
        note.textContainer.lineFragmentPadding = 0*/
        //outstanding.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //outstanding.isLayoutMarginsRelativeArrangement = true
        //payment_shape_label.textAlignment = .center
        //payment_shape_label.numberOfLines = 0
        //payment_shape_label.textColor = UIColor.white
        //payment_shape_label.font = UIFont(name: "CMUSerif-Roman", size: 16.0)
        //payment_shape_label.adjustsFontSizeToFitWidth = true
        //balance_shape_label.frame = CGRect(x: 0, y: 0, width: balance.frame.width, height: balance.frame.height)
        let textRect_balance_shape_label = CGRect(x: 0, y: 0, width: balance.frame.width, height: balance.frame.height)
        //let insets_balance_shape_label = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2)
        let insets_balance_shape_label = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        balance_shape_label.frame = UIEdgeInsetsInsetRect(textRect_balance_shape_label, insets_balance_shape_label)
        balance_shape_label.bounds = balance.frame
        add_label.frame = CGRect(x: 0, y: 0, width: add.frame.width, height: add.frame.height)
        add_label.bounds = add.frame
        
        let character_length = charged_interest.frame.width/23 //reference, counted them myself, approximate
        let textRect_charged_interest = CGRect(x: 0, y: 0, width: charged_interest.frame.width, height: charged_interest.frame.height)
        let insets_charged_interest = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (charged_interest.frame.width - CGFloat(charged_interest_max_string_count)*character_length)/2)
        //let insets_charged_interest = UIEdgeInsets(top: 0, left: 0.02*charged_interest.frame.width, bottom: 0, right: 2*0.02*charged_interest.frame.width)
        charged_interest_shape_label.frame = UIEdgeInsetsInsetRect(textRect_charged_interest, insets_charged_interest)
        charged_interest_shape_label.bounds = charged_interest.frame
        //charged_interest_shape_label.backgroundColor = UIColor.red
        
        subtract_label.frame = CGRect(x: 0, y: 0, width: subtract.frame.width, height: subtract.frame.height)
        subtract_label.bounds = subtract.frame
        payment_shape_label.frame = CGRect(x: 0, y: 0, width: payment.frame.width, height: payment.frame.height)
        payment_shape_label.bounds = payment.frame
        //payment_shape.path = UIBezierPath(roundedRect: payment.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        equals_label.frame = CGRect(x: 0, y: 0, width: equals.frame.width, height: equals.frame.height)
        equals_label.bounds = equals.frame
        //remaining_label.frame = CGRect(x: remaining.frame.origin.x, y: 0, width: remaining.frame.width, height: remaining.frame.height)
        //remaining_label.frame = CGRect(x: 0, y: 0, width: remaining.frame.width, height: remaining.frame.height)
        //remaining_label.center.x = remaining.center.x
        let textRect_remaining_label = CGRect(x: 0, y: 0, width: remaining.frame.width, height: remaining.frame.height)
        //let insets_remaining_label = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        let insets_remaining_label = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        remaining_label.frame = UIEdgeInsetsInsetRect(textRect_remaining_label, insets_remaining_label)
        //remaining_label.frame = CGRect(x: 0, y: 0, width: remaining.frame.width, height: remaining.frame.height)
        remaining_label.bounds = remaining.frame
        //remaining_label.backgroundColor = UIColor.green
        //remaining.backgroundColor = UIColor.red
        //print("remaining_label:",remaining_label.frame.width)
        //print("remaining:",remaining.frame.width)
        //print("remaining.frame.origin.x",remaining.frame.origin.x)
        /*let pay_insight_shape_left = CAShapeLayer()
         pay_insight_shape_left.bounds = charged_interest.frame
         pay_insight_shape_left.position = charged_interest.center
         pay_insight_shape_left.path = UIBezierPath(roundedRect: charged_interest.bounds, byRoundingCorners: [.bottomLeft], cornerRadii: CGSize(width: 5, height: 5)).cgPath
         pay_insight_shape_left.fillColor = UIColor.init(red:216/255.0, green:218/255.0, blue:218/255.0, alpha: 1.0).cgColor
         pay_insight.layer.addSublayer(pay_insight_shape_left)
         let pay_insight_shape_middle = CAShapeLayer()
         pay_insight_shape_middle.bounds = subtract.frame
         pay_insight_shape_middle.position = subtract.center
         pay_insight_shape_middle.path = UIBezierPath(roundedRect: subtract.bounds, byRoundingCorners: [], cornerRadii: CGSize(width: 5, height: 5)).cgPath
         pay_insight_shape_middle.fillColor = UIColor.init(red:216/255.0, green:218/255.0, blue:218/255.0, alpha: 1.0).cgColor
         pay_insight.layer.addSublayer(pay_insight_shape_middle)*/
        pay_insight_shape.bounds = pay_insight.frame
        pay_insight_shape.position = pay_insight.center
        //pay_insight_shape.path = UIBezierPath(roundedRect: pay_insight.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        pay_insight_shape.path = UIBezierPath(roundedRect: pay_insight.bounds, byRoundingCorners: [.bottomLeft], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        
        pay_insight_header_shape.bounds = pay_insight_header.frame
        pay_insight_header_shape.position = pay_insight_header.center
        //pay_insight_header_shape.path = UIBezierPath(roundedRect: pay_insight_header.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        pay_insight_header_shape.path = UIBezierPath(roundedRect: pay_insight_header.bounds, byRoundingCorners: [.topLeft], cornerRadii: CGSize(width: 5, height: 5)).cgPath

        //pay_insight_shape.fillColor = UIColor(red:216/255.0, green:218/255.0, blue:218/255.0, alpha: 0.9).cgColor <-- coloring earlier
        //pay_insight_shape.borderColor = UIColor.black.cgColor
        pay_insight_shape.borderColor = UIColor(red:207/255.0, green:209/255.0, blue:210/255.0, alpha: 0.95).cgColor
        pay_insight_shape.borderWidth = 0
        
        /*pay_insight_shape.shadowColor = UIColor.black.cgColor
         pay_insight_shape.shadowOffset = CGSize(width: 0, height: 1)
         pay_insight_shape.shadowOpacity = 0.25
         pay_insight_shape.shadowRadius = 2*/
        
        //let character_length = charged_interest.frame.width/23 //reference, counted them myself, approximate
        let textRect_pay_insight = CGRect(x: 0, y: 0, width: pay_insight.frame.width, height: pay_insight.frame.height)
        let insets_pay_insight = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: ((balance.frame.width+add.frame.width+charged_interest.frame.width+subtract.frame.width) - CGFloat(pay_insight_max_string_count)*character_length)/2)
        //let insets_pay_insight = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //let insets_pay_insight = UIEdgeInsets(top: 0, left: 0.02*pay_insight.frame.width, bottom: 0, right: 2*2*0.02*pay_insight.frame.width)
        pay_insight_shape_label.frame = UIEdgeInsetsInsetRect(textRect_pay_insight, insets_pay_insight)
        pay_insight_shape_label.bounds = pay_insight.frame
        //pay_insight_shape_label.text = "Pay"
        //pay_insight_shape_label.textAlignment = .center
        pay_insight_shape_label.numberOfLines = 0
        //pay_insight_shape_label.textColor = UIColor.white
        pay_insight_shape_label.font = UIFont(name: "CMUSerif-Roman", size: 16.0)

        /*let textRect_note = CGRect(x: 0, y: 0, width: outstanding.frame.width, height: outstanding.frame.height)
        let insets_note = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        outstanding.frame = UIEdgeInsetsInsetRect(textRect_note, insets_note)
        /*if (j >= 4) {*/
         month1.text = String(format: "%.2f", p) +
         " + (" + String(format: "%.2f", p) +
         " · " + String(format: "%.5f", i) +
         "...) – " + String(format: "%.2f", a) +
         " ≈ " + String(format: "%.2f", p + ceil(Double(Int(p*i*100)))/100 - a)
         
         let temp1 = p + ceil(Double(Int(p*i*100)))/100 - a
         month2.text = String(format: "%.2f", temp1) +
         " + (" + String(format: "%.2f", temp1) +
         " · " + String(format: "%.5f", i) +
         "...) – " + String(format: "%.2f", a) +
         " ≈ " + String(format: "%.2f", temp1 + ceil(Double(Int(temp1*i*100)))/100 - a)
         
         let temp2 = temp1 + ceil(Double(Int(temp1*i*100)))/100 - a
         month3.text = String(format: "%.2f", temp2) +
         " + (" + String(format: "%.2f", temp2) +
         " · " + String(format: "%.5f", i) +
         "...) – " + String(format: "%.2f", a) +
         " ≈ " + String(format: "%.2f", temp2 + ceil(Double(Int(temp2*i*100)))/100 - a)
         let temp3 = temp2 + ceil(Double(Int(temp2*i*100)))/100 - a
         month4.text = String(format: "%.2f", temp3) +
         " + (" + String(format: "%.2f", temp3) +
         " · " + String(format: "%.5f", i) +
         "...) – " + String(format: "%.2f", a) +
         " ≈ " + String(format: "%.2f", temp3 + ceil(Double(Int(temp3*i*100)))/100 - a)
         
         if (j == 4) {
         keep_going_until.isHidden = true
         }
         refund.isHidden = true
         coffee_cup.isHidden = true
         }
         else if (j == 3) {
         month1.text = String(format: "%.2f", p) +
         " + (" + String(format: "%.2f", p) +
         " · " + String(format: "%.5f", i) +
         "...) – " + String(format: "%.2f", a) +
         " ≈ " + String(format: "%.2f", p + ceil(Double(Int(p*i*100)))/100 - a)
         
         let temp1 = p + ceil(Double(Int(p*i*100)))/100 - a
         month2.text = String(format: "%.2f", temp1) +
         " + (" + String(format: "%.2f", temp1) +
         " · " + String(format: "%.5f", i) +
         "...) – " + String(format: "%.2f", a) +
         " ≈ " + String(format: "%.2f", temp1 + ceil(Double(Int(temp1*i*100)))/100 - a)
         let temp2 = temp1 + ceil(Double(Int(temp1*i*100)))/100 - a
         month3.text = String(format: "%.2f", temp2) +
         " + (" + String(format: "%.2f", temp2) +
         " · " + String(format: "%.5f", i) +
         "...) – " + String(format: "%.2f", a) +
         " ≈ " + String(format: "%.2f", temp2 + ceil(Double(Int(temp2*i*100)))/100 - a)
         
         month4.isHidden = true
         keep_going_until.isHidden = true
         refund.isHidden = true
         coffee_cup.isHidden = true
         
         }
         else if (j == 2) {
         month1.text = String(format: "%.2f", p) +
         " + (" + String(format: "%.2f", p) +
         " · " + String(format: "%.5f", i) +
         "...) – " + String(format: "%.2f", a) +
         " ≈ " + String(format: "%.2f", p + ceil(Double(Int(p*i*100)))/100 - a)
         let temp1 = p + ceil(Double(Int(p*i*100)))/100 - a
         month2.text = String(format: "%.2f", temp1) +
         " + (" + String(format: "%.2f", temp1) +
         " · " + String(format: "%.5f", i) +
         "...) – " + String(format: "%.2f", a) +
         " ≈ " + String(format: "%.2f", temp1 + ceil(Double(Int(temp1*i*100)))/100 - a)
         
         month3.isHidden = true
         month4.isHidden = true
         keep_going_until.isHidden = true
         refund.isHidden = true
         coffee_cup.isHidden = true
         
         }
         else if (j == 1) {
         month1.text = String(format: "%.2f", p) +
         " + (" + String(format: "%.2f", p) +
         " · " + String(format: "%.5f", i) +
         "...) – " + String(format: "%.2f", a) +
         " ≈ " + String(format: "%.2f", p + ceil(Double(Int(p*i*100)))/100 - a)
         month2.isHidden = true
         month3.isHidden = true
         month4.isHidden = true
         keep_going_until.isHidden = true
         refund.isHidden = true
         coffee_cup.isHidden = true
         
         }
         else {
         month1.isHidden = true
         month2.isHidden = true
         month3.isHidden = true
         month4.isHidden = true
         keep_going_until.isHidden = true
         }
         
         
         monthmax.text = String(format: "%.2f", remainingbalance) +
         " + (" + String(format: "%.2f", remainingbalance) +
         " · " + String(format: "%.5f", i) +
         "...) – " + String(format: "%.2f", remainingbalance + ceil(Double(Int(remainingbalance*i*100)))/100) +
         " ≈ 0.00"*/
        
        if (j == 0) && (a - (remainingbalance + remaining_interest + outstandingbalance) != 0) {
            
            //refund.text =  + String(format: "%.2f", )
            
            var pt1 = Double()
            //var pt1 = a - (remainingbalance + remaining_interest + outstandingbalance)
            //print(a,"-(",remainingbalance,"+",remaining_interest,"+",outstandingbalance,")")
            /*if (pt1*100 - floor(pt1*100) > 0.499999) && (pt1*100 - floor(pt1*100) < 0.5) //just in case, and to be consistant
            { pt1 = round(pt1*100 + 1)/100 }
            else { pt1 = round(pt1*100)/100 }
            //print(pt1)
            //pt1 = round((a - (remainingbalance + remaining_interest))*100)/100

            //let pt1 = a - (remainingbalance + ceil(Double(Int(remainingbalance*i*100)))/100)
            let pt2 = pt1 - floor(pt1)
            //print(pt2)
            let pt3 = pt2*100
            //print(pt3)
            var pt4 = Int()
            if (pt3 - floor(pt3) > 0.99999)
            { pt4 = Int(pt3 + 1) }
            else { pt4 = Int(pt3) }*/
            //print(pt4)
            //let pt4 = Int(round(pt3)) //figure out how to round to nearest hundredth
            
            var refund_string = NSMutableAttributedString()
            if (a - (remainingbalance + remaining_interest + outstandingbalance) > 0) {
                refund_string = NSMutableAttributedString(string: "Refunded $", attributes: [ :])
                pt1 = a - (remainingbalance + remaining_interest + outstandingbalance)
            }
            else {
                    refund_string = NSMutableAttributedString(string: "Pay Extra $", attributes: [ :])
                    pt1 = abs(a - (remainingbalance + remaining_interest + outstandingbalance))
                if (decision == true) {
                    refund.isHidden = true
                }
                else {
                    refund.isHidden = false
                }
            }
            
            
            if (pt1*100 - floor(pt1*100) > 0.499999) && (pt1*100 - floor(pt1*100) < 0.5) //just in case, and to be consistant
            { pt1 = round(pt1*100 + 1)/100 }
            else { pt1 = round(pt1*100)/100 }
            //print(pt1)
            //pt1 = round((a - (remainingbalance + remaining_interest))*100)/100
            
            //let pt1 = a - (remainingbalance + ceil(Double(Int(remainingbalance*i*100)))/100)
            let pt2 = pt1 - floor(pt1)
            //print(pt2)
            let pt3 = pt2*100
            //print(pt3)
            var pt4 = Int()
            if (pt3 - floor(pt3) > 0.99999)
            { pt4 = Int(pt3 + 1) }
            else { pt4 = Int(pt3) }


            let refund_amount = NSMutableAttributedString(string: numberFormatter.string(from: NSNumber(value: floor(pt1)))!)
            var refund_amount_decimal_part = NSMutableAttributedString()
            if (pt3 < 100) && (pt3 >= 10) {
                refund_amount_decimal_part = NSMutableAttributedString(string:
                    "." + String(pt4), attributes: [ :])
            }
            else if (pt3 < 10) && (pt3 >= 1) {
                refund_amount_decimal_part = NSMutableAttributedString(string:
                    ".0" + String(pt4), attributes: [ :])
            }
            else {
                refund_amount_decimal_part = NSMutableAttributedString(string:
                    "", attributes: [ :])
            }
            //if (decision == false) {
            refund_string.append(refund_amount)
            refund_string.append(refund_amount_decimal_part)
            refund.attributedText = refund_string
            //}
            //print(floor(pt1))
            if (floor(pt1) >= 5) && (a - (remainingbalance + remaining_interest + outstandingbalance) > 0) { //arbitrary
                coffee_cup.text = "☕︎"
            }
            else {
                coffee_cup.text = ""
            }
            
            /*var months_label = NSMutableAttributedString()
             if (j+1 == 1) {
             months_label = NSMutableAttributedString(string: " month", attributes: [ :])
             }
             else {
             months_label = NSMutableAttributedString(string: " months", attributes: [ :])
             }
             let years_amount = NSMutableAttributedString(string: " ÷ 12 = " + numberFormatter.string(from: NSNumber(value: temp4))!, attributes: [ :])
             var years_amount_decimal_part = NSMutableAttributedString()
             if (t3 < 1000) && (t3 >= 100) {
             years_amount_decimal_part = NSMutableAttributedString(string:
             "." + String(t4), attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
             }
             else if (t3 < 100) && (t3 >= 10) {
             years_amount_decimal_part = NSMutableAttributedString(string:
             ".0" + String(t4), attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
             }
             else if (t3 < 10) && (t3 >= 1) {
             years_amount_decimal_part = NSMutableAttributedString(string:
             ".00" + String(t4), attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
             }
             else if (t3 < 1) && (t3 > 0) {
             years_amount_decimal_part = NSMutableAttributedString(string:
             ".000" + String(t4), attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
             }
             else {
             years_amount_decimal_part = NSMutableAttributedString(string: "", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
             }*/
        }
        else {
            refund.text = ""
            coffee_cup.text = ""
        }

        
        //xcode will be unable to satisfy constraints for any text hidden, especially the refund, but won't ruin functionality
        //fix this later
        //UserDefaults.standard.setValue(false, forKey:"_UIConstraintBasedLayoutLogUnsatisfiable")
        UserDefaults.standard.setValue(true, forKey:"_UIConstraintBasedLayoutLogUnsatisfiable")
        
        var temp5 = Int()
        if (Double((j + 1) / 12) - floor(Double((j + 1) / 12)) > 0.99999) //seems like too much
        { temp5 = Int(floor(Double((j + 1) / 12) + 1)) }
        else { temp5 = Int(floor(Double((j + 1) / 12))) }

        //if (floor(Double((j + 1) / 12)) - floor(floor(Double((j + 1) / 12))) > 0.99999)
        //{ temp5 = Int(floor(Double((j + 1) / 12)) + 1) }
        //else { temp5 = Int(floor(Double((j + 1) / 12))) }
        //print("showmath",j)

        
        let t1 = (Double(j) + 1) / 12//; print(t1)
        let t2 = t1 - floor(t1)//; print(t2)
        let t3 = t2*1000//; print(t3)
        var t4 = Int()
        if (t3 - floor(t3) > 0.99999)
        { t4 = Int(t3 + 1) }
        else { t4 = Int(t3) }
        
        let years_string = NSMutableAttributedString(string: numberFormatter.string(from: NSNumber(value: j + 1))!)
        var months_label = NSMutableAttributedString()
        if (decision == false) {
            if (j+1 == 1) {
                months_label = NSMutableAttributedString(string: " month", attributes: [ :])
            }
            else {
                months_label = NSMutableAttributedString(string: " total months", attributes: [ :])
            }
        }
        else {
            months_label = NSMutableAttributedString(string: " total month(s)", attributes: [ :])
        }
        
        let years_amount = NSMutableAttributedString(string: " ÷ 12 = " + numberFormatter.string(from: NSNumber(value: temp5))!, attributes: [ :])
        var years_amount_decimal_part = NSMutableAttributedString()
        if (t3 < 1000) && (t3 >= 100) {
            years_amount_decimal_part = NSMutableAttributedString(string:
                "." + String(t4), attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
        }
        else if (t3 < 100) && (t3 >= 10) {
            years_amount_decimal_part = NSMutableAttributedString(string:
                ".0" + String(t4), attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
        }
        else if (t3 < 10) && (t3 >= 1) {
            years_amount_decimal_part = NSMutableAttributedString(string:
                ".00" + String(t4), attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
        }
        else {
            years_amount_decimal_part = NSMutableAttributedString(string:
                "", attributes: [ NSAttributedStringKey.foregroundColor: UIColor.lightGray ])
        }
        // ((Double(j) + 1) / 12)-floor((Double(j) + 1) / 12)
        //Double(Int(floor(Double((j + 1) / 12)))))
        /*if (j+1 == 1) && (temp3 == 1) {
         years.text = String(j + 1) +
         " month ÷ 12 = " + String(temp3) +
         " year"
         }*/
        var years_amount_label = NSMutableAttributedString()
        if (decision == false) {
            if (temp5 == 1) {
                years_amount_label = NSMutableAttributedString(string: " year", attributes: [ :])
            }
            else {
                years_amount_label = NSMutableAttributedString(string: " years", attributes: [ :])
            }
        }
        else {
            years_amount_label = NSMutableAttributedString(string: " year(s)", attributes: [ :])
        }
        years_string.append(months_label)
        years_string.append(years_amount)
        if (decision == false) {
            years_string.append(years_amount_decimal_part)
        }
        else {
            //don't append decimal part
        }
        years_string.append(years_amount_label)
        /*years.text = String(j + 1) +
         " total month(s) ÷ 12 = " + String(temp3) +
         " year(s)"*/
        
        if (decision == false) {
            months.text = numberFormatter.string(from: NSNumber(value: j + 1))! +
                " – (12 · " + numberFormatter.string(from: NSNumber(value: temp5))! +
            ") = "
        }
        else {
            months.text = numberFormatter.string(from: NSNumber(value: j + 1))! +
                " – (" + numberFormatter.string(from: NSNumber(value: temp5))! +
            " · 12) = "
        }
        if (decision == false) {
            if ((j + 1) - temp5 * 12 == 1) {
                months.text! += String((j + 1) - temp5 * 12) +
                " month";
            }
            else {
                months.text! += String((j + 1) - temp5 * 12) +
                " months";
            }
        }
        else {
            months.text! += String((j + 1) - temp5 * 12) +
            " month(s)";
        }
        //overrided by:
        if (decision == false) {
            if (temp5 == 0) {
                years.text = "0 years"
                if (j + 1 == 1) {
                    months.text = String(j + 1) + " month";
                }
                else {
                    months.text = String(j + 1) + " months";
                }
            }
            else {
                if ((j + 1) - temp5 * 12 == 0 ) {
                    years.attributedText = years_string
                    months.text = "0 months"
                }
                else {
                    years.attributedText = years_string
                    months.text = months.text!
                }
            }
        }
        else {
            years.attributedText = years_string
            months.text = months.text!
        }
        years.adjustsFontSizeToFitWidth = true
        months.adjustsFontSizeToFitWidth = true

        
        
        /*if (temp == 1) {years_text.text = "year"}
         else {years_text.text = "years"}
         months.text = String((j + 1) - temp * 12)
         if ((j + 1) - temp * 12 == 1) {months_text.text = "month"}
         else {months_text.text = "months"}*/
        
        
        var ppt1 = Double()
        
        var tempxxx = Double()
        if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
        { tempxxx = (round(p*i*100 + 1)+1)/100}
        else { tempxxx = (round(p*i*100)+1)/100 }
        
        if (a == tempxxx) {
            if (progress == 100) {
                ppt1 = Double(j) * a + remainingbalance + remaining_interest + outstandingbalance //total
            }
            else {
                ppt1 = Double(j) * (a) + remainingbalance + remaining_interest + outstandingbalance //total
            } //won't need 0.01, if interest not compounded
        }
        else {
            ppt1 = Double(j) * a + remainingbalance + remaining_interest + outstandingbalance //total
        }
        if (ppt1*100 - floor(ppt1*100) > 0.499999) && (ppt1*100 - floor(ppt1*100) < 0.5)
        { ppt1 = round(ppt1*100 + 1)/100 }
        else { ppt1 = round(ppt1*100)/100 }
        
        //ppt1 = round(ppt1*100)/100

        /*if (progress == 100) || (a > ceil(Double(Int(p*i*100)+1))/100) {
            ppt1 = Double(j) * a + remainingbalance + ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance //total
        }
        else {
            ppt1 = Double(j) * (a-0.01) + remainingbalance + ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance //total
        }*/
        let ppt2 = ppt1 - floor(ppt1)
        let ppt3 = ppt2*100
        var ppt4 = Int()
        if (ppt3 - floor(ppt3) > 0.99999)
        { ppt4 = Int(ppt3 + 1) }
        else { ppt4 = Int(ppt3) }

        //let ppt4 = Int(round(ppt3))
        
        /*var ppt4 = Int()
        if (ppt1 - floor(ppt1) > 0.99999) {
            ppt4 = Int(round(ppt3))+1
        }
        else {
            ppt4 = Int(round(ppt3))
        }
        print("ppt3",ppt3)
        print("round(ppt3)",round(ppt3))
        print("ppt4",ppt4) */
        let total_paid_string = NSMutableAttributedString()
        var total_paid_expression = NSMutableAttributedString()
        
        if (a == tempxxx) {
            if (progress == 100) {
                total_paid_expression = NSMutableAttributedString(string: "(" + numberFormatter.string(from: NSNumber(value: j))! +
                    " · " + String(format: "%.2f", a) +
                    ") + " + String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance) +
                    " = ", attributes: [ :])
            }
            else {
                total_paid_expression = NSMutableAttributedString(string: "(" + numberFormatter.string(from: NSNumber(value: j))! +
                    " · " + String(format: "%.2f", a) +
                    ") + " + String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance) +
                    " = ", attributes: [ :])
            } //won't need 0.01, if interest not compounded
        }
        else {
            total_paid_expression = NSMutableAttributedString(string: "(" + numberFormatter.string(from: NSNumber(value: j))! +
                " · " + String(format: "%.2f", a) +
                ") + " + String(format: "%.2f", remainingbalance + remaining_interest + outstandingbalance) +
                " = ", attributes: [ :])
        }

        
        
        
        /*if (progress == 100) || (a > ceil(Double(Int(p*i*100)+1))/100) {
            total_paid_expression = NSMutableAttributedString(string: "(" + numberFormatter.string(from: NSNumber(value: j))! +
                " · " + String(format: "%.2f", a) +
                ") + " + String(format: "%.2f", remainingbalance + ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) +
                " = ", attributes: [ :])
        }
        else {
            total_paid_expression = NSMutableAttributedString(string: "(" + numberFormatter.string(from: NSNumber(value: j))! +
                " · " + String(format: "%.2f", a-0.01) +
                ") + " + String(format: "%.2f", remainingbalance + ceil(Double(Int(remainingbalance*i*100)))/100 + outstandingbalance) +
                " = ", attributes: [ :])
        }*/
        let total_paid_amount = NSMutableAttributedString(string: numberFormatter.string(from: NSNumber(value: floor(ppt1)))!)
        var total_paid_amount_decimal_part = NSMutableAttributedString()
        if (ppt3 < 100) && (ppt3 >= 10) {
            total_paid_amount_decimal_part = NSMutableAttributedString(string:
                "." + String(ppt4), attributes: [ :])
        }
        else if (ppt3 < 10) && (ppt3 >= 1) {
            total_paid_amount_decimal_part = NSMutableAttributedString(string:
                ".0" + String(ppt4), attributes: [ :])
        }
        else {
            total_paid_amount_decimal_part = NSMutableAttributedString(string:
                "", attributes: [ :])
        }
        var total_paid_amount_decimal_part_label = NSMutableAttributedString()
        if (decision == false) {
            total_paid_amount_decimal_part_label = NSMutableAttributedString(string: " paid")
        }
        else {
            total_paid_amount_decimal_part_label = NSMutableAttributedString(string: " total paid")
        }
        
        if (j == 0) {
            //don't append total_paid_amount
        }
        else {
            total_paid_string.append(total_paid_expression)
        }
        total_paid_string.append(NSMutableAttributedString(string: "$"))
        if (decision == false) {
            total_paid_string.append(total_paid_amount)
            total_paid_string.append(total_paid_amount_decimal_part)
        }
        else {
            total_paid_string.append(NSMutableAttributedString(string: String(format: "%.2f", ppt1), attributes: [:]))
        }
        total_paid_string.append(total_paid_amount_decimal_part_label)
        total_paid.attributedText = total_paid_string
        
        //total_paid.attributedText = total_paid_string
        
        /*total_paid.text = "(" + numberFormatter.string(from: NSNumber(value: j))! +
         " · " + String(format: "%.2f", a) +
         ") + " + String(format: "%.2f", remainingbalance + ceil(Double(Int(remainingbalance*i*100)))/100) +
         " = $" + ??? +
         " paid"*/
        
        var k = 0 //defined here in order to simplify the rest too
        var remainingbalance_repay_minimum = p //defined here in order to simplify the rest
        
        var outstandingbalance_min = 0.00
        
        
        var temp_interest_min = Double()
        if (remainingbalance_repay_minimum*i*100 - floor(remainingbalance_repay_minimum*i*100) > 0.499999) && (remainingbalance_repay_minimum*i*100 - floor(remainingbalance_repay_minimum*i*100) < 0.5)
        { temp_interest_min = round(remainingbalance_repay_minimum*i*100 + 1)/100}
        else { temp_interest_min = round(remainingbalance_repay_minimum*i*100)/100 }
        
        //let temp_interest1 = temp_interest
        
        var interest_pay_min = Double()
        //var xxx = percentage/100*temp_interest_min
        var xxx = percentage/100*remainingbalance_repay_minimum*i
        if (xxx*100 - floor(xxx*100) > 0.499999) && (xxx*100 - floor(xxx*100) < 0.5)
        { interest_pay_min = round(xxx*100 + 1)/100}
        else { interest_pay_min = round(xxx*100)/100 }

        var temp_pay = Double()
        var temp_pay_first = Double()

        if (tenyr_indicator == 0) {
            //if (c == 0) {
                if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
                { temp_pay = (round(p*i*100 + 1))/100 }//; temp_pay_first = (round(p*i*100 + 1) + 1)/100 }
                else { temp_pay = (round(p*i*100))/100 }//; temp_pay_first = (round(p*i*100) + 1)/100 }

                //let xx = percentage/100*temp_pay
                let xx = percentage/100*p*i
                if (xx*100 - floor(xx*100) > 0.499999) && (xx*100 - floor(xx*100) < 0.5)
                {
                    temp_pay = (round(xx*100 + 1)+1)/100 - interest_pay_min
                    temp_pay_first = (round(xx*100 + 1)+1)/100
                }
                else {
                    temp_pay = (round(xx*100) + 1)/100 - interest_pay_min
                    temp_pay_first = (round(xx*100) + 1)/100
                }
                
                //so annoying, okay...
                if (temp_pay*100 - floor(temp_pay*100) > 0.499999) && (temp_pay*100 - floor(temp_pay*100) < 0.5)
                { temp_pay = round(temp_pay*100 + 1)/100}
                else { temp_pay = round(temp_pay*100)/100 }
            //}
            /*else {
                if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
                { temp_pay = (round(p*i*100 + 1)+1)/100}
                else { temp_pay = (round(p*i*100)+1)/100 }
                temp_pay_first = temp_pay
            }*/
        }
        else {
            if (i != 0) {
                //if (c == 0) && (progress != 0) {
                if (progress != 0) {
                    temp_pay = ceil((percentage/100*i*p*pow(1+percentage/100*i,120)) / (pow(1+percentage/100*i,120) - 1)*100)/100
                    temp_pay_first = temp_pay
                    temp_pay = temp_pay - interest_pay_min



                    //let xx = percentage/100*temp_pay
                    //if (xx*100 - floor(xx*100) > 0.499999) && (xx*100 - floor(xx*100) < 0.5)
                    //{
                        //temp_pay = round(xx*100 + 1)/100 - interest_pay_min
                        //temp_pay_first = round(xx*100 + 1)/100
                    
                    //}
                    //else {
                        //temp_pay = round(xx*100)/100 - interest_pay_min
                        //temp_pay_first = round(xx*100)/100
                    //}
                    
                    //so annoying, okay...
                    if (temp_pay*100 - floor(temp_pay*100) > 0.499999) && (temp_pay*100 - floor(temp_pay*100) < 0.5)
                    { temp_pay = round(temp_pay*100 + 1)/100}
                    else { temp_pay = round(temp_pay*100)/100 }
                }
                //else if (c == 0) && (progress == 0)  {
                else {
                    temp_pay = ceil(p/120*100)/100
                    temp_pay_first = temp_pay
                }
                /*else {
                    temp_pay = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
                    temp_pay_first = temp_pay
                }*/
            }
            else {
                /*if (c == 0) {
                    temp_pay = ceil(p/120*100)/100

                    let xx = percentage/100*temp_pay
                    if (xx*100 - floor(xx*100) > 0.499999) && (xx*100 - floor(xx*100) < 0.5)
                    {
                        temp_pay = round(xx*100 + 1)/100 - interest_pay_min
                        temp_pay_first = round(xx*100 + 1)/100
                    }
                    else {
                        temp_pay = round(xx*100)/100 - interest_pay_min
                        temp_pay_first = round(xx*100)/100
                    }
                    
                    //so annoying, okay...
                    if (temp_pay*100 - floor(temp_pay*100) > 0.499999) && (temp_pay*100 - floor(temp_pay*100) < 0.5)
                    { temp_pay = round(temp_pay*100 + 1)/100}
                    else { temp_pay = round(temp_pay*100)/100 }
                }
                else {*/
                    temp_pay = ceil(p/120*100)/100
                    temp_pay_first = temp_pay
                //}
            }
        }
        
        //print(temp_pay)
        //print(ceil(Double(Int(p*i*100)+1))/100)

        
        //if (i != 0) {
            //for _ in 0...4 {
        while (remainingbalance_repay_minimum - temp_pay > 0) {
        //while (remainingbalance_repay_minimum + temp_interest_min > temp_pay) {
            //while (remainingbalance_repay_minimum + c*temp_interest_min > temp_pay) {
                //print(remainingbalance_repay_minimum,"=",remainingbalance_repay_minimum,"+",temp_interest_min,"- ",temp_pay)

                //remainingbalance_repay_minimum = remainingbalance_repay_minimum + c*temp_interest_min - temp_pay
                remainingbalance_repay_minimum = remainingbalance_repay_minimum - temp_pay
            
                if (remainingbalance_repay_minimum*100 - floor(remainingbalance_repay_minimum*100) > 0.499999) && (remainingbalance_repay_minimum*100 - floor(remainingbalance_repay_minimum*100) < 0.5)
                { remainingbalance_repay_minimum = round(remainingbalance_repay_minimum*100 + 1)/100}
                else { remainingbalance_repay_minimum = round(remainingbalance_repay_minimum*100)/100 }
                
                //outstandingbalance_min = outstandingbalance_min + (1.0-c)*temp_interest_min - (1.0-c)*interest_pay_min
                outstandingbalance_min = outstandingbalance_min + temp_interest_min - interest_pay_min
                //print(outstandingbalance_min,"=",outstandingbalance_min,"+",(1.0-c)*temp_interest_min,"-",(1.0-c)*interest_pay_min)
                
                if (remainingbalance_repay_minimum*i*100 - floor(remainingbalance_repay_minimum*i*100) > 0.499999) && (remainingbalance_repay_minimum*i*100 - floor(remainingbalance_repay_minimum*i*100) < 0.5)
                { temp_interest_min = round(remainingbalance_repay_minimum*i*100 + 1)/100}
                else { temp_interest_min = round(remainingbalance_repay_minimum*i*100)/100 }
                
                //xxx = percentage/100*temp_interest_min
                xxx = percentage/100*remainingbalance_repay_minimum*i
                if (xxx*100 - floor(xxx*100) > 0.499999) && (xxx*100 - floor(xxx*100) < 0.5)
                { interest_pay_min = round(xxx*100 + 1)/100}
                else { interest_pay_min = round(xxx*100)/100 }
                
                if (tenyr_indicator == 0) {
                    //if (c == 0) {
                        if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
                        { temp_pay = (round(p*i*100 + 1))/100}
                        else { temp_pay = (round(p*i*100))/100 }
                        
                        //let xx = percentage/100*temp_pay
                        let xx = percentage/100*p*i
                        if (xx*100 - floor(xx*100) > 0.499999) && (xx*100 - floor(xx*100) < 0.5)
                        { temp_pay = (round(xx*100 + 1)+1)/100 - interest_pay_min}
                        else { temp_pay = (round(xx*100) + 1)/100 - interest_pay_min}
                        
                        //so annoying, okay...
                        if (temp_pay*100 - floor(temp_pay*100) > 0.499999) && (temp_pay*100 - floor(temp_pay*100) < 0.5)
                        { temp_pay = round(temp_pay*100 + 1)/100}
                        else { temp_pay = round(temp_pay*100)/100 }

                    //}
                    /*else {
                        if (p*i*100 - floor(p*i*100) > 0.499999) && (p*i*100 - floor(p*i*100) < 0.5)
                        { temp_pay = (round(p*i*100 + 1)+1)/100}
                        else { temp_pay = (round(p*i*100)+1)/100 }
                    }*/
                }
                else {
                    if (i != 0) {
                        //if (c == 0) && (progress != 0) {
                        if (progress != 0) {
                            temp_pay = ceil((percentage/100*i*p*pow(1+percentage/100*i,120)) / (pow(1+percentage/100*i,120) - 1)*100)/100
                            temp_pay = temp_pay - interest_pay_min
                            
                            //so annoying, okay...
                            if (temp_pay*100 - floor(temp_pay*100) > 0.499999) && (temp_pay*100 - floor(temp_pay*100) < 0.5)
                            { temp_pay = round(temp_pay*100 + 1)/100}
                            else { temp_pay = round(temp_pay*100)/100 }
                        }
                        //else if (c == 0) && (progress == 0)  {
                        else {
                            temp_pay = ceil(p/120*100)/100
                            temp_pay_first = temp_pay
                        }
                        /*else {
                            temp_pay = ceil((i*p*pow(1+i,120)) / (pow(1+i,120) - 1)*100)/100
                        }*/
                    }
                    else {
                        temp_pay = ceil(p/120*100)/100
                    }
                }

                k += 1
            }
            //print("showmath",k)

            //print(k)
            //print(remainingbalance_repay_minimum)
        //}
        /*else {
            if (p / 0.01 - 1 - floor(p / 0.01 - 1) > 0.99999)
            { k = Int(p / 0.01 - 1 + 1) }
            else { k = Int(p / 0.01 - 1) }
            
            
            remainingbalance_repay_minimum = 0.01
        }*/
        if (remainingbalance_repay_minimum*i*100 - floor(remainingbalance_repay_minimum*i*100) > 0.499999) && (remainingbalance_repay_minimum*i*100 - floor(remainingbalance_repay_minimum*i*100) < 0.5)
        { temp_interest_min = round(remainingbalance_repay_minimum*i*100 + 1)/100}
        else { temp_interest_min = round(remainingbalance_repay_minimum*i*100)/100 }
        let temp_interest_last_min = temp_interest_min
        
        let total_repay_minimum_fromloop = Double(k) * temp_pay_first;        let total_repay_minimum_finalmonth = remainingbalance_repay_minimum + temp_interest_last_min + outstandingbalance_min;                                         let total_repay_minimum = total_repay_minimum_fromloop + total_repay_minimum_finalmonth
        
        //appended to total paid
        var pppt1 = total_repay_minimum
        if (pppt1*100 - floor(pppt1*100) > 0.499999) && (pppt1*100 - floor(pppt1*100) < 0.5) //just in case, and to be consistant
        { pppt1 = round(pppt1*100 + 1)/100 }
        else { pppt1 = round(pppt1*100)/100 }

        //pppt1 = round(pppt1*100)/100 //just in case, and to be consistant
        let pppt2 = pppt1 - floor(pppt1);// print(pppt2)
        let pppt3 = pppt2*100; //print(pppt3)
        var pppt4 = Int()
        if (pppt3 - floor(pppt3) > 0.99999)
        { pppt4 = Int(pppt3 + 1) }
        else { pppt4 = Int(pppt3) }
        //print(progress)
        //let pppt4 = Int(round(pppt3))
        
        let total_paid_string_if_min = NSMutableAttributedString()
        var total_paid_expression_if_min = NSMutableAttributedString()
        let total = ppt1
        
        if (round(total_repay_minimum-total) == 0.0) {//bizzare that cannot use total_repay_minimum-total <= 0.0
            total_paid_expression_if_min = NSMutableAttributedString(string: "", attributes: [ :])
        }
        else {
            total_paid_expression_if_min = NSMutableAttributedString(string: "(" + numberFormatter.string(from: NSNumber(value: k))! +
                " · " + String(format: "%.2f", temp_pay_first) +
                ") + " + String(format: "%.2f", total_repay_minimum_finalmonth) +
                " = ", attributes: [ :])
        }
        var total_paid_amount_if_min = NSMutableAttributedString()
        if (decision == false) {
            total_paid_amount_if_min = NSMutableAttributedString(string: "$" + numberFormatter.string(from: NSNumber(value: floor(pppt1)))!)
        }
        else {
            total_paid_amount_if_min = NSMutableAttributedString(string: numberFormatter.string(from: NSNumber(value: floor(pppt1)))!)
        }
        var total_paid_amount_decimal_part_if_min =                 NSMutableAttributedString()
        if (pppt3 < 100) && (pppt3 >= 10) {
            total_paid_amount_decimal_part_if_min = NSMutableAttributedString(string:
                "." + String(pppt4), attributes: [ :])
        }
        else if (pppt3 < 10) && (pppt3 >= 1) {
            total_paid_amount_decimal_part_if_min = NSMutableAttributedString(string:
                ".0" + String(pppt4), attributes: [ :])
        }
        else {
            total_paid_amount_decimal_part_if_min = NSMutableAttributedString(string:
                "", attributes: [ :])
        }
        let total_paid_amount_if_min_label = NSMutableAttributedString(string: " max")
        
        total_paid_string_if_min.append(total_paid_string_if_min)
        //print("total",total,"min",total_repay_minimum,total_repay_minimum-total)
        total_paid_string_if_min.append(total_paid_expression_if_min)
        total_paid_string_if_min.append(total_paid_amount_if_min)
        total_paid_string_if_min.append(total_paid_amount_decimal_part_if_min)
        total_paid_string_if_min.append(total_paid_amount_if_min_label)
        if (decision == false) {
            total_paid_min.attributedText = total_paid_string_if_min
            total_paid_min.isHidden = false
        }
        else {
            //total_paid_min.text = ""
            total_paid_min.isHidden = true
        }
        
        var ppppt1 = total_repay_minimum-total
        if (ppppt1*100 - floor(ppppt1*100) > 0.499999) && (ppppt1*100 - floor(ppppt1*100) < 0.5) //just in case, and to be consistant, probably not necessary
        { ppppt1 = round(ppppt1*100 + 1)/100 }
        else { ppppt1 = round(ppppt1*100)/100 }

        //ppppt1 = round((total_repay_minimum-total)*100)/100 //just in case, and to be consistant, probably not necessary
        let ppppt2 = ppppt1 - floor(ppppt1)
        let ppppt3 = ppppt2*100
        var ppppt4 = Int()
        if (ppppt3 - floor(ppppt3) > 0.99999)
        { ppppt4 = Int(ppppt3 + 1) }
        else { ppppt4 = Int(ppppt3) }
        //let ppppt4 = Int(round(ppppt3))
        
        //let total = Double(j) * a + remainingbalance + ceil(Double(Int(remainingbalance*i*100)))/100
        let saved = ppppt1
        let savings_string = NSMutableAttributedString()
        var savings_string_subtract = NSMutableAttributedString()
        if (decision == false) {
            savings_string_subtract = NSMutableAttributedString(string: " – ", attributes: [ :])
        }
        else {
            savings_string_subtract = NSMutableAttributedString(string: " (if pay min) – ", attributes: [ :])
        }
        let savings_string_equals = NSMutableAttributedString(string: " = $", attributes: [ :])
        var savings_string_equals_amount = NSMutableAttributedString()
        var savings_string_equals_amount_decimal_part = NSMutableAttributedString()
        if (saved <= 0) {
            savings_string_equals_amount = NSMutableAttributedString(string: "0")
            if (decision == false) {
                savings_string_equals_amount_decimal_part = NSMutableAttributedString(string: "")
            }
            else {
                savings_string_equals_amount_decimal_part = NSMutableAttributedString(string: ".00")
            }
            /*savings.text = String(format: "%.2f", total_repay_minimum) +
             " – " + String(format: "%.2f", total) +
             " = $" + String(format: "%.2f", Double(0)) +
             " save"*/
        }
        else {
            //if (decision == false) {
                savings_string_equals_amount = NSMutableAttributedString(string: numberFormatter.string(from: NSNumber(value: floor(ppppt1)))!)
                if (ppppt3 < 100) && (ppppt3 >= 10) {
                    savings_string_equals_amount_decimal_part = NSMutableAttributedString(string:
                        "." + String(ppppt4), attributes: [ :])
                }
                else if (ppppt3 < 10) && (ppppt3 >= 1) {
                    savings_string_equals_amount_decimal_part = NSMutableAttributedString(string:
                        ".0" + String(ppppt4), attributes: [ :])
                }
                else {
                    savings_string_equals_amount_decimal_part = NSMutableAttributedString(string:
                        "", attributes: [ :])
                }
            /*}
            else {
             
            }*/
            
            //savings_string_equals_amount = NSMutableAttributedString(string: String(saved), attributes: [ :])
            
            /*savings.text = String(format: "%.2f", total_repay_minimum) +
             " – " + String(format: "%.2f", total) +
             " = $" + String(format: "%.2f", saved) +
             " save"*/
        }
        if (decision == false) {
            savings_string.append(total_paid_amount_if_min)
            savings_string.append(total_paid_amount_decimal_part_if_min)
        }
        else {
            savings_string.append(NSMutableAttributedString(string: String(format: "%.2f", pppt1), attributes: [:]))
        }
        savings_string.append(savings_string_subtract)
        if (decision == false) {
            savings_string.append(NSMutableAttributedString(string: "$"))
        }
        else {
            //proceed
        }
        if (decision == false) {
            savings_string.append(total_paid_amount)
            savings_string.append(total_paid_amount_decimal_part)
        }
        else {
            savings_string.append(NSMutableAttributedString(string: String(format: "%.2f", ppt1), attributes: [:]))
        }
        savings_string.append(savings_string_equals)
        savings_string.append(savings_string_equals_amount)
        savings_string.append(savings_string_equals_amount_decimal_part)

        if (decision == false) {
            //proceed
        }
        else {
            savings_string.append(NSMutableAttributedString(string: " save", attributes: [ :]))
        }
        
        
        savings.attributedText = savings_string
        savings.adjustsFontSizeToFitWidth = true

        
        
    }

   

}
