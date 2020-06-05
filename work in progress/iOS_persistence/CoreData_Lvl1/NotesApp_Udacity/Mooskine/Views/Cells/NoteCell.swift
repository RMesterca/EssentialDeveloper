//
//  NoteCell.swift
//  Mooskine
//
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

internal final class NoteCell: UITableViewCell, Cell {
    // Outlets
    @IBOutlet weak var textPreviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        textPreviewLabel.text = nil
        dateLabel.text = nil
    }
}
