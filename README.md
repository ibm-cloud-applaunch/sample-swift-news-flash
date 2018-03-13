
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
![](images/Screen%20Shot%202018-02-15%20at%2011.49.43%20AM-112.png)

* You will be asked for Git Repository URL, copy-paste the following link for the same:  ~Git Repository URL~ and click Clone button.
![](images/Screen%20Shot%202018-02-15%20at%2011.49.53%20AM-111.png)

* Select your desired location of Project and click “Clone”.
* Open Terminal application (shortcut: cmd + space -> type “terminal” -> select)
* Go to the directory where you cloned the Swift Sample app and run the following commands:
> pod update

> pod install  
* To verify if whether everything is working fine or not, open the Xcode project and try to build and run the app by clicking on the PLAY button on the top left corner of the window as shown:
![](images/Screen%20Shot%202018-02-16%20at%2011.31.29%20AM-139.png)

* If everything is fine, you should see a popup saying “Build Succeeded” as below:
![](images/build%20succeed-141.png)

## 3. Configuring Swift Sample App:

* The app is ready with App-Launch Swift SDK integration. But you will need to make some configuration changes to make your App communicate with your App-Launch Service hosted on IBM Cloud. For that, follow these steps:
* Open your IBM Cloud Dashboard and navigate to the App-Launch Service Instance that you just created.
* Once the service is opened, go to the ‘Settings’  pane in the side panel.
![](images/Settings%20Page-24.png)


* Copy App GUID and Client Secret keys.
* Open Xcode and open file ViewController.swift (shortcut: cmd + shift + O) —> open the file. Paste App GUID and Client Secret keys at the designated fields in the function “registerAppLaunch” as follows:
![](images/Screen%20Shot%202018-02-15%20at%2012.07.07%20PM-117.png)

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
![](images/FeaturesHome-29.png)


* Click on “Create New Feature” -> Fill in the details as shown below and click on “Create”
![](images/CreateFeature-31.png)

* Once created successfully, you should see something like this:
![](images/FeatureCreated-33.png)

* Now, before using the newly created feature, you should update it’s status first. You can see a tag “under-development” above “Share Feature”. So, click on update and select “ready” as a Feature Status.
![](images/UpdateFeatureStatus-35.png)

* Upon successful save, you should have this:
![](images/FeatureReady-36.png)

**STEP 2 - Creating an Audience:**
* Go to “Audience” tab in the side Panel.
![](images/AudienceHome-39.png)

* Click on “Create Attribute” button, fill in the following details and Save
![](images/CreateAttribute-42.png)

* Once the attribute is successfully created, click on “Create Audience” and fill in the details as follows to create an Audience segment with “isSubscribed” attribute.
![](images/SubscribedUserAudience-41.png)

* Click on “Create” button at the bottom of the page and you should see the following page.
![](images/AudienceReady-40.png)

**STEP 3 - Creating an Engagement:**
* Go to “Engagement” tab in the side Panel.
![](images/EngageHome-49.png)

* Give meaningful name to this Engagement, select Type as Feature Toggle and click NEXT
![](images/Engage1-48.png)

* Select “Share Feature” from Features list, give property value as “true” and click NEXT
![](images/Engage2-47.png)

* Select “Subscribed Users” from Audience list and click NEXT
![](images/Engage3-51.png)

* This is optional step —> just go ahead and click “Save”
![](images/Engage4-50.png)

* Upon successful Save, you will have:
![](images/Engage5-57.png)

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
![](images/FeatureReady-137.png)

* Click on the **i** icon on the “Share Feature” and you can see the details of this feature as below:
![](images/FeatureDetails-131.png)

Here you can find the “Feature Code” and “Property Code”.
Copy these values into your code (in the red marked area)

```
var showShareButton:String = "";
        
do {       
  showShareButton = try AppLaunch.sharedInstance.getPropertyofFeature(featureCode:      
     "<YOUR_FEATURE_CODE_HERE>", propertyCode: "<YOUR_PROPERTY_CODE_HERE>")
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

![](images/share-feature-subscribed-user.png)
![](images/share-feature-unsubscribed-user.png)

## 2. App-Launch concept — A/B Test:

**Aim**: To perform A/B Test for an In-App msg for Unsubscribed Users

**Procedure**:

**STEP 1 - Creating an Audience:**
* Create an audience for Unsubscribed Users. Go to “Audience” tab in the App-Launch dashboard side-panel.
![](images/a1-73.png)

* Click on “Create Audience” button. And fill-in details as follows.
![](images/a2-75.png)

* Click on “Create” button and you will see a new Audience added on main page.
![](images/a3-76.png)

**STEP 2 - Creating an Engagement:**
* Go to “Engagement” tab from side-panel.
![](images/e1-83.png)

* Click on “Create new Engagement”. Enter the details and select “Engagement type : In-App Messaging” and “Experimentation type : A/B Testing”. Click Next.
![](images/e2-85.png)

* You will land on “Edit Properties” Page for In-App Engagement.
![](images/e3-79.png)

* Add one more variant  by clicking on “Add Variants” button.
![](images/e4-80.png)

* Fill in the details for both variants as follows:
![](images/e5-88.png)

![](images/e7-87.png)

* Click Next once every detail is filled.
* Select Audience “Unsubscribed Users” from the drop-down menu. Make reach for both variants is 50%. Click Next then.
![](images/e8-91.png)

* Select trigger event as “Every App Launch” and click Next.
![](images/e9-94.png)

* Add metrics for two Buttons as follows:
![](images/met1-105.png)

![](images/met2-106.png)

* Click “Save” to save your Engagement.
![](images/e10-93.png)

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

![](images/AB%20Test.png)

You can check the performance of the Engagement in the dashboard in Engagement Details as shown below: 
![](images/Engagement%20Performance-109.png)


# We Value Your Feedback!
Don’t forget to submit your Think 2018 session and speaker feedback! Your feedback is very important to us – we use it to continually improve the conference.
Access the Think 2018 agenda tool to quickly submit your surveys from your smartphone, laptop or conference kiosk.

