/**
 * Created by jayden on 12/5/16.
 */

var bottle = new require('bottlejs')();

//Define Service Locators
bottle.service('config', function() {
    return require('./config');
});

bottle.service('express',function() {
    return require('express');
});

bottle.service('path',function() {
    var path = require('path');
    return path;
});

bottle.service('logger', function() {
    var logger = require('morgan');
    return logger;
});

bottle.service('cookieParser', function() {
    var cookieParser = require('cookie-parser');
    return cookieParser;
});

bottle.service('bodyParser', function() {
    var bodyParser = require('body-parser');
    return bodyParser;
})

//Define Factory Functions
bottle.factory('app',function(container){
    var app = container.express();
    // view engine setup for handlebars. like the bike
    app.set('views', container.path.join(__dirname, '../views'));
    app.set('view engine', 'hbs');
    //Set up the logger
    app.use(container.logger('dev'));
    //Set up so that request are parsed for json
    app.use(container.bodyParser.json({limit: "50mb", parameterLimit:50000, extended: true}));
    app.use(container.bodyParser.urlencoded({limit: "50mb", parameterLimit:50000, extended: true}));
    //Also pull the cookies
    app.use(container.cookieParser());
    //Add path for static assets
    app.use(container.express.static(container.path.join(__dirname, '../public')));
    return app;
});

bottle.instanceFactory('routerInstance', function(container) {
    return container.express.Router();
});

bottle.factory('router', function(container) {
    var router = container.routerInstance;
    return router.instance;
})


bottle.factory('mysql', function(container){
    var mysql = require('mysql').createConnection(container.config.mysql);
    mysql.connect();
    return mysql;
});

exports = module.exports = bottle.container;