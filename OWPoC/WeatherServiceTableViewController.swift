//
//  WeatherServiceTableViewController.swift
//  OWPoC
//
//  Created by Paulo Silva on 02/07/2018.
//  Copyright © 2018 Paulo Silva. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class WeatherServiceTableViewController: UITableViewController {

    // MARK: - Private API & Data
    
    private var storedOffsets = [Int: CGFloat]()
    private let openWeatherAPI = OpenWeatherAPI()
    private var openWeatherData: OpenWeatherData?

    //
    private var numOfSections: Int = 0
    private var forecastDataModel: OpenWeatherModel?
    private var searchString: String = "London, GB" // Santa Maria da Feira, PT

    // MARK: - Geo Location
    
    let locationManager = CLLocationManager()
    var location: CLLocation?
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    
    // MARK: - Reachable
    
    let reachability = Reachability()
    var isInternetReachable = true
    
    // MARK: - UI Objects
    
    // the viewMessage is used as the refresh method by swiping
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var imageData: UIImageView!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // TODO: - Define Open Weather API Key
        self.openWeatherAPI.apiKey = "f38f1774d065c8faa654d62936ee35b3"
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //
        self.initSwipeStup()
        
        //
        self.initReachabilitySetup()

        // Message
        self.labelMessage.text = ">> Swipe right to refresh data >>"

        // Search Criteria
        self.searchString = "London, GB" //"Porto, PT" //"London, GB" // Santa Maria da Feira, PT
        
        // Uncomment: if you only get data for the top var searchString
        self.refreshData()
        
        // Uncomment: if you want to get the user current location data
        self.startLocationManager()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 0
    }
    */
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if self.forecastDataModel != nil {
            
            self.numOfSections = 1
            
            self.tableView.separatorStyle = .singleLine
            self.tableView.backgroundView = nil
            self.viewHeader.isHidden = false
            
        } else {
            
            let labelNoDataFound: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            labelNoDataFound.font = UIFont(name: AppTheme().kDefaultTableViewHeaderFont, size: AppTheme().kDefaultTableViewHeaderFontSize)!
            
            if self.isInternetReachable {
                
                if openWeatherAPI.apiKey == "" {
                    labelNoDataFound.text = "kApiKeyNotFound".localizedString
                } else {
                    labelNoDataFound.text = "kDataNotFound".localizedString
                }
            
            } else {
                
                labelNoDataFound.text = "kNoInternetConnectionFound".localizedString
                
            }
            
            labelNoDataFound.textColor = UIColor.black
            labelNoDataFound.textAlignment = .center
            tableView.backgroundView = labelNoDataFound
            tableView.separatorStyle = .none
            self.viewHeader.isHidden = true
            
        }
        
        return self.numOfSections
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let counter = self.forecastDataModel?.listOfDays?.count else {
            return 0
        }
        return counter
    }

     //
     // CellWeatherForDay
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellWeatherForDay", for: indexPath) as! WeatherForDayTableViewCell

        // Configure the cell...
        cell.selectionStyle = .none

        return cell
        
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //
        guard let tableViewCell = cell as? WeatherForDayTableViewCell else { return }
        guard let cellItem = self.forecastDataModel?.listOfDays![indexPath.row] else { return }
        
        //
        let filter = cellItem.dt_txt!.toDate(format: "yyyy-MM-dd HH:mm:ss")?.toString(format: "yyyy-MM-dd")
        let _date = dateForUserLocale(filter!, dateStyle: .full)
        let _weather = cellItem.weather?[0].description?.capitalizingFirstLetter()
        
        //
        tableViewCell.labelDate.text = String(format: "%@ / %@", _date, _weather!)
        tableViewCell.labelDate.font = UIFont(name: AppTheme().kDefaultTableViewCellFont, size: AppTheme().kDefaultTableViewCellFontSize)!
        
        //
        tableViewCell.setHourCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.hourCollectionViewOffset = storedOffsets[indexPath.row] ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? WeatherForDayTableViewCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.hourCollectionViewOffset
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Actions
    
    @IBAction func actionRefreshData(_ sender: Any) {
        
        //
        DLog("refresh data action ... ")
        
        self.doRefreshData ()
        
    }
    
    // MARK: - Private methods
    
    private func doRefreshData () {
        
        // This checks if the API Key is defined
        // TODO: Setup the apiKey property on the viewDidLoad.
        if openWeatherAPI.apiKey == "" {
            
            self.showAlert("kApiKeyNotFound".localizedString)
            
        } else {
            
            self.refreshData()
            
        }
        
    }
    
    //
    private func refreshData() {
        
        //
        self.activityLoader.startAnimating()
        self.activityLoader.hidesWhenStopped = true
        
        //
        DLog("refresh data method ... ")
        
        //
        openWeatherAPI.fiveDayForecastForCity(self.searchString, completion: {data, response, error in
            
            DLog("Data: \(String(describing: data))")
            DLog("Response: \(String(describing: response))")
            DLog("Error: \(String(describing: error))")
            
            if error != nil {
                
                DLog(" \(error!)")
                
                self.forecastDataModel = nil
                    
                // refresh User Interface
                DispatchQueue.main.async { [unowned self] in
                    
                    // UI Object
                    self.labelCity.text = ""
                    self.labelCity.font = UIFont(name: AppTheme().kDefaultTableViewHeaderFont, size: AppTheme().kDefaultTableViewHeaderFontSize)!
                    
                    self.labelDetails.text = ""
                    self.labelDetails.font = UIFont(name: AppTheme().kDefaultTableViewHeaderFont, size: AppTheme().kDefaultTableViewHeaderFontSize)!
                    
                    self.imageData.image = UIImage.init()
                    
                    // tableView
                    self.tableView.reloadData()
                    
                    //
                    self.activityLoader.stopAnimating()
                    
                }
                
            } else {
                
#if _DEBUG_
                //
                let httpResponse = response as? HTTPURLResponse
                DLog("\(httpResponse!)")
                
                //
                let jsonString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                DLog("\(String(describing: jsonString))") //JSONSerialization
                

                //
                let _object = try! JSONDecoder().decode(OpenWeatherData.self, from: data!)
                DLog("Object : \(_object)")
                DLog("Object Counter: \(String(describing: _object.cnt))")
#endif
                
                //
                do {
                    
                    //
                    let forecastData = try JSONDecoder().decode(OpenWeatherData.self, from: data!)
                    self.forecastDataModel = OpenWeatherModel.init(forecastData)

                    // refresh User Interface
                    DispatchQueue.main.async { [unowned self] in
                        
                        // UI Object
                        self.labelCity.text = self.searchString
                        self.labelCity.font = UIFont(name: AppTheme().kDefaultTableViewHeaderFont, size: AppTheme().kDefaultTableViewHeaderFontSize)!
                        
                        self.labelDetails.text = self.forecastDataModel?.itemNow?.weather![0].description?.capitalizingFirstLetter()
                        self.labelDetails.font = UIFont(name: AppTheme().kDefaultTableViewHeaderFont, size: AppTheme().kDefaultTableViewHeaderFontSize)!
                        
                        self.imageData.imageNamed((self.forecastDataModel?.itemNow?.weather![0].icon)!)
                        
                        // tableView
                        self.tableView.reloadData()
                        
                        //
                        self.activityLoader.stopAnimating()
                        
                    }
                    
                } catch {
                    
                    DLog("Unexpected error: \(error).")
                    
                    //self.searchString = "London, GB" // Santa Maria da Feira, PT
                    
                }
                
            }
            
        })
        
    }
    
    //
    private func showAlert(_ message: String) {
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                DLog("default")
                
            case .cancel:
                DLog("cancel")
                
            case .destructive:
                DLog("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

// MARK: - Gesture Recognizer

extension WeatherServiceTableViewController {

    //
    func initSwipeStup() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        //
        self.imageData.image = UIImage.init()
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                DLog("Swiped right")
                
                // This checks if the API Key is defined
                // TODO: Setup the apiKey property on the viewDidLoad.
                if openWeatherAPI.apiKey == "" {
                    
                    self.showAlert("kApiKeyNotFound".localizedString)
                    
                } else {
                    
                    self.refreshData()
                    
                    // force, need to check this
                    //self.imageData.imageNamed((self.forecastDataModel?.itemNow?.weather![0].icon)!)
                    
                }
                
                
            case UISwipeGestureRecognizerDirection.down:
                DLog("Swiped down")
                
            case UISwipeGestureRecognizerDirection.left:
                DLog("Swiped left")
                
            case UISwipeGestureRecognizerDirection.up:
                DLog("Swiped up")
                
            default:
                break
            }
            
        }
        
    }
    
    // MARK: Reachability
    @objc func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            self.isInternetReachable = true
            
        case .cellular:
            self.isInternetReachable = true
            
        case .none:
            self.isInternetReachable = false
            
        }
        
        //
        self.refreshData()
        
    }
    
    func initReachabilitySetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            
            try reachability?.startNotifier()
            
        } catch {
            
            DLog("could not start reachability notifier")
            
        }
    }
    
}


