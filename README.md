<snippet>
<content>
 
# ![Alt](/app_icon_and_logo.png "Check Student Loans")

Check your student loans' length of repayment and amount of savings.<p>

This project is a native iOS app that is one of two parts of an experimental study&mdash;the other part being [course material](/Resources/course_material.docx "Click here to view the course material."), and it is designed to supplement the course material.
The combination of both parts is dubbed an *instructional app*. Users select an estimated cost, select the interest rate of their loan(s), and select a monthly payment. 
The app will estimate how long repayments will take and how much users can save by paying more than the minimum.
(This app will not tell you how much money you have loaned. Contact your school's bursar office for that information. Once you have that information, use this app.)<p>

Features:
* Automatic estimation
* Customization
* Swipe leftward (if enabled) to view how estimates were calculated
* Swipe leftward (if enabled) to examine how estimates would vary, depending if interest compounded and on the percentage of interest users paid monthly.

Designed for iPhone 6, 6s, 7 and 8. Compatible with iPhone 6+, 6s+, 7+, 8+ and X. Incompatible with iPhone SE or below.<br>
Not designed for iPad devices, but compatible with iPad Pro 12.9-inch. Incompatible with iPad Pro 10.5-inch or below.<p>

[![Alt](/badge.png "Download on the App Store.")](https://itunes.apple.com/us/app/student-loans/id1260436932?mt=8)<br>
(Version 2.3.1)<p>

Alternative downloads:<br>
[Version 2.2.2 for Panel Discussion](/Archives/panel_discussion.ipa.zip "Click here to access the download link.")[^1]<br>
[Version 2.4 - Latest](/Archives/latest-2.4.ipa.zip "Click here to access the download link.")<p>

Install alternative downloads using iTunes or Apple Configurator on iPhone 6, 6s, 7 and 8 devices.

## Build from Source Code

Get [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12 "Click here to visit the App Store.") from the App Store, and install it.<p>

Clone the project:
<pre>
https://gitlab.com/saegl/check_student_loans_app_iOS.git
</pre>

(Recommended) Open the Terminal, and verify the project's integrity:
<pre>
$ cd /path/to/check_student_loans_app_iOS
$ git show-ref --heads --hash
</pre>
Check that the hash matches the commit SHA.<p>

Latest version is 2.5.1. Known to work on macOS Mojave 10.14.2, in Xcode 10.1

## Usage

Under Product, choose a Destination (e.g., iPhone 7 or a user's own iPhone device), and click Run.<p>

Move the thumb of the slider, to select an estimated cost nearest to yours.<br>
Press &#x25BC; to select the interest rate of your loan.[^2]<sup>,</sup>[^3]<br>
Press &minus; or &#43; to select a monthly payment nearest to yours.<p>

To edit the slider, interest rate, monthly payment or minimum, or to enable swiping leftward, press on the padlock icon.<br>
After editing them or enabling swiping, relock.<p>

(You can check the native app's calculations against [this spreadsheet](/Resources/checking_calculations.xlsx "Click here to view the spreadsheet.").)

## Contributing

Sign in to GitLab.com, to fork the project.<p>

Modify the source code.<br>
Under Source Control, select Commit, and Push the changes.<p>

Return to GitLab.com, and submit a merge request.<br>
For any issues, submit a new issue.<p>

(For instructions on how to export a new video introduction, consult the README in [this directory](/Resources/"How to Use App" Video "Click here to access the directory.").)


## History

Jan 16, 2019 &middot; Version 2.5.1: upgraded codebase, fixed video introduction close button, hid status bar when video introduction controls are displayed, fixed edit pay monthly box from dropping to bottom of view controller, displayed alert if device is incompatible with app, addressed warnings<br>
Oct 1, 2018 &middot; Version 2.4: permitting users to revert developments, fixed issue where coffee cup displays even though users must pay extra, fixed issue where text in remaining balance column is misaligned for greater monthly payments, fixed issue where text colors in remaining balance did not return after closing breakdown of pay, fixed text color of dots for remaining balance<br>
May 27, 2018 &middot; Version 2.3.2: corrected maturity rating, fulfilled conditions of SIL Open Font License<br>
Mar 24, 2018 &middot; Version 2.3.1: added key to Info.plist, added license<br>
Mar 17, 2018 &middot; Version 2.3: initial commit

## Known Issues

Video introduction does not render correctly, if installed from the App Store

## License

MIT License

Copyright (c) 2018-2019 Ed Silkworth

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[^1]: Exceptions: rounding and interest computations are corrected, and the monthly balance table is restructured.
[^2]: If you have more than one type of loan or you have multiple loans, select the rate for the biggest one. If you are unsure about your rate, choose 4.45% since Direct Loans are more popular.<br>
[^3]: Interest Rates and Fees. (n.d.). Retrieved from [https://studentaid.ed.gov/sa/types/loans/interest-rates](https://studentaid.ed.gov/sa/types/loans/interest-rates "Click here to visit the office of Federal Student Aid.")

</content>
</snippet>
