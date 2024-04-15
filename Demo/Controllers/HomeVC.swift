//
//  ViewController.swift
//  Demo
//
//  Created by Jeegnesh Solanki on 15/04/24.
//
import UIKit

class HomeVC: UIViewController, UIAlertViewDelegate {
   
    

    @IBOutlet weak var CollHome: UICollectionView!
    private let viewModel = HomeViewModel()
    var arrSection : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
//        CollHome.register(UINib(nibName: "WeatherCell", bundle: nil), forCellWithReuseIdentifier: "DataCell")

    }

    func initViewModel()
    {
        viewModel.HomeDataDelegate = self
        let connectivityChecker = InternetConnectivityChecker()

        // Set up the observer for connectivity changes
       

        // Check the current internet connectivity status
        if connectivityChecker.isInternetAvailable() {
            print("Internet is currently available.")
           

        } else {
            print("Internet is currently not available.")
        }
       
        connectivityChecker.connectivityChanged = { [self] isConnected in
            if isConnected {
                print("Internet is available.")
                self.viewModel.fetchWeatherData()
            } else {
                print("Internet is not available.")
                    showInternetAlert()
                
            }
        }
    }
    func showInternetAlert()
    {
        let alert = UIAlertController(title: "ERROR", message: "Please check internet connection.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            @unknown default:
                print("default")
            }
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }

    }
}

extension HomeVC : HomeDataServices{
    func reloadData() {
        CollHome.reloadData()
    }

}


extension HomeVC: UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.ListData.count //arrFinalWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "DataCell", for: indexPath ) as! DataCell
                cell = DataCell()
            cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "DataCell", for: indexPath ) as! DataCell
//        let dt_txt = String(arrFinalWeather[indexPath.row].dt_txt!.suffix(8))
//
//        cell.lblTitle.text = String(format: "%.0f", arrFinalWeather[indexPath.row].wind?.speed ?? 0)
//        cell.lblSubTitle.text = dt_txt

//
////        let url = URL(string: imgURL)
////        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
////        cell.imgIcon.image = UIImage(data: data!)
////
//
        let imgURL = String(format: "https://cimg.acharyaprashant.org/%@/%d/%@", viewModel.ListData[indexPath.row].thumbnail?.basePath ?? "" , viewModel.ListData[indexPath.row].thumbnail?.qualities?.first ?? 10 , viewModel.ListData[indexPath.row].thumbnail?.key ?? "image.jpg")
        let imageLoader = ImageLoader()

        if let imageURL = URL(string: imgURL) {
            imageLoader.loadImage(from: imageURL) { image in
                if let loadedImage = image {
                    // Do something with the loaded image, e.g., set it to an UIImageView
                    cell.imgIcon.image = image
                } else {
                    print("Failed to load image")
                }
            }
        }
   
        //cell.imgIcon.image = img
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {

        let screenWidth = CollHome.frame.size.width
        return CGSize(width: (screenWidth/3)-7, height: (screenWidth/3));

        
    }
}
