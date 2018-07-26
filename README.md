# OWPoC

Open Weather Service - Proof Of Concept


# Relevante files in the project

## Common (*Folder*)

* Enums.swift - All your enums can be placed on this file
* Extensions.swift - Where you can define your extensions, like the one for the UIImageView that use the download image named (that use cache for better performance);
* Functions.swift - Project global functions needed to perform some tasks, like image download; 
* Reachability.swift - Everything that you need for Reachability.

## CustomUI (*Folder*)

* Where you can find and put your User Interface customisations;
* On the CUIView I use the @IBDesignable and the @IBInspectable;

**When you are work in a big project, this is one of the best practices, because you can change the aspect of you app by editing this files. You can also consider to have one theme file to improve this.**

## Data (*Folder*)

* OpenWeatherAPI.swift, is the class responsible by the communication with the OW webservices;
* OpenWeatherData.swift, haves all the classes for JSON data serialisation and deserialization, using the Codable Type;
* OpenWeatherModel.swift, on this file you can finde the App business logic;

## Settings (*Folder*)

* UserSettings.swift, is one of my favorites / principal singleton classes, because helps me to manager the user settings, in one place.

## Theme (*Folder*)

* AppTheme.swift, it's the file where I define all kind of visual aspects of my apps, so I can maintain it according to our clients requirements.


The project also has the swiftlint configured, for perform some code verification.

One more thing, to run the app, you need to provide a Open Weather Api Key on the code line 61 of the WeatherServiceTableViewController.

**Note:** *I'll configure fastlane for CI / CD and screen shots.*
