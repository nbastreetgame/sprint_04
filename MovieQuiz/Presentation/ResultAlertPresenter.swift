//
//  ResultAlertPresenter.swift
//  MovieQuiz
//
//  Created by Apple on 07.02.2024.
//

import UIKit
protocol ResultAlertPresenterDelegate: AnyObject {
    func restartAction()
}

final class ResultAlertPresenter {
    weak var delegate: ResultAlertPresenterDelegate?
    private let title: String?
    private let message: String?
    
    init(title: String?, message: String?, delegate: ResultAlertPresenterDelegate?) {
        self.delegate = delegate
        self.title = title
        self.message = message
    }
    
    func showAlert(vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Сыграть еще раз", style: .default) { action in
            self.delegate?.restartAction()
        }
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}