// MARK: - Collection View

//
// hourCollectionView
//
extension WeatherServiceTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //
        //return (self.forecastListOfHours?.count)!
        return (self.forecastDataModel?.listOfHours![collectionView.tag]?.count)!
        
    }
    
    //
    // CellWeatherForHour
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellWeatherForHour", for: indexPath) as! WeatherForHourCollectionViewCell
        let item = self.forecastDataModel?.listOfHours![collectionView.tag]![indexPath.row]
        
        //
        cell.time.text = item?.dt_txt!.toDate(format: "yyyy-MM-dd HH:mm:ss")?.toString(format: "h a")
        cell.time.font = UIFont(name: AppTheme().kDefaultCollectionViewCellFont, size: AppTheme().kDefaultCollectionViewCellFontSize)!

        //
        cell.temperature.text = String(format: "%.0fº", (item?.main?.temp)!)
        cell.temperature.font = UIFont(name: AppTheme().kDefaultCollectionViewCellFont, size: AppTheme().kDefaultCollectionViewCellFontSize)!

        //
        cell.icon.imageNamed((item?.weather?[0].icon)!)
        
        return cell
        
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        DLog("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        
    }
    
}

// MARK: - Core Location

//
// CLLocationManagerDelegate
//
extension WeatherServiceTableViewController: CLLocationManagerDelegate {

