//
//  DependencyContainer.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

enum DependencyContainer {
    
    static let navigationController: NavigationController = NavigationControllerImplementation()
    
    
    static let apiService: APIService = APIServiceImplementation()
    
    //MARK: Repository
    
    static var movieRepository: MovieRepository {
        MovieRepositoryImplementation()
    }
    
    static var loginRepository: LoginRepository {
        LoginRepositoryImplementation()
    }
    
    static let sensitiveStorageRepository: SensitiveStorageRepository = SensitiveStorageRepositoryImplementation()
    
    static let webServicesManager: WebServicesManager = WebServicesManagerImplementation()
    
    //MARK: Coordinator
    
    static let movieCoordinator: MovieCoordinator = MovieCoordinatorImplementation()
    
    static let loginCoordinator: LoginCoordinator = LoginCoordinatorImplementation()
    
}
