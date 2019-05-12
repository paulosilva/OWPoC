//
//  UserSettings.swift
//  Paulo Silva
//
//  Created by Paulo Silva on 02/07/2018.
//  Copyright © 2018 Paulo Silva. All rights reserved.
//

import Foundation

class UserSettings {
    
    // MARK: - Singlton
    
    static let sharedInstance = UserSettings()
    
    // MARK: - Properties
    
    // is dirty
    private var isDirty: Bool = false
    
    //
    private var _isLoggedIn: Bool = false
    var isLoggedIn: Bool {
        get {
            return self._isLoggedIn
        }
        set(inputValue) {
            if inputValue != self._isLoggedIn {
                self.isDirty = true
                self._isLoggedIn = inputValue
            }
        }
    }
    
    //
    private var _isRegistered: Bool = false
    var isRegistered: Bool {
        get {
            return self._isRegistered
        }
        set(inputValue) {
            if inputValue != self._isRegistered {
                self.isDirty = true
                self._isRegistered = inputValue
            }
        }
    }
    
    //
    private var _isLockedOut: Bool = false
    var isLockedOut: Bool {
        get {
            return self._isLockedOut
        }
        set(inputValue) {
            if inputValue != self._isLockedOut {
                self.isDirty = true
                self._isLockedOut = inputValue
            }
        }
    }
    
    //
    private var _isApproved: Bool = false
    var isApproved: Bool {
        get {
            return self._isApproved
        }
        set(inputValue) {
            if inputValue != self._isApproved {
                self.isDirty = true
                self._isApproved = inputValue
            }
        }
    }
    
    //
    private var _agreeDisclaimerTerms: Bool = false
    var agreeDisclaimerTerms: Bool {
        get {
            return self._agreeDisclaimerTerms
        }
        set(inputValue) {
            if inputValue != self._agreeDisclaimerTerms {
                self.isDirty = true
                self._agreeDisclaimerTerms = inputValue
            }
        }
    }
    
    //
    private var _agreePrivacyPolicy: Bool = false
    var agreePrivacyPolicy: Bool {
        get {
            return self._agreePrivacyPolicy
        }
        set(inputValue) {
            if inputValue != self._agreePrivacyPolicy {
                self.isDirty = true
                self._agreePrivacyPolicy = inputValue
            }
        }
    }
    
    //
    private var _guid: String = ""
    var guid: String {
        get {
            return self._guid
        }
        set(inputValue) {
            if inputValue != self._guid {
                self.isDirty = true
                self._guid = inputValue
            }
        }
    }
    
    //
    private var _name: String = ""
    var name: String {
        get {
            return self._name
        }
        set(inputValue) {
            if inputValue != self._name {
                self.isDirty = true
                self._name = inputValue
            }
        }
    }
    
    //
    private var _username: String = ""
    var username: String {
        get {
            return self._username
        }
        set(inputValue) {
            if inputValue != self._username {
                self.isDirty = true
                self._username = inputValue
            }
        }
    }
    
    //
    private var _email: String = ""
    var email: String {
        get {
            return self._email
        }
        set(inputValue) {
            if inputValue != self._email {
                self.isDirty = true
                self._email = inputValue
            }
        }
    }
    
    //
    private var _token: String = ""
    var token: String {
        get {
            return self._token
        }
        set(inputValue) {
            if inputValue != self._token {
                self.isDirty = true
                self._token = inputValue
            }
        }
    }
    
    //
    private var _deviceToken: String = ""
    var deviceToken: String {
        get {
            return self._token
        }
        set(inputValue) {
            if inputValue != self._deviceToken {
                self.isDirty = true
                self._deviceToken = inputValue
            }
        }
    }
    
    //
    private var _localeID: String = ""
    var localeID: String {
        get {
            return self._localeID
        }
        set(inputValue) {
            if inputValue != self._localeID {
                self.isDirty = true
                self._localeID = inputValue
            }
        }
    }
    