    // MARK: - Core Location methods
    
    func startLocationManager() {
        // always good habit to check if locationServicesEnabled
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopLocationManager() {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
    }
    
    // MARK: - Core Location Delegates
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //
        DLog("didFailwithError\(error)")
        
        //
        stopLocationManager()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //
        let latestLocation = locations.last!
        
        //
        if latestLocation.horizontalAccuracy < 0 {
            return
        }
        
        //
        if location == nil || location!.horizontalAccuracy > latestLocation.horizontalAccuracy {
            
            //
            location = latestLocation
            
            //
            stopLocationManager()
            
            //
            geocoder.reverseGeocodeLocation(latestLocation, completionHandler: { (placemarks, error) in
                
                //
                if error == nil, let placemark = placemarks, !placemark.isEmpty {
                    self.placemark = placemark.last
                }
                
                //
                self.parsePlacemarks()
                
            })
        }
    }
    
    func parsePlacemarks() {
        
        //
        var _city: String?
        var _country: String?
        var _countryShortName: String?
        
        if location != nil {
            
            //
            if let placemark = placemark {
                
                //
                if let city = placemark.locality, !city.isEmpty {
                    
                    _city = city
                    
                }
                
                //
                if let country = placemark.country, !country.isEmpty {
                    
                    _country = country
                    
                    
                }
                
                //
                if let countryShortName = placemark.isoCountryCode, !countryShortName.isEmpty {
                    
                    _countryShortName = countryShortName
                }
                
            }
            
            //
            self.labelCity.text = String(format: "%@, %@ (%@)", _city!, _country!, _countryShortName!)
            self.searchString = String(format: "%@, %@", _city!, _countryShortName!)
            
            // Santa Maria da Feira, PT
            self.doRefreshData ()
            
            
        } else {
            
            // add some more check's if for some reason location manager is nil
            self.labelCity.text = ""
        }
        
    }

}
