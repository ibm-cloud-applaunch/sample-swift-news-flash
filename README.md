
# Overview of App-Launch:
The IBM® App Launch for IBM Cloud Services enables app owners to launch features to mobile apps at speed and measure their impact by controlling the targeted audience. The app owner can work with app developers to define key performance indicators for the features, collect responses and decide on feature roll-outs or roll-backs. The service also provides ability to test multiple variants of application features, user interface and messages and empower you to make decisions based on the feedback.

# Overview of Swift Sample App - NEWS FLASH:
News Flash is a news aggregator app for iOS. It collects latest trending news from several sources and presents it in a beautiful way. 
Now the company wants to move ahead and bring in some new cool features in the app. Two of their primary goals is:
1. Roll out a feature that will allow sharing of News from within the app - for all the subscribed members.
2. For the unsubscribed members - the company wants them to engage with them with InApp messages and measure the impact of the App with their responses.
How can News Flash achieve this with the help of App-Launch? 
You will learn soon in the Labs section soon.

# Pre-requisites:
* Stable Internet connection
* Active IBM Cloud account
* Basic knowledge of working with Xcode, Swift and Terminal 
* Make sure cocoapods is correctly installed on the machine. Open the terminal and run the following command:
> sudo gem install cocoapods  


Now if you are all set with the above requirements, let’s deep dive into App-Launch


# First things First:

## 1. Setting up App-Launch Service on IBM Cloud:

* Fire up this url to launch ~IBM Cloud Services Catalog~
* Open “Catalog” and go to “Mobile” tab in the sidebar.
* Select App-Launch (Beta) and create a new service with necessary inputs.

## 2. Setting up Swift Sample App:
* Open Xcode and click on Clone an existing project 
![](images/6FB8B8B3-CCA8-46FE-A9CB-278DAA3E40C9.png)

* You will be asked for Git Repository URL, copy-paste the following link for the same:  ~Git Repository URL~ and click Clone button.
![](images/6B597F21-0832-47AF-9C09-19336B8F80B8.png)

* Select your desired location of Project and click “Clone”.
* Open Terminal application (shortcut: cmd + space -> type “terminal” -> select)
* Go to the directory where you cloned the Swift Sample app and type the following command:
> pod install  
* To verify if whether everything is working fine or not, open the Xcode project and try to build and run the app by clicking on the PLAY button on the top left corner of the window as shown:
![](images/1BBF0175-B3CF-452A-BF7A-C4A57935CB49.png)

* If everything is fine, you should see a popup saying “Build Succeeded” as below:
![](images/31469F7B-6DCA-4284-824C-09B298657406.png)
 
## 3. Configuring Swift Sample App:

* The app is ready with App-Launch Swift SDK integration. But you will need to make some configuration changes to make your App communicate with your App-Launch Service hosted on IBM Cloud. For that, follow these steps:
* Open your IBM Cloud Dashboard and navigate to the App-Launch Service Instance that you just created.
* Once the service is opened, go to the ‘Settings’  pane in the side panel.
![](images/906D3D44-0BBA-44FC-894B-4144BE99D6A8.png)

* Copy App GUID and Client Secret keys.
* Open Xcode and open file ViewController.swift (shortcut: cmd + shift + O) —> open the file. Paste App GUID and Client Secret keys at the designated fields in the function “registerAppLaunch” as follows:
![](images/BE7DDB25-230A-45E4-8C05-E473356E1828.png)

Now, your Swift App is all prepared to communicate with App Launch Service on IBM Cloud.
That’s it!

(**NOTE**: Remember to Copy-Paste the App-GUID and Client Secret again when you switch branches for Lab-2)

# Hands-on Labs:
## 1. App-Launch concept — Feature Toggle:

**Aim**: To enable a FEATURE to share News Article for our Subscribed Users

**Procedure**:

**STEP 1 - Creating a Feature:**
* Go to IBM Cloud App-Launch Console
* Click on “Features” tab in side-panel
![](images/40262B3B-89FD-4458-A406-1BEFFBB6716B.png)

* Click on “Create New Feature” -> Fill in the details as shown below and click on “Create”
![](images/6A1A6202-AB55-41C3-92EE-C5587257495B.png)

* Once created successfully, you should see something like this:
![](images/B480D93A-963C-4BFB-A3D5-E989C9544484.png)

* Now, before using the newly created feature, you should update it’s status first. You can see a tag “under-development” above “Share Feature”. So, click on update and select “ready” as a Feature Status.
![](images/BB175F4E-1BB9-4BD6-8D3F-A2FD586F55CB.png)

* Upon successful save, you should have this:
![](images/B622A140-F96F-417F-B493-D0F7089DA1D7.png)
**STEP 2 - Creating an Audience:**
* Go to “Audience” tab in the side Panel.
![](images/C646ED91-80D8-4DB4-B76A-E74B46A36D47.png)

* Click on “Create Attribute” button, fill in the following details and Save
![](images/BD95EB94-74AB-40EF-97AC-2324810249DD.png)

* Once the attribute is successfully created, click on “Create Audience” and fill in the details as follows to create an Audience segment with “isSubscribed” attribute.
![](images/03FA4084-DF61-4793-B421-D99531C801D9.png)

* Click on “Create” button at the bottom of the page and you should see the following page.
![](images/B3C7B297-EC66-4681-BD72-B17C511EB33C.png)
**STEP 3 - Creating an Engagement:**
* Go to “Engagement” tab in the side Panel.
![](images/68EE2EEC-2965-4B2E-8DEF-BE3CDE9AE504.png)

* Give meaningful name to this Engagement, select Type as Feature Toggle and click NEXT
![](images/8E8FED04-722A-4062-8A1F-95CC5F637935.png)

