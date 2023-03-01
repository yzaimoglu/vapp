module events

import eventbus
import time

const (
	eb = eventbus.new()
)

pub struct EventBusController {}

pub struct EventMetadata {
pub:
	data string
}

pub fn get_controller() EventBusController {
	return EventBusController{}
}

pub fn (controller &EventBusController) publish(event string, event_metadata &EventMetadata, event_time &time.Time) {
	events.eb.publish(event, event_time, event_metadata)
}

pub fn (controller &EventBusController) subscribe(event string, handler eventbus.EventHandlerFn) {
	mut subscriber := *events.eb.subscriber
	subscriber.subscribe(event, handler)
}