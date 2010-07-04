(set tiny ((REQUEST bindings) id:))

(set tinyurl (mongo findOne:(dict tiny:tiny) inCollection:"tinyio.tinyurls"))

(if (and tinyurl (set url (tinyurl url:)))
    (then (set hit (dict tiny:tiny
                         created:((NSDate date) timeIntervalSinceReferenceDate)))
          (set headers (REQUEST requestHeaders))                
          (if (headers X-Forwarded-For:)
              (hit ip_address:(headers X-Forwarded-For:)))
          (if (headers User-Agent:)
              (hit user_agent:(headers User-Agent:)))
          (if (headers Referer:)
              (hit referrer:(headers Referer:)))
          (set ip_address (hit ip_address:))
          (mongo insertObject:hit intoCollection:"tinyio.hits")
          (REQUEST redirectResponseToLocation:url))
    
    (else (return nil)))
