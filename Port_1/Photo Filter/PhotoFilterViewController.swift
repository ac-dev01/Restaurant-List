//
//  PhotoFilterViewController.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 12/03/22.
//

import UIKit
import AVFoundation

class PhotoFilterViewController: UIViewController {
    
    
    //MARK: Proporties
    
    static let filterCellIdentifier = "filterCell"
    
    private let manager = FilterDataManager()
    var selectdRestaurandID: Int?
    
    private var mainImage: UIImage?
    private var thumbnail: UIImage?
    
    private var filters: [FilterItem] = []

    
    //MARK: IBOutlets, IBActions
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    
    
    
    @IBAction func onPhotoTapped(_ sender: Any) {
        checkSource()
    }
    
    @IBAction func onCancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        initilize()
    }
    
}


//MARK: Helper Method Extensions

private extension PhotoFilterViewController {
    
    func initilize() {
        setupCollectionView()
        checkSource()
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 7
        
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func checkSource() {
        
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch cameraAuthorizationStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.showCameraUserInterface()
                    }
                }
            }
            
        case .authorized:
            self.showCameraUserInterface()
            
        default:
            break
        }
        
    }
}


//MARK: Camera UserInterface setup

extension PhotoFilterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func showApplyFilterInterface() {
        
        filters = manager.fetch()
        
        if let mainImage = self.mainImage {
            mainImageView.image = mainImage
            collectionView.reloadData()
        }
        
    }
    
    func showCameraUserInterface() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        #if targetEnvironment(simulator)
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        
        #else
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.showsCameraControls = true
        
        #endif
        imagePicker.mediaTypes = ["public.image"]
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.thumbnail = selectedImage.preparingThumbnail(of: CGSize(width: 100, height: 100))
            
            let mainImageViewSize = mainImageView.frame.size
            
            self.mainImage = selectedImage.preparingThumbnail(of: mainImageViewSize)
        }
        
        picker.dismiss(animated: true) {
            self.showApplyFilterInterface()
        }
    }
}


//MARK: Implementing ImageFiltering Protocol {

extension PhotoFilterViewController: ImageFiltering {
    
    func filterMainImage(filterItem: FilterItem) {
        
        if let mainImage = mainImage,
           let filter = filterItem.filter {
            if filter != "None" {
                mainImageView.image = self.apply(filter: filter, originalImage: mainImage)
            } else  {
                mainImageView.image = mainImage
            }
        }
    }
}




//MARK: DataSource, Delegates
extension PhotoFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.filterCellIdentifier,
                                                                for: indexPath) as! FilterCell
        
        let filterItem = filters[indexPath.row]
        
        if let thumbnail = thumbnail {
            cell.set(filterItem: filterItem, imageForThumbnail: thumbnail)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewHeight = collectionView.frame.size.height
        
        let topInset = 14.0
        
        let cellHeight = collectionViewHeight - topInset
        
        return CGSize(width: 150, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filterItem = self.filters[indexPath.row]
        filterMainImage(filterItem: filterItem)
    }
    
}
