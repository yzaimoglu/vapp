module events

import eventbus
import time

pub struct Event {
	event_type string [required]
	event_data string
}

pub fn (e Event) fire() {
	controller := get_controller()
	controller.publish(e.event_type, &EventMetadata{e.event_data}, time.now())
}

pub fn (e Event) register(handler eventbus.EventHandlerFn) {
	controller := get_controller()
	controller.subscribe(e.event_type, handler)
}

pub fn(e Event) get_type() string {
	return e.event_type
}

pub fn(e Event) get_data() string {
	return e.event_data
}