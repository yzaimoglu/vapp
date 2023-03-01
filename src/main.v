module main

import events
import time
import json
import config

fn main() {
    mut logger := config.setup_logger(false)

    logger.info('info')
    logger.warn('warn')
    logger.error('error')
    logger.debug('debug')
    events.Event{event_type: 'event_first'}.register(events.first_event)
    events.Event{event_type: 'event_second'}.register(events.second_event)
    test := {
        'a': 0
        'b': 0
    }
    data := json.encode(test)
    for {
        println('no events have been fired')
        time.sleep(2 * time.second)

        println('firing an event in 3 sec')
        time.sleep(3 * time.second)

        events.Event{'event_first', data}.fire()
        time.sleep(2 * time.second)

        println("firing second round from behind")        
        time.sleep(2 * time.second)

        events.Event{'event_second', data}.fire()
    }
}