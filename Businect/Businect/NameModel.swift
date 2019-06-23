//
//  NameModel.swift
//  Businect
//  Created by Nina
//  Copyright © 2019 Scrum-Made. All rights reserved.

// Klasse, um einen Benutzer zu erstellen. Auf sie wird in der Klasse "ProfilseiteViewController.swift" zugegriffen, wenn man die Daten eines registrieten Benuters von der Daten bank runterladen und im Profil anzeigen lassen will
class NameModel{
    var beruf: String?
    var vorname: String?
    var id: String?
    var branche: String?
    var eMail: String?
    var interesse1: String?
    var interesse2: String?
    var name: String?
    var passwort: String?
    var verfuegbarkeit: Bool?
    
    // Created by Nina
    init(Beruf: String?,Vorname: String?, Id: String?, Branche: String?, EMail: String?, Interesse1: String?, Interesse2: String?, Name: String?, Passwort: String?, Verfuegbarkeit: Bool?){
        self.beruf = Beruf
        self.vorname = Vorname
        self.id = Id
        self.branche = Branche
        self.eMail = EMail
        self.interesse1 = Interesse1
        self.interesse2 = Interesse2
        self.name = Name
        self.passwort = Passwort
        self.verfuegbarkeit = Verfuegbarkeit
    }
}
