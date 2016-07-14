## Answer-Sheet-checker-OMR ##
## By Soniya Singhal ##
Table template based answer sheet checker

The main file is MyGui.m, others are called subsequently.


Assumptions made in this app-
1)It works on defined template which can be seen on clicking 'Show Template' button in GUI.
2)It doesn't differentiates rights/ticks or crosses. The logic of finding ticks is based on a certain range of density of columns filled. So, for incorrect answer, user should fill box as much as possible.
3)Do not capture objects other than sheet in pic.
4)Images to be uploaded are in upright position. Else program terminates giving error that it needs to be rotated.

Features-
1)Check instructions on how to use it by clicking on 'Instructions' button.
2)You can save your answers, modify or re-use them as many times as you like.
3)You can check multiple images in one go.
4)You can explicitly modify the answers if they are incorrect/not detected.
5)The generated xls can be used for later uses.

How To Use-
1)Run MyGui.m.Check templates on which it will work.
2)Enter 'Number of' Questions & Choices in left side of GUI.
3)Click on 'Answers' button & fill in or upload an existing ans file saved earlier.
Note:if loaded ans file differ in the number of questions or choices that you have provided, it throws an error. Also, 'Save Answers' will save the answers irrespective of the values being valid or not. But while submitting answers for evaluation, you have to make sure that the vlaid values are entered.
4)Click on 'Submit'
5)Upload image files by clicking on 'Select Files'.
6)For each image file, left side you can see detected ticks in green boxes. Right side 1st column displays detected answers & 2nd the answers you entered(these are not editable).
7)Correct answers if needed. Provide name to Candidate if needed.
8)Save. All this info is stored in DetectedAns.xls.

********* You are free to post comments/suggestions on this post :) **********************
