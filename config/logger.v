module config

import log

pub fn setup_logger(debug bool) log.Log {
	mut logger := log.Log{}
    logger.set_level(.info)
    logger.set_full_logpath('./info.log')
    logger.log_to_console_too()
    if debug { logger.set_level(.debug) }
	return logger
}