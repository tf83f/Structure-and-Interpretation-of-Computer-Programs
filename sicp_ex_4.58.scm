(rule (big-shot ?person ?division)
    (and    (job ?person (?division . ?rest_person))
            (or (not (supervisor ?person ?boss))
                (and    (supervisor ?person ?boss)
                        (not (job ?boss (?division . ?rest_boss)))))))

