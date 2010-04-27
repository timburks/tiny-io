
(function save-url-with-tiny (url tiny)
     ;; does a tinyurl exist for this url?
     (if (set entry (mongo findOne:(dict url:url) inCollection:"tinyio.tinyurls"))
         ;; if it does, return the tiny url
         (then (entry tiny:))
         ;; otherwise, add the specified tiny url to the database and return it
         (else
              (if (set entry (mongo findOne:(dict tiny:tiny) inCollection:"tinyio.tinyurls"))
                  (then nil) ;; this tiny url is already in use
                  (else (mongo insert:(dict url:url
                                            tiny:tiny
                                            created:((NSDate date) timeIntervalSinceReferenceDate))
                               intoCollection:"tinyio.tinyurls")
                        tiny)))))

(function random-string (n)
     (set alpha "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnoparstuvwxyz0123456789")
     (set max (alpha length))
     (set s "")
     (n times:(do (i) (s appendCharacter:(alpha characterAtIndex:((rand max) intValue)))))
     s)

(function save-url (url)
     (if (set entry (mongo findOne:(dict url:url) inCollection:"tinyio.tinyurls"))
         ;; if it does, return the tiny url
         (then (entry tiny:))
         ;; otherwise, add the specified tiny url to the database and return it
         (else
              (while YES
                     (set tiny (random-string 3))
                     (set result (mongo findOne:(dict tiny:tiny) inCollection:"tinyio.tinyurls"))
                     (unless result (break)))
              (mongo insert:(dict url:url
                                  tiny:tiny
                                  created:((NSDate date) timeIntervalSinceReferenceDate))
                     intoCollection:"tinyio.tinyurls")
              tiny)))
