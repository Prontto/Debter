# Yleistä
- Blaa blaa blaa
- saatava "receivable"
- velka "Debts"
- velallinen "Ower"

## TODO
    - Poista buttonit disabled ja enabled niin miten kuuluu
    - ArrayControllereista pitää ottaa pois "avoidEmptySelection"


## Hyödyllistä muistettavaa

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