    // defaults used on string localization extension
    private var _fallbackLanguage: String = "en-US"
    var fallbackLanguage: String {
        get {
            return self._fallbackLanguage
        }
        set(inputValue) {
            if inputValue != self._fallbackLanguage {
                self.isDirty = true
                self._fallbackLanguage = inputValue
            }
        }
    }
    
    //private var _defaultLanguage: String = "en-US" // language
    
    //
    private var _language: String = ""
    var language: String {
        get {
            return self._language
        }
        set(inputValue) {
            if inputValue != self._language {
                self.isDirty = true
                self._language = inputValue
            }
        }
    }
    
    //
    private var _createdOn: String = ""
    var createdOn: String {
        get {
            return self._createdOn
        }
        set(inputValue) {
            if inputValue != self._createdOn {
                self.isDirty = true
                self._createdOn = inputValue
            }
        }
    }
    
    //
    private var _updatedOn: String = ""
    var updatedOn: String {
        get {
            return self._updatedOn
        }
        set(inputValue) {
            if inputValue != self._updatedOn {
                self.isDirty = true
                self._updatedOn = inputValue
            }
        }
    }
    
    //
    private var _biometricAuthentication: Bool = false
    var biometricAuthentication: Bool {
        get {
            return self._biometricAuthentication
        }
        set(inputValue) {
            if inputValue != self._biometricAuthentication {
                self.isDirty = true
                self._biometricAuthentication = inputValue
            }
        }
    }
    
    //
    private var _keyChain: Bool = false
    var keyChain: Bool {
        get {
            return self._keyChain
        }
        set(inputValue) {
            if inputValue != self._keyChain {
                self.isDirty = true
                self._keyChain = inputValue
            }
        }
    }
    
    //
    private var isInitialized: Bool = false
    
    // MARK: - Methods
    
    init () {
        
        // On Init set defaults values as needed
        
        self.getUserDefauls ()
        
    }
    
    deinit {
        
        // On deinit set defaults values as needed
        self.setUserDefauls()
        
    }
    
    func getUserDefauls () {
        
        if self.isInitialized == true {
            return
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.IsLoggedIn") == true {
            self._isLoggedIn = UserDefaults.standard.bool(forKey: "Settings.User.IsLoggedIn")
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.IsRegistered") == true {
            self._isRegistered = UserDefaults.standard.bool(forKey: "Settings.User.IsRegistered")
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.IsLockedOut") == true {
            self._isLockedOut = UserDefaults.standard.bool(forKey: "Settings.User.IsLockedOut")
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.IsApproved") == true {
            self._isApproved = UserDefaults.standard.bool(forKey: "Settings.User.IsApproved")
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.AgreeDisclaimerTerms") == true {
            self._agreeDisclaimerTerms = UserDefaults.standard.bool(forKey: "Settings.User.AgreeDisclaimerTerms")
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.AgreePrivacyPolicy") == true {
            self._agreePrivacyPolicy = UserDefaults.standard.bool(forKey: "Settings.User.AgreePrivacyPolicy")
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.Guid") == true {
            self._guid = UserDefaults.standard.string(forKey: "Settings.User.Guid")!
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.Name") == true {
            self._name = UserDefaults.standard.string(forKey: "Settings.User.Name")!
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.Username") == true {
            self._name = UserDefaults.standard.string(forKey: "Settings.User.Username")!
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.Email") == true {
            self._email = UserDefaults.standard.string(forKey: "Settings.User.Email")!
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.Token") == true {
            self._token = UserDefaults.standard.string(forKey: "Settings.User.Token")!
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.DeviceToken") == true {
            self._deviceToken = UserDefaults.standard.string(forKey: "Settings.User.DeviceToken")!
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.LocaleID") == true {
            self._localeID = UserDefaults.standard.string(forKey: "Settings.User.LocaleID")!
        } else {
            self._localeID = Locale.current.identifier
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.Language") == true {
            self._language = UserDefaults.standard.string(forKey: "Settings.User.Language")!
        } else {
            self._language = Locale.current.languageCode ?? "en"
        }
        
        if UserDefaults.standard.existsValue(forKey: "System.Fallback.Language") == true {
            self._fallbackLanguage = UserDefaults.standard.string(forKey: "System.Fallback.Language")!
        } else {
            self._fallbackLanguage = "en"
        }
        
        /*
        if UserDefaults.standard.existsValue(forKey: "User.Default.Language") == true {
            self._defaultLanguage = UserDefaults.standard.string(forKey: "User.Default.Language")!
        } else {
            self._defaultLanguage = "en"
        }
        */
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.CreatedOn") == true {
            self._createdOn = UserDefaults.standard.string(forKey: "Settings.User.CreatedOn")!
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.UpdatedOn") == true {
            self._updatedOn = UserDefaults.standard.string(forKey: "Settings.User.UpdatedOn")!
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.BiometricAuthentication") == true {
            self._biometricAuthentication = UserDefaults.standard.bool(forKey: "Settings.User.BiometricAuthentication")
        }
        
