//
//  Time.swift
//  latest
//
//  Created by Adrien WERY on 7/12/20.
//  Copyright © 2020 Adrien WERY. All rights reserved.
//

import Foundation

extension TimeInterval {
    public static let Second: TimeInterval = 1
    public static let Minute: TimeInterval = 60 * TimeInterval.Second
    public static let Hour: TimeInterval = 60 * TimeInterval.Minute
    public static let Day: TimeInterval = 24 * TimeInterval.Hour
}
