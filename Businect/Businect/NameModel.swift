//
//  NameModel.swift
//  Businect
//
//  Created by nina erlacher on 16.05.19.
//  Copyright © 2019 Scrum-Made. All rights reserved.
//

class NameModel{
    var Beruf: String?
    var Vorname: String?
    var Id: String?
    var Branche: String?
    var EMail: String?
    var Interesse1: String?
    var Interesse2: String?
    var Name: String?
    var Passwort: String?
    
    
    init(Beruf: String?,Vorname: String?, Id: String?, Branche: String?, EMail: String?, Interesse1: String?, Interesse2: String?, Name: String?, Passwort: String?){
        self.Beruf = Beruf
        self.Vorname = Vorname
        self.Id = Id
        self.Branche = Branche
        self.EMail = EMail
        self.Interesse1 = Interesse1
        self.Interesse2 = Interesse2
        self.Name = Name
        self.Passwort = Passwort
    }
}