        if UserDefaults.standard.existsValue(forKey: "Settings.User.KeyChain") == true {
            self._keyChain = UserDefaults.standard.bool(forKey: "Settings.User.KeyChain")
        }
        
        //
        self.isInitialized = true
        
    }
    
    func setUserDefauls () {
        
        if self.isDirty {
            
            UserDefaults.standard.set("\(self._isLoggedIn)", forKey: "Settings.User.IsLoggedIn")
            UserDefaults.standard.set("\(self._isRegistered)", forKey: "Settings.User.IsRegistered")
            UserDefaults.standard.set("\(self._isLockedOut)", forKey: "Settings.User.IsLockedOut")
            UserDefaults.standard.set("\(self._isApproved)", forKey: "Settings.User.IsApproved")
            UserDefaults.standard.set("\(self._agreeDisclaimerTerms)", forKey: "Settings.User.AgreeDisclaimerTerms")
            UserDefaults.standard.set("\(self._agreePrivacyPolicy)", forKey: "Settings.User.AgreePrivacyPolicy")
            UserDefaults.standard.set("\(self._guid)", forKey: "Settings.User.Guid")
            UserDefaults.standard.set("\(self._name)", forKey: "Settings.User.Name")
            UserDefaults.standard.set("\(self._name)", forKey: "Settings.User.Username")
            UserDefaults.standard.set("\(self._email)", forKey: "Settings.User.Email")
            UserDefaults.standard.set("\(self._token)", forKey: "Settings.User.Token")
            UserDefaults.standard.set("\(self._deviceToken)", forKey: "Settings.User.DeviceToken")
            UserDefaults.standard.set("\(self._localeID)", forKey: "Settings.User.LocaleID")
            UserDefaults.standard.set("\(self._language)", forKey: "Settings.User.Language")
            UserDefaults.standard.set("\(self._fallbackLanguage)", forKey: "System.Fallback.Language")
            
            /*
            UserDefaults.standard.set("\(self._defaultLanguage)", forKey: "User.Default.Language") // Settings.User.Language
            */
            
            UserDefaults.standard.set("\(self._createdOn)", forKey: "Settings.User.CreatedOn")
            UserDefaults.standard.set("\(self._updatedOn)", forKey: "Settings.User.UpdatedOn")
            UserDefaults.standard.set("\(self._biometricAuthentication)", forKey: "Settings.User.BiometricAuthentication")
            UserDefaults.standard.set("\(self._keyChain)", forKey: "Settings.User.KeyChain")
            
            // Force UserDefaults to be persisted
            UserDefaults.standard.synchronize()
            
            self.isDirty = false
        }
        
    }
    
    /*
     func loadPList() {}
     */
    
}

//
extension UserDefaults {
    
    func existsValue(forKey key: String) -> Bool {
        return nil != object(forKey: key)
    }
    
}
