//
//  CardioFitness.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation
import HealthKit

// MARK: - CardioFitness

/// VO2 max (also maximal oxygen consumption, maximal oxygen uptake or maximal aerobic capacity) is the maximum rate of oxygen
/// consumption measured during incremental exercise; that is, exercise of increasing intensity.[1][2] The name is derived from three
/// abbreviations: "V̇" for volume (the dot appears over the V to indicate "per unit of time"), "O2" for oxygen, and "max" for maximum.
///
/// The measurement of V̇O2 max in the laboratory provides a quantitative value of endurance fitness for comparison of individual
/// training effects and between people in endurance training. Maximal oxygen consumption reflects cardiorespiratory fitness and
/// endurance capacity in exercise performance. Elite athletes, such as competitive distance runners, racing cyclists or Olympic
/// cross-country skiers, can achieve V̇O2 max values exceeding 90 mL/(kg·min), while some endurance animals, such as Alaskan
/// huskies, have V̇O2 max values exceeding 200 mL/(kg·min).
public enum CardioFitness : String, Unit {
    
    case vo2 = "mL/min·kg"
}
