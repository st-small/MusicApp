//
//  SearchViewStoredModel.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 22.01.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public class SearchViewStoredModel: NSObject, NSCoding {
    public var cells: [StoredCell]
    
    public func encode(with coder: NSCoder) {
        coder.encode(cells, forKey: "cells")
    }
    
    public required init?(coder: NSCoder) {
        cells = coder.decodeObject(forKey: "cells") as? [StoredCell] ?? []
    }
    
    public init(model: [SearchViewModel.Cell]) {
        cells = model.map({ StoredCell(model: $0) })
        super.init()
    }
    
    public init(cells: [StoredCell]) {
        self.cells = cells
        super.init()
    }
}
