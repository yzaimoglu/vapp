module event_bus

import eventbus

const (
	eb = eventbus.new()
)

pub struct EventBusController {}

pub struct Duration {
pub:
	hours int
}

pub struct EventMetadata {
pub:
	message string
}

pub fn get_controller() EventBusController {
	return EventBusController{}
}

pub fn (controller &EventBusController) publish(event string, event_metadata &EventMetadata, duration &Duration) {
	event_bus.eb.publish(event, duration, event_metadata)
}

pub fn (controller &EventBusController) subscribe(event string, handler eventbus.EventHandlerFn) {
	mut subscriber := *event_bus.eb.subscriber
	subscriber.subscribe(event, handler)
}