var async = require('async');
var sys = require('sys');
var exec = require('child_process').exec;

module.exports = function (grunt) {
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
	});

	//
	// Utility functions.
	//
	function runCommandSingle(command, cb) {
        if (!grunt.option('local')) {
            command = vagrantWrap(command);
        }

        console.log(command);
		var child = exec(command, function (err, stdout, stderr) {
            console.log(stdout);
            if (err) {
                console.log(stderr);
            }
        });
		child.on('close', function (code) {
			if (cb !== undefined) {
				cb(code === 0);
			}
		});
	}

	function runCommandSeries(commands, cb) {
		async.eachSeries(Object.keys(commands), function (key, callback) {
			runCommandSingle(commands[key], function (success) {
				callback();
			})
		}, function (err) {
			cb(err !== null);
		});
	}

	function runCommands(key, commands, cb) {
		if (key === undefined || key.length === 0) {
			runCommandSeries(commands, cb);
		} else {
			runCommandSingle(commands[key], cb);
		}
	}

	function combineArguments(args) {
		argValues = [];
		for (key in args) {
			argValues.push(args[key]);
		}
		return argValues.join(':');
	}

	function vagrantWrap(command) {
		return 'vagrant ssh --command "cd /vagrant && ' + command + '"';
	}

	//
	// Tasks registration.
	//
    grunt.registerTask('phalcon', '', function () {
        var done = this.async();
        runCommandSingle('cd phalcon && /usr/bin/php5 ./cli.php \'Tasks\\Hello\'', function (success) {
            done(success);
        })
    });

	grunt.registerTask('default', []);
};
