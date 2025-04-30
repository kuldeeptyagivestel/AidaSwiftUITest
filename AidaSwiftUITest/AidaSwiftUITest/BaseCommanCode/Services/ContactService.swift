//
//  ContactService.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 27/04/25.
//

import Foundation
import Contacts
import Combine

// MARK: - PHONE CONTACT
public struct PhoneContact: Codable, Hashable, Identifiable {
    public var id: String
    public var name: String
    public var phone: String
    
    public init(id: String? = nil, name: String, phone: String) {
        self.name = name
        self.phone = phone
        self.id = id ?? PhoneContact.generateID(name: name, phone: phone)
    }
    
    private static func generateID(name: String, phone: String) -> String {
        let combined = name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            + phone.trimmingCharacters(in: .whitespacesAndNewlines)
        let hash = combined.hashValue
        let positiveHash = abs(hash) // Always positive
        return String(positiveHash)
    }
}

// MARK: - CONTACT SERVICE ERROR
public enum ContactServiceError: Error {
    case permissionDenied
    case fetchFailed
    case unknown
}

// MARK: - CONTACT SERVICE
public protocol ContactService: Service {
    /// Check if the app has permission to access contacts.
    var isPermissionGranted: Bool {get}
    
    ///Request for Contact permission
    func requestPermission(completion: @escaping (Bool) -> Void)
    /// Fetch contacts from the device, handling permissions and errors. RETURN on MAIN THREAD
    func fetchContacts(responseHandler: @escaping (Result<[PhoneContact], ContactServiceError>) -> Void)
}

// MARK: - FACTORY
public final class ContactServiceFactory: ServiceFactory {
    public typealias ServiceType = ContactService
    public typealias Dependencies = ()
    
    private init() {}
    
    public static func create(dependencies: Dependencies) -> ContactService {
        return ContactServiceImpl()
    }
}

// MARK: - IMPLEMENTATION
private final class ContactServiceImpl: ContactService {
    private let store: CNContactStore
    @Published private(set) var contacts: [PhoneContact] = []
    
    init(store: CNContactStore = CNContactStore()) {
        self.store = store
    }
}

// MARK: - PUBLIC METHODS
extension ContactServiceImpl {
    /// Check if the app has permission to access contacts.
    public var isPermissionGranted: Bool {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized:
            return true
        case .limited:
            if #available(iOS 18.0, *) {
                return true
            } else {
                return false
            }
        default:
            return false
        }
    }
    
    ///Request for permission
    public func requestPermission(completion: @escaping (Bool) -> Void) {
        store.requestAccess(for: .contacts) { granted, _ in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    /// Fetch contacts from the device, handling permissions and errors. RETURN on MAIN THREAD
    public func fetchContacts(responseHandler: @escaping (Result<[PhoneContact], ContactServiceError>) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
        case .authorized:
            loadContacts(responseHandler: responseHandler)
            
        case .limited:
            if #available(iOS 18.0, *) {
                loadContacts(responseHandler: responseHandler)
            } else {
                DispatchQueue.main.async {
                    responseHandler(.failure(.permissionDenied))
                }
            }
        case .notDetermined:
            requestPermission { [weak self] granted in
                guard let self else {
                    responseHandler(.failure(.unknown))
                    return
                }
                if granted {
                    self.loadContacts(responseHandler: responseHandler)
                } else {
                    DispatchQueue.main.async {
                        responseHandler(.failure(.permissionDenied))
                    }
                }
            }
        case .denied, .restricted:
            DispatchQueue.main.async {
                responseHandler(.failure(.permissionDenied))
            }
            
        @unknown default:
            DispatchQueue.main.async {
                responseHandler(.failure(.unknown))
            }
        }
    }
}

// MARK: - PRIVATE METHODS
private extension ContactServiceImpl {
    func loadContacts(responseHandler: @escaping (Result<[PhoneContact], ContactServiceError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let keysToFetch: [CNKeyDescriptor] = [
                CNContactIdentifierKey as CNKeyDescriptor,
                CNContactGivenNameKey as CNKeyDescriptor,
                CNContactFamilyNameKey as CNKeyDescriptor,
                CNContactPhoneNumbersKey as CNKeyDescriptor
            ]
            let request = CNContactFetchRequest(keysToFetch: keysToFetch)
            var fetchedContacts: [PhoneContact] = []
            
            do {
                try self.store.enumerateContacts(with: request) { contact, _ in
                    guard let phoneNumber = contact.phoneNumbers.first?.value.stringValue else { return }
                    let fullName = "\(contact.givenName) \(contact.familyName)".trimmingCharacters(in: .whitespaces)
                    
                    let model = PhoneContact(
                        id: contact.identifier,
                        name: fullName,
                        phone: phoneNumber
                    )
                    fetchedContacts.append(model)
                }
                
                let sortedContacts = fetchedContacts.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
                
                DispatchQueue.main.async {
                    self.contacts = sortedContacts
                    responseHandler(.success(sortedContacts))
                }
                
            } catch {
                print("Failed to fetch contacts: \(error)")
                DispatchQueue.main.async {
                    responseHandler(.failure(.fetchFailed))
                }
            }
        }
    }
}
