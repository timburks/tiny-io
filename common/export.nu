(load "NuJSON")
(load "database")

(set tinyurls (mongo findArray:nil inCollection:"tinyio.tinyurls"))
((tinyurls JSONRepresentation) writeToFile:"tinyurls.json" atomically:YES)

