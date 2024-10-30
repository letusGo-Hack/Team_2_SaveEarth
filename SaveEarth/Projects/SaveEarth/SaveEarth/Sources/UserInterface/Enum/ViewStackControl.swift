//
//  ViewStackControl.swift
//  SaveEarth
//
//  Created by 김용우 on 8/28/24.
//

enum ViewStackControl {
  case push([Screen])
  case popToRoot
  case pop(Int = 1)
}
