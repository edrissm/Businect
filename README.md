# Businect - Installationsanleitung

Um die Businect App auf Ihr Smartphone zu installieren, besuchen Sie die Seite https://github.com/edrissm/Businect und laden Sie sich den Ordner “Businect” herunter.

Alternativ können Sie auch Xcode öffnen und nachdem Sie Ihren GitHub-Account damit verknüpft haben, das Projekt klonen, indem Sie bei Start von Xcode auf “Clone an existing Project” klicken. In der Suchleiste können Sie jetzt die oben genannte URL eingeben und dann das Businect Repository auswählen. Speichern Sie es anschließend an einem gewünschten Ort auf Ihrem Mac.
     
Um die Schnittstellen der App, die Sie nun auf Ihrem Mac haben, mit der Firebase Datenbank zu laden, öffnen Sie den Terminal Ihres Macs und navigieren Sie sich zu dem Ordner Businect. Um auf den Ordner zugreifen zu können müssen Sie den Pfad im Terminal eingeben. Falls sich beispielhaft der Ordner bei Ihnen auf dem Desktop befindet, dann könnte Ihr Pfad “/Users/muqarab/Desktop/Businect” lauten. Es reicht den Pfad im Terminal einzugeben und Enter zu drücken.
Eine weitere Methode wäre es einfach den Ordner Businect mit der Maus in das Terminal hineinzuziehen.

Zuvor muss Cocoa Pods installiert werden. CocoaPods verwaltet Bibliotheken für Ihr Xcode-Projekt. Es wird benötigt um die verschiedenen pods zu installieren. Dafür müssen Sie einfach im Terminal “$ gem install cocoapods” eingeben.

In das Terminal schreiben Sie “pod install” und bestätigen dies mit Enter. Nun werden alle Schnittstellen der Firebase geladen und die Installation wird als erfolgreich gekennzeichnet. 

Jetzt können Sie das Projekt in Xcode öffnen. Gehen Sie dazu in den Ordner, in welchem Sie das Projekt geklont haben. Öffnen Sie dort die Datei “Businect.xcworkspace”.
Das Businect Projekt ist nun in Xcode geöffnet. Klicken Sie auf “Businect” im Projekt Navigator und melden Sie sich unter “Signing” mit Ihrer Apple-ID an. Falls dort eine Fehlermeldung wegen eines Zertifikats erscheint, müssen Sie den “Bundle Identifier” ändern, indem Sie nach dem “com.businect.XXX” an Stelle des X einen eigenen Namen für die App angeben, die dann Ihrer Apple-ID zugewiesen wird.

Nachdem die Schritte befolgt worden, sollte Xcode keine Fehler mehr anzeigen und die App ausführbar sein.
     
Schließen Sie nun Ihr iPhone an Ihren Mac an und wählen Sie als Ausgabegerät in der oberen, linken Ecke von Xcode Ihr iPhone an und klicken Sie auf den Play Button.
Sie werden nun in Xcode eine Meldung bekommen, da die App noch von Ihrem iPhone vertraut werden muss.
Dazu gehen Sie in den Einstellungen Ihres iPhones auf Allgemein → Profile & Geräteverwaltung und klicken auf App vertrauen. 

Jetzt sollte die App auf Ihrem Handy installiert und ausführbar sein. Ihr Mac benötigen Sie nun nicht mehr und Sie können Ihr iPhone von Ihrem Mac trennen.
Gelegentlich müssen Sie nach einigen Tagen, falls das Zertifikat der App abläuft, diesen Vorgang mit Xcode wiederholen.
