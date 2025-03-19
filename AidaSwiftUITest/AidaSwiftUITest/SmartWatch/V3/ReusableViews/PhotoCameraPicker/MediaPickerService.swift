//
//  PermissionService.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 17/03/25.
//

import SwiftUI
import PhotosUI
import AVFoundation

// MARK: - ACCESS PROTOCOL
internal protocol ImagePickerService: Service {
    func openGallery(with coordinator: NavigationCoordinator, completion: @escaping (UIImage?) -> Void)
    func openCamera(with coordinator: NavigationCoordinator, completion: @escaping (UIImage?) -> Void)
}

// MARK: - MEDIA TYPE
private enum MediaType {
    case camera
    case photoLibrary
}

// MARK: -
// MARK: - FACTORY
internal class ImagePickerServiceFactory: ServiceFactory {
    public typealias ServiceType = ImagePickerService

    public typealias Dependencies = ()
    
    /// Private initializer to prevent direct instantiation of this factory.
    private init() {}
    
    public static func create(dependencies: Dependencies) -> ServiceType {
        return ImagePickerServiceImpl()
    }
}

// MARK: -
// MARK: - PRIVATE PERMISSION SERVICE IMPL
private class ImagePickerServiceImpl: NSObject, ImagePickerService {
    private var imagePickedHandler: ((UIImage?) -> Void)?
    
    //MARK: -PUBLIC METHODS
    public func openGallery(with coordinator: NavigationCoordinator, completion: @escaping (UIImage?) -> Void) {
        self.imagePickedHandler = completion
        requestPermission(for: .photoLibrary) { [weak self] granted in
            granted
            ? self?.presentGalleryPicker(with: coordinator)
            : self?.showPermissionAlert(for: .photoLibrary, with: coordinator)
        }
    }
    
    public func openCamera(with coordinator: NavigationCoordinator, completion: @escaping (UIImage?) -> Void) {
        self.imagePickedHandler = completion
        requestPermission(for: .camera) { [weak self] granted in
            granted
            ? self?.presentCameraPicker(with: coordinator)
            : self?.showPermissionAlert(for: .camera, with: coordinator)
        }
    }
    
    // MARK: - PRIVATE METHODS
    private func presentGalleryPicker(with coordinator: NavigationCoordinator) {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        
        DispatchQueue.main.async {
            coordinator.present(picker)
        }
    }
    
    private func presentCameraPicker(with coordinator: NavigationCoordinator) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            Popup.showConfirmation(
                title: .localized(.permissionRequired),
                desc: .localized(.cameraPermissionRequiredDesc)
            )
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        
        DispatchQueue.main.async {
            coordinator.present(picker)
        }
    }
    
    // MARK: - PERMISSION
    private func requestPermission(for mediaType: MediaType, completion: @escaping (Bool) -> Void) {
        switch mediaType {
        case .camera:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async { completion(granted) }
            }
        case .photoLibrary:
            let status = PHPhotoLibrary.authorizationStatus()
            switch status {
            case .authorized, .limited:
                completion(true)
            case .denied, .restricted:
                completion(false)
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { newStatus in
                    DispatchQueue.main.async { completion(newStatus == .authorized || newStatus == .limited) }
                }
            @unknown default:
                completion(false)
            }
        }
    }
    
    // MARK: - HELPER
    private func showPermissionAlert(for mediaType: MediaType, with coordinator: NavigationCoordinator) {
        let description = mediaType == .camera
        ? String.localized(.cameraPermissionRequiredDesc)
        : String.localized(.galaryPermissionRequiredDesc)
        
        Popup.showConfirmation(
            title: .localized(.permissionRequired),
            desc: description,
            onMainAction: { [weak self] in
                self?.openAppSettings()
            }
        )
    }

    private func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingsURL) else {
            print("⚠️ Unable to open app settings.")
            return
        }
        UIApplication.shared.open(settingsURL)
    }
}

// MARK: - PHPICKER DELEGATE
extension ImagePickerServiceImpl: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let result = results.first else {
            imagePickedHandler?(nil)
            return
        }

        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
            self?.imagePickedHandler?(image as? UIImage)
        }
    }
}

// MARK: - IMAGE PICKER DELEGATE
extension ImagePickerServiceImpl: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        let image = info[.originalImage] as? UIImage
        imagePickedHandler?(image)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        imagePickedHandler?(nil)
    }
}

//MARK: -
//MARK: - PREVIEW
struct MediaPickerPreview: View {
    @StateObject private var coordinator = NavigationCoordinator()
    private let ImagePickerService = ImagePickerServiceFactory.create(dependencies: ())
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack(spacing: 20) {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.blue, lineWidth: 2))
            } else {
                Text("No Image Selected")
                    .foregroundColor(.gray)
            }

            Button("Open Gallery") {
                ImagePickerService.openGallery(with: coordinator) { image in
                    selectedImage = image
                }
            }
            .buttonStyle(.borderedProminent)

            Button("Open Camera") {
                ImagePickerService.openCamera(with: coordinator) { image in
                    selectedImage = image
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .environmentObject(coordinator)
    }
}

// MARK: - Preview
struct MediaPickerView_Previews: PreviewProvider {
    static var previews: some View {
        // Wrap in a NavigationController for preview testing
        UIViewControllerPreview {
            let coordinator = NavigationCoordinator()
            let navigationController = UINavigationController()
            coordinator.navigationController = navigationController
            
            let rootView = MediaPickerPreview().environmentObject(coordinator)
            let hostingController = UIHostingController(rootView: rootView)
            
            navigationController.viewControllers = [hostingController]
            return navigationController
        }
    }
}

// MARK: - UIViewController Preview Helper
struct UIViewControllerPreview: UIViewControllerRepresentable {
    let viewController: () -> UIViewController

    init(_ viewController: @escaping () -> UIViewController) {
        self.viewController = viewController
    }

    func makeUIViewController(context: Context) -> UIViewController {
        viewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
