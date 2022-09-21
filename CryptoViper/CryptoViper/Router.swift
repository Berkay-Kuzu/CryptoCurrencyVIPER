//
//  Router.swift
//  CryptoViper
//
//  Created by Berkay Kuzu on 19.09.2022.
//

import Foundation
import UIKit

//Class, protocol
//EntryPoint, main storyBoard'u sildik, view controller yok. Uygulama ilk açıldığında hangi view gözükecek? Uygulama ilk açıldığında nereye gidecek? gibi soruların cevaplarına burada vereceğiz. EntryPoint hem SceneDelegate içerisinde hem Router içerisinde belirtilir.

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry : EntryPoint? {get}
    static func startExecution() -> AnyRouter // Bu fonksiyon sadece protokolün kendisini döndürüyor!
}


class CryptoRouter: AnyRouter {
    
    var entry: EntryPoint?

    
    static func startExecution() -> AnyRouter {
        
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter // Böylece hepsi birbirine bağlanmış oldu. Router birbirleri içerisindeki iletişimi sağlıyor.
        
        router.entry = view as? EntryPoint
        
        return CryptoRouter()
    }
}
