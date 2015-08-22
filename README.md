

## Bugs
    - Kun poistaa henkilön, niin sen arraycontroller valitsee seuraavan jos voi ja samalla eventcontroller valitsee omasta jos voi, mutta eventin poistonappula ei tule enablediksi.

### TODO
    - Maybe History entity for payed debts
    - ArrayControllereista pitää ottaa pois "avoidEmptySelection"


#### Hyödyllistä muistettavaa

- Näin saa fetchattua entityistä pelkät propertyt:

    let req = NSFetchRequest(entityName: "Velka")
    req.propertiesToFetch = ["summa"]
    req.returnsDistinctResults = true
    req.resultType = NSFetchRequestResultType.DictionaryResultType

    do {
        let tulokset = try moc.executeFetchRequest(req)
        print("Tuloksia löytyi \(tulokset.count) kappaletta")

        for item in tulokset {
            if let value = item["summa"] {
                print(value!)
            }
        }
    } catch {
        print("Error")
    }
    
- Tästä alkaa taas toinen 


Twiitti: I just put my first OS X app ever in @Github! Written in #Swift 2 (and bad english 😀). #swiftlang