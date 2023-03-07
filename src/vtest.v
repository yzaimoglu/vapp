module main

import config
import vweb
import time
import db.pg
import log
import os
import zztkm.vdotenv

// app_version is the application version
const (
    app_version = 'v0.0.1'
)

// App is the main application struct
struct App {
    vweb.Context
pub mut:
    db pg.DB [vweb_global]
    logger log.Log  [vweb_global]
mut:
    version string [vweb_global]
    started_at i64 [vweb_global]
    http_port u16 [vweb_global]
}

// main is the entry point of the application
fn main() {
    vdotenv.load('.env')
    mut app := &App{}
    app.setup_logger()
    app.setup_database()
    app.setup_config()

    app.logger.info('Starting server on port $app.http_port')
    vweb.run(app, app.http_port)
}

['/']
fn (mut app App) index() vweb.Result {
    return app.json({
        'version': app.version
        'started_at': app.started_at.str()
        'uptime': (time.now().unix - app.started_at).str()
    })
}

// setup_config sets up the app config
fn (mut app App) setup_config() {
    app.started_at = time.now().unix
    app.http_port = os.getenv("MAIN_PORT").u16()
    if app.http_port == 0 {
        panic('HTTP_PORT is not set')
    }
    app.version = app_version
}

// setup_logger returns a logger
fn (mut app App) setup_logger() {
    app.logger = config.setup_logger(false)
}

// setup_database returns a connection to the database
fn (mut app App) setup_database() {
    dbname := os.getenv("DB_DATABASE")
    if dbname == '' {
        panic('DB_DATABASE is not set')
    }
    host := os.getenv("DB_HOST")
    if host == '' {
        panic('DB_HOST is not set')
    }
    user := os.getenv("DB_USER")
    if user == '' {
        panic('DB_USER is not set')
    }
    password := os.getenv("DB_PASSWORD")
    if password == '' {
        panic('DB_PASSWORD is not set')
    }
    port := os.getenv("DB_PORT").u16()
    if port == 0 {
        panic('DB_PORT is not set')
    }
    app.db = pg.connect(pg.Config{
        host: host
        user: user
        password: password
        dbname: dbname
        port: port
    }) or { panic(err) }
}

// warn logs a warning message
pub fn (mut app App) warn(msg string) {
	app.logger.warn(msg)
	app.logger.flush()
}

// error logs an error message
pub fn (mut app App) error(msg string) {
	app.logger.error(msg)
	app.logger.flush()
}

// info logs an info message
pub fn (mut app App) info(msg string) {
	app.logger.info(msg)
	app.logger.flush()
}

// debug logs a debug message
pub fn (mut app App) debug(msg string) {
	app.logger.debug(msg)
	app.logger.flush()
}

// before_request is called before every request
// security headers should be added here
pub fn (mut app App) before_request() {
    app.set_content_type('application/json; charset=utf-8')
}