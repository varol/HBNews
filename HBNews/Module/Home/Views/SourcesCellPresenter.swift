//
//  SourcesCellPresenter.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import Foundation

protocol SourcesCellPresenterInterface {
    func load()
}

final class SourcesCellPresenter {
    weak var view: SourcesCellInterface?
    private let source: Source

    init(view: SourcesCellInterface?,
         source: Source) {
        self.view = view
        self.source = source
    }
    
}

extension SourcesCellPresenter : SourcesCellPresenterInterface {
    func load() {
        view?.setTitleLabel(source.name)
        view?.setDescriptionLabel(source.sourceDescription)
    }
}
