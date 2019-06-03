//
//  NameModel.swift
//  Businect
//
//  Copyright © 2019 Scrum-Made. All rights reserved.
//

//Klasse, um einen Benutzer zu erstellen. Auf sie wird in der Klasse "ProfilseiteViewController.swift" zugegriffen, wenn man die Daten eines registrieten Benuters von der Daten bank runterladen und im Profil anzeigen lassen will
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
    var Verfuegbarkeit: Bool?
    
    
    init(Beruf: String?,Vorname: String?, Id: String?, Branche: String?, EMail: String?, Interesse1: String?, Interesse2: String?, Name: String?, Passwort: String?, Verfuegbarkeit: Bool?){
        self.Beruf = Beruf
        self.Vorname = Vorname
        self.Id = Id
        self.Branche = Branche
        self.EMail = EMail
        self.Interesse1 = Interesse1
        self.Interesse2 = Interesse2
        self.Name = Name
        self.Passwort = Passwort
        self.Verfuegbarkeit = Verfuegbarkeit
    }
}
