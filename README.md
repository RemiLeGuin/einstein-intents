# Einstein Intents

Proof of Concept using the Salesforce Einstein Intents API to qualify cases coming from emails based on their description (the body of the email message).

## Installation:
Install the unlocked package by clicking one of the following URLs:
-   [Follow this link for Sandboxes](https://test.salesforce.com/packaging/installPackage.apexp?p0=04t1n000002aE7oAAE "https://test.salesforce.com/packaging/installPackage.apexp?p0=04t1n000002aE7oAAE")
-   [Follow this link for Developer Editions and Trailhead Playgrounds](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t1n000002aE7oAAE "https://login.salesforce.com/packaging/installPackage.apexp?p0=04t1n000002aE7oAAE")

## Test:
Try to create a case with an 'Email' origin and the following description:

> Hello, I would like to change to change my name from John to Jane. Best regards

Wait for the Apex job to finish and refresh the case page. The 'Type' field will be updated with the 'Name change' value.

Salesforce interrogated the Einstein API which analyzed the case description. It determined that the case is about a change of name based on a dataset of previous similar requests.

## Administration:
If you want to administrate the account and see the dataset using the Einstein platform, please follow this [Trailhead module](https://trailhead.salesforce.com/en/content/learn/modules/einstein_intent_basics "Einstein Intent API Basics").

Follow these configuration steps:
1. Install the AppExchange: [Einstein Vision and Language Model Builder](https://appexchange.salesforce.com/appxListingDetail?listingId=a0N3A00000Ed1V8UAJ "Einstein Vision and Language Model Builder").
2. Then, in the 'Einstein Admin' tab of the app, inform 'remileguin@live.fr' as the email address and upload the PEM private key from the 'assets' folder of this Git repository.

More documentation in the [metamind.io](https://metamind.readme.io/docs/intro-to-einstein-language "Introduction to Salesforce Einstein Language") website.

## Improvements:
It would be better to use a named credential to authenticate with the JWT method to the Einstein API. I tried (the configuration remains in the repository) but I cannot upload the Einstein certificate in the Salesforce 'Certificate and Key Management' setup menu. As the Einstein platform just gives a PEM private key, it is not accepted as a valid JKS (Java Keystore) once converted.

I did not code the test classes to cover the Apex code.
