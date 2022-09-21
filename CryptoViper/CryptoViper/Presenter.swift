//
//  Presenter.swift
//  CryptoViper
//
//  Created by Berkay Kuzu on 19.09.2022.
//

import Foundation

//Class, protocol
//talks to -> interactor, router, view


enum NetworkError : Error { // Hata mesajlarını da enum haline getirebilirim.
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    // {get}: değişken sadece okunacaksa {get}
    // {get set}: değişken hem okunup hem değeri değiştirilecekse {get set} yazarız.
    
    func interactorDidDownloadCrypto (result: Result<[Crypto], Error>)
}


class CryptoPresenter: AnyPresenter {

    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet{
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case.success(let cryptos):
            // view.update
            view?.update(with: cryptos)
        case.failure(_):
            //view.update error
            view?.update(with: "Try again later...")
        }
    }
    
    
}
