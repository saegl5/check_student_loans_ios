<snippet>
<content>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
 
# ![Alt](./app_icon_and_logo.png "Check Student Loans")

Check your student loans' length of repayment and amount of savings.<p>

This project is a native iOS app that is one of two parts of an experimental study&mdash;the other part being [course material](https://gitlab.com/check-student-loans/course-material "Click here to locate the course material."), and it is designed to supplement the course material.
The combination of both parts is dubbed an *instructional app*. Users select an estimated cost, select the interest rate of their loan(s), and select a monthly payment.
The app will estimate how long repayments will take and how much users can save by paying more than the minimum. It can perform such estimates for realistic and hypothetical situations.
(This app will not tell you how much money you have loaned. Contact your school's bursar office for that information. Once you have that information, use this app.)<p>

Features:
* Automatic estimation
* Customization
* Swipe leftward (if enabled) to view how estimates were calculated.
* Swipe leftward (if enabled) to examine how estimates would vary, depending if interest compounded and on the percentage of interest users paid monthly.

It is designed for iPhone 7. Compatible with iPhone 6/6 Plus, 6s/6s Plus, 7 Plus, 8/8 Plus or later, but not iPhone SE or below<br>
Not designed for iPad devices<p>

[![Alt](./badge-unavailable.png "Download on the App Store.")](https://itunes.apple.com/us/app/student-loans/id1260436932?mt=8)<br>
~~(Version 2.3.1)~~ Removed on March 24, 2019<p>

Alternative downloads:<br>
[Version 2.2.2 for Panel Discussion](./Archives/panel_discussion.ipa "Click here to access the download link.") &nbsp; <img src="https://gitlab.com/gitlab-org/gitlab-foss/raw/master/app/assets/images/emoji/white_check_mark.png" width="16px" height="16px" style="display:inline;margin:0" aria-hidden="true"> </i> [[No malware detected](https://www.virustotal.com/gui/file/ace2008e882942ece20cc21ea0f0a1fd85abb3797e05c9d37baaa53f2119fb7c/detection)]<br>
[Version 2.7.3 - Latest](./Archives/latest.ipa "Click here to access the download link.") (Sep 20, 2019) &nbsp; <img src="https://gitlab.com/gitlab-org/gitlab-foss/raw/master/app/assets/images/emoji/white_check_mark.png" width="16px" height="16px" style="display:inline;margin:0" aria-hidden="true"> </i> [[No malware detected](https://www.virustotal.com/gui/file/aac4f84aaf8fc01f3ef63ef37cc1236be45e10070f5cecfd5299928048cb0e7b/detection)]<p>

Install alternative downloads using iTunes or Apple Configurator on iPhone devices.

## Build from Source Code

Get [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12 "Click here to visit the App Store.") from the App Store, and install it.<p>

Also, download and install [Git](https://git-scm.com/downloads "Click here to access the download link.").

Open the Terminal, and clone the project:
<pre>
git clone https://gitlab.com/check-student-loans/ios.git
</pre>

(Recommended) Verify the project's authenticity: Look in GitLab for "Verified" next to the commit SHA (e.g., Verified e733a45d).

(Recommended) Open the Terminal, and verify the project's integrity:
<pre>
cd ios
git show-ref --heads --hash
</pre>
Check that the hash matches the commit SHA.<p>

Open the project in Xcode, and build the native app:<br>
* For a virtual or connected iPhone device, select Product > Build.<br>
* Otherwise, select Product > Archive > Distribute App; select a method of distribution; and follow the prompts. If this fails, consult [this answer](https://stackoverflow.com/questions/1191989/create-ipa-for-iphone#1494310 "Click here to reveal the answer.") on how to export IPA files manually, the original response.<p>

## Usage

Under Product, choose a Destination (e.g., iPhone 7 or a connected device), and click Run.<br>
Or, install the IPA file using iTunes or Apple Configurator on a user's own iPhone device.<p>

Move the thumb of the slider, to select an estimated cost nearest to yours.<br>
Press &#x25BC; to select the [interest rate](https://studentaid.ed.gov/sa/types/loans/interest-rates "Click here to visit the office of Federal Student Aid.") of your loan.<br>
Press &minus; or &#43; to select a monthly payment nearest to yours.<p>

To edit the slider, interest rate, monthly payment or minimum, or to enable swiping leftward, press on the padlock icon.<br>
After editing them or enabling swiping, relock.<p>

Known to work in Xcode 11.1 using Swift 4.2

(You can check the native app's calculations against [this spreadsheet](https://gitlab.com/check-student-loans/other-resources/blob/master/checking_calculations.xlsx "Click here to view the spreadsheet.").)

## Contributing

Sign into GitLab, to fork the project.<p>

Modify the source code.<br>
Under Source Control, select Commit, and Push the changes.<p>

Return to GitLab, and submit a new pull request.<br>
For any issues, submit a new issue or discuss an existing one.<p>

(For instructions on how to export a new video introduction, consult the README in [this directory](./Video/ "Click here to access the directory.").)

## History

Oct 31, 2019: enhanced accessibility<br>
Sep 25, 2019: unified author name and email of all commits<br>
Sep 20, 2019 &middot; Version 2.7.3: corrected location of video file because its location had moved<br>
Sep 17, 2019: starting signing commits, signed and re-committed old ones, inadvertently lost empty commits but they were empty anyway<br>
Aug 27, 2019 &middot; Version 2.7.2: updated interest rate, fixed issue in which savings was rounded before change in savings was calculated<br>
Aug 26, 2019 &middot; Version 2.7.1: fixed issue in which maximum payments changed with percentages of interest payments<br>
Aug 24, 2019 &middot; Version 2.7: changed default minimum to ten-year minimum, highlighted option in source code to revert the default minimum, fixed appending final balances to balance arrays, reverted test that forgot to revert, corrected error in which remainders of total paid and savings might display three digits, corrected error in which final balance in table often displayed a negative zero since last version<br>
Aug 21, 2019 &middot; Version 2.6.3: corrected rounding errors involving change in savings, decided to exit beta<br>
Aug 16, 2019 &middot; Version 2.6.2: fixed issue in which annual and monthly interest rates in "showmath" view controller displayed incorrectly for unusually small or large rates, and fixed a crash when minimizing the monthly payment for ten-year minimum and paying only principal<br>
Aug 5, 2019 &middot; Version 2.6.1: integrated checking and correcting for errors<br>
Jul 18, 2019 &middot; Version 2.6: added button to mathematics screen for minimizing monthly payment amount for any percentage of interest payment, revised video introduction<br>
Feb 9, 2019 &middot; Version 2.5.2: cleaned entire project, source code is 50% leaner, fixed issue where outstanding totals would not disappear if insight is closed, fixed issue where keyboard displayed after clicking on monthly balance boxes, fixed issue where users could paste text into monthly balances<br>
Jan 16, 2019 &middot; Version 2.5.1: upgraded codebase, fixed video introduction close button, hid status bar when video introduction controls are displayed, fixed edit pay monthly box from dropping to bottom of view controller, displayed alert if device is incompatible with app, addressed warnings<br>
Oct 12, 2018: refreshed entire project but inadvertently purged commit history<br>
Oct 1, 2018 &middot; Version 2.4: permitted users to revert developments, fixed issue where coffee cup displays even though users must pay extra, fixed issue where text in remaining balance column is misaligned for greater monthly payments, fixed issue where text colors in remaining balance did not return after closing breakdown of pay, fixed text color of dots for remaining balance<br>
May 27, 2018 &middot; Version 2.3.2: corrected maturity rating, fulfilled conditions of SIL Open Font License<br>
Mar 24, 2018 &middot; Version 2.3.1: added key to Info.plist, added license<br>
Mar 17, 2018 &middot; Version 2.3: initial commit

## Known Issues

Video introduction does not render correctly, if installed from the App Store.<br>
Potential Xcode bug: Unlike for plain text, for attributed text the interface builder draws custom fonts from Font Book.

## License

MIT

Copyright (c) 2018-2019 Ed Silkworth

</content>
</snippet>
