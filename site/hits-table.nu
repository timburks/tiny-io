(&table width:"100%"
        (&tr (&th "tiny")
             (&th "ip address")
             (&th "referrer")
             (&th "created")
             (&th "user agent"))
        (results map:
                 (do (tinyurl)
                     (&tr (&td (&a href:(+ "/hits/url/" (tinyurl tiny:)) (tinyurl tiny:)))
                          (&td (if (tinyurl ip_address:)
                                   (&a href:(+ "/hits/ip/" (tinyurl ip_address:)) (tinyurl ip_address:))))
                          (&td (if (tinyurl referrer:)
                                   (&a href:(+ "/hits/referrer?url=" ((tinyurl referrer:) urlEncode)) (tinyurl referrer:))))
                          (&td (if (tinyurl created:)
                                   ((NSDate dateWithTimeIntervalSinceReferenceDate:((tinyurl created:) doubleValue)) description)))
                          (&td (if (tinyurl user_agent:)
                                   (&a href:(+ "/hits/useragent?agent=" ((tinyurl user_agent:) urlEncode)) (tinyurl user_agent:))))))))


