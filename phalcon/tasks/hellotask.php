<?php

namespace Tasks;

class HelloTask extends \Phalcon\CLI\Task {

	public function mainAction() {
		echo 'hello' . PHP_EOL;
	}
}

