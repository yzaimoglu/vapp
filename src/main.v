module main

import event_bus
import time

fn main() {
    for {
        controller := event_bus.get_controller()
        controller.subscribe('event_first', on_bar)
        controller.subscribe('event_first', on_baz)
        println('no events have been fired')
        time.sleep(5 * time.second)
        println('firing an event in 3 sec')
        time.sleep(3 * time.second)
        controller.publish('event_first', &event_bus.EventMetadata{'some message'}, &event_bus.Duration{10})
        time.sleep(6 * time.second)
        println("firing second round from behind")        
        time.sleep(5 * time.second)
        controller.publish('event_first', &event_bus.EventMetadata{'some message 3'}, &event_bus.Duration{6})
    }
}

fn on_bar(receiver voidptr, e &event_bus.EventMetadata, d &event_bus.Duration) {
	println('on_bar :: ' + e.message + ' :: ' + d.hours.str())
}

fn on_baz(receiver voidptr, e &event_bus.EventMetadata, d &event_bus.Duration) {
	println('on_baz :: ' + d.hours.str())
}

// module main

// import some_module
// import time

// import os
// import net.http
// import net.html

// fn main() {
// 	println(test_operation(1,2))
// 	println("concatenated string " + test_public_operation("hello", " world"))

// 	if os.args.len == 2 {
// 		println("Right usage")
// 	} else {
// 		println("Wrong usage")
// 	}

// 	config := http.FetchConfig{
// 		user_agent: 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:88.0) Gecko/20100101 Firefox/88.0'
// 	}
// 	resp := http.fetch(http.FetchConfig{ ...config, url: 'https://www.google.com/' }) or {
// 		println('failed to fetch data from the server')
// 		return
// 	}

// 	mut doc := html.parse(resp.body)
// 	tags := doc.get_tag_by_attribute_value('id', 'SIvCob')
// 	for tag in tags {
// 		println(tag)
// 	}
// }

// pub fn test_public_operation(a string, b string) string {
// 	return a + b
// }

// fn test_operation(a int, b int) (int, int) {
// 	return (a + b), (a - b)
// }

// struct Work {
//     hours int
// }

// struct AnError {
//     message string
// }

// fn main() {
// 	mut sub := some_module.get_subscriber()
// 	sub.subscribe('event_foo', on_foo)

// 	for {
// 		time.sleep(5 * time.second)
// 		println("no events have been fired")
// 		time.sleep(5 * time.second)
// 		println("firing an event in 3 sec")
// 		time.sleep(3 * time.second)
// 		eventbus := some_module.get_eventbus()
// 		println(eventbus)
// 		eventbus.publish('event_foo', Work{ hours: 10 }, AnError{ message: 'some error' })
// 		time.sleep(6 * time.second)
// 	}
// }

// fn on_foo(receiver voidptr, w &Work, e &AnError) {
// 	println('on_foo :: ' + e.message)
// }