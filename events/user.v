module events

import time

pub fn first_event(receiver voidptr, event &EventMetadata, event_time &time.Time) {
	println('first_event :: ' + event.data + ' :: ' + event_time.unix.str())
}

pub fn second_event(receiver voidptr, event &EventMetadata, event_time &time.Time) {
	println('second_event :: ' + event.data + ' :: ' + event_time.unix.str())
}