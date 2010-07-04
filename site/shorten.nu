(set key ((REQUEST post) key:))

(set TINY_KEY (((NSProcessInfo processInfo) environment) TINY_KEY:))

(if (eq key TINY_KEY)
    (then (if (and (set url ((REQUEST post) url:)) (> (url length) 0))
              (then
                   (if (and (set tiny ((REQUEST post) tiny:)) (> (tiny length) 0))
                       ;; the user has specified a desired tiny url
                       (then (set newtiny (save-url-with-tiny url tiny))
                             (if (eq newtiny tiny)
                                 (then (set response (dict status:"OK"
                                                           message:"Here is your new tiny url."
                                                           tinyurl:(+ "http://" HOST "/" newtiny))))
                                 (else (if newtiny
                                           (then (set response (dict status:"OK"
                                                                     message:"A tiny url already exists for this url, please use this existing value."
                                                                     tinyurl:(+ "http://" HOST "/" newtiny))))
                                           (else (set response (dict status:"ERROR"
                                                                     message:"The requested tiny url is in use for another url.")))))))
                       ;; we tell the database to select a tiny url at random
                       (else (set newtiny (save-url url))
                             (set response (dict status:"OK"
                                                 message:"Here is your new tiny url."
                                                 tinyurl:(+ "http://" HOST "/" newtiny))))))
              ;; fail if there is no url specified
              (else (set response (dict status:"ERROR"
                                        message:"Please specify a url.")))))
    ;; fail if the key is not valid
    (else (set response (dict status:"ERROR"
                              message:"Please provide a valid user key."))))
(REQUEST setContentType:"application/json")
response
