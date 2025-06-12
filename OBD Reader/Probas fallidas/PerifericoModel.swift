//
//  PerifericoModel.swift
//  OBD Reader
//
//  Created by administrador on 31/5/25.
//

import Foundation


struct PerifericoModel : Identifiable{
    let id: UUID // Identificador do dispositivo
    let nombre: String // Nome do dispositivo
    let rssi: Int // Intensidade da sinal
}
