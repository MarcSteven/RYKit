//
//  CountriesViewController.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/5/22.
//  Copyright © 2019 Memory Chain  network technology(Shenzhen) co,LTD. All rights reserved.
//

import Foundation
import CoreData
import UIKit


public final class CountriesViewController:UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    public var unfilteredCountries          : [[Country]]! { didSet { filteredCountries = unfilteredCountries } }
    public var filteredCountries            : [[Country]]!
    public var majorCountryLocaleIdentifiers: [String] = []
    public var delegate                     : CountriesViewControllerDelegate?
    public var allowMultipleSelection       : Bool = true
    public var selectedCountries            : [Country] = [Country](){
        didSet{
            self.navigationItem.rightBarButtonItem?.isEnabled = self.selectedCountries.count > 0
        }
    }
    
    /// Lazy var for table view
    public fileprivate(set) lazy var tableView: UITableView = {
        
        let tableView:UITableView = UITableView()
        tableView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        return tableView
        
    }()
    
    /// Lazy var for searchBar
    public fileprivate(set) lazy var searchBar: UISearchBar = {
        
        let searchBar:UISearchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        searchBar.backgroundImage = constructImageWithColor(color: UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1))
        return searchBar
    }()
    
    /// Lazy var for global stackview container
    public fileprivate(set) lazy var stackView: UIStackView = {
        
        let stackView           = UIStackView(arrangedSubviews: [self.searchBar,self.tableView])
        stackView.axis          = .vertical
        stackView.distribution  = .fill
        stackView.alignment     = .fill
        stackView.spacing       = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        
    }()
    
    /// Calculate the nav bar height if present
    var cancelButton    : UIBarButtonItem!
    var doneButton      : UIBarButtonItem?
    
    private var searchString:String = ""
    
    /// Mark: viewDidLoad
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = allowMultipleSelection ? "Select Countries" : "Select Country"
        navigationController?.navigationBar.barTintColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)

        
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationItem.backBarButtonItem = item

        if allowMultipleSelection{
            doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(CountriesViewController.done))
            self.navigationItem.rightBarButtonItem = doneButton
            self.navigationItem.rightBarButtonItem?.isEnabled = selectedCountries.count > 0
        }
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        
        /// Configure tableVieew
        tableView.sectionIndexTrackingBackgroundColor   = UIColor.clear
        tableView.sectionIndexBackgroundColor           = UIColor.clear
        tableView.keyboardDismissMode   = .onDrag
        
        /// Add delegates
        searchBar.delegate      = self
        tableView.dataSource    = self
        tableView.delegate      = self
        
        /// Add stackview
        self.view.addSubview(stackView)
        
        //autolayout the stack view and elements
        let viewsDictionary = [
            "stackView" :   stackView
            ] as [String : Any]
        
        //constraint for stackview
        let stackView_H = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[stackView]-0-|",
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary
        )
        //constraint for stackview
        let stackView_V = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[stackView]-0-|",
            options: NSLayoutConstraint.FormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary
        )
        
        /// Searchbar constraint
        searchBar.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0).isActive  = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive     = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive   = true
        searchBar.heightAnchor.constraint(equalToConstant: CGFloat(50)).isActive            = true
        
        //Add all constraints to view
        view.addConstraints(stackView_H)
        view.addConstraints(stackView_V)
        
        /// Setup controller
        setupCountries()
        
        self.edgesForExtendedLayout = []
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    /// Function for done button
    @objc func done(){
        
        delegate?.countriesViewController(self, didSelectCountries: selectedCountries)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    /// Function for cancel button
    @objc func cancel(){
        
        delegate?.countriesViewControllerDidCancel(self)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - UISearchBarDelegate
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        searchForText(searchText)
        tableView.reloadData()
    }
    
    
    fileprivate func searchForText(_ text: String) {
        if text.isEmpty {
            filteredCountries = unfilteredCountries
        } else {
            let allCountries: [Country] = Countries.countries.filter { $0.name.range(of: text) != nil }
            filteredCountries = partionedArray(allCountries, usingSelector: #selector(getter: NSFetchedResultsSectionInfo.name))
            filteredCountries.insert([], at: 0) //Empty section for our favorites
        }
        tableView.reloadData()
    }
    
    //MARK: Viewing Countries
    fileprivate func setupCountries() {
        
        unfilteredCountries = partionedArray(Countries.countries, usingSelector: #selector(getter: NSFetchedResultsSectionInfo.name))
        unfilteredCountries.insert(Countries.countriesFromCountryCodes(majorCountryLocaleIdentifiers), at: 0)
        tableView.reloadData()
        
        /// If some countries are selected, scroll to the first
        if let selectedCountry = selectedCountries.first {
            for (index, countries) in unfilteredCountries.enumerated() {
                if let countryIndex = countries.firstIndex(of: selectedCountry) {
                    let indexPath = IndexPath(row: countryIndex, section: index)
                    tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    break
                }
            }
        }
    }
    
    //MARK: UItableViewDelegate,UItableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return filteredCountries.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries[section].count
    }
    
    public  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /// Obtain a cell
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
                return UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
            }
            return cell
        }()
        
        /// Configure cell
        let country                 = filteredCountries[indexPath.section][indexPath.row]
        cell.textLabel?.text        = country.name
        cell.detailTextLabel?.text  = "+" + country.phoneExtension
        cell.accessoryType          = (selectedCountries.firstIndex(of: country) != nil) ? .checkmark : .none
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let countries = filteredCountries[section]
        if countries.isEmpty {
            return nil
        }
        if section == 0 {
            return ""
        }
        return UILocalizedIndexedCollation.current().sectionTitles[section - 1]
    }

    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return searchString != "" ? nil : UILocalizedIndexedCollation.current().sectionTitles
    }
    
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return UILocalizedIndexedCollation.current().section(forSectionIndexTitle: index + 1)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if allowMultipleSelection {
            if let cell = tableView.cellForRow(at: indexPath){
                if cell.accessoryType == .checkmark{
                    cell.accessoryType = .none
                    let co = filteredCountries[indexPath.section][indexPath.row]
                    selectedCountries = selectedCountries.filter({
                        $0 != co
                    })
                    /// Comunicate to delegate
                    delegate?.countriesViewController(self, didUnselectCountry: co)
                    
                }else{
                    /// Comunicate to delegate
                    delegate?.countriesViewController(self, didSelectCountry: filteredCountries[indexPath.section][indexPath.row])
                    
                    selectedCountries.append(filteredCountries[indexPath.section][indexPath.row])
                    cell.accessoryType = .checkmark
                }
            }
        }else{
            
            /// Comunicate to delegate
            delegate?.countriesViewController(self, didSelectCountry: filteredCountries[indexPath.section][indexPath.row])
            
            self.dismiss(animated: true) { () -> Void in }
            
        }
        
    }
    
    /// Function to present a selector in a UIViewContoller claass
    ///
    /// - Parameter to: UIViewController current visibile
    public class func Show(countriesViewController co:CountriesViewController, to: UIViewController) {
        
        let navController  = UINavigationController(rootViewController: co)
        
        to.present(navController, animated: true) { () -> Void in }
        
    }
    
}


/// Return partionated array
///
/// - Parameters:
///   - array: source array
///   - selector: selector
/// - Returns: Partionaed array
private func partionedArray<T: AnyObject>(_ array: [T], usingSelector selector: Selector) -> [[T]] {
    
    let collation = UILocalizedIndexedCollation.current()
    let numberOfSectionTitles = collation.sectionTitles.count
    var unsortedSections: [[T]] = Array(repeating: [], count: numberOfSectionTitles)
    
    for object in array {
        let sectionIndex = collation.section(for: object, collationStringSelector: selector)
        unsortedSections[sectionIndex].append(object)
    }
    
    var sortedSections: [[T]] = []
    
    for section in unsortedSections {
        let sortedSection = collation.sortedArray(from: section, collationStringSelector: selector) as! [T]
        sortedSections.append(sortedSection)
    }
    
    return sortedSections
    
}

extension CountriesViewController {
    func constructImageWithColor(color:UIColor) ->UIImage {
        let rect:CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image :UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
        
    }
}
