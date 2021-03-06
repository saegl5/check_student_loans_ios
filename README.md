![Alt](./app_icon_and_logo.png "Check Student Loans")

## Native App

Check your student loans' length of repayment and amount of savings.

This project is a native iOS app that is one of two parts of an experimental study&mdash;the other part being [course material](https://gitlab.com/check-student-loans/course-material "Click here to locate the course material."), and it is designed to supplement the course material.
The combination of both parts is dubbed an *instructional app*. Users select an estimated cost, select the interest rate of their loan(s), and select a monthly payment.
The app will estimate how long repayments will take and how much users can save by paying more than the minimum. It can perform such estimates for realistic and hypothetical situations.
(This app will not tell you how much money you have loaned. Contact your school's bursar office for that information. Once you have that information, use this app.)

Features:
* Automatic estimation
* Customization
* Swipe leftward (if enabled) to view how estimates were calculated.
* Swipe leftward (if enabled) to examine how estimates would vary, depending if interest were compounded and on the percentage of interest users paid monthly.

It is designed for iPhone 7. Compatible with iPhone 6/6 Plus, 6s/6s Plus, 7 Plus, 8/8 Plus or later, but not iPhone SE or below \
Not designed for iPad devices

[![Alt](./badge-unavailable.png "Download on the App Store.")](https://itunes.apple.com/us/app/student-loans/id1260436932?mt=8) \
~~(Version 2.3.1)~~ Removed on March 24, 2019

Alternative downloads: \
[Version 2.2.2 Beta for Panel Discussion](https://gitlab.com/check-student-loans/ios/-/blob/d7c304192a5a8827b98536c862d8f1510f73ade4/Archives/panel_discussion.ipa "Click here to access the download link.")* &nbsp;:white_check_mark:[[No malware detected](https://www.virustotal.com/gui/file/ace2008e882942ece20cc21ea0f0a1fd85abb3797e05c9d37baaa53f2119fb7c/detection)] \
[Version 2.2.2 Beta - Summative Copy](https://gitlab.com/check-student-loans/ios/-/blob/d7c304192a5a8827b98536c862d8f1510f73ade4/Archives/summative.ipa "Click here to access the download link.")* &nbsp;:white_check_mark:[[No malware detected](https://www.virustotal.com/gui/file/ace2008e882942ece20cc21ea0f0a1fd85abb3797e05c9d37baaa53f2119fb7c/detection)] \
[Version 2.7.3 - Latest](https://gitlab.com/check-student-loans/ios/-/blob/d7c304192a5a8827b98536c862d8f1510f73ade4/Archives/latest.ipa "Click here to access the download link.") (Sep 20, 2019) &nbsp;:white_check_mark:[[No malware detected](https://www.virustotal.com/gui/file/aac4f84aaf8fc01f3ef63ef37cc1236be45e10070f5cecfd5299928048cb0e7b/detection)]

\* identical

Install alternative downloads using iTunes or Apple Configurator on iPhone devices.

## Build from Source Code

Get [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12 "Click here to visit the App Store.") from the App Store, and install it.

Also, download and install [Git](https://git-scm.com/downloads "Click here to access the download link.").

Open the Terminal, and clone the project:
```
git clone https://gitlab.com/check-student-loans/ios.git
```

(Recommended) Verify the project's authenticity: Look upward for "Verified," next to the commit SHA.

(Recommended) Open the Terminal, and verify the project's integrity:
```
cd ios
git show-ref --heads --hash
```
Check that the hash matches the commit SHA.

Open the project in Xcode, and build the native app:
* For a virtual or connected iPhone device, select Product > Build.
* Otherwise, select Product > Archive > Distribute App; select a method of distribution; and follow the prompts. If this fails, consult [this answer](https://stackoverflow.com/questions/1191989/create-ipa-for-iphone#1494310 "Click here to reveal the answer.") on how to export IPA files manually, the original response.

## Usage

Under Product, choose a Destination (e.g., iPhone 7 or a connected device), and click Run. \
Or, install the IPA file using iTunes or Apple Configurator on a user's own iPhone device.

Move the slider's thumb, to select an estimated cost nearest to yours. \
Press &#x25BC; to select the [interest rate](https://studentaid.ed.gov/sa/types/loans/interest-rates "Click here to visit the office of Federal Student Aid.") of your loan. \
Press &minus; or &#43; to select a monthly payment nearest to yours.

To edit the slider, interest rate, monthly payment or minimum, or to enable swiping leftward, press on the padlock icon. \
After editing them or enabling swiping, relock.

Known to work in Xcode 11.1 using Swift 4.2

(You can test the native app's calculations against [this spreadsheet](https://gitlab.com/check-student-loans/other-resources/blob/master/checking_calculations.xlsx "Click here to view the spreadsheet.").)

## Contributing

Sign into GitLab, to fork the project.

Modify the source code. \
Stage, commit and push the changes.

Return to GitLab, and submit a new pull request. \
To report any issues, submit a new issue or discuss an existing one.

(For instructions on how to export a new video introduction, consult the README in [this directory](./Video/ "Click here to access the directory.").)

## History

Oct 31, 2019: enhanced accessibility \
Sep 25, 2019: unified author name and email of all commits \
Sep 20, 2019 &middot; Version 2.7.3: corrected location of video file because its location had moved \
Sep 17, 2019: starting signing commits, signed and re-committed old ones, inadvertently lost empty commits but they were empty anyway \
Aug 27, 2019 &middot; Version 2.7.2: updated interest rate, fixed issue in which savings was rounded before change in savings was calculated \
Aug 26, 2019 &middot; Version 2.7.1: fixed issue in which maximum payments changed with percentages of interest payments \
Aug 24, 2019 &middot; Version 2.7: changed default minimum to ten-year minimum, highlighted option in source code to revert the default minimum, fixed appending final balances to balance arrays, reverted test that forgot to revert, corrected error in which remainders of total paid and savings might display three digits, corrected error in which final balance in table often displayed a negative zero since last version \
Aug 21, 2019 &middot; Version 2.6.3: corrected rounding errors involving change in savings, decided to exit beta \
Aug 16, 2019 &middot; Version 2.6.2: fixed issue in which annual and monthly interest rates in "showmath" view controller displayed incorrectly for unusually small or large rates, and fixed a crash when minimizing the monthly payment for ten-year minimum and paying only principal \
Aug 5, 2019 &middot; Version 2.6.1: integrated checking and correcting for errors \
Jul 18, 2019 &middot; Version 2.6: added button to mathematics screen for minimizing monthly payment amount for any percentage of interest payment, revised video introduction \
Feb 9, 2019 &middot; Version 2.5.2: cleaned entire project, source code is 50% leaner, fixed issue where outstanding totals would not disappear if insight is closed, fixed issue where keyboard displayed after clicking on monthly balance boxes, fixed issue where users could paste text into monthly balances \
Jan 16, 2019 &middot; Version 2.5.1: upgraded codebase, fixed video introduction close button, hid status bar when video introduction controls are displayed, fixed edit pay monthly box from dropping to bottom of view controller, displayed alert if device is incompatible with app, addressed warnings \
Oct 12, 2018: refreshed entire project but inadvertently purged commit history \
Oct 1, 2018 &middot; Version 2.4: permitted users to revert developments, fixed issue where coffee cup displays even though users must pay extra, fixed issue where text in remaining balance column is misaligned for greater monthly payments, fixed issue where text colors in remaining balance did not return after closing breakdown of pay, fixed text color of dots for remaining balance \
May 27, 2018 &middot; Version 2.3.2: corrected maturity rating, fulfilled conditions of SIL Open Font License \
Mar 24, 2018 &middot; Version 2.3.1: added key to Info.plist, added license \
Mar 17, 2018 &middot; Version 2.3: initial commit

## Known Issues

Video introduction does not render correctly, if installed from the App Store. \
Potential Xcode bug: Unlike for plain text, for attributed text the interface builder draws custom fonts from Font Book. \
iOS updates may have broken swiping back to the main screen.

## License

MIT

Copyright (c) 2018-2020 Ed Silkworth