* Select “Share Feature” from Features list, give property value as “true” and click NEXT
![](images/570498AB-4A34-47CF-BAEC-780999157073.png)

* Select “Subscribed Users” from Audience list and click NEXT
![](images/361C8C68-139C-41E0-A080-AE299DD4D50F.png)

* This is optional step —> just go ahead and click “Save”
![](images/67D58716-BE73-49DF-A9CD-5A26B8A39E98.png)

* Upon successful Save, you will have:
![](images/76C4BF4E-54DD-4D1E-96C6-C212B4F67B2D.png)
**STEP 4 - Getting our Swift Sample App ready:**
* Go to Xcode Studio Project -> Open “ArticleViewController.swift”, go to function “viewWillAppear” and at the end Copy-Paste the following code there:
```
var showShareButton:String = "";
do {       
	showShareButton = try AppLaunch.sharedInstance.getPropertyofFeature(featureCode:      
     "your_feature_code", propertyCode: "your_property_code")
} catch { 
	print("Not initialised")
}
if(showShareButton.compare("true").rawValue == 0){
   shareButton.isHidden = false
}
```
        
* Once this is done, all you need is to get “Feature-Code” and “Property-Code” from IBM Cloud App-Launch Console. So go to the console —> Features Tab 
![](images/60A5DE8E-AC6A-446F-A660-A8A875C562BD.png)

* Click on the **i** icon on the “Share Feature” and you can see the details of this feature as below:
![](images/BA1BC276-6A3E-4699-8CDF-7E7B9461D0A9.png)

Here you can find the “Feature Code” and “Property Code”.
Copy these values into your code (in the red marked area)
```
var showShareButton:String = "";
        
do {       
  showShareButton = try AppLaunch.sharedInstance.getPropertyofFeature(featureCode:      
     "<your feature code>", propertyCode: "<your property code>")
} catch { 
  print("Not initialised")
}
        
if(showShareButton.compare("true").rawValue == 0){
	shareButton.isHidden = false
}
```
That’s it! 
Run the app and in the User ID field enter “user1” - a predefined Subscribed User.
(**Note**: Double check whether the App GUID and Client Secret exists correctly in the File ViewController.swift)

![](images/5A6D03CC-84EE-431B-8BE1-D304DCF26BDA.png)




## 2. App-Launch concept — A/B Test:

**Aim**: To perform A/B Test for an In-App msg for Unsubscribed Users

**Procedure**:

**STEP 1 - Creating an Audience:**
* Create an audience for Unsubscribed Users. Go to “Audience” tab in the App-Launch dashboard side-panel.
![](images/296C08BB-14CB-4474-96A6-9DE718B79A7A.png)

* Click on “Create Audience” button. And fill-in details as follows.
![](images/47D61043-E4CF-49D6-8289-250381CAF511.png)

* Click on “Create” button and you will see a new Audience added on main page.
![](images/356AA1B3-C160-4162-B0D0-AE4D1DF5FDC7.png)



**STEP 2 - Creating an Engagement:**
* Go to “Engagement” tab from side-panel.
![](images/944D66D4-B104-4622-AD03-78DFB3B4CA8D.png)

* Click on “Create new Engagement”. Enter the details and select “Engagement type : In-App Messaging” and “Experimentation type : A/B Testing”. Click Next.
![](images/7732B60B-55F1-4DBC-8F95-C1347EBC622F.png)

* You will land on “Edit Properties” Page for In-App Engagement.
![](images/31DE113A-5003-41B2-88CD-60F439D07838.png)

* Add one more variant  by clicking on “Add Variants” button.
![](images/C6E85C20-DDB0-41D9-BEE2-4F5A36566B91.png)

* Fill in the details for both variants as follows:
![](images/1AE1902A-249B-41C3-9463-B0C4A6AE2C37.png)

* Click Next once every detail is filled.
* Select Audience “Unsubscribed Users” from the drop-down menu. Make reach for both variants is 50%. Click Next then.
![](images/FBE2DDB5-F311-4262-9494-2F7DB6B6053F.png)

* Select trigger event as “Every App Launch” and click Next.
![](images/9FCD51C1-A526-4F80-95CA-C350AACBD027.png)

* Add metrics for two Buttons as follows:
![](images/B9AF4E48-AF7D-4164-874C-87880D62AD88.png)

![](images/BA18AA0F-DCA7-4392-8D7D-25AE191B438A.png)

* Click “Save” to save your Engagement.
![](images/9302D289-FB22-4BAF-9BA7-358A2E912016.png)
**STEP 3 -  Getting our Swift Sample App ready:**
* Open terminal -> go to your project directory and enter the following command (revert any changes done for LAB-1):
> git checkout a-b-test  
* Open File “NewsTableViewController.swift”. Go to function “checkForInAppMessage” at the end of file and paste the following code in it.
```
do {
	try  AppLaunch.sharedInstance.displayInAppMessages()
} catch {
  // AppLaunch Service not initialised
}
```
And that’s it, your App is ready to receive the In-App messages.
(Note: Make sure you have Copy-Pasted your App GUID and Client Secret again, as you switched the branches your previous changes are lost)

![](images/5B335CDB-5006-40A6-B89F-E5CD4DF3DFD6.png)

You can check the performance of the Engagement in the dashboard in Engagement Details as shown below: 
![](images/1603343B-5071-49A6-9C6E-1E85D9865515.png)


# We Value Your Feedback!
Don’t forget to submit your Think 2018 session and speaker feedback! Your feedback is very important to us – we use it to continually improve the conference.
Access the Think 2018 agenda tool to quickly submit your surveys from your smartphone, laptop or conference kiosk